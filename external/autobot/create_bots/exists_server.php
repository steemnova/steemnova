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

// Get 100 TOP players
$points = mysqli_fetch_all(mysqli_query($connection, "SELECT DISTINCT id_owner FROM uni1_statpoints ORDER BY total_points desc limit 100"));

// Create a list of TOP 100 Players
$list = '';
for($i=0; $i<=(count($points)-1); $i++) {
$list = $list.' '.$points[$i][0];
}

$list = str_replace(' ', ',', trim($list));

// Get Average technology levels
$user_techs = mysqli_fetch_all(mysqli_query($connection, "SELECT ROUND(AVG(spy_tech)), ROUND((computer_tech)), ROUND((military_tech)), ROUND((defence_tech)), ROUND((shield_tech)), ROUND((energy_tech)), ROUND((hyperspace_tech)), ROUND((combustion_tech)), ROUND((impulse_motor_tech)), ROUND((hyperspace_motor_tech)), ROUND((laser_tech)), ROUND((ionic_tech)), ROUND((buster_tech)), ROUND((intergalactic_tech)), ROUND((expedition_tech)), ROUND((metal_proc_tech)), ROUND((crystal_proc_tech)), ROUND((deuterium_proc_tech)), ROUND((graviton_tech)) FROM uni1_users WHERE id IN ($list)"))[0];

// Get Planets
$get_id_planets = mysqli_fetch_all(mysqli_query($connection, "SELECT MIN(id) FROM uni1_planets WHERE id_owner IN ($list) GROUP BY id_owner"));

$list_planets = '';
for($i=0; $i<=(count($get_id_planets)-1); $i++) {
$list_planets = $list_planets.' '.$get_id_planets[$i][0];
}

$list_planets = str_replace(' ', ',', trim($list_planets));

// Get Average planet
$user_planets = mysqli_fetch_all(mysqli_query($connection, "SELECT ROUND(AVG(metal_mine)), ROUND(AVG(crystal_mine)), ROUND(AVG(deuterium_sintetizer)), ROUND(AVG(solar_plant)), ROUND(AVG(fusion_plant)), ROUND(AVG(robot_factory)), ROUND(AVG(nano_factory)), ROUND(AVG(hangar)), ROUND(AVG(metal_store)), ROUND(AVG(crystal_store)), ROUND(AVG(deuterium_store)), ROUND(AVG(laboratory)), ROUND(AVG(terraformer)), ROUND(AVG(university)), ROUND(AVG(ally_deposit)), ROUND(AVG(silo)), ROUND(AVG(mondbasis)), ROUND(AVG(phalanx)), ROUND(AVG(sprungtor)), ROUND(AVG(small_ship_cargo)), ROUND(AVG(big_ship_cargo)), ROUND(AVG(light_hunter)), ROUND(AVG(heavy_hunter)), ROUND(AVG(crusher)), ROUND(AVG(battle_ship)), ROUND(AVG(colonizer)), ROUND(AVG(recycler)), ROUND(AVG(spy_sonde)), ROUND(AVG(bomber_ship)), ROUND(AVG(solar_satelit)), ROUND(AVG(destructor)), ROUND(AVG(dearth_star)), ROUND(AVG(battleship)), ROUND(AVG(lune_noir)), ROUND(AVG(ev_transporter)), ROUND(AVG(star_crasher)), ROUND(AVG(giga_recykler)), ROUND(AVG(dm_ship)), ROUND(AVG(orbital_station)), ROUND(AVG(misil_launcher)), ROUND(AVG(small_laser)), ROUND(AVG(big_laser)), ROUND(AVG(gauss_canyon)), ROUND(AVG(ionic_canyon)), ROUND(AVG(buster_canyon)), ROUND(AVG(small_protection_shield)), ROUND(AVG(planet_protector)), ROUND(AVG(big_protection_shield)), ROUND(AVG(graviton_canyon)), ROUND(AVG(interceptor_misil)), ROUND(AVG(interplanetary_misil)) FROM uni1_planets WHERE id IN ($list_planets)"))[0];

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
else if($planet>=4) { $image = 'dschjungelplanet'.sprintf('%02d',mt_rand(1,10)); }
else { $temp_image=array('trockenplanet'.sprintf('%02d',mt_rand(1,10)), 'wuestenplanet'.sprintf('%02d',mt_rand(1,4))); $image=$temp_image[array_rand($temp_image)]; }

$planet_name = trim($nickname_db[rand(1, count($nickname_db)-1)]);

do {
    mysqli_query($connection, "INSERT INTO uni1_planets (id_owner, name, universe, last_update, galaxy, system, planet, image) VALUES (9999999, '$planet_name', 1, 1, '$galaxy', '$system', '$planet', '$image')");
    $id = mysqli_fetch_array(mysqli_query($connection, "SELECT id FROM uni1_planets WHERE id_owner = 9999999 LIMIT 1"))[0];
} while (empty($id));

