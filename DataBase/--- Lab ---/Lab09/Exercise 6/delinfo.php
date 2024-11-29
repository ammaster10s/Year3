<?php

$mysqli = new mysqli("localhost:8889", "root", "root", "lab09");

if($mysqli->connect_errno) {
    die("Connection failed: " . $mysqli->connect_errno . ": " . $mysqli->connect_error);
}

$p_id = $_GET['id'];
$mysqli = new mysqli("localhost:8889", "root", "root", "lab09");
if ($mysqli->connect_errno) {
    echo $mysqli->connect_errno.": ". $mysqli->connect_error;
}

$q = "DELETE FROM product where p_id = $p_id;";
if ($mysqli->query($q)) {
    echo "Record deleted successfully<br>";
} else {
    echo "DELETE failed. ERROR: {$mysqli->error}<br>";
}
$mysqli->close();
header("Location: viewinfo.php");

?>