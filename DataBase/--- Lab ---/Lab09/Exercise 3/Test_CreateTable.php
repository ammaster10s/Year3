<?php
$servername = "localhost:8889";
$username = "root";
$password = "root";
$dbname = "lab09"; // Replace "db_name" with the actual name of your database.
// Create connection
$conn = new mysqli($servername, $username,
 $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: {$conn->connect_error}");
}
echo "Connected successfully";

$sql = "CREATE TABLE product (
    p_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    p_name VARCHAR(50) NOT NULL,
    p_price FLOAT NOT NULL
)";

if ($conn->query($sql)) {
    echo "Table product created successfully";
} else {
    echo "Error creating table: {$conn->error}";
}


