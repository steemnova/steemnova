<?php

function attack($id_owner, $fleet_start_id, $fleet_start_galaxy, $fleet_start_system, $fleet_start_planet, $id_planet_attacked, $id_attacked, $x, $y, $z, $destroyers, $death_stars) {
	global $fleet_speed, $connection;

	if($destroyers > 0) { $fleet_amount = $destroyers; $fleet_array = '213,'.$destroyers; } else { $fleet_amount=$death_stars; $fleet_array = '214,'.$destroyers;}

	// Calculating distance
	$galaxy_distance = abs($fleet_start_galaxy - $x);
	$system_distance = abs($fleet_start_system - $y);
	$boost = 1;

	if($destroyers > 0) {
		$end_time = 60;
		$galaxy_multiplier = 1;
		$system_multiplier = 1;
	} else {
		$end_time = 8400;
		$galaxy_multiplier = 2;
		$system_multiplier = 4;
	}

	while ($galaxy_distance != 0) {
		if ($boost == 1) {
			$end_time = ($end_time + 7200) * $galaxy_multiplier;
			$boost = 0;
		} else {
			$end_time = ($end_time + 2700) * $galaxy_multiplier;
		}

		$galaxy_distance--;
	}

	$boost = 1;

	while ($system_distance != 0) {
		if ($boost == 1) {
			$end_time = ($end_time + 2700) * $system_multiplier;
			$boost = 0;
		} else {
			$end_time = ($end_time + 60) * $system_multiplier;
		}

	$system_distance--;

        }

	$start_time = time();
	$fleet_start_time = $start_time + ($end_time / $fleet_speed);
	$fleet_end_stay = $fleet_start_time;
	$fleet_end_time = $fleet_end_stay + ($end_time / $fleet_speed);
	mysqli_query($connection, "INSERT INTO uni1_fleets (fleet_owner, fleet_mission, fleet_amount, fleet_array, fleet_universe, fleet_start_id, fleet_start_galaxy, fleet_start_system, fleet_start_planet, fleet_start_type, fleet_end_id, fleet_end_galaxy, fleet_end_system, fleet_end_planet, fleet_end_type, start_time, fleet_start_time, fleet_end_stay, fleet_end_time, fleet_target_owner) VALUES  ($id_owner, 1, $fleet_amount, '$fleet_array', 1, $fleet_start_id, $fleet_start_galaxy, $fleet_start_system, $fleet_start_planet, 1, $id_planet_attacked, $x, $y, $z, 1, $start_time, $fleet_start_time, $fleet_end_stay, $fleet_end_time, $id_attacked)");
	$fleet_id = mysqli_fetch_all(mysqli_query($connection, "SELECT fleet_id FROM uni1_fleets ORDER by fleet_id DESC LIMIT 1"))[0][0];
	mysqli_query($connection, "INSERT INTO uni1_log_fleets (fleet_id, fleet_owner, fleet_mission, fleet_amount, fleet_array, fleet_universe, fleet_start_id, fleet_start_galaxy, fleet_start_system, fleet_start_planet, fleet_start_type, fleet_end_id, fleet_end_galaxy, fleet_end_system, fleet_end_planet, fleet_end_type, start_time, fleet_start_time, fleet_end_stay, fleet_end_time, fleet_target_owner) VALUES ($fleet_id, $id_owner, 1, $fleet_amount, $fleet_array, 1, $fleet_start_id, $fleet_start_galaxy, $fleet_start_system, $fleet_start_planet, 1, $id_planet_attacked, $x, $y, $z, 1, $start_time, $fleet_start_time, $fleet_end_stay, $fleet_end_time, $id_attacked)");
	mysqli_query($connection, "INSERT INTO uni1_fleet_event (fleetID, time) VALUES ($fleet_id, $fleet_start_time)");

	if($destroyers > 0) {
		mysqli_query($connection, "UPDATE uni1_planets SET destructor = 0 WHERE id=$fleet_start_id");
	} else {
		mysqli_query($connection, "UPDATE uni1_planets SET dearth_star = 0 WHERE id=$fleet_start_id");
	}
}

