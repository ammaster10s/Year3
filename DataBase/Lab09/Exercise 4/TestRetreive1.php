<?php

$mysqli = new mysqli("localhost:8889", "root", "root", "lab09");

// Check connection
if ($mysqli->connect_errno) {
    die("Connection failed: " . $mysqli->connect_errno . ": " . $mysqli->connect_error);
}


$q = "SELECT p_id from product where p_name like 'P%';";

if ( $result= $mysqli->query(($q))){

    $count = $result->num_rows;
    echo "there are $count products starting with P<br>";
    $result->free();

}
else {
    echo "Retrieval failed: " . $mysqli->error;
}

$q = "SElECT * from Product limit 1;";
if ( $result= $mysqli->query($q)) {
    $count = $result->field_count;
    echo "There are $count columns.<br>";
    $result->free();
}
else{
    echo "Query failed: ". $mysqli->error;
}

$q = "SELECT p_name , p_price from product order by p_price limit 3;" ;
if ($result = $mysqli->query($q)){
    $result->data_seek(2);
    $row = $result->fetch_assoc();
    echo $row['p_name'] . " has the third lowest price which is: " . $row['p_price'] . "<br>";
    $result->free();

}
else {
    echo "Query failed: ". $mysqli->error;
}

