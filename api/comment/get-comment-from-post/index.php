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

    if (isset($_GET["query"])) {
      $post_id = $_GET["query"];
    } else {
      echo json_encode([
        'status' => 400,
        'error' => "Post id is required"
      ]);
      return;
    }

    $sql = "SELECT * 
            FROM Comment 
            WHERE post_id='$post_id'
            ORDER BY date_posted DESC";
    $result = $conn->query($sql);

    $comments = array();
    if ($result->num_rows > 0) {
      while ($row = $result->fetch_assoc()) {
        $comments[] = $row;
      }
    }

    echo json_encode([
      'status' => 200,
      'data' => $comments
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