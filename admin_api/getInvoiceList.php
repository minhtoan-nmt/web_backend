<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if ($_SERVER["REQUEST_METHOD"]==="GET") {
    $result = mysqli_query($conn,"SELECT * FROM `invoice`");
    $invoices = [];
    while ($row = mysqli_fetch_assoc($result)) {
        array_push($invoices, $row);
    }
    echo json_encode($invoices);
}
?>