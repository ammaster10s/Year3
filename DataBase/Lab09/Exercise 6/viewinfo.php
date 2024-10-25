<?php

$mysqli = new mysqli("localhost:8889", "root", "root", "lab09");

if($mysqli->connect_errno) {
    die("Connection failed: " . $mysqli->connect_errno . ": " . $mysqli->connect_error);
}

$q = "SELECT * from product";

if ($result = $mysqli->query($q)) {
    echo '<table border="1">';
    echo '<tr><th>Id</th><th>Name</th><th>Price</th></tr>';
    while ($row = $result->fetch_array()){

        echo "<tr>";
        echo "<td>" . $row['p_name'] . "</td>";
        echo "<td>" . $row['p_price'] . "</td>";
        echo "<td><a href='delinfo.php?id=" . $row['p_id'] . "'>Delete</a></td>";
        echo "</tr>";

    }
    echo '<table>';
    $result->free();
} else {
    echo "Retrieval failed: " . $mysqli->error;
}
?>