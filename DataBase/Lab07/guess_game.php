<?php
$randomNumber = rand(1, 10);
$message = "";
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $userGuess = $_POST["guess"];
    if  ($userGuess == $randomNumber) {
        $message = "Correct! You guessed the number.";
    } else {
        $message = "Try again!";
    }
}
?>
<!DOCTYPE html>
<html>

<head>
    <title>Guess the Number</title>
</head>

<body>
    <h1>Guess the Number Game</h1>
    <form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
        Enter your guess (1-10): <input type="text" name="guess"><br>
        <input type="submit" value="Submit Guess">
    </form>
    <p><?php echo $message; ?></p>
</body>

</html>