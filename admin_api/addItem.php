<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if ($_SERVER["REQUEST_METHOD"] === "POST"){
    if (strlen($_POST["item-id"]) > 10 || strlen($_POST["item-id"]) === 0) {
        echo "ID của bạn không hợp lệ (độ dài phải nhỏ hơn hoặc bằng 10 và không được để trống)";
        exit;
    }
    if (strlen($_POST["product-name"]) > 100 || strlen($_POST["product-name"] === 0)) {
        echo "Tên của sản phẩm không hợp lệ (độ dài nhỏ hơn hoặc bằng 100 và không được để trống)";
        exit;
    }
    if (strlen($_POST["description"]) > 5000) {
        echo "Mô tả của sản phẩm không hợp lệ (độ dài nhỏ hơn hoặc bằng 5000)";
        exit;
    }
    if ($_POST["price"] < 0) {
        echo "Giá của sản phẩm không hợp lệ (giá trị phải lớn hơn 0)";
        exit;
    }
    if ($_POST["discount"] < 0) {
        echo "Giá trị khuyến mãi không hợp lệ (giá trị phải lớn hơn 0)";
        exit;
    }
    if ($_POST["rating"] <= 0 || $_POST["rating"] > 5) {
        echo "Giá trị đánh giá không hợp lệ (số nguyên từ 1 đến 5)";
    }
    // if (strlen($_POST["image-link"]) > 1000) {
    //     echo "Liên kết hình ảnh của sản phẩm không hợp lệ (độ dài nhỏ hơn hoặc bằng 5000)";
    //     exit;
    // }
    if (strlen($_POST["brand"]) > 50) {
        echo "Tên thương hiệu của sản phẩm không hợp lệ (độ dài nhỏ hơn hoặc bằng 50)";
        exit;
    }
    if ($_POST["quantity"] < 0) {
        echo "Giá trị số lượng không hợp lệ (giá trị phải lớn hơn hoặc bằng 0)";
        exit;
    }
    echo "<pre>";
    var_dump($_FILES);
    echo "</pre>";

    $allowFileTypes = array("jpg", "png", "jpeg", "gif");
    $nameParts = explode(".", $_FILES["image-link"]["name"]);
    $extension = end($nameParts);
    if (($_FILES["image-link"]["type"] === "image/jpeg" || $_FILES["image-link"]["type"] === "image/gif"
    || $_FILES["image-link"]["type"] === "image/png" || $_FILES["image-link"]["type"] === "image/pjpeg")
    && $_FILES["image-link"]["size"] < 10000000 && in_array($extension, $allowFileTypes)) {
        if ($_FILES["image-link"]["error"]) {
            echo $_FILES["image-link"]["error"];
        } else {
            if (file_exists("./../images/" . $_FILES["image-link"]["name"])) {
                echo "File có tồn tại trước đó";
            }
            else move_uploaded_file($_FILES["image-link"]["tmp_name"], "./../images/".$_FILES["image-link"]["name"]);
        }
    }

    $imageLink = "http://localhost/images/" . $_FILES["image-link"]["name"];
    $link = str_replace(" ", "%20", $imageLink);
    echo $link;

    $sql = "INSERT INTO `items` (`ID`, `Product Name`, `Description`, `Price`, `Discount`, `Rating`, `Image Src`, `Item_type_id`, `Brand`, `Quantity`) 
/*CHANGE THE LINK */        VALUES ('" . $_POST["item-id"] . "', '" . $_POST["product-name"] . "', '" . $_POST["description"] . "', '" . $_POST["price"] . "', '" . $_POST["discount"] . "', '" . $_POST["rating"] . "', '" . $link/* WOULD BE OVERRIDE BY URL OF FILE UPLOAD */ . "', '" . $_POST["item-type"] . "', '" . $_POST["brand"] . "', '" . $_POST["quantity"] . "')";
    $result = mysqli_query($conn, $sql);
    if ($result) {
        echo json_encode($result);
        header('Location: http://localhost:3000/admin/products');
        exit;
    }
    else {
        echo "Cập nhật không thành công!";
    }
}
?>