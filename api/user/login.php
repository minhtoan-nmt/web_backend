<?php

$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    exit;
}

$query = mysqli_query($conn, "SELECT * 
FROM `accounts` 
WHERE `username` = '" . $_POST["username"] . "' AND `password` = '". $_POST["password"] . "'");

$row = mysqli_fetch_assoc($query);
if (!$row) {
    echo "Thông tin đăng nhập không chính xác";
    exit;
}

// header("Set-Cookie: token=" . $row["cart_id"] . "; Expires=" . time()+60*60*24);
echo $row;

?>