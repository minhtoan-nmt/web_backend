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

    $title = $data["title"];
    $content = $data["content"];
    $img_src = $data["img_src"] ?? "";
    $date_posted = date("Y-m-d H:i:s");

    $sql = "INSERT INTO post (title, star_rate, img_src, date_posted, content)
            VALUES (?, 0, ?, ?, ?);";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssss", $title, $img_src, $date_posted, $content);
    $result = $stmt->execute();
    $stmt->close();

    echo json_encode([
      'status' => 200,
      'message' => "Post created successfully"
    ]);
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