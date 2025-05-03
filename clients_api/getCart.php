<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if (!isset($_GET)) return;

$result = mysqli_query($conn, "SELECT * FROM `cart` WHERE `cart`.`ID` = 'GUEST0001'");
$data = [];
while ($row = mysqli_fetch_assoc($result)) {
    array_push($data, $row);
}

echo json_encode($data);
?>