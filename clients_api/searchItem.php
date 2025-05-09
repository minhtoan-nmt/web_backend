<?php
$conn = mysqli_connect("localhost", "root", "", "ecommerce");
if (!$conn) {
    die("No connection");
}

if (isset($_GET["query"])) {
    if (preg_match('/[\'^£$%&*()}{@#~?><>,|=_+¬-]/', $_GET["query"])) {
        echo json_encode("No data returned");
        return;
    }
    $query = $_GET["query"];
    $items = [];
    $sql = "SELECT items.ID, `items`.`Product Name`, `items`.`Description`, `items`.`Price`, `items`.`Discount`, `items`.`Rating`, `items`.`Image Src`, `items`.`Brand`, `items`.`Quantity` 
        FROM `items` JOIN `item type` ON `items`.`Item_type_id` = `item type`.`Item_type_id`
        WHERE `ID` LIKE '%" . $query . "%' OR `Product Name` LIKE '%" . $query . "%' OR `Brand` LIKE '%"
        . $query . "%' OR `Item_type_name` LIKE '%" . $query . "%' OR `items`.`Item_type_id` LIKE '%" . $query
        . "%'";
    $result = mysqli_query($conn, $sql);
    while ($row = mysqli_fetch_assoc($result)) {
        array_push($items, $row);
    }
    if (count($items)>0) echo json_encode($items);
    else echo json_encode("No data returned");
}

?>