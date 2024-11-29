<?php

$p_id = $_GET['id'];
require_once "connect_1.php";
$q = "SELECT * from product where p_id = $p_id";

$result = $mysqli->query($q);
echo "<form action='practice_2update.php' method='post'>";

while ( $row = $result->fetch_array() ) {
    echo "Product ID: <input type='text' name='p_id' value='".$row['p_id']."' readonly><br>"; // Change 'name' to 'p_id'
    echo "<input type='hidden' name='p_id' value='".$row['p_id']."'>"; // Add this line
    echo "Product Name: <input type='text' name='p_name' value='".$row['p_name']."'><br>";
    echo "Product Price: <input type='text' name='p_price' value=".$row['p_price']."><br>";
    echo "<input type='submit' value='submit'>";
}

$mysqli->close();
?>