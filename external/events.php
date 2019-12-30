<?php

$config = file("config.txt");
$connection = mysqli_connect(trim($config[0]), trim($config[1]), trim($config[2]), trim($config[3]));
$database = mysqli_fetch_all(mysqli_query($connection, "SELECT id FROM uni1_users"));

$random_event = rand(1,7);
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
	break;
} else if($random_event==2) {
	$text = '<span class="admin">Someone came to our planet in a blue box and improved our energy installation! For 24 hours we will generate more energy.</span>';
	mysqli_query($connection, "INSERT INTO uni1_messages (message_owner, message_sender, message_time, message_type, message_from, message_subject, message_text, message_unread, message_universe) VALUES ($id, 1, $time, 50, '$nickname', '$subject', '$text', 1, 1)");
	$dm = mysqli_fetch_all(mysqli_query($connection, "SELECT dm_energie FROM uni1_users WHERE id=$id"));
	if($dm[0][0]<$time) {
	mysqli_query($connection, "UPDATE uni1_users SET dm_energie=($time+86400) WHERE id=$id");
	} else {
	mysqli_query($connection, "UPDATE uni1_users SET dm_energie=dm_energie+86400 WHERE id=$id");
	}
} else if($random_event==3) {
	$text = '<span class="admin">We found the coal reserves! Thanks to it, our ships will be 10% faster! Unfortunately, we do not have too many stocks of this resource ...</span>';
	mysqli_query($connection, "INSERT INTO uni1_messages (message_owner, message_sender, message_time, message_type, message_from, message_subject, message_text, message_unread, message_universe) VALUES ($id, 1, $time, 50, '$nickname', '$subject', '$text', 1, 1)");
	$dm = mysqli_fetch_all(mysqli_query($connection, "SELECT dm_fleettime FROM uni1_users WHERE id=$id"));
	if($dm[0][0]<$time) {
	mysqli_query($connection, "UPDATE uni1_users SET dm_fleettime=($time+86400) WHERE id=$id");
	} else {
	mysqli_query($connection, "UPDATE uni1_users SET dm_fleettime=dm_fleettime+86400 WHERE id=$id");
	}
} else if($random_event==4) {
	$text = '<span class="admin">A strange cosmic anomaly caused the water to evaporate suddenly. Scientists are investigating the matter, but thanks to this mysterious phenomenon we have additional space for buildings!</span>';
	mysqli_query($connection, "INSERT INTO uni1_messages (message_owner, message_sender, message_time, message_type, message_from, message_subject, message_text, message_unread, message_universe) VALUES ($id, 1, $time, 50, '$nickname', '$subject', '$text', 1, 1)");
	mysqli_query($connection, "UPDATE uni1_planets SET field_max=field_max+1 WHERE planet_type=1");
	break;
} else if($random_event==5) {
	$text = '<span class="admin">We found a magic button on the ships. It turned out that it increases the shield of the ship for some time. For the next 24 hours our ships will be better protected from enemy attacks!</span>';
	mysqli_query($connection, "INSERT INTO uni1_messages (message_owner, message_sender, message_time, message_type, message_from, message_subject, message_text, message_unread, message_universe) VALUES ($id, 1, $time, 50, '$nickname', '$subject', '$text', 1, 1)");
	$dm = mysqli_fetch_all(mysqli_query($connection, "SELECT dm_defensive FROM uni1_users WHERE id=$id"));
	if($dm[0][0]<$time) {
	mysqli_query($connection, "UPDATE uni1_users SET dm_defensive=($time+86400) WHERE id=$id");
	} else {
	mysqli_query($connection, "UPDATE uni1_users SET dm_defensive=dm_defensive+86400 WHERE id=$id");
	}
} else if($random_event==6) {
	$text = '<span class="admin">Our planets were attacked by pirates, we managed to destroy them by throwing rocks (not minerals). In orbit of our planets there are remains that you can collect with a recycler!</span>';
	mysqli_query($connection, "INSERT INTO uni1_messages (message_owner, message_sender, message_time, message_type, message_from, message_subject, message_text, message_unread, message_universe) VALUES ($id, 1, $time, 50, '$nickname', '$subject', '$text', 1, 1)");
	$metal = rand(1, 1000);
	$crystal = rand(1, 500);
	$mother_planet = mysqli_fetch_all(mysqli_query($connection, "SELECT galaxy, system, planet FROM uni1_users"));
	for($i=0; $i<=(count($mother_planet)-1); $i++) {
	$galaxy = $mother_planet[$i][0];
	$system = $mother_planet[$i][1];
	$planet = $mother_planet[$i][2];
	mysqli_query($connection, "UPDATE uni1_planets SET der_metal=der_metal+$metal WHERE (galaxy=$galaxy AND system=$system AND planet=$planet)");
	mysqli_query($connection, "UPDATE uni1_planets SET der_crystal=der_crystal+$crystal WHERE (galaxy=$galaxy AND system=$system AND planet=$planet)");
	}
} else if($random_event==7) {
	$text = '<span class="admin">Strange thing. It turned out that one of the citizens detained by the police had small amounts of dark matter in his trouser pocket. Of course, we seized it.</span>';
	mysqli_query($connection, "INSERT INTO uni1_messages (message_owner, message_sender, message_time, message_type, message_from, message_subject, message_text, message_unread, message_universe) VALUES ($id, 1, $time, 50, '$nickname', '$subject', '$text', 1, 1)");
	$dm = rand(1, 350);
	mysqli_query($connection, "UPDATE uni1_users SET darkmatter=darkmatter+$dm");
	break;
}

}