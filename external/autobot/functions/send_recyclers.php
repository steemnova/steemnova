<?php

$config = file("config.txt");
$connection = mysqli_connect(trim($config[0]), trim($config[1]), trim($config[2]), trim($config[3]));
$fleet_speed = mysqli_fetch_all(mysqli_query($connection, "SELECT FLOOR(fleet_speed/2500) FROM uni1_config")) [0][0];
$get_bots_techs = mysqli_fetch_all(mysqli_query($connection, "SELECT id, computer_tech, combustion_tech, shield_tech FROM uni1_users WHERE email='bot'"));
for ($i = 0;$i <= count($get_bots_techs) - 1;$i++) {
    $random_planet = mysqli_fetch_all(mysqli_query($connection, "SELECT galaxy, system, planet, id, id_owner FROM uni1_planets WHERE (der_metal!=0 || der_crystal!=0) ORDER BY RAND() LIMIT 1")) [0];
    if (empty($random_planet)) {
	continue;
    } else {
	$x = $random_planet[0];
	$y = $random_planet[1];
	$z = $random_planet[2];
    }
    $id_owner = $get_bots_techs[$i][0];
    $count_fleets = mysqli_fetch_all(mysqli_query($connection, "SELECT COUNT(*) FROM uni1_fleets WHERE fleet_owner=$id_owner")) [0][0];
    // Calculate max fleets of recyclers
    $max_fleets = min(($get_bots_techs[$i][1] + 1) - $count_fleets, 3);
    if ($max_fleets != 0) {
	// Check how many Recyclers Bot have, also receive info about resources needed to build it
	$planet_resources = mysqli_fetch_all(mysqli_query($connection, "SELECT recycler, floor(metal), floor(crystal), floor(deuterium), hangar, id, galaxy, system, planet FROM uni1_planets WHERE id_owner=$id_owner")) [0];
	$id_planet = $planet_resources[5];
	if ($planet_resources[0] == 0 && $get_bots_techs[$i][2] >= 6 && $get_bots_techs[$i][3] >= 2 && $planet_resources[1] >= 10000 && $planet_resources[2] >= 6000 && $planet_resources[3] >= 2000 && $planet_resources[4] >= 4) {
	    mysqli_query($connection, "UPDATE uni1_planets SET metal = metal - 10000 WHERE id=$id_planet");
	    mysqli_query($connection, "UPDATE uni1_planets SET crystal = crystal - 6000 WHERE id=$id_planet");
	    mysqli_query($connection, "UPDATE uni1_planets SET deuterium = deuterium - 2000 WHERE id=$id_planet");
	    mysqli_query($connection, "UPDATE uni1_planets SET recycler = recycler + 1 WHERE id=$id_planet");
	    $planet_resources[0]++;
	}
	if ($planet_resources[0] > 0) {
	    $fleet_start_id = $id_planet;
	    $fleet_start_galaxy = $planet_resources[6];
	    $fleet_start_system = $planet_resources[7];
	    $fleet_start_planet = $planet_resources[8];
	    $id_planet_recycled = $random_planet[3];
	    $id_player_recycled = $random_planet[4];
	    // Calculating distance
	    $galaxy_distance = abs($fleet_start_galaxy - $x);
	    $system_distance = abs($fleet_start_system - $y);
	    $boost = 1;
	    $end_time = 60;
	    while ($galaxy_distance != 0) {
		if ($boost == 1) {
		    $end_time = $end_time + 3600;
		    $boost = 0;
		} else {
		    $end_time = $end_time + 1800;
		}
		$galaxy_distance--;
	    }
	    $boost = 1;
	    while ($system_distance != 0) {
		if ($boost == 1) {
		    $end_time = $end_time + 1800;
		    $boost = 0;
		} else {
		    $end_time = $end_time + 30;
		}
		$system_distance--;
	    }
	    $start_time = time();
	    $fleet_start_time = $start_time + ($end_time / $fleet_speed);
	    $fleet_end_stay = $fleet_start_time;
	    $fleet_end_time = $fleet_end_stay + ($end_time / $fleet_speed);
	    mysqli_query($connection, "INSERT INTO uni1_fleets (fleet_owner, fleet_mission, fleet_amount, fleet_array, fleet_universe, fleet_start_id, fleet_start_galaxy, fleet_start_system, fleet_start_planet, fleet_start_type, fleet_end_id, fleet_end_galaxy, fleet_end_system, fleet_end_planet, fleet_end_type, start_time, fleet_start_time, fleet_end_stay, fleet_end_time) VALUES  ($id_owner, 8, 1, '209,1', 1, $fleet_start_id, $fleet_start_galaxy, $fleet_start_system, $fleet_start_planet, 1, $id_planet_recycled, $x, $y, $z, 2, $start_time, $fleet_start_time, $fleet_end_stay, $fleet_end_time)");
	    $fleet_id = mysqli_fetch_all(mysqli_query($connection, "SELECT fleet_id FROM uni1_fleets ORDER by fleet_id DESC LIMIT 1")) [0][0];
	    mysqli_query($connection, "INSERT INTO uni1_log_fleets (fleet_id, fleet_owner, fleet_mission, fleet_amount, fleet_array, fleet_universe, fleet_start_id, fleet_start_galaxy, fleet_start_system, fleet_start_planet, fleet_start_type, fleet_end_id, fleet_end_galaxy, fleet_end_system, fleet_end_planet, fleet_end_type, start_time, fleet_start_time, fleet_end_stay, fleet_end_time) VALUES  ($fleet_id, $id_owner, 8, 1, '209,1', 1, $fleet_start_id, $fleet_start_galaxy, $fleet_start_system, $fleet_start_planet, 1, $id_planet_recycled, $x, $y, $z, 2, $start_time, $fleet_start_time, $fleet_end_stay, $fleet_end_time)");
	    mysqli_query($connection, "INSERT INTO uni1_fleet_event (fleetID, time) VALUES ($fleet_id, $fleet_start_time)");
	    mysqli_query($connection, "UPDATE uni1_planets SET recycler = recycler - 1 WHERE id=$fleet_start_id");
	}
	$max_fleets--;
    }
}
