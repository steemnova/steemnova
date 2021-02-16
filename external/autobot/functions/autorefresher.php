<?php

function attack($id_owner, $fleet_start_id, $fleet_start_galaxy, $fleet_start_system, $fleet_start_planet) {
    global $connection;

        $start_time = time();
        $fleet_start_time = $start_time + 1;
        $fleet_end_stay = $fleet_start_time;
        $fleet_end_time = $fleet_end_stay + 1;

        mysqli_query($connection, "INSERT INTO uni1_fleets (fleet_owner, fleet_mission, fleet_amount, fleet_array, fleet_universe, fleet_start_id, fleet_start_galaxy, fleet_start_system, fleet_start_planet, fleet_start_type, fleet_end_id, fleet_end_galaxy, fleet_end_system, fleet_end_planet, fleet_end_type, start_time, fleet_start_time, fleet_end_stay, fleet_end_time, fleet_target_owner) VALUES  ($id_owner, 6, 1, '210,1', 1, $fleet_start_id, $fleet_start_galaxy, $fleet_start_system, $fleet_start_planet, 1, $fleet_start_id, $fleet_start_galaxy, $fleet_start_system, $fleet_start_planet, 1, $start_time, $fleet_start_time, $fleet_end_stay, $fleet_end_time, $id_owner)");
        $fleet_id = mysqli_fetch_all(mysqli_query($connection, "SELECT fleet_id FROM uni1_fleets ORDER by fleet_id DESC LIMIT 1"))[0][0];
        mysqli_query($connection, "INSERT INTO uni1_log_fleets (fleet_id, fleet_owner, fleet_mission, fleet_amount, fleet_array, fleet_universe, fleet_start_id, fleet_start_galaxy, fleet_start_system, fleet_start_planet, fleet_start_type, fleet_end_id, fleet_end_galaxy, fleet_end_system, fleet_end_planet, fleet_end_type, start_time, fleet_start_time, fleet_end_stay, fleet_end_time, fleet_target_owner) VALUES ($fleet_id, $id_owner, 6, 1, '210,1', 1, $fleet_start_id, $fleet_start_galaxy, $fleet_start_system, $fleet_start_planet, 1, $fleet_start_id, $fleet_start_galaxy, $fleet_start_system, $fleet_start_planet, 1, $start_time, $fleet_start_time, $fleet_end_stay, $fleet_end_time, $id_owner)");
        mysqli_query($connection, "INSERT INTO uni1_fleet_event (fleetID, time) VALUES ($fleet_id, $fleet_start_time)");
	mysqli_query($connection, "UPDATE uni1_planets SET spy_sonde = 0 WHERE id=$fleet_start_id");
	mysqli_query($connection, "UPDATE uni1_users SET onlinetime = $start_time WHERE id=$id_owner");
}


$config = file("config.txt");
$connection = mysqli_connect(trim($config[0]), trim($config[1]), trim($config[2]), trim($config[3]));
$get_all_bots = mysqli_fetch_all(mysqli_query($connection, "SELECT id FROM uni1_users WHERE email = 'bot'"));

for($i=0; $i<=count($get_all_bots)-1; $i++) {
	$id_bot = $get_all_bots[$i][0];
	$get_planets = mysqli_fetch_all(mysqli_query($connection, "SELECT id, galaxy, system, planet, metal, crystal, deuterium FROM uni1_planets WHERE id_owner = $id_bot"));
	for($j=0; $j<=count($get_planets)-1; $j++) {
		attack($id_bot, $get_planets[$j][0], $get_planets[$j][1], $get_planets[$j][2], $get_planets[$j][3]);
	}
}

?>