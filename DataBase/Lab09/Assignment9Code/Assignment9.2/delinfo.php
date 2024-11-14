<?php
require_once 'connect.php';

if (isset($_GET['id']) || isset($_GET['userid'])) {
    if (isset($_GET['id'])) {
        $id = intval($_GET['id']);

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

        $query = "DELETE FROM USER_GROUP WHERE USERGROUP_ID = ?";
        $redirect_url = "group.php";

    } elseif (isset($_GET['userid'])) {
        $id = intval($_GET['userid']);

        $fetchQuery = "SELECT USER_TITLE, USER_GENDER FROM USER WHERE USER_ID = ?";
        if ($stmt = $mysqli->prepare($fetchQuery)) {
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $stmt->bind_result($title_id, $gender_id);
            $stmt->fetch();
            $stmt->close();
        } else {
            echo "Error fetching user data: " . $mysqli->error;
            $mysqli->close();
            exit();
        }

        $query = "DELETE FROM USER WHERE USER_ID = ?";
        $redirect_url = "user.php";
    }

    if ($stmt = $mysqli->prepare($query)) {
        $stmt->bind_param("i", $id);
        if ($stmt->execute()) {
            $stmt->close();

            if (isset($title_id) && isset($gender_id)) {
                $titleCheckQuery = "SELECT COUNT(*) AS title_count FROM USER WHERE USER_TITLE = ?";
                if ($stmt = $mysqli->prepare($titleCheckQuery)) {
                    $stmt->bind_param("i", $title_id);
                    $stmt->execute();
                    $stmt->bind_result($title_count);
                    $stmt->fetch();
                    $stmt->close();

                    if ($title_count == 0) {
                        $titleDeleteQuery = "DELETE FROM TITLE WHERE TITLE_ID = ?";
                        if ($stmt = $mysqli->prepare($titleDeleteQuery)) {
                            $stmt->bind_param("i", $title_id);
                            $stmt->execute();
                            $stmt->close();
                        }
                    }
                }

                $genderCheckQuery = "SELECT COUNT(*) AS gender_count FROM USER WHERE USER_GENDER = ?";
                if ($stmt = $mysqli->prepare($genderCheckQuery)) {
                    $stmt->bind_param("i", $gender_id);
                    $stmt->execute();
                    $stmt->bind_result($gender_count);
                    $stmt->fetch();
                    $stmt->close();

                    if ($gender_count == 0) {
                        $genderDeleteQuery = "DELETE FROM GENDER WHERE GENDER_ID = ?";
                        if ($stmt = $mysqli->prepare($genderDeleteQuery)) {
                            $stmt->bind_param("i", $gender_id);
                            $stmt->execute();
                            $stmt->close();
                        }
                    }
                }
            }

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
