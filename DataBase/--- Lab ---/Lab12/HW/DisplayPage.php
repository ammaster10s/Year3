<?php
session_start();

if (!isset($_SESSION['admin'])) {
    session_destroy();
    header('Location: LoginForm.php');
    exit();
} else {
    $mysqli = new mysqli(
        'localhost:8889',
        'admin',
        'admin-user',
        'DB_LAB12'
    );

    if ($mysqli->connect_errno) {
        echo "Failed to connect to MySQL: " . $mysqli->connect_error;
        exit();
    }
}

$query = "SELECT * FROM account_view";
$result = $mysqli->query($query);

if (!$result) {
    echo "Query failed. Error: " . $mysqli->error;
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Display Account View</title>
</head>

<body>
    <h2>Login Successfully</h2>

    <table border="1">
        <tr>
            <th>Account No.</th>
            <th>Name</th>
            <th>Balance</th>
        </tr>

        <?php
        while ($row = $result->fetch_assoc()) { ?>
            <tr>
                <td><?php echo htmlspecialchars($row['Account No.']); ?></td>
                <td><?php echo htmlspecialchars($row['Name']); ?></td>
                <td><?php echo htmlspecialchars($row['Balance']); ?></td>
            </tr>
        <?php } ?>
    </table>
    <br><a href="DisplayPage.php?logout=true">Logout</a>
    <?php
    if (isset($_GET['logout'])) {
        session_destroy();
        header("Location: LoginForm.php");
        exit();
    }
    ?>
</body>

</html>

<?php
$mysqli->close();
?>