<?php
$file = fopen("counter.txt", "r+") or die("Unable to open file!");

// Read the current counter value
$currentValue = intval(fread($file, filesize("counter.txt")));

// Simulate a delay
sleep(5); // Sleep for 5 seconds (simulated delay)

// Simulate user update (increment counter)
$newValue = $currentValue + 1;

// Move to the beginning of the file to update the counter
fseek($file, 0);
fwrite($file, $newValue);

fclose($file);

echo "Counter updated successfully! New value: $newValue";
