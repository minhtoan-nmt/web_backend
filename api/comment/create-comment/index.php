<?php

$response = array();
header('Content-Type: application/json');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  try {
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "ecommerce";
  
    $conn = new mysqli($servername, $username, $password, $dbname);
  
    if ($conn->connect_error) {
      $response["success"] = "false";
      $response["message"] = "Database connection failed: " . $conn->connect_error;
      echo json_encode($response);
      return;
    }

    $json_data = file_get_contents("php://input");
    $data = json_decode($json_data, true);

    $user_id = $data["user_id"];
    $post_id = $data["post_id"];
    $content = $data["content"];
    $date_posted = date("Y-m-d H:i:s");

    $sql = "INSERT INTO comment (user_id, post_id, content, date_posted, like_count)
            VALUES (?, ?, ?, ?, 0);";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssss", $user_id, $post_id, $content, $date_posted);
    $result = $stmt->execute();
    $stmt->close();

    echo json_encode([
      'status' => 200,
      'message' => "Comment created successfully"
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