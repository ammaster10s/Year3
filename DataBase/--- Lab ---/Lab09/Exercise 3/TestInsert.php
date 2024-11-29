<?php

$mysqli = new mysqli('localhost:8889', 'root', 'root', 'lab09');

// Check connection
if ( $mysqli->connect_error ) {
    die("Connection failed: " . $mysqli->connect_error);
}

$recs = array(
    // array('Pencil', 10),
    // array('Eraser', 5),
    // array('Mouse', 600),
    array('Printer', 4000)
);

foreach ($recs as $r) {
    $q = "INSERT INTO product (p_name, p_price) VALUES ('{$r[0]}', {$r[1]})";
    
    // Corrected the logic to check for query failure
    if ( !$mysqli->query($q) ) {
        echo "INSERT failed. ERROR: {$mysqli->error}<br>";
    } else {
        echo "Record inserted successfully: {$r[0]}<br>";
    }
}

// Close connection
$mysqli->close();
?>
