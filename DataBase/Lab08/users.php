<?php
session_start();  
error_reporting(~E_NOTICE);  

?>
<!-- link to the style sheet "default1.css"-->
<link rel="stylesheet" href="default1.css">

<!-- Add the given image "back.jpg" as illustrated (no repeat and cover the page) -->

<head>
<style>
body {
  background-image: url('back.jpg');
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center;
}
</style>
</head>

<!-- Add php content to restrict only the user with password to enter -->

<!-- php file begin-->
<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['username']) && isset($_POST['passwd']) && isset($_POST['cpasswd'])) {
        $_SESSION['username'] = $_POST['username'];
        $_SESSION['passwd'] = $_POST['passwd'];
        $_SESSION['cpasswd'] = $_POST['cpasswd'];
    }
}

if (isset($_SESSION['username']) && $_SESSION['username'] == "Admin" &&
    isset($_SESSION['passwd']) && $_SESSION['passwd'] == "1234" &&
    isset($_SESSION['cpasswd']) && $_SESSION['cpasswd'] == "1234") {
    $_SESSION["username"] = $username;
    
    $is_logged_in = true;

} else {
    $is_logged_in = false;

    if (!isset($_SESSION['time'])) {
        $_SESSION['time'] = time(); // Store the current time
    }

    // Calculate the current session duration
    $duration = time() - $_SESSION['time'];
    $remaining_time = 30 - $duration;
    if ($remaining_time <= 0) {
        $txt = "history.go(-1);";
        echo "<h1>You do not have access to this page!</h1>";
        echo "<button onclick='history.go(-1);'>Back</button>";
        session_unset();
        session_destroy();
        $is_logged_in = false;

    } else {
        echo "<h1>You do not have access to this page!</h1>";
        echo "<p id='message'>You will be given the redirecting button in <span id='countdown'>$remaining_time</span> seconds.</p>";
        header("Refresh:1");
    }
    
    $is_logged_in = false;
}

if ($is_logged_in):
?>


<!-- the heading is given as " Welcome Mr./Mrs./Ms. User Name", change the font to Arial, size of font to 200%, make the text appear in center-->
<h1 style="font-family: Arial; font-size: 200%; text-align: center;">
  Welcome 
  <?php 
  if (isset($_POST['title']) && isset($_POST['firstname']) && isset($_POST['lastname'])) {
      // Check if the fields are not empty
      if (!empty($_POST['title']) && !empty($_POST['firstname']) && !empty($_POST['lastname'])) {
          // Output the user's title and name if all fields are filled
          echo htmlspecialchars($_POST["title"]), " ", htmlspecialchars($_POST["firstname"]), " ", htmlspecialchars($_POST["lastname"]), "!!!";
      } else {
          // If fields are set but empty, show a message
          echo "Please fill all information.";
      }
  } else {
      // Fallback if the fields are not set
      echo "Please fill all information.";
  }
  ?>
</h1>


<!-- add the image "avatar.png", height to 240 pixels-->
<img src="avatar.png" alt="Avatar</p>" class="avatar" height="240">
<!-- change the font to Arial,size of font to 170%-->
<h3 style="font-family: Arial; font-size: 170%;"> This is your profile </h3>

<!-- change the font to Arial-->
<p>
	<?php
	echo "Name:", " ", $_POST["title"], " ", $_POST["firstname"], " ", $_POST["lastname"], "<br>";
	//--add "User Group: usergroup"-- 
    echo "User Group: ", $_POST["usergroup"], "<br>";

	//-- add "Email address: Email"-- 
    echo "Email address: ", $_POST["email"], "<br>";

	//-- Find the gender and output "Gender: gender"-- 
    $Temp;
    if ($_POST["title"] == "Mr."){
        echo "Gender: Male", "<br>";
    }
    else if ($_POST["title"] == "Mrs." || $_POST["title"] == "Ms."){
        echo "Gender: Female",  "<br>";
    }
   





	//-- Find the age and output as "Age in years: age"--
	$bday = $_POST["birthdate"]; // Your date of birth
    echo "Age in years: ", date_diff(date_create($bday), date_create('today'))->y, "<br>";
	//-- set default time zone--
	date_default_timezone_set("Asia/Bangkok");
	//-- print the login type as " Login time (local): time on date"-- 
    // echo "Login time (local): ", date("H:i:s"), " on ", date("Y-m-d"), "<br>"; 24 Hour Format

    echo "Login time (local): ", date("g:i:s A"), " on ", date("Y-m-d"), "<br>";  //12 Hour Format


	?>
</p>

<!-- change font to Arial, bold and font size to 150%-->
<p style="font-family: Arial; font-size: 150%;font-weight: bold;">Welcome to the CSS326 system <br></p>

<p style="font-family: Arial">
	Whether you are an experienced programmer or not, this website is intended for everyone who wishes to learn Database programming.
	There is no need to download anything - just click on the chapter you wish to begin from, and follow the instructions. <br> </p>

<!-- Remeber how you formatted the links in previous lab-->
<div class="menu-container">
    <ul class="menu">
        <li><a href="https://www.learn-php.org/en/Hello%2C_World%21" target="_blank">Hello World!</a></li>
        <li><a href="https://www.learn-php.org/en/Variables_and_Types" target="_blank">Variables</a></li>
        <li><a href="https://www.learn-php.org/en/For_loops" target="_blank">For Loops</a></li>
        <li><a href="https://www.learn-php.org/en/Functions" target="_blank">Functions</a></li>
        <li><a href="https://www.learn-php.org/en/While_loops" target="_blank">While Loops</a></li>
    </ul>
</div>


<!-- </div> -->

<!-- Change to bold, font to Arial and text size to 120% and Center the text-->

<p style="font-family: Arial; font-size: 120%; text-align: center;"> Good Luck!</p>

<?php
        echo "<button onclick='history.go(-1);'>Back</button>";
?>

<?php endif; ?>
</body>

</html>