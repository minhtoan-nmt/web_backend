<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if (isset($_GET["id"])) {
    $sql = "DELETE FROM `cart has items` 
        WHERE `Cart ID` = 'GUEST0001' AND `Item ID` = '" . $_GET["id"] . "'";
    $result = mysqli_query($conn, $sql);
}

echo json_encode($result);
?>