$created=1;
// UPGRADE
mysqli_query($connection, "UPDATE uni1_planets SET metal_mine=$user_planets[0] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET crystal_mine=$user_planets[1] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET deuterium_sintetizer=$user_planets[2] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET solar_plant=$user_planets[3] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET fusion_plant=$user_planets[4] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET robot_factory=$user_planets[5] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET nano_factory=$user_planets[6] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET hangar=$user_planets[7] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET metal_store=$user_planets[8] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET crystal_store=$user_planets[9] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET deuterium_store=$user_planets[10] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET laboratory=$user_planets[11] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET terraformer=$user_planets[12] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET university=$user_planets[13] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET ally_deposit=$user_planets[14] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET silo=$user_planets[15] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET mondbasis=$user_planets[16] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET phalanx=$user_planets[17] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET sprungtor=$user_planets[18] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET small_ship_cargo=$user_planets[19] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET big_ship_cargo=$user_planets[20] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET light_hunter=$user_planets[21] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET heavy_hunter=$user_planets[22] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET crusher=$user_planets[23] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET battle_ship=$user_planets[24] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET colonizer=$user_planets[25] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET recycler=$user_planets[26] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET spy_sonde=$user_planets[27] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET bomber_ship=$user_planets[28] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET solar_satelit=$user_planets[29] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET destructor=$user_planets[30] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET dearth_star=$user_planets[31] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET battleship=$user_planets[32] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET lune_noir=$user_planets[33] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET ev_transporter=$user_planets[34] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET star_crasher=$user_planets[35] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET giga_recykler=$user_planets[36] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET dm_ship=$user_planets[37] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET orbital_station=$user_planets[38] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET misil_launcher=$user_planets[39] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET small_laser=$user_planets[40] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET big_laser=$user_planets[41] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET gauss_canyon=$user_planets[42] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET ionic_canyon=$user_planets[43] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET buster_canyon=$user_planets[44] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET small_protection_shield=$user_planets[45] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET planet_protector=$user_planets[46] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET big_protection_shield=$user_planets[47] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET graviton_canyon=$user_planets[48] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET interceptor_misil=$user_planets[49] WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_planets SET interplanetary_misil=$user_planets[50] WHERE id=$id");
// UPGRADE
}

// Create User
$time = time();
mysqli_query($connection, "INSERT INTO uni1_users (username, password, email, email_2, universe, galaxy, system, planet, register_time, onlinetime) VALUES ('$nick', 'bot', 'bot', 'bot', 1, $galaxy, $system, $planet, $time, $time)");
$botid = (mysqli_fetch_array(mysqli_query($connection, "SELECT id FROM uni1_users ORDER by ID desc LIMIT 1")))[0];
mysqli_query($connection, "UPDATE uni1_planets SET id_owner=$botid WHERE id=$id");
mysqli_query($connection, "UPDATE uni1_users SET id_planet=$id WHERE id=$botid");

// UPGRADE
mysqli_query($connection, "UPDATE uni1_users SET spy_tech=$user_techs[0] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET computer_tech=$user_techs[1] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET military_tech=$user_techs[2] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET defence_tech=$user_techs[3] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET shield_tech=$user_techs[4] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET energy_tech=$user_techs[5] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET hyperspace_tech=$user_techs[6] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET combustion_tech=$user_techs[7] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET impulse_motor_tech=$user_techs[8] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET hyperspace_motor_tech=$user_techs[9] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET laser_tech=$user_techs[10] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET ionic_tech=$user_techs[11] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET buster_tech=$user_techs[12] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET intergalactic_tech=$user_techs[13] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET expedition_tech=$user_techs[14] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET metal_proc_tech=$user_techs[15] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET crystal_proc_tech=$user_techs[16] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET deuterium_proc_tech=$user_techs[17] WHERE id=$botid");
mysqli_query($connection, "UPDATE uni1_users SET graviton_tech=$user_techs[18] WHERE id=$botid");
// UPGRADE

// check that the basic variables are initialized correctly
do {
    mysqli_query($connection, "UPDATE uni1_planets SET id_owner=$botid WHERE id=$id");
    $isset = mysqli_fetch_array(mysqli_query($connection, "SELECT id_owner FROM uni1_planets WHERE id=$id"))['id_owner'];
} while ($isset==0);

do {
    mysqli_query($connection, "UPDATE uni1_users SET id_planet=$id WHERE id=$botid");
    $isset = mysqli_fetch_array(mysqli_query($connection, "SELECT id_planet FROM uni1_users WHERE id=$botid"))['id_planet'];
} while ($isset==0);

}