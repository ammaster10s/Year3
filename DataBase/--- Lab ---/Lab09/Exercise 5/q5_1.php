<?php

$mysqli = new mysqli("localhost:8889", "root", "root", "lab09");

// Check connection
if ($mysqli->connect_errno) {
    die("Connection failed: " . $mysqli->connect_errno . ": " . $mysqli->connect_error);
}

$r = array("Idiot's Guide Book", 1200); // Typo fixed in the string
$q = "INSERT INTO product (p_name, p_price) 
VALUES( ' ".$mysqli->real_escape_string($r[0])." ', {$r[1]})";

// Corrected the conditional logic
if( $mysqli->query($q) ) {
    echo "Record inserted successfully: {$r[0]}<br>";
} else {
    echo "INSERT failed. ERROR: {$mysqli->error}<br>";
}

// Close connection
$mysqli->close();
?>