$config = file("config.txt");
$connection = mysqli_connect(trim($config[0]), trim($config[1]), trim($config[2]), trim($config[3]));
$fleet_speed = mysqli_fetch_all(mysqli_query($connection, "SELECT FLOOR(fleet_speed/2500) FROM uni1_config"))[0][0];
$get_bots = mysqli_fetch_all(mysqli_query($connection, "SELECT id FROM uni1_users WHERE email='bot'"));
$get_users = mysqli_fetch_all(mysqli_query($connection, "SELECT * FROM uni1_users WHERE email!='bot' AND urlaubs_modus=0"));
$id_offensive_bots = [];

for($i=0; $i<=count($get_bots)-1; $i++) {
	$id_bot = $get_bots[$i][0];
	$get_planets_data = mysqli_fetch_all(mysqli_query($connection, "SELECT id_owner, destructor, dearth_star, id FROM uni1_planets WHERE (id_owner=$id_bot AND (destructor > 0 || dearth_star > 0))"));

	if(count($get_planets_data) > 1) {

		for($k=0; $k<=count($get_planets_data)-1; $k++) {
			if($k==0) { $id_main_planet = $get_planets_data[0][3]; array_push($id_offensive_bots, $id_main_planet); } else {
			$id_current_planet = $get_planets_data[$k][3];
			$destroyers = $get_planets_data[$k][1];
			$death_stars = $get_planets_data[$k][2];
			mysqli_query($connection, "UPDATE uni1_planets SET destructor = destructor + $destroyers WHERE id = $id_main_planet");
			mysqli_query($connection, "UPDATE uni1_planets SET dearth_star = dearth_star + $death_stars WHERE id = $id_main_planet");
			mysqli_query($connection, "UPDATE uni1_planets SET destructor = 0 WHERE id = $id_current_planet");
			mysqli_query($connection, "UPDATE uni1_planets SET dearth_star = 0 WHERE id = $id_current_planet");
			}
		}
	}
}

$enemies = [];
for($j=0; $j<=count($get_users)-1; $j++) {
	// Verify if points are higher that 5000
	$id_user = $get_users[$j][0];
	$get_points = mysqli_fetch_array(mysqli_query($connection, "SELECT total_points FROM uni1_statpoints WHERE id_owner = $id_user"))[0];
	if($get_points < 5000) {
		unset($get_users[$j]);
	} else {
		array_push($enemies, $get_users[$j]);
	}
}

$planets = [];

foreach($get_users as $get_user) {
	// Get Planets ID
	$id_user = $get_user[0];
	$get_user_planets = mysqli_fetch_all(mysqli_query($connection, "SELECT id FROM uni1_planets WHERE (id_owner = $id_user AND planet_type = 1)"));
	for($k=0; $k<=count($get_user_planets)-1; $k++) {
		array_push($planets, $get_user_planets[$k][0]);
	}
}

// Gets all bots ready
for($i=0; $i<=count($get_bots)-1; $i++) {
	$id_bot = $get_bots[$i][0];
	$get_planets_data = mysqli_fetch_all(mysqli_query($connection, "SELECT id_owner, destructor, dearth_star, id, galaxy, system, planet FROM uni1_planets WHERE id_owner=$id_bot AND (destructor > 0 OR dearth_star > 0)"));

	if(!empty($get_planets_data[0])) {
		$random_target = $planets[array_rand($planets)];
		$get_target_stats = mysqli_fetch_array(mysqli_query($connection, "SELECT id_owner, galaxy, system, planet FROM uni1_planets WHERE id = $random_target"));
		echo 'Attack '.$random_target.PHP_EOL;
		echo attack($id_bot, $get_planets_data[0][3], $get_planets_data[0][4], $get_planets_data[0][5], $get_planets_data[0][6], $random_target, $get_target_stats[0], $get_target_stats[1], $get_target_stats[2], $get_target_stats[3], $get_planets_data[0][1], $get_planets_data[0][2]);
	}

}

?>