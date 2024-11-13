<?php
require_once 'connect.php';
?>
<!DOCTYPE html>
<html>

<head>
	<title>CSS326 Sample</title>
	<link rel="stylesheet" href="default.css">
</head>

<body>

	<div id="wrapper">
		<?php include 'header.php'; ?>
		<div id="div_main">
			<div id="div_left"></div>
			<div id="div_content" class="usergroup">
				<!--%%%%% Main block %%%%-->
				<?php
				if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['sub'])) {
					// Collect and validate form data
					$title_name = !empty($_POST['title']) ? $mysqli->real_escape_string($_POST['title']) : null;
					$firstname = $mysqli->real_escape_string($_POST['firstname']);
					$lastname = $mysqli->real_escape_string($_POST['lastname']);
					$gender_name = !empty($_POST['gender']) ? $mysqli->real_escape_string($_POST['gender']) : null;
					$email = $mysqli->real_escape_string($_POST['email']);
					$username = $mysqli->real_escape_string($_POST['username']);
					$password = $_POST['passwd'];
					$usergroup_id = !empty($_POST['usergroup']) ? $mysqli->real_escape_string($_POST['usergroup']) : null;
					$disabled = isset($_POST['disabled']) ? 1 : 0;

					// Check for missing required fields
					if ($title_name === null || $gender_name === null || $usergroup_id === null) {
						echo "Error: Please ensure all required fields are selected.";
						exit;
					}

					if ($password == $_POST["cpasswd"]) {
						echo "Passwords match!";
					} else {
						echo "Error: Passwords do not match.";
						exit;
					}
					// Insert or fetch Title ID
					$titleQuery = "INSERT INTO TITLE (TITLE_NAME) VALUES ('$title_name') ON DUPLICATE KEY UPDATE TITLE_ID=LAST_INSERT_ID(TITLE_ID)";
					if ($mysqli->query($titleQuery)) {
						$title_id = $mysqli->insert_id;
					} else {
						echo "Error inserting title: {$mysqli->error}";
						exit;
					}

					// Insert or fetch Gender ID
					$genderQuery = "INSERT INTO GENDER (GENDER_NAME) VALUES ('$gender_name') ON DUPLICATE KEY UPDATE GENDER_ID=LAST_INSERT_ID(GENDER_ID)";
					if ($mysqli->query($genderQuery)) {
						$gender_id = $mysqli->insert_id;
					} else {
						echo "Error inserting gender: {$mysqli->error}";
						exit;
					}

					// Insert into User
					$userInsertQuery = "INSERT INTO USER (USER_TITLE, USER_FNAME, USER_LNAME, USER_GENDER, USER_EMAIL, USER_NAME, USER_PASSWD, USER_GROUPID, DISABLE) 
                    VALUES ('$title_id', '$firstname', '$lastname', '$gender_id', '$email', '$username', '$password', '$usergroup_id', '$disabled')";

					if ($mysqli->query($userInsertQuery)) {
						echo "User added successfully!";
					} else {
						echo "Error inserting user: {$mysqli->error}";
					}
				}
				?>
				<h2>User Profile</h2>
				<table>
					<col width="15%">
					<col width="30%">
					<col width="30%">
					<col width="20%">
					<col width="5%">

					<tr>
						<th>Title</th>
						<th>Name</th>
						<th>Email</th>
						<th>User Group</th>
						<th>Disabled</th>
						<th>Edit</th>
						<th>Del</th>
					</tr>
					<?php
					$q = "SELECT * FROM USER 
					      JOIN USER_GROUP ON USER.USER_GROUPID = USER_GROUP.USERGROUP_ID 
					      JOIN TITLE ON USER.USER_TITLE = TITLE.TITLE_ID 
					      JOIN GENDER ON USER.USER_GENDER = GENDER.GENDER_ID";
					$result = $mysqli->query($q);
					if (!$result) {
						echo "Error fetching users: {$mysqli->error}";
					} else {
						while ($row = $result->fetch_array()) { ?>
							<tr>
								<td><?php echo $row['TITLE_NAME']; ?></td>
								<td><?php echo $row['USER_FNAME'] . " " . $row['USER_LNAME']; ?> (<?php echo $row['GENDER_NAME']; ?>)</td>
								<td><?php echo $row['USER_EMAIL']; ?></td>
								<td><?php echo $row['USERGROUP_NAME']; ?></td>
								<td><input type='checkbox' <?php if ($row['DISABLE']) echo "CHECKED"; ?> disabled></td>
								<td>
									<a href="edit_user.php?id=<?php echo $row['USER_ID']; ?>">
										<img src="images/Modify.png" width="24" height="24" alt="Edit">
									</a>
								</td>
								<td>
									<a href="delinfo.php?userid=<?php echo $row['USER_ID']; ?>">
										<img src="images/Delete.png" width="24" height="24" alt="Delete">
									</a>
								</td>
							</tr>
						<?php }
						?>
						<tr>
							<td colspan="6" style="text-align: right; font-weight: bold;">
								<?php
								$totalRecords = $result->num_rows;
								echo "Total Records: $totalRecords";
								?>
							</td>
						</tr>
					<?php } ?>
				</table>
			</div> <!-- end div_content -->

		</div> <!-- end div_main -->

		<div id="div_footer"></div>
	</div>
</body>

</html>