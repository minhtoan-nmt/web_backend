<?php
// config/database.php

// Thông tin kết nối
$host = 'localhost';
$db   = 'ecommerce';         // tên database của bạn
$user = 'root';              // username MySQL
$pass = '';                  // password MySQL
$charset = 'utf8mb4';

// Tạo DSN (Data Source Name)
$dsn = "mysql:host=$host;dbname=$db;charset=$charset";

$options = [
    // Báo lỗi ở dạng Exception
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    // Trả về kết quả dưới dạng mảng kết hợp
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    // Không giữ nhiều kết nối
    PDO::ATTR_PERSISTENT         => false,
];

try {
    // Khởi tạo PDO
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (PDOException $e) {
    // Nếu kết nối thất bại, dừng và in lỗi
    die("Database connection failed: " . $e->getMessage());
}
