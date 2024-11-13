<?php
require_once 'connect.php';

// Check if either 'id' or 'userid' parameter is set in the URL
if (isset($_GET['id']) || isset($_GET['userid'])) {
    if (isset($_GET['id'])) {
        // 'id' is provided, so prepare to delete from USER_GROUP table
        $id = intval($_GET['id']);

        // Check for associated users in USER table before deletion
        $checkQuery = "SELECT COUNT(*) AS user_count FROM USER WHERE USER_GROUPID = ?";
        if ($stmt = $mysqli->prepare($checkQuery)) {
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $stmt->bind_result($user_count);
            $stmt->fetch();
            $stmt->close();

            if ($user_count > 0) {
                echo "Cannot delete this user group as it is associated with $user_count users.";
                $mysqli->close();
                exit();
            }
        }

        // No associated users, proceed to delete the group
        $query = "DELETE FROM USER_GROUP WHERE USERGROUP_ID = ?";
        $redirect_url = "group.php"; // Redirect to group page after deletion

    } elseif (isset($_GET['userid'])) {
        // 'userid' is provided, so prepare to delete from USER table
        $id = intval($_GET['userid']);
        $query = "DELETE FROM USER WHERE USER_ID = ?";
        $redirect_url = "user.php"; // Redirect to user page after deletion
    }

    // Prepare and execute the delete statement
    if ($stmt = $mysqli->prepare($query)) {
        $stmt->bind_param("i", $id);
        if ($stmt->execute()) {
            // Successful deletion, redirect to the specified page
            $stmt->close();
            $mysqli->close();
            header("Location: $redirect_url");
            exit();
        } else {
            echo "DELETE failed. Error: " . $stmt->error;
        }
    } else {
        echo "Preparation failed. Error: " . $mysqli->error;
    }
} else {
    echo "No ID specified.";
}

$mysqli->close();
?>
