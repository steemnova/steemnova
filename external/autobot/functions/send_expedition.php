<?php

$config = file("config.txt");
$connection = mysqli_connect(trim($config[0]), trim($config[1]), trim($config[2]), trim($config[3]));
$fleet_speed = mysqli_fetch_all(mysqli_query($connection, "SELECT FLOOR(fleet_speed/2500) FROM uni1_config")) [0][0];
$get_bots_techs = mysqli_fetch_all(mysqli_query($connection, "SELECT id, computer_tech, expedition_tech, combustion_tech FROM uni1_users WHERE email='bot'"));
for ($i = 0;$i <= count($get_bots_techs) - 1;$i++) {
    $id_owner = $get_bots_techs[$i][0];
    $count_fleets = mysqli_fetch_all(mysqli_query($connection, "SELECT COUNT(*) FROM uni1_fleets WHERE fleet_owner=$id_owner")) [0][0];
    $count_fleets_on_expedition = mysqli_fetch_all(mysqli_query($connection, "SELECT COUNT(*) FROM uni1_fleets WHERE fleet_owner=$id_owner AND fleet_mission=15")) [0][0];
    // Calculate max fleets expeditions
    $max_expedition_fleets = min(floor($get_bots_techs[$i][1] + 1) - $count_fleets, floor(($get_bots_techs[$i][2] / 2) - $count_fleets_on_expedition));
    while ($max_expedition_fleets > 0) {
	// Check how many Small Cargo Bot have, also receive info about resources needed to build it
	$planet_resources = mysqli_fetch_all(mysqli_query($connection, "SELECT small_ship_cargo, floor(metal), floor(crystal), hangar, id, galaxy, system, planet FROM uni1_planets WHERE id_owner=$id_owner")) [0];
	$id_planet = $planet_resources[4];
	if ($planet_resources[0] == 0 && $get_bots_techs[$i][3] >= 2 && $planet_resources[1] >= 2000 && $planet_resources[2] >= 2000 && $planet_resources[3] >= 2) {
	    mysqli_query($connection, "UPDATE uni1_planets SET metal = metal - 2000 WHERE id=$id_planet");
	    mysqli_query($connection, "UPDATE uni1_planets SET crystal = crystal - 2000 WHERE id=$id_planet");
	    mysqli_query($connection, "UPDATE uni1_planets SET small_ship_cargo = small_ship_cargo + 1 WHERE id=$id_planet");
	    $planet_resources[0]++;
	}
	if ($planet_resources[0] > 0) {
	    $fleet_start_id = $id_planet;
	    $fleet_start_galaxy = $planet_resources[5];
	    $fleet_start_system = $planet_resources[6];
	    $fleet_start_planet = $planet_resources[7];
	    $start_time = time();
	    $fleet_start_time = $start_time + (7200 / $fleet_speed);
	    $fleet_end_stay = $fleet_start_time + 1800;
	    $fleet_end_time = $fleet_end_stay + (7200 / $fleet_speed);
	    mysqli_query($connection, "INSERT INTO uni1_fleets (fleet_owner, fleet_mission, fleet_amount, fleet_array, fleet_universe, fleet_start_id, fleet_start_galaxy, fleet_start_system, fleet_start_planet, fleet_start_type, fleet_end_id, fleet_end_galaxy, fleet_end_system, fleet_end_planet, fleet_end_type, start_time, fleet_start_time, fleet_end_stay, fleet_end_time) VALUES ($id_owner, 15, 1, '202,1', 1, $fleet_start_id, $fleet_start_galaxy, $fleet_start_system, $fleet_start_planet, 1, 0, $fleet_start_galaxy, $fleet_start_system, 16, 1, $start_time, $fleet_start_time, $fleet_end_stay, $fleet_end_time)");
	    $fleet_id = mysqli_fetch_all(mysqli_query($connection, "SELECT fleet_id FROM uni1_fleets ORDER by fleet_id DESC LIMIT 1")) [0][0];
	    mysqli_query($connection, "INSERT INTO uni1_log_fleets (fleet_id, fleet_owner, fleet_mission, fleet_amount, fleet_array, fleet_universe, fleet_start_id, fleet_start_galaxy, fleet_start_system, fleet_start_planet, fleet_start_type, fleet_end_id, fleet_end_galaxy, fleet_end_system, fleet_end_planet, fleet_end_type, start_time, fleet_start_time, fleet_end_stay, fleet_end_time) VALUES ($fleet_id, $id_owner, 15, 1, '202,1', 1, $fleet_start_id, $fleet_start_galaxy, $fleet_start_system, $fleet_start_planet, 1, 0, $fleet_start_galaxy, $fleet_start_system, 16, 1, $start_time, $fleet_start_time, $fleet_end_stay, $fleet_end_time)");
	    mysqli_query($connection, "INSERT INTO uni1_fleet_event (fleetID, time) VALUES ($fleet_id, $fleet_start_time)");
	    mysqli_query($connection, "UPDATE uni1_planets SET small_ship_cargo = small_ship_cargo - 1 WHERE id=$fleet_start_id");
	    mysqli_query($connection, "UPDATE uni1_users SET onlinetime = $start_time WHERE id=$id_owner");
	}
	$max_expedition_fleets--;
    }
}