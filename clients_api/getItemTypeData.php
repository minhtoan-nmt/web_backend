<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if ($_SERVER["REQUEST_METHOD"] === "GET") {
    $result = mysqli_query($conn, "SELECT * FROM `item type`");
    $data = [];
    while ($row = mysqli_fetch_assoc($result)) {
        array_push($data, $row);
    }
    echo json_encode($data);
}
?>