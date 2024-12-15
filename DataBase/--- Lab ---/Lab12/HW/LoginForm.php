<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
</head>

<body>
    <h2>Admin Login</h2>
    <form action="LoginForm.php" method="post">
        <label for="admin_username">Username:</label>
        <input type="text" name="admin_username" id="admin_username" required><br><br>

        <label for="admin_password">Password:</label>
        <input type="password" name="admin_password" id="admin_password" required><br><br>

        <input type="submit" name="admin_login" value="Login">
    </form>

    <?php
    session_start();
    if (isset($_POST['admin_login'])) {
        $admin_username = $_POST['admin_username'];
        $admin_password = htmlspecialchars($_POST['admin_password'], ENT_QUOTES, 'UTF-8');

        $mysqli = new mysqli(
            'localhost:8889',
            $admin_username,
            $admin_password,
            'DB_LAB12'
        );

        if ($mysqli->connect_errno) {
            echo "Failed to connect to MySQL: " . $mysqli->connect_error;
        } else {
            $_SESSION['admin'] = true;
            header('Location: DisplayPage.php');
            exit();
        }
    }
    ?>
</body>

</html>