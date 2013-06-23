<?php
echo "Werckered!"

// we connect to example.com and port 3307
$link = mysql_connect($_ENV['WERCKER_MYSQL_HOST'] . ':' . $_ENV['WERCKER_MYSQL_PORT'], $_ENV['WERCKER_MYSQL_USERNAME'], $_ENV['WERCKER_MYSQL_PASSWORD']);
if (!$link) {
    die('Could not connect: ' . mysql_error());
}
echo 'Connected successfully';
mysql_close($link);

?>
