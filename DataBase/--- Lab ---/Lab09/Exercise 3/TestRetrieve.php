<?php

$mysqli = new mysqli("localhost:8889", "root", "root", "lab09");

// Check connection
if ($mysqli->connect_errno) {
    die("Connection failed: " . $mysqli->connect_errno . ": " . $mysqli->connect_error);
}

// Corrected query (removed the colon ':')
$q = "SELECT p_name, p_price FROM product WHERE p_price > 100";

if ($result = $mysqli->query($q)) {
    echo '<table border="1">';
    echo '<tr><th>Name</th><th>Price</th></tr>';

    // Fetch results as an associative array
    while ($row = $result->fetch_assoc()) {
        echo "<tr>";
        echo "<td>" . $row['p_name'] . "</td>";
        echo "<td>" . $row['p_price'] . "</td>";
        echo "</tr>";
    }
    
    echo '</table>';
    $result->free(); // Free result set
} else {
    // Display error message if the query fails
    echo "Retrieval failed: " . $mysqli->error;
}

// Close connection
$mysqli->close();
?>
