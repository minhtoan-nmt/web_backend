<?php

header('Content-Type: application/json');
header("Access-Control-Allow-Methods: PATCH");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");


if ($_SERVER["REQUEST_METHOD"] == "PATCH") {
  try {
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "LTW";
  
    $conn = new mysqli($servername, $username, $password, $dbname);
  
    if ($conn->connect_error) {
      echo json_encode([
        'status' => 500,
        'message' => "Database connection failed: " . $conn->connect_error
      ]);
      return;
    }

    $json_data = file_get_contents("php://input");
    $data = json_decode($json_data, true);

    if (!isset($data["id"])) {
      echo json_encode([
        'status' => 400,
        'message' => "No id found"
      ]);
      return;
    }

    $id = $data["id"];
    $title = $data["title"] ?? "";
    $content = $data["content"] ?? "";
    $img_src = $data["img_src"] ?? "";

    if (empty($title) && empty($content) && empty($img_src)) {
      echo json_encode([
        'status' => 200,
        'message' => "No field provided for update"
      ]);
    }

    $updates = array();
    if (!empty($title)) {
      $updates[] = "title='$title'";
    }
    if (!empty($content)) {
      $updates[] = "content='$content'";
    }
    if (!empty($img_src)) {
      $updates[] = "img_src='$img_src'";
    }

    $sql = "UPDATE post SET ";
    $sql .= implode(", ", $updates);
    $sql .= " WHERE id='$id'";



    $stmt = $conn->prepare($sql);
    $result = $stmt->execute();
    $stmt->close();

    echo json_encode([
      'status' => 200,
      'message' => "Post with id $id updated successfully"
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