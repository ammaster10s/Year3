<?php
require_once 'connect.php';

if (isset($_POST['sub'])) {
	// Extract all data from POST
	$userid = $_POST['userid'];
	$title = $mysqli->real_escape_string($_POST['title']);
	$firstname = $mysqli->real_escape_string($_POST['firstname']);
	$lastname = $mysqli->real_escape_string($_POST['lastname']);
	$gender = $mysqli->real_escape_string($_POST['gender']);
	$email = $mysqli->real_escape_string($_POST['email']);
	$username = $mysqli->real_escape_string($_POST['username']);
	$passwd = $mysqli->real_escape_string($_POST['passwd']);
	$usergroup = $mysqli->real_escape_string($_POST['usergroup']);
	$disabled = isset($_POST['disabled']) ? 1 : 0;

	$q = "UPDATE USER SET USER_TITLE='$title', USER_FNAME='$firstname', USER_LNAME='$lastname', 
		  USER_GENDER='$gender', USER_EMAIL='$email', USER_NAME='$username',
		  USER_PASSWD='$passwd', USER_GROUPID='$usergroup', DISABLE='$disabled' 
		  WHERE USER_ID='$userid'";

	$result = $mysqli->query($q);
	if (!$result) {
		echo "Update failed. Error: {$mysqli->error}";
		return false;
	}
	header("Location: user.php");
	exit();
}
?>

<!DOCTYPE html>
<html>

<head>
	<title>Edit User Profile</title>
	<link rel="stylesheet" href="default.css">
</head>

<body>

	<div id="wrapper">
		<?php include 'header.php'; ?>
		<div id="div_main">
			<div id="div_left"></div>
			<div id="div_content" class="form">
				<h2>Edit User Profile</h2>

				<?php
				$userid = $_GET['id'];
				$q = "SELECT * FROM USER WHERE USER_ID = $userid";
				$result = $mysqli->query($q);

				if ($result && $row = $result->fetch_array()) {
					echo "<form action='edit_user.php' method='post'>";

					// Title selection
					echo "<label>Title</label>";
					echo "<select name='title'>";
					$q1 = "SELECT TITLE_ID, TITLE_NAME FROM TITLE";
					if ($result1 = $mysqli->query($q1)) {
						while ($row1 = $result1->fetch_array()) {
							$selected = $row1['TITLE_ID'] == $row['USER_TITLE'] ? "selected" : "";
							echo "<option value='{$row1['TITLE_ID']}' $selected>{$row1['TITLE_NAME']}</option>";
						}
					} else {
						echo "Query error: {$mysqli->error}";
					}
					echo "</select><br>";

					// First name
					echo "<label>First Name</label>";
					echo "<input type='text' name='firstname' value='{$row['USER_FNAME']}'><br>";

					// Last name
					echo "<label>Last Name</label>";
					echo "<input type='text' name='lastname' value='{$row['USER_LNAME']}'><br>";

					// Gender selection
					echo "<label>Gender</label>";
					$q2 = 'select GENDER_ID, GENDER_NAME from GENDER;';
					if ($result2 = $mysqli->query($q2)) {
						while ($row2 = $result2->fetch_array()) {
							echo "<input ";
							if ($row2[0] == $row['USER_GENDER'])
								echo "CHECKED='CHECKED'";
							echo "type='radio' name='gender' value='$row2[0]' >" . $row2[1];
						}
					} else {
						echo "Query error: {$mysqli->error}";
					}
					echo "<br>";

					// Email
					echo "<label>Email</label>";
					echo "<input type='email' name='email' value='{$row['USER_EMAIL']}'><br>";

					// Account Profile section
					echo "<h2>Account Profile</h2>";

					// Username
					echo "<label>Username</label>";
					echo "<input type='text' name='username' value='{$row['USER_NAME']}'><br>";

					// Password
					echo "<label>Password</label>";
					echo "<input type='password' name='passwd' value='{$row['USER_PASSWD']}'><br>";

					// Confirmed Password
					echo "<label>Confirm Password</label>";
					echo "<input type='password' name='cpasswd' value='{$row['USER_PASSWD']}'><br>";

					// User group selection
					echo "<label>User Group</label>";
					echo "<select name='usergroup'>";
					$q3 = "SELECT USERGROUP_ID, USERGROUP_NAME FROM USER_GROUP";
					if ($result3 = $mysqli->query($q3)) {
						while ($row3 = $result3->fetch_array()) {
							$selected = $row3['USERGROUP_ID'] == $row['USER_GROUPID'] ? "selected" : "";
							echo "<option value='{$row3['USERGROUP_ID']}' $selected>{$row3['USERGROUP_NAME']}</option>";
						}
					} else {
						echo "Query error: {$mysqli->error}";
					}
					echo "</select><br>";

					// Disabled checkbox
					echo "<label>Disabled</label>";
					$checked = $row['DISABLE'] == 1 ? "checked" : "";
					echo "<input type='checkbox' name='disabled' $checked><br>";

					// Hidden user ID and submit button
					echo "<input type='hidden' name='userid' value='{$row['USER_ID']}'>";
					echo "<div class='center'>";
					echo "<input type='submit' name='sub' value='Submit' style='display: inline-block;'>";
					echo "<input type='reset' value='Cancel' style='display: inline-block;'>";

					echo "</div>";

					echo "</form>";
				} else {
					echo "No user found with the given ID or query error.";
				}
				?>
			</div> <!-- end div_content -->

		</div> <!-- end div_main -->

		<div id="div_footer"></div>
	</div>
</body>

</html>