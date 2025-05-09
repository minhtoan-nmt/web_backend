<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if (!isset($_GET["id"]) || !isset($_GET["cartid"]) || !isset($_GET["status"])) {
    exit;
}

$sql = "UPDATE `invoice`
SET `Status` = '" . $_GET["status"] . "'
WHERE `ID` = '". $_GET["id"] . "' AND `Cart ID` = '" . $_GET["cartid"] . "'";
$result = mysqli_query($conn, $sql);
echo json_encode($result);
?>