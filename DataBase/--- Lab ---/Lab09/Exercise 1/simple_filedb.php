<?php
  if (isset($_POST["submit"])) {
    $file = fopen("mydb.txt", "w");
    fwrite($file, $_POST['note']);
    fclose($file);
  }
?>

<!DOCTYPE html>
<html>
  <head>
    <title>Simple File DB</title>
  </head>
  <body>
    <p style="border:solid 1px gray;background-color:#EEEEEE">
      <?php
        readfile("mydb.txt");
      ?>
    </p>
    <hr/>
    <form action="simple_filedb.php" method="POST">
      <b>Note</b>: <textarea name="note" cols="30" rows="5"></textarea> <br>
      <input type="submit" value="Save to DB" name="submit">
    </form>
  </body>
</html>

