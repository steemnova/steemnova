<?php

$config = file("config.txt");
$connection = mysqli_connect(trim($config[0]), trim($config[1]), trim($config[2]), trim($config[3]));
$database = mysqli_fetch_all(mysqli_query($connection, "SELECT id FROM uni1_users"));

$random_event = rand(1,4);
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
} else if($random_event==2) {
	$text = '<span class="admin">Someone came to our planet in a blue box and improved our energy installation! For 24 hours we will generate more energy.</span>';
	mysqli_query($connection, "INSERT INTO uni1_messages (message_owner, message_sender, message_time, message_type, message_from, message_subject, message_text, message_unread, message_universe) VALUES ($id, 1, $time, 50, '$nickname', '$subject', '$text', 1, 1)");
	$dm = mysqli_fetch_all(mysqli_query($connection, "SELECT dm_energie FROM uni1_users WHERE id=$id"));
	if($dm[0][0]==0) {
	mysqli_query($connection, "UPDATE uni1_users SET dm_energie=($time+86400) WHERE id=$id");
	} else {
	mysqli_query($connection, "UPDATE uni1_users SET dm_energie=dm_energie+86400 WHERE id=$id");
	}
} else if($random_event==3) {
	$text = '<span class="admin">We found the coal reserves! Thanks to it, our ships will be 10% faster! Unfortunately, we do not have too many stocks of this resource ...</span>';
	mysqli_query($connection, "INSERT INTO uni1_messages (message_owner, message_sender, message_time, message_type, message_from, message_subject, message_text, message_unread, message_universe) VALUES ($id, 1, $time, 50, '$nickname', '$subject', '$text', 1, 1)");
	$dm = mysqli_fetch_all(mysqli_query($connection, "SELECT dm_fleettime FROM uni1_users WHERE id=$id"));
	if($dm[0][0]==0) {
	mysqli_query($connection, "UPDATE uni1_users SET dm_fleettime=($time+86400) WHERE id=$id");
	} else {
	mysqli_query($connection, "UPDATE uni1_users SET dm_fleettime=dm_fleettime+86400 WHERE id=$id");
	}
} else if($random_event==4) {
	$text = '<span class="admin">A strange cosmic anomaly caused the water to evaporate suddenly. Scientists are investigating the matter, but thanks to this mysterious phenomenon we have additional space for buildings!</span>';
	mysqli_query($connection, "INSERT INTO uni1_messages (message_owner, message_sender, message_time, message_type, message_from, message_subject, message_text, message_unread, message_universe) VALUES ($id, 1, $time, 50, '$nickname', '$subject', '$text', 1, 1)");
	mysqli_query($connection, "UPDATE uni1_planets SET field_max=field_max+1 WHERE planet_type=1 AND id=$id");
	
}



}

