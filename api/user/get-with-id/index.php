<?php
$response = array();
header('Content-Type: application/json');

if ($_SERVER["REQUEST_METHOD"] == "GET") {
  try {
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "LTW";
  
    $conn = new mysqli($servername, $username, $password, $dbname);
  
    if ($conn->connect_error) {
      $response["success"] = "false";
      $response["message"] = "Database connection failed: " . $conn->connect_error;
      echo json_encode($response);
      return;
    }

    if (isset($_GET["id"])) {
      $id = $_GET["id"];
    } else {
      echo json_encode([
        "status" => 400,
        "error" => "Id is required"
      ]);
      return;
    }

    $sql = "SELECT * FROM User WHERE id='$id'";
  
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
      $row = $result->fetch_assoc();
      $data = $row;
    } else {
      $data = "No data found";
    }
  
    echo json_encode([
      'status' => 200,
      'data' => $data
    ]);
  } catch (Exception $e) {
    printf($e->getMessage());
    echo json_encode([
      'status' => 400,
      'error' => $e->getMessage()
    ]);
  }
} else {
  echo json_encode([
    'status' => 404,
    'message' => "Can't find API"
  ]);
}