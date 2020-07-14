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

			// Image
			if($planet>=13) { $image = 'eisplanet'.sprintf('%02d', mt_rand(1,10)); }
			else if($planet>=9) { $temp_image=array('normaltempplanet'.sprintf('%02d',mt_rand(1,7)), 'wasserplanet'.sprintf('%02d',mt_rand(1,9))); $image=$temp_image[array_rand($temp_image)]; }
			else if($planet>=7) { $image = 'normaltempplanet'.sprintf('%02d',mt_rand(1,7)); }
			else if($planet>=4) { $image = 'dschjungel'.sprintf('%02d',mt_rand(1,10)); }
			else { $temp_image=array('trockenplanet'.sprintf('%02d',mt_rand(1,10)), 'wuestenplanet'.sprintf('%02d',mt_rand(1,4))); $image=$temp_image[array_rand($temp_image)]; }

			$planet_name = trim($nickname_db[rand(1, count($nickname_db)-1)]);
			echo mysqli_query($connection, "INSERT INTO uni1_planets (id_owner, name, universe, last_update, galaxy, system, planet, image) VALUES (1, '$planet_name', 1, 1, '$galaxy', '$system', '$planet', '$image')");
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

// check that the basic variables are initialized correctly
do {
	mysqli_query($connection, "UPDATE uni1_planets SET id_owner=$botid WHERE id=$id");
	$isset = mysqli_fetch_array(mysqli_query($connection, "SELECT id_owner FROM uni1_planets WHERE id=$id"))['id_owner'];
} while ($isset==0);

do {
	mysqli_query($connection, "UPDATE uni1_users SET id_planet=$id WHERE id=$botid");
	$isset = mysqli_fetch_array(mysqli_query($connection, "SELECT id_planet FROM uni1_users WHERE id=$botid"))['id_planet'];
} while ($isset==0);