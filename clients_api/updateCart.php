<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if (!isset($_POST)) {
    return;
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $input = file_get_contents("php://input");
    $data = json_decode($input, true);
    $result = mysqli_query($conn, "UPDATE `cart` SET `No. products` = " . $data['Num_product'] . ", `Total Price` = " . $data['Total_price'] . " WHERE `cart`.`ID` = 'GUEST0001'");
    if ($result) echo json_encode("Successful");
}
?>