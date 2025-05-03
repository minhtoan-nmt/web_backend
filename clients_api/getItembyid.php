<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if (!isset($_GET["id"])) {
    echo json_encode("No data returned");
    return;
}

$sql = "SELECT * FROM `items` WHERE `ID` = '" . $_GET['id'] . "'";
$result = mysqli_query($conn, $sql);
$row = mysqli_fetch_assoc($result);

echo json_encode($row);
?>