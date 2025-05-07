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
      echo json_encode([
        "status" => 500,
        "message" => "Database connection failed: " . $conn->connect_error
      ]);
      return;
    }

    if (!isset($_GET["category"])) {
      echo json_encode([
        "status" => 400,
        "message" => "Missing param"
      ]);
      return;
    }
    $category = $_GET["category"];
    
    if (!isset($_GET["limit"])) {
      $sql = "SELECT *
              FROM product
              WHERE category=$category";
    } else {
      $limit = $_GET["limit"];
      $sql = "SELECT *
              FROM product
              WHERE category=$category
              LIMIT $limit";
    }
  
    $data = array();
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
      while ($row = $result->fetch_assoc()) {
        $data[] = $row;
      }
    } else {
      $data[] = "No data found";
    }
  
    echo json_encode([
      'status' => 200,
      'data' => $return_data
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
