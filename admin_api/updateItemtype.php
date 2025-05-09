<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    if (strlen($_POST["item-type-id"]) > 10 || strlen($_POST["item-type-id"]) <= 0) {
        echo "ID của bạn không hợp lệ (độ dài phải nhỏ hơn hoặc bằng 10 và không được để trống)";
        exit;
    }
    if (strlen($_POST["item-type-name"]) > 100 || strlen($_POST["item-type-name"]) <= 0) {
        echo "Tên của bạn không hợp lệ (độ dài phải nhỏ hơn hoặc bằng 100 và không được để trống)";
        exit;
    }
    
    $sql = "UPDATE `item type`
    SET `Item_type_id` = '" . $_POST["item-type-id"] . "', `Item_type_name` = '" . $_POST["item-type-name"] . "'
    WHERE `Item_type_id` = '" . $_GET["id"] . "'";
    $result = mysqli_query($conn, $sql);
    if ($result) {
        echo json_encode($result);
        header('Location: http://localhost:3000/admin/products');
        exit;
    } else {
        echo "Cập nhật không thành công!";
    }
}

?>