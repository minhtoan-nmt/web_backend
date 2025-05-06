<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}

//insert a new row in invoice (including ID, CartID,..., Phone num in $_POST)
if ($_SERVER["REQUEST_METHOD"]!=="POST") {
    exit;
}
// echo "<pre>";
// var_dump($_POST);
// echo "</pre>";
$name = test_input($_POST["full-name"]);
$city = test_input($_POST["city"]);
$district = test_input($_POST["city"]);
$ward = test_input($_POST["ward"]);
$address = test_input($_POST["address"]);
$phone_num = test_input($_POST["phone-number"]);
$email = test_input($_POST["email"]);


if (strlen($name) === 0 || strlen($name) > 100) {
    echo "Tên của bạn không hợp lệ (Không được để trống tên và có độ dài ký tự nhỏ hơn hoặc bằng 100)";
    exit;
}
if (strlen($city)===0 || strlen($city) > 100) {
    echo "Thành phố hoặc tỉnh của bạn không hợp lệ (Không được để trống thành phố hoặc tỉnh và có độ dài ký tự nhỏ hơn hoặc bằng 100)";
    exit;
}
if (strlen($district)===0 || strlen($district) > 100) {
    echo "Quận/Huyện của bạn không hợp lệ (Không được để trống Quận/Huyện và có độ dài ký tự nhỏ hơn hoặc bằng 100)";
    exit;
}
if (strlen($ward)===0 || strlen($ward) > 100) {
    echo "Phường/Xã của bạn không hợp lệ (Không được để trống và có độ dài ký tự nhỏ hơn hoặc bằng 100)";
    exit;
}
if (strlen($address)===0 || strlen($address) > 100) {
    echo "Địa chỉ của bạn không hợp lệ (Không được để trống và có độ dài ký tự nhỏ hơn hoặc bằng 100)";
    exit;
}
if (strlen($phone_num)===0 || !preg_match('/^[0-9]{10}+$/', $phone_num)) {
    echo "Số điện thoại của bạn không hợp lệ";
    exit;
}
if (strlen($email)===0 || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo "Email của bạn không hợp lệ";
    exit;
}



$insert = "INSERT INTO `invoice`(`Cart ID`, `Full Name`, `City/Province`, `District`, `Ward`, `Address`, `Email`, `Phone number`, `Pay_method`, `Total_price`)
VALUES ('GUEST0001', '" . $_POST["full-name"] . "', '" . $_POST["city"] . "', '" . $_POST["district"] . "', '" . $_POST["ward"] . "', '" . $_POST["address"] . "', '" . $_POST["email"] . "', '" . $_POST["phone-number"] . "', '" . $_POST["payment-type"] . "', '" . $_POST["total-price"] . "')";
$result = mysqli_query($conn, $insert);
$latest = mysqli_query($conn, "SELECT LAST_INSERT_ID()");
$r = mysqli_fetch_assoc($latest);
$id = $r["LAST_INSERT_ID()"];

$query = mysqli_query($conn, "SELECT * FROM `cart has items` WHERE `Cart ID` = 'GUEST0001'");
while ($row = mysqli_fetch_assoc($query)) {
    // how to get the invoice id of the latest insert
    $insert_to_invoice = mysqli_query($conn, "INSERT INTO `invoice has items`(`Invoice ID`, `Cart ID`, `Item ID`, `Quantity`)
    VALUES ('". $id . "', '" . $row["Cart ID"] . "', '" . $row["Item ID"] . "', '" . $row["Quantity"] . "')");
    if (!$insert_to_invoice) {
        echo "Thanh toán không thành công, vui lòng thử lại";
        exit;
    }
}

$removeItemsInCart = mysqli_query($conn, "DELETE FROM `cart has items` WHERE `cart ID` = 'GUEST0001'");

echo "<script>alert('Thanh toán thành công. Vui lòng tiếp tục mua sắm!')</script>";

header('Location: http://localhost:3000/payment_success');

?>