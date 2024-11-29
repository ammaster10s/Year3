<?php

$mysqli = new mysqli("localhost:8889", "root", "root", "lab09");

// Check connection
if ($mysqli->connect_errno) {
    die("Connection failed: " . $mysqli->connect_errno . ": " . $mysqli->connect_error);
}

$q = "DELETE FROM product where p_id = 5;";
if ($mysqli->query($q)) {
    echo "Record deleted successfully<br>";
} else {
    echo "DELETE failed. ERROR: {$mysqli->error}<br>";
}