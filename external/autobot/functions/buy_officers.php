<?php
$config = file("config.txt");
$connection = mysqli_connect(trim($config[0]), trim($config[1]), trim($config[2]), trim($config[3]));
$officers = array(0 => 'rpg_geologue', 1 => 'rpg_amiral', 2 => 'rpg_ingenieur', 3 => 'rpg_technocrate', 4 => 'rpg_constructeur', 5 => 'rpg_scientifique', 6 => 'rpg_stockeur', 7 => 'rpg_defenseur', 8 => 'rpg_bunker', 9 => 'rpg_espion', 10 => 'rpg_commandant', 11 => 'rpg_destructeur', 12 => 'rpg_general', 13 => 'rpg_raideur', 14 => 'rpg_empereur', 15 => 'dm_resource');
$get_bots = mysqli_fetch_all(mysqli_query($connection, "SELECT id, darkmatter, rpg_geologue, rpg_amiral, rpg_ingenieur, rpg_technocrate, rpg_constructeur, rpg_scientifique, rpg_stockeur, rpg_defenseur, rpg_bunker, rpg_espion, rpg_commandant, rpg_destructeur, rpg_general, rpg_raideur, rpg_empereur, dm_resource FROM uni1_users WHERE email='bot'"));
for ($i = 0;$i <= count($get_bots) - 1;$i++) {
    for ($j = 0;$j <= count($officers) - 1;$j++) {
	$k = $j + 2;
	$officer_name = $officers[$j];
	$get_officer_data = mysqli_fetch_all(mysqli_query($connection, "SELECT maxLevel, cost921 FROM uni1_vars WHERE name='$officer_name'")) [0];
	if (($get_bots[$i][$k] < $get_officer_data[0]) && ($get_officer_data[1] <= $get_bots[$i][1])) {
	    // Buy officer
	    $id = $get_bots[$i][0];
	    $cost = $get_officer_data[1];
	    mysqli_query($connection, "UPDATE uni1_users SET $officer_name = $officer_name + 1 WHERE id = $id");
	    mysqli_query($connection, "UPDATE uni1_users SET darkmatter = darkmatter - $cost WHERE id = $id");
	    break;
	} else if ($get_bots[$i][$k] == $get_officer_data[0]) {
	    // Skip	
	} else if ($j == 15) {
	    // Buy resource power up
	    $time = time();
	    $k = 17;
	    $id = $get_bots[$i][0];
	    $cost = $get_officer_data[1];
	    if ($get_bots[$i][$k] < $time) {
		mysqli_query($connection, "UPDATE uni1_users SET dm_resource=($time+86400) WHERE id=$id");
	    } else {
		mysqli_query($connection, "UPDATE uni1_users SET dm_resource=dm_resource+86400 WHERE id=$id");
	    }
	    mysqli_query($connection, "UPDATE uni1_users SET darkmatter = darkmatter - $cost WHERE id = $id");
	} else {
	    echo 'Not enough Dark Matter - ' . $get_bots[$i][1] . ' / ' . $get_officer_data[1] . PHP_EOL;
	    break;
	}
    }
}
