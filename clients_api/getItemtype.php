<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

$items = [];

$sql = "
    SELECT * FROM `item type`";
$result = mysqli_query($conn, $sql);
while ($row = mysqli_fetch_assoc($result)) {
    $arr = [];
    $item_type_name = $row["Item_type_name"];
    // echo $item_type_name . "; ";
    array_push($arr, $item_type_name);
    $item_with_type = [];
    $query = "SELECT * FROM `items` WHERE `Item_type_id` LIKE '" . $row["Item_type_id"] . "'";
    $products = mysqli_query($conn, $query);
    while ($item = mysqli_fetch_assoc($products)) {
        array_push($item_with_type, $item);
    }
    array_push($arr, $item_with_type);
    array_push($items, $arr);
}
// echo "<pre>";
// var_dump($items);
// echo "</pre>";

echo json_encode($items);
?>