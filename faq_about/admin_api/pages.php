<?php
require_once '../../config/database.php';
require_once '../../helpers/response.php';
require_once '../../helpers/auth.php';

// Kiểm tra quyền admin
require_admin();

// Lấy method của request
$method = $_SERVER['REQUEST_METHOD'];

switch($method) {
    case 'GET':
        // Lấy thông tin trang theo ID
        if(isset($_GET['id'])) {
            $stmt = $pdo->prepare("SELECT * FROM pages WHERE id = ?");
            $stmt->execute([$_GET['id']]);
            $page = $stmt->fetch();
            
            if($page) {
                ok($page);
            } else {
                err("Page not found", 404);
            }
        } 
        // Lấy danh sách tất cả các trang
        else {
            $stmt = $pdo->query("SELECT * FROM pages");
            $pages = $stmt->fetchAll();
            ok($pages);
        }
        break;

    case 'POST':
        // Thêm trang mới
        $data = json_decode(file_get_contents('php://input'), true);
        
        if(!isset($data['title']) || !isset($data['content'])) {
            err("Title and content are required");
        }

        $stmt = $pdo->prepare("INSERT INTO pages (title, content, image_url) VALUES (?, ?, ?)");
        $stmt->execute([$data['title'], $data['content'], $data['image_url'] ?? null]);
        
        ok(['id' => $pdo->lastInsertId()]);
        break;

    case 'PUT':
        // Cập nhật thông tin trang
        $data = json_decode(file_get_contents('php://input'), true);
        
        if(!isset($data['id'])) {
            err("Page ID is required");
        }

        $updates = [];
        $params = [];
        
        if(isset($data['title'])) {
            $updates[] = "title = ?";
            $params[] = $data['title'];
        }
        if(isset($data['content'])) {
            $updates[] = "content = ?";
            $params[] = $data['content'];
        }
        if(isset($data['image_url'])) {
            $updates[] = "image_url = ?";
            $params[] = $data['image_url'];
        }
        
        if(empty($updates)) {
            err("No fields to update");
        }
        
        $params[] = $data['id'];
        $sql = "UPDATE pages SET " . implode(", ", $updates) . " WHERE id = ?";
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        
        ok(['message' => 'Page updated successfully']);
        break;

    case 'DELETE':
        // Xóa trang
        if(!isset($_GET['id'])) {
            err("Page ID is required");
        }

        $stmt = $pdo->prepare("DELETE FROM pages WHERE id = ?");
        $stmt->execute([$_GET['id']]);
        
        ok(['message' => 'Page deleted successfully']);
        break;

    default:
        err("Method not allowed", 405);
        break;
}
?> 