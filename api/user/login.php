<?php

$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    exit;
}

$json = file_get_contents('php://input');

// Decode the JSON to an associative array
$data = json_decode($json, true);

// var_dump($data);

$query = mysqli_query($conn, "SELECT * 
FROM `accounts` 
WHERE `username` = '" . $data["username"] . "' AND `password` = '". $data["password"] . "'");

$row = mysqli_fetch_assoc($query);
if (!$row) {
    echo json_encode(false);
    exit;
}

// header("Set-Cookie: token=" . $row["cart_id"] . "; Expires=" . time()+60*60*24);
echo json_encode($row["cart_id"]);

?>