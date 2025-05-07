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

    $sql = "SELECT * 
            FROM Post 
            ORDER BY date_posted DESC 
            LIMIT 13";
    $result = $conn->query($sql);

    $main_posts = array();
    $related_posts = array();
    $post_count = 0;
    if ($result->num_rows > 0) {
      while ($row = $result->fetch_assoc()) {
        if ($post_count < 8) {
          $main_posts[] = $row;
        } else {
          $related_posts[] = $row;
        }
        $post_count++;
      }
      $data = array(
        "main_posts" => $main_posts,
        "related_posts" => $related_posts
      );
    } else {
      $data = array();
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