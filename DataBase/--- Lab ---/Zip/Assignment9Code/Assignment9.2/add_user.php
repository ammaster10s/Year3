<?php include 'connect.php'; ?>
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
			<div id="div_content" class="form">
				<!-- Main form -->
				<form action="user.php" method="post">
					<h2>User Profile</h2>

					<label>Title</label>
					<select name="title">
						<option value="">-Select Title-</option>
						<option value="Mr">Mr</option>
						<option value="Mrs">Mrs</option>
						<option value="Ms">Ms</option>
					</select>

					<?php
					// Fetch TITLE_ID and TITLE_NAME from TITLE table
					$q = 'select TITLE_ID, TITLE_NAME from TITLE;';
					if ($result = $mysqli->query($q)) {
						while ($row = $result->fetch_array()) {
							echo "<option value=\"{$row[0]}\">{$row[1]}</option>";
						}
					} else {
						echo "Query error: {$mysqli->error}";
					}
					?>

					<label>First name</label>
					<input type="text" name="firstname">

					<label>Last name</label>
					<input type="text" name="lastname">

					<!-- Inline radio buttons for gender -->
					<style>
						.radio-inline {
							display: inline-flex;
							align-items: center;
							margin-right: 15px;
							font-weight: bold;
						}
					</style>

					<label>Gender</label>
					<label class="radio-inline">
						<input type="radio" name="gender" value="Male" checked> Male
					</label>
					<label class="radio-inline">
						<input type="radio" name="gender" value="Female"> Female
					</label>
					<label class="radio-inline">
						<input type="radio" name="gender" value="Other"> Other
					</label>

					<!-- <?php
					// Fetch GENDER_ID and GENDER_NAME from GENDER table
					// Set $userGroupId to a default value if $row['USER_GROUPID'] is not available
					$userGroupId = isset($row['USER_GROUPID']) ? $row['USER_GROUPID'] : '';

					$q3 = "SELECT USERGROUP_ID, USERGROUP_NAME FROM USER_GROUP";
					if ($result3 = $mysqli->query($q3)) {
						while ($row3 = $result3->fetch_array()) {
							// Compare with $userGroupId instead of $row['USER_GROUPID']
							$selected = $row3['USERGROUP_ID'] == $userGroupId ? "selected" : "";
							echo "<option value='{$row3['USERGROUP_ID']}' $selected>{$row3['USERGROUP_NAME']}</option>";
						}
					} else {
						echo "Query error: {$mysqli->error}";
					}

					echo "</select><br>";

					?> -->

					</select>

					<br><br>
					<label>Email</label>
					<input type="email" name="email" required>

					<h2>Account Profile</h2>

					<label>Username</label>
					<input type="text" name="username" required>

					<label>Password</label>
					<input type="password" name="passwd" required>

					<label>Confirm Password</label>
					<input type="password" name="cpasswd" required>

					<label>User group</label>
					<select name="usergroup">
						<?php
						// Fetch USERGROUP_ID and USERGROUP_NAME from USERGROUP table
						$q = 'select USERGROUP_ID, USERGROUP_NAME from USER_GROUP;';
						if ($result = $mysqli->query($q)) {
							while ($row = $result->fetch_array()) {
								echo "<option value=\"{$row[0]}\">{$row[1]}</option>";
							}
						} else {
							echo "Query error: {$mysqli->error}";
						}
						?>
					</select>

					<label>Disabled</label>
					<input type="checkbox" name="disabled" value="1">
					<input type="hidden" name="page" value="adduser">
					<div class="center">
						<input type="submit" name="sub" value="Submit">
					</div>
				</form>
			</div> <!-- end div_content -->
		</div> <!-- end div_main -->

		<div id="div_footer"></div>
	</div>
</body>

</html>