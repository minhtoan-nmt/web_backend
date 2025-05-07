<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    exit;
}

echo "<pre>";
var_dump($_POST);
echo "</pre>";

//check whether the id has been created
$checkid = mysqli_query($conn, "SELECT * FROM `user` WHERE `username` = '" . $_POST["username"] . "'");
if ($row = mysqli_fetch_assoc($checkid)) {
    echo json_encode(false);
    exit;
}

function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}

$firstName = test_input($_POST["first-name"]);
$lastName = test_input($_POST["last-name"]);
$citizenId = test_input($_POST["citizen-id"]);
$dob = $_POST["dob"];
$phoneNum = test_input($_POST["phone-num"]);
$address = test_input($_POST["address"]);
$username = test_input($_POST["username"]);
$password = test_input($_POST["password"]);
$confirmPass = test_input($_POST["confirm-password"]);

if (!$firstName || strlen($firstName) > 50) {
    echo "<p>Họ của bạn không hợp lệ (không được để trống và số ký tự không được vượt quá 50)</p>";
    exit;
}
if (!$lastName || strlen($lastName) > 50) {
    echo "<p>Tên của bạn không hợp lệ (không được để trống và số ký tự không được vượt quá 50)</p>";
    exit;
}
if (strlen($citizenId) !== 12 || !ctype_digit($citizenId)) {
    echo "<p>Số cmnd của bạn không hợp lệ (không được để trống và số ký tự không được khác 12)</p>";
    exit;
}
if (!$phoneNum || strlen($phoneNum) > 15) {
    echo "<p>Số điện thoại của bạn không hợp lệ (không được để trống và số ký tự không được vượt quá 15)</p>";
    exit;
}
if (strlen($address) > 100) {
    echo "<p>Địa chỉ của bạn không hợp lệ (không được để trống và số ký tự không được vượt quá 50)</p>";
    exit;
}
if (!$username || strlen($username) > 20) {
    echo "<p>Tên tài khoản của bạn không hợp lệ (không được để trống và số ký tự không được vượt quá 50)</p>";
    exit;
}
if (!$password || !preg_match("/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/", $password)) {
    echo "<p>Mật khẩu của bạn không hợp lệ (không được để trống, ít nhất 8 ký tự bao gồm chữ cái hoa và thường, số, và ký tự đặc biệt)</p>";
    exit;
}
if ($password !== $confirmPass) {
    echo "<p>Mật khẩu nhập lại không trùng khớp!</p>";
    exit;
}

//end form validation

//insert entry to `user`
try {
    $insertToUser = mysqli_query($conn, "INSERT INTO `user` (`username`, `first_name`, `last_name`, `citizen_id`, `phone_num`, `address`, `birth_date`)
    VALUES ('" . $username . "', '" . $firstName . "', '" . $lastName . "', '" . $citizenId . "', '" . $phoneNum . "', '" . $address . "', '" . $dob . "')");
} catch (Exception $e) {
    echo "Đăng ký tài khoản không thành công (Lỗi : " . $e->getMessage() . ")";
    exit;
}


$getNewId = mysqli_query($conn, "SELECT `id` FROM `user` WHERE `username` = '" . $username . "'");//get newly created id
//create token
$id = mysqli_fetch_assoc($getNewId);
$newid = $id["id"];
$token = hash('sha256', $username);
echo strlen($token);
$accountType = "client";

try {
    $insertToAccount = mysqli_query($conn, "INSERT INTO `accounts` (`username`, `password`, `user_id`, `cart_id`, `account_type`)
    VALUES ('" . $username . "', '" . $password . "', '" . $newid . "', '" . $token . "', '" . $accountType . "')");
} catch (Exception $e) {
    echo "Đăng ký tài khoản không thành công (Lỗi : " . $e->getMessage() . ")";
    exit;
}

try {
    $insertToCart = mysqli_query($conn, "INSERT INTO `cart` (`ID`, `Customer ID`) VALUES ('" . $token . "', '" . $newid . "')");
} catch (Exception $e) {
    echo "Đăng ký tài khoản không thành công (Lỗi : " . $e->getMessage() . ")";
    exit;
}

header('Location: http://localhost:3000/auth/create_acc_success');
echo json_encode($insertToAccount);

?>