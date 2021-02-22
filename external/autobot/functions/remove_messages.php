<?php

$config = file("config.txt");
$connection = mysqli_connect(trim($config[0]), trim($config[1]), trim($config[2]), trim($config[3]));
$get_bots = mysqli_fetch_all(mysqli_query($connection, "SELECT id FROM uni1_users WHERE email='bot'"));

for($i=0; $i<=count($get_bots)-1; $i++) {
	$id_bot = $get_bots[$i][0];
	mysqli_query($connection, "DELETE FROM uni1_messages WHERE (message_owner = $id_bot AND message_sender = 0)");
}

?>