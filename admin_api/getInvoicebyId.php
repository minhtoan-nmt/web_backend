<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if (!isset($_GET["id"]) || !isset($_GET["cartid"])) {
    echo "Id is not defined";
    exit;
}

$data = [];
$sql = "SELECT * FROM `invoice` WHERE `ID` = '" . $_GET["id"] . "' AND `Cart ID` = '" . $_GET["cartid"] . "'";
$result = mysqli_query($conn, $sql);
$info = mysqli_fetch_assoc($result);
array_push($data, $info);

$sql = "SELECT `items`.`ID`, `items`.`Product Name`, `invoice has items`.`Quantity`, `items`.`Price`, `items`.`Discount`, `items`.`Image Src` FROM `invoice has items` JOIN `items` ON `invoice has items`.`Item ID` = `items`.`ID` WHERE `Invoice ID` = '" . $_GET["id"] . "' AND `Cart ID` = '" . $_GET["cartid"] . "'";
$result = mysqli_query($conn, $sql);
$items = [];
while ($row = mysqli_fetch_assoc($result)) {
    array_push($items, $row);
}

array_push($data, $items);
echo json_encode($data);
?>