<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if ($_SERVER["REQUEST_METHOD"]==="GET") {
    $result = mysqli_query($conn, "DELETE FROM `items` WHERE `items`.`ID` = '" . $_GET["id"] . "'");
    echo json_encode($result);
}
?>