<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

$result = mysqli_query($conn, "SELECT `items`.`ID`, `items`.`Product Name`, `items`.`Description`, `items`.`Price`, `items`.`Discount`, `cart has items`.`Quantity`, `items`.`Image Src`, `items`.`Quantity` AS `Num_left`
    FROM `items` JOIN `cart has items` ON `items`.`ID` = `cart has items`.`Item ID`
    WHERE `cart has items`.`Cart ID` = 'GUEST0001'");
$data = [];
while ($row = mysqli_fetch_assoc($result)) {
    array_push($data, $row);
}

echo json_encode($data);
?>