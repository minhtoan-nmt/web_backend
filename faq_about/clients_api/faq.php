<?php
// Cho phép CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
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
                $stmt = $pdo->prepare("SELECT * FROM faqs WHERE question LIKE :search OR answer LIKE :search ORDER BY RAND() LIMIT 3");
                $stmt->bindParam(':search', $search);
            } else {
                $stmt = $pdo->prepare("SELECT * FROM faqs ORDER BY RAND() LIMIT 3");
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
        try {
            // Lấy dữ liệu từ request body
            $data = json_decode(file_get_contents('php://input'), true);
            
            if(!isset($data['question'])) {
                echo json_encode([
                    'success' => false,
                    'message' => 'Question is required'
                ]);
                exit;
            }

            // Thêm câu hỏi mới vào database
            $stmt = $pdo->prepare("INSERT INTO faqs (question, answer, created_at) VALUES (?, ?, NOW())");
            $stmt->execute([
                $data['question'],
                $data['answer'] ?? 'Câu hỏi của bạn đang được xử lý. Chúng tôi sẽ trả lời sớm nhất có thể.'
            ]);
            
            echo json_encode([
                'success' => true,
                'message' => 'Question added successfully',
                'id' => $pdo->lastInsertId()
            ]);
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