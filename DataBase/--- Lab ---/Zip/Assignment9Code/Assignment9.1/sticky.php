
<?php
  if (isset($_POST["submit"])) {
	$file = fopen("Sticky_note376.txt", "a");
	// fwrite($file, $_POST['title'] . "\n" . $_POST['note'] . "\n---\n");
	fclose($file);
  }
?>
?>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="sticky.css">
</head>

<body>
    <!-- Display all notes -->
    <?php
    if (file_exists("Sticky_note376.txt")) {
        readfile("Sticky_note376.txt");
    }
    ?>

    <form action="<?= $_SERVER["PHP_SELF"] ?>" method="POST">
        <b>Title</b>: <input type="text" name="title" id="title" size="30"> <br><br>
        <b>Note</b>: <textarea name="note" cols="30" rows="5"></textarea> <br>
        <input type="submit" value="Post!" name="submit">
    </form>
    <hr>

    <div class="post">
        <div class="title">
            <?php
            if (isset($_POST["submit"])) {
                echo htmlspecialchars($_POST['title']);
            }
            ?>
        </div>
        <div class="note">
            <?php
            if (isset($_POST["submit"])) {
                echo nl2br(htmlspecialchars($_POST['note']));
            }
            ?>
        </div>
        <div class="notefoot">
            <?php
            if (isset($_POST["submit"]) && file_exists("Sticky_note376.txt")) {
                $file = fopen("Sticky_note376.txt", "r");
                if ($file) {
                    $content = fread($file, filesize("Sticky_note376.txt"));
                    fclose($file);
                    $totalNotes = substr_count($content, "---");
                    echo "{$totalNotes} notes have been made";
                }
            }
            ?>
        </div>
    </div>
</body>
</html>