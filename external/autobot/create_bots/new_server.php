<?php

$config = file("config.txt");
$connection = mysqli_connect(trim($config[0]), trim($config[1]), trim($config[2]), trim($config[3]));

// Get maximum game coordinates
$config = mysqli_fetch_array(mysqli_query($connection, "SELECT max_galaxy, max_system FROM uni1_config WHERE uni=1"));
$max_galaxy = $config[0];
$max_system = $config[1];

// Get random username
$nickname_db = file("nicknames.txt");

$created = 0;
while($created!=1) {
	$nick = trim($nickname_db[rand(1, count($nickname_db)-1)]);

	$is_empty = mysqli_fetch_all(mysqli_query($connection, "SELECT id FROM uni1_users WHERE username='$nick' "));
		if(empty($is_empty)) { $created=1; }
}

// Find free space to initialize planet creation
$created = 0;
while($created!=1) {
	$galaxy = rand(1, $max_galaxy);
	$system = rand(1, $max_system);
	$planet = rand(1, 15);
	$is_empty = mysqli_fetch_all(mysqli_query($connection, "SELECT id FROM uni1_planets WHERE galaxy=$galaxy AND system=$system AND planet=$planet"));
		if(empty($is_empty)) {
			$planet_name = trim($nickname_db[rand(1, count($nickname_db)-1)]);
			echo mysqli_query($connection, "INSERT INTO uni1_planets (id_owner, name, universe, last_update, galaxy, system, planet) VALUES (1, '$planet_name', 1, 1, '$galaxy', '$system', '$planet')");
			$id = (mysqli_fetch_array(mysqli_query($connection, "SELECT id FROM uni1_planets ORDER by ID desc LIMIT 1")))[0];
			$created=1;

			// Create User
			$time = time();
			mysqli_query($connection, "INSERT INTO uni1_users (username, password, email, email_2, universe, galaxy, system, planet, register_time, onlinetime) VALUES ('$nick', 'bot', 'bot', 'bot', 1, $galaxy, $system, $planet, $time, $time)");
			$botid = (mysqli_fetch_array(mysqli_query($connection, "SELECT id FROM uni1_users ORDER by ID desc LIMIT 1")))[0];
			mysqli_query($connection, "UPDATE uni1_planets SET id_owner=$botid WHERE id=$id");
			mysqli_query($connection, "UPDATE uni1_users SET id_planet=$id WHERE id=$botid");
			}
}