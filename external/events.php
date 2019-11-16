<?php

$config = file("config.txt");
$connection = mysqli_connect(trim($config[0]), trim($config[1]), trim($config[2]), trim($config[3]));
$database = mysqli_fetch_all(mysqli_query($connection, "SELECT id FROM uni1_users"));

$random_event = rand(1,1);
$time = time();
$nickname = '<span class="admin">SteemNova Event System</span>';
$subject = '<span class="admin">New Event</span>';

for($i=0; $i<=(count($database)-1); $i++) {
$id = $database[$i][0];


if($random_event==1) {
	$text = '<span class="admin">Space pirates stole 10% of our resources and fled before we could send the fleet. We need to be more vigilant for the second time!</span>';
	mysqli_query($connection, "INSERT INTO uni1_messages (message_owner, message_sender, message_time, message_type, message_from, message_subject, message_text, message_unread, message_universe) VALUES ($id, 1, $time, 50, '$nickname', '$subject', '$text', 1, 1)");
	mysqli_query($connection, "UPDATE uni1_planets SET metal=(metal*0.9)");
	mysqli_query($connection, "UPDATE uni1_planets SET crystal=(crystal*0.9)");
	mysqli_query($connection, "UPDATE uni1_planets SET deuterium=(deuterium*0.9)"); 
}

}

