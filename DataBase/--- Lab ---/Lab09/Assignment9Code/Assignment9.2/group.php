<?php require_once 'connect.php'; ?>
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
			<div id="div_left">

			</div>
			<div id="div_content" class="usergroup">
				<!--%%%%% Main block %%%%-->
				<?php
				if (isset($_POST['submit'])) {
					// Retrieve form data
					$groupcode = $_POST['groupcode'];
					$groupname = $_POST['groupname'];
					$remark = $_POST['remark'];
					$url = $_POST['url'];

					// Prepare and execute the insert statement
					$sqlinsert = "INSERT INTO USER_GROUP (USERGROUP_CODE, USERGROUP_NAME, USERGROUP_REMARK, USERGROUP_URL) VALUES ('$groupcode', '$groupname', '$remark', '$url')";

					// Execute the query
					if ($mysqli->query($sqlinsert) === TRUE) {
					} else {
					}
				}
				?>


				<h2>User Group</h2>
				<table>
					<col width="10%">
					<col width="20%">
					<col width="30%">
					<col width="30%">
					<col width="5%">
					<col width="5%">

					<tr>
						<th>Group Code</th>
						<th>Group Name</th>
						<th>Remark</th>
						<th>URL</th>
						<th>Edit</th>
						<th>Del</th>
					</tr>
					<?php
					$q = "select * from USER_GROUP";
					$result = $mysqli->query($q);
					if (!$result) {
						echo "Select failed. Error: {$mysqli->error}";
						return false;
					}

					while ($row = $result->fetch_array()) { ?>
						<tr>
							<td><?php echo $row['USERGROUP_CODE']; ?></td>
							<td><?php echo $row['USERGROUP_NAME']; ?></td>
							<td><?php echo $row['USERGROUP_REMARK']; ?></td>
							<td><?php echo $row['USERGROUP_URL']; ?></td>
							<td>
								<a href="edit_group.php?id=<?php echo $row['USERGROUP_ID']; ?>">
									<img src="images/Modify.png" width="24" height="24" alt="Edit">
								</a>
							</td>
							<td>
								<a href="delinfo.php?id=<?php echo $row['USERGROUP_ID']; ?>">
									<img src="images/Delete.png" width="24" height="24" alt="Delete">
								</a>
							</td>
						</tr>
					<?php } ?>
					<tr>
						<td colspan="6" style="text-align: right; font-weight: bold;">
							<?php
							$totalRecords = $result->num_rows;
							echo "Total Records: $totalRecords";
							?>
						</td>
					</tr>
				</table>

			</div> <!-- end div_content -->

		</div> <!-- end div_main -->

		<div id="div_footer">

		</div>

	</div>
</body>

</html>