<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
// Retrieve form data
$username = $_POST['username'];
// Process the data (in this example, we'll just display it)
echo "Hello, $username! You have submitted the form.";
} else {
// Handle cases where the form wasn't submitted via POST
echo "Form not submitted.";
}
?>