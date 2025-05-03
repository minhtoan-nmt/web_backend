<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if (isset($_GET["id"])) {
    $check = mysqli_query($conn, "SELECT * FROM `cart has items` 
    WHERE `item ID` = '". $_GET["id"] . "' " . "AND `Cart ID` = 'GUEST0001'");
    if ($row = mysqli_fetch_assoc($check)) {
        $result = mysqli_query($conn, "UPDATE `cart has items` 
            SET `Quantity` = `Quantity` + " . $_GET["quantity"] . 
            " WHERE `Item ID` = '" . $_GET["id"] . "'");
    } else {
        $sql = "INSERT INTO `cart has items`(`Cart ID`, `Item ID`, `Quantity`)
            VALUES ('GUEST0001', '" . $_GET["id"] . "', '" . $_GET["quantity"] . "')";
        $result = mysqli_query($conn, $sql);
    }
}

echo json_encode($result);
?>