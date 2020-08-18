<?php
$config = file("config.txt");

$building_list_destroyer = array(3,0,0,3,0,0,3,0,3,1,1,1,3,0,1,3,2,2,2,3,3,2,3,2,1,3,2,5,5,11,21,23,23,7,7,11,11,23,7,16,16,17,17,17,24,24,16,9,24,21,21,11,11,11,23,23,23,19,19,3,0,0,3,1,1,1,1,0,3,2,0,8,7,20,20,30,3,0,1,0,8,9,10,3,1,1,0,3,2,1,7,21,26,26,26,26,26,27,27,24,8,9,10,3,21,0,1,2,11,11,31,32,33,31,32,31,32,33,31,32,31,32,33,33,3,2,0,17,9,8,10,30,20,20,20,3,2,1,0,33,32,31,33,17,7,7,19,19,19,22,22,22,8,9,10,25,25,25,25,5,5,5,3,0,1,17,30,18,19,20,8,9,10,0,18,7,7,3,0,2,32,33,31,22,22,5,5,3,1,2,0,8,9,25,32,33,8,3,10,1,1,2,25,17,17,17,5,5,5,17,6,18,18,18,30,30,18);
$building_list_deathstar = array(3,0,0,3,0,0,3,0,3,1,1,1,3,0,1,3,2,2,2,3,3,2,3,2,1,3,2,5,5,11,21,23,23,7,7,11,11,23,7,16,16,17,17,17,24,24,16,9,24,21,21,11,11,11,23,23,23,19,19,3,0,0,3,1,1,1,1,0,3,2,0,8,7,20,20,30,3,0,1,0,8,9,10,3,1,1,0,3,2,1,7,21,26,26,26,26,26,27,27,24,8,9,10,3,21,0,1,2,11,11,31,32,33,31,32,31,32,33,31,32,31,32,33,33,3,2,0,17,9,8,10,30,20,20,20,3,2,1,0,33,32,31,33,17,7,7,19,19,19,22,22,22,8,9,10,25,25,25,25,5,5,5,3,0,1,17,30,18,19,20,8,9,10,0,18,7,7,3,0,2,32,33,31,22,22,5,5,3,1,2,0,8,9,25,32,33,8,3,10,1,1,2,25,17,17,17,5,5,5,17,6,18,18,18,30,30,18,3,2,0,3,1,0,2,31,31,32,33,31,32,33,22,9,8,10,25,3,0,1,2,11,11,7,11,11,34,7,7,8,9,10,9,8,18,19,20,18,19,20,18,19,20,18,19,20,3,1,2,3,0,1,2,30,30,30,30);

$connection = mysqli_connect(trim($config[0]) , trim($config[1]) , trim($config[2]) , trim($config[3]));

$bots = mysqli_fetch_all(mysqli_query($connection, "SELECT id FROM uni1_users WHERE email='bot'"));

for ($j = 0;$j <= count($bots) - 1;$j++)
{
    // Unset ID just for sure
    if (isset($id))
    {
        unset($id);
    }
    $id_bot = $bots[$j][0];

    // Choose whether the bot should build destroyers or death stars.
    if ($id_bot % 2 != 0)
    {
        $building_list = $building_list_destroyer;
    }
    else
    {
        $building_list = $building_list_deathstar;
    }

    // Get user data
    $bot_data = mysqli_fetch_array(mysqli_query($connection, "SELECT id_planet, b_tech_planet, b_tech, b_tech_id, b_tech_queue, spy_tech, computer_tech, military_tech, defence_tech, shield_tech, energy_tech, hyperspace_tech, combustion_tech, impulse_motor_tech, hyperspace_motor_tech, laser_tech, ionic_tech, buster_tech, intergalactic_tech, expedition_tech, metal_proc_tech, crystal_proc_tech, deuterium_proc_tech, graviton_tech FROM uni1_users WHERE id=$id_bot"));
    $planets = mysqli_fetch_all(mysqli_query($connection, "SELECT id FROM uni1_planets WHERE id_owner=$id_bot"));

    foreach ($planets as $bot_planet)
    {
	// Get user planet
        $id_planet = $bot_planet[0];
        $planet_buildings = mysqli_fetch_array(mysqli_query($connection, "SELECT metal_mine, crystal_mine, deuterium_sintetizer, solar_plant, fusion_plant, robot_factory, nano_factory, hangar, metal_store, crystal_store, deuterium_store, laboratory ,terraformer, university, ally_deposit, silo FROM uni1_planets WHERE (id=$id_planet AND b_building = '')"));
        $planet_position = mysqli_fetch_array(mysqli_query($connection, "SELECT galaxy, system, planet FROM uni1_planets WHERE (id=$id_planet AND b_building = '')"));
        $bot_resources = mysqli_fetch_array(mysqli_query($connection, "SELECT metal, crystal, deuterium FROM uni1_planets WHERE (id=$id_planet)"));
	$metal = $bot_resources[0];
	$crystal = $bot_resources[1];
	$deuterium = $bot_resources[2];
        mysqli_query($connection, "UPDATE uni1_planets SET spy_sonde = 0 WHERE id=$id_planet");

	// Check if something can be built by a bot
        $build_planet_array = [];
        $build_planet_level = [];

        $i = 0;
        foreach ($planet_buildings as $key => $building)
        {

            if (!is_integer($key))
            {
                $build_planet_array[$i] = $key;
                $build_planet_level[$i] = $building;
                $i++;
            }

        }

        foreach ($bot_data as $key => $research)
        {

            if ((!is_integer($key)) && ((strpos($key, 'b_tech') === false) && (strpos($key, 'id_planet') === false)))
            {
                $build_planet_array[$i] = $key;
                $build_planet_level[$i] = $research;
                $i++;
            }

        }

        $simulate = [];
        for ($k = 0;$k <= count($build_planet_array) - 1;$k++)
        {
            $simulate[$k] = 0;
        }

        for ($m = 0;$m <= count($building_list) - 1;$m++)
        {

            $simulate[$building_list[$m]] = $simulate[$building_list[$m]] + 1;

            if ($simulate[$building_list[$m]] > $build_planet_level[$building_list[$m]])
            {
                $id = $building_list[$m];
                break;
            }

        }

        if (!isset($id))
        {
		if ( ($id_bot % 2 != 0) && ($metal >= 60000 ) && ($crystal >= 50000 ) && ($deuterium >= 15000 ) )
			{
				mysqli_query($connection, "UPDATE uni1_planets SET metal = metal - 60000 WHERE id = $id_planet");
				mysqli_query($connection, "UPDATE uni1_planets SET crystal = crystal - 50000 WHERE id = $id_planet");
				mysqli_query($connection, "UPDATE uni1_planets SET deuterium = deuterium - 15000 WHERE id = $id_planet");
				mysqli_query($connection, "UPDATE uni1_planets SET destructor = destructor + 1 WHERE id = $id_planet");
			}
		else if ( ($id_bot % 2 == 0) && ($metal >= 5000000 ) && ($crystal >= 4000000 ) && ($deuterium >= 1000000 ) )
			{
				mysqli_query($connection, "UPDATE uni1_planets SET metal = metal - 5000000 WHERE id = $id_planet");
				mysqli_query($connection, "UPDATE uni1_planets SET crystal = crystal - 4000000 WHERE id = $id_planet");
				mysqli_query($connection, "UPDATE uni1_planets SET deuterium = deuterium - 1000000 WHERE id = $id_planet");
				mysqli_query($connection, "UPDATE uni1_planets SET dearth_star = dearth_star + 1 WHERE id = $id_planet");
		}
		else {
		echo 'Lack of sufficient resources'.PHP_EOL;
}
        }

    }
}