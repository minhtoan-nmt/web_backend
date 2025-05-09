<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if ($_SERVER["REQUEST_METHOD"]==="GET") {
    $result = mysqli_query($conn,"SELECT * FROM `items`");
    $items = [];
    while ($row = mysqli_fetch_assoc($result)) {
        array_push($items, $row);
    }
    echo json_encode($items);
}
?>