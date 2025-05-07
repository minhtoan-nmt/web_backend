<?php
// Cho phép CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

// Báo lỗi chi tiết trong quá trình phát triển
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once '../config/database.php';

// Lấy method của request
$method = $_SERVER['REQUEST_METHOD'];

switch($method) {
    case 'GET':
        try {
            // Kiểm tra xem có tham số tìm kiếm không
            if (isset($_GET['search'])) {
                $search = '%' . $_GET['search'] . '%';
                $stmt = $pdo->prepare("SELECT * FROM faqs WHERE question LIKE :search OR answer LIKE :search ORDER BY created_at DESC");
                $stmt->bindParam(':search', $search);
            } else {
                $stmt = $pdo->prepare("SELECT * FROM faqs ORDER BY created_at DESC");
            }
            
            $stmt->execute();
            $faqs = $stmt->fetchAll(PDO::FETCH_ASSOC);
            
            echo json_encode([
                'success' => true,
                'data' => $faqs
            ]);
        } catch(PDOException $e) {
            echo json_encode([
                'success' => false,
                'message' => 'Database error: ' . $e->getMessage()
            ]);
        }
        break;

    case 'POST':
        // Thêm câu hỏi mới
        $data = json_decode(file_get_contents('php://input'), true);
        
        if(!isset($data['question']) || !isset($data['answer'])) {
            err("Question and answer are required");
        }

        $stmt = $pdo->prepare("INSERT INTO faqs (question, answer, created_at) VALUES (?, ?, NOW())");
        $stmt->execute([$data['question'], $data['answer']]);
        
        ok(['id' => $pdo->lastInsertId()]);
        break;

    case 'PUT':
        try {
            // Lấy dữ liệu từ request body
            $data = json_decode(file_get_contents('php://input'), true);
            
            if(!isset($data['id']) || !isset($data['answer'])) {
                echo json_encode([
                    'success' => false,
                    'message' => 'ID and answer are required'
                ]);
                exit;
            }

            // Cập nhật câu trả lời
            $stmt = $pdo->prepare("UPDATE faqs SET answer = :answer, updated_at = NOW() WHERE id = :id");
            $stmt->execute([
                ':answer' => $data['answer'],
                ':id' => $data['id']
            ]);
            
            if($stmt->rowCount() > 0) {
                echo json_encode([
                    'success' => true,
                    'message' => 'Answer updated successfully'
                ]);
            } else {
                echo json_encode([
                    'success' => false,
                    'message' => 'FAQ not found'
                ]);
            }
        } catch(PDOException $e) {
            echo json_encode([
                'success' => false,
                'message' => 'Database error: ' . $e->getMessage()
            ]);
        }
        break;

    case 'DELETE':
        try {
            if(!isset($_GET['id'])) {
                echo json_encode([
                    'success' => false,
                    'message' => 'ID is required'
                ]);
                exit;
            }

            // Xóa FAQ
            $stmt = $pdo->prepare("DELETE FROM faqs WHERE id = :id");
            $stmt->execute([':id' => $_GET['id']]);
            
            if($stmt->rowCount() > 0) {
                echo json_encode([
                    'success' => true,
                    'message' => 'FAQ deleted successfully'
                ]);
            } else {
                echo json_encode([
                    'success' => false,
                    'message' => 'FAQ not found'
                ]);
            }
        } catch(PDOException $e) {
            echo json_encode([
                'success' => false,
                'message' => 'Database error: ' . $e->getMessage()
            ]);
        }
        break;

    default:
        echo json_encode([
            'success' => false,
            'message' => 'Method not allowed'
        ]);
        break;
}
?> 