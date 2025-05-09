<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

$sql = "SELECT COUNT(*) FROM `cart has items` WHERE `Cart ID` = 'GUEST0001'";
$result = mysqli_query($conn, $sql);
$row = mysqli_fetch_assoc($result);

echo json_encode($row["COUNT(*)"]);
?>