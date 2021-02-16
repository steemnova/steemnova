<?php
$config = file("config.txt");

$building_list_destroyer = array(3,0,0,3,0,0,3,0,3,1,1,1,3,0,1,3,2,2,2,3,3,2,3,2,1,3,2,5,5,11,21,23,23,7,7,11,11,23,7,16,16,17,17,17,24,24,16,9,24,21,21,11,11,11,23,23,23,19,19,3,0,0,3,1,1,1,1,0,3,2,0,8,7,20,20,30,3,0,1,0,8,9,10,3,1,1,0,3,2,1,7,21,26,26,26,26,26,27,27,24,8,9,10,3,21,0,1,2,11,11,31,32,33,31,32,31,32,33,31,32,31,32,33,33,3,2,0,17,9,8,10,30,20,20,20,3,2,1,0,33,32,31,33,17,7,7,19,19,19,22,22,22,8,9,10,25,25,25,25,5,5,5,3,0,1,17,30,18,19,20,8,9,10,0,18,7,7,3,0,2,32,33,31,22,22,5,5,3,1,2,0,8,9,25,32,33,8,3,10,1,1,2,25,17,17,17,5,5,5,17,6,18,18,18,30,30,18);
$building_list_deathstar = array(3,0,0,3,0,0,3,0,3,1,1,1,3,0,1,3,2,2,2,3,3,2,3,2,1,3,2,5,5,11,21,23,23,7,7,11,11,23,7,16,16,17,17,17,24,24,16,9,24,21,21,11,11,11,23,23,23,19,19,3,0,0,3,1,1,1,1,0,3,2,0,8,7,20,20,30,3,0,1,0,8,9,10,3,1,1,0,3,2,1,7,21,26,26,26,26,26,27,27,24,8,9,10,3,21,0,1,2,11,11,31,32,33,31,32,31,32,33,31,32,31,32,33,33,3,2,0,17,9,8,10,30,20,20,20,3,2,1,0,33,32,31,33,17,7,7,19,19,19,22,22,22,8,9,10,25,25,25,25,5,5,5,3,0,1,17,30,18,19,20,8,9,10,0,18,7,7,3,0,2,32,33,31,22,22,5,5,3,1,2,0,8,9,25,32,33,8,3,10,1,1,2,25,17,17,17,5,5,5,17,6,18,18,18,30,30,18,3,2,0,3,1,0,2,31,31,32,33,31,32,33,22,9,8,10,25,3,0,1,2,11,11,7,11,11,34,7,7,8,9,10,9,8,18,19,20,18,19,20,18,19,20,18,19,20,3,1,2,3,0,1,2,30,30,30,30);

$connection = mysqli_connect(trim($config[0]) , trim($config[1]) , trim($config[2]) , trim($config[3]));
$game_speed = mysqli_fetch_all(mysqli_query($connection, "SELECT FLOOR(game_speed/2500) FROM uni1_config")) [0][0];

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
        $bot_resources = mysqli_fetch_array(mysqli_query($connection, "SELECT metal, crystal, deuterium FROM uni1_planets WHERE (id=$id_planet AND b_building = '')"));

        if (empty($planet_buildings) || !empty($bot_data[4]))
        {
	    // Bot build something
            echo 'The Queue' . PHP_EOL;
            continue;
        }
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
            // The list of buildings has been completed
            echo 'The list to build has been completed for this planet' . PHP_EOL;
            continue;
        }

        $name = $build_planet_array[$id];
        if (strpos($name, '_tech') === false)
        {
            $level = $planet_buildings[$name];
        }
        else
        {
            $level = $bot_data[$name];
        }
	// Calculate building costs
        $levelup = $level + 1;

        $data_building = mysqli_fetch_array(mysqli_query($connection, "SELECT cost901, cost902, cost903, factor, elementID FROM uni1_vars WHERE name='$name'"));
        $id_vars = $data_building[4];
        $metal = $data_building[0];
        $crystal = $data_building[1];
        $deuterium = $data_building[2];

        $metal = round($metal * pow($data_building[3], $level));
        $crystal = round($crystal * pow($data_building[3], $level));
        $deuterium = round($deuterium * pow($data_building[3], $level));

        if ($bot_resources['metal'] < $metal || $bot_resources['crystal'] < $crystal || $bot_resources['deuterium'] < $deuterium)
        {
	    // Lack of resources
            echo 'Lack of required resources!' . PHP_EOL;
            continue;
        }

        if (strpos($name, '_tech') === false)
        {
	    // Building time!
            $time = time();
            $buildTime = (($metal + $crystal + 3) / ($game_speed * (1 + $planet_buildings[5])) * pow(0.5, $planet_buildings[6])) * $data_building[3];
            $endTime = $time + $buildTime;
            $b_building_array[0][0] = $id_vars;
            $b_building_array[0][1] = $levelup;
            $b_building_array[0][2] = $buildTime;
            $b_building_array[0][3] = $endTime;
            $b_building_array[0][4] = "build";
            $b_building_id = serialize($b_building_array);
            mysqli_query($connection, "UPDATE uni1_planets SET b_building = $endTime WHERE id=$id_planet");
            mysqli_query($connection, "UPDATE uni1_planets SET b_building_id = '$b_building_id' WHERE id=$id_planet");
            mysqli_query($connection, "UPDATE uni1_planets SET metal = metal - $metal WHERE id=$id_planet");
            mysqli_query($connection, "UPDATE uni1_planets SET crystal = crystal - $crystal WHERE id=$id_planet");
            mysqli_query($connection, "UPDATE uni1_planets SET deuterium = deuterium - $deuterium WHERE id=$id_planet");
        }
        else
        {
            $time = time();
            $buildTime = ($metal + $crystal + 3) / (1000 * $levelup) / $game_speed * (1 + $planet_buildings[11]);
            $endTime = $time + $buildTime;
            $b_tech_array[0][0] = $id_vars;
            $b_tech_array[0][1] = $levelup;
            $b_tech_array[0][2] = $buildTime;
            $b_tech_array[0][3] = $endTime;
            $b_tech_array[0][4] = $id_planet;
            $b_tech_queue = serialize($b_tech_array);

            mysqli_query($connection, "UPDATE uni1_users SET b_tech_planet = $id_planet WHERE id=$id_bot");
            mysqli_query($connection, "UPDATE uni1_users SET b_tech = $endTime WHERE id=$id_bot");
            mysqli_query($connection, "UPDATE uni1_users SET b_tech_id = $id_vars WHERE id=$id_bot");
            mysqli_query($connection, "UPDATE uni1_users SET b_tech_queue = '$b_tech_queue' WHERE id=$id_bot");
            mysqli_query($connection, "UPDATE uni1_planets SET metal = metal - $metal WHERE id=$id_planet");
            mysqli_query($connection, "UPDATE uni1_planets SET crystal = crystal - $crystal WHERE id=$id_planet");
            mysqli_query($connection, "UPDATE uni1_planets SET deuterium = deuterium - $deuterium WHERE id=$id_planet");
        }

	// Forcing bot to attack in order to finish construction (BitNova finishes construction when there is a battle or when the user logs in to the game)
        $fleet_start_galaxy = $planet_position[0];
        $fleet_start_system = $planet_position[1];
        $fleet_start_planet = $planet_position[2];
        $start_time = time();
        $fleet_start_time = $endTime + 1;
        $fleet_end_stay = $endTime + 2;
        $fleet_end_time = $endTime + 3;

        mysqli_query($connection, "UPDATE uni1_users SET onlinetime = $start_time WHERE id=$id_bot");
        echo "I'm starting to work!" . PHP_EOL;

    }
}