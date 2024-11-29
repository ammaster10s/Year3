<?php

$mysqli = new mysqli("localhost:8889", "root", "root", "lab09");

if($mysqli->connect_errno) {
    die("Connection failed: " . $mysqli->connect_errno . ": " . $mysqli->connect_error);
}
?>