<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

$items = [];

$sql = "
    SELECT * FROM `items`";
$result = mysqli_query($conn, $sql);
while ($row = mysqli_fetch_assoc($result)) {
    array_push($items, $row);
}
// echo "<pre>";
// var_dump($items);
// echo "</pre>";
echo json_encode($items);
?>