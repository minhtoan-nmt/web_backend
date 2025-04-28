<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

// echo gettype($_GET["item_type"]);

$sql = "SELECT * FROM `items` WHERE `Item_type_id` LIKE '" . $_GET["item_type"] . "'";
// $sql = "SELECT * FROM `items` WHERE `Item_type_name` LIKE 'Laptop'";

$res_arr = [];
$result = mysqli_query($conn, $sql);

while ($row = mysqli_fetch_assoc($result)) {
    array_push($res_arr, $row);
}

echo json_encode($res_arr);
?>