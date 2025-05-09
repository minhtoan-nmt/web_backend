<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if (isset($_GET["id"])) {
    $items = [];

    $sql = "
        SELECT * FROM `item type` WHERE `item type`.`Item_type_id` = '" . $_GET["id"] . "'";
    $result = mysqli_query($conn, $sql);
    while ($row = mysqli_fetch_assoc($result)) {
        array_push($items, $row);
    }
    echo json_encode($items);
}
?>