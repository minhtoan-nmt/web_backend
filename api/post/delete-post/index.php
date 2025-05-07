<?php
$response = array();
header('Content-Type: application/json');

if ($_SERVER["REQUEST_METHOD"] == "DELETE") {
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

    $data = json_decode(file_get_contents('php://input'), true);

    if (isset($data["id"])) {
      $id = $data["id"];
    } else {
      echo json_encode([
        "status" => 400,
        "error" => "Id is required"
      ]);
      return;
    }

    $sql = "DELETE FROM post
            WHERE id='$id'";
  
    $result = $conn->query($sql);
    $affected_rows = $conn->affected_rows;
  
    if ($affected_rows > 0) {
      echo json_encode([
        'status' => 200,
        'message' => "Post $id deleted successfully"
      ]);
    } else {
      echo json_encode([
        'status' => 400,
        'error' => `No post with id $id found`
      ]);
    }
  
  } catch (Exception $e) {
    printf($e->getMessage());
    echo json_encode([
      'status' => 400,
      'message' => $e->getMessage()
    ]);
  }
} else {
  echo json_encode([
    'status' => 405,
    'message' => "Can't find API"
  ]);
}