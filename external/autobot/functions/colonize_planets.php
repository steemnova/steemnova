<?php
$config = file("config.txt");
$connection = mysqli_connect(trim($config[0]) , trim($config[1]) , trim($config[2]) , trim($config[3]));

// Get maximum game coordinates
$config = mysqli_fetch_array(mysqli_query($connection, "SELECT max_galaxy, max_system FROM uni1_config WHERE uni=1"));
$max_galaxy = $config[0];
$max_system = $config[1];

// Get random name planet
$database = file("nicknames.txt");

$bots = mysqli_fetch_all(mysqli_query($connection, "SELECT id FROM uni1_users WHERE email='bot'"));
for ($i = 0;$i <= count($bots) - 1;$i++)
{
    $id_bots = $bots[$i][0];

    $planet_count = mysqli_fetch_array(mysqli_query($connection, "SELECT COUNT(*) FROM uni1_planets WHERE (id_owner = $id_bots AND planet_type=1)")) [0];
    $get_expedition = mysqli_fetch_array(mysqli_query($connection, "SELECT expedition_tech FROM uni1_users WHERE id = $id_bots")) [0];
    $get_imperator = mysqli_fetch_array(mysqli_query($connection, "SELECT rpg_empereur FROM uni1_users WHERE id = $id_bots")) [0];
    $get_resources = mysqli_fetch_array(mysqli_query($connection, "SELECT metal, crystal, deuterium, id FROM uni1_planets WHERE id_owner = $id_bots LIMIT 1"));
    $metal = floor($get_resources[0]);
    $crystal = floor($get_resources[1]);
    $deuterium = floor($get_resources[2]);
    $id_mother_planet = $get_resources[3];
    $max_planets = 1 + ceil($get_expedition / 2) + ($get_imperator * 2);
    if (($planet_count < $max_planets) && ($metal > 10000) && ($crystal > 20000) && ($deuterium > 10000))
    {
        // Colonize planet!
        $created = 0;
        while ($created != 1)
        {
            $galaxy = rand(1, $max_galaxy);
            $system = rand(1, $max_system);
            $planet = rand(4, 12);
            $is_empty = mysqli_fetch_all(mysqli_query($connection, "SELECT id FROM uni1_planets WHERE galaxy=$galaxy AND system=$system AND planet=$planet"));
            if (empty($is_empty))
            {

                // Image
                if ($planet >= 13)
                {
                    $image = 'eisplanet' . sprintf('%02d', mt_rand(1, 10));
                }
                else if ($planet >= 9)
                {
                    $temp_image = array(
                        'normaltempplanet' . sprintf('%02d', mt_rand(1, 7)) ,
                        'wasserplanet' . sprintf('%02d', mt_rand(1, 9))
                    );
                    $image = $temp_image[array_rand($temp_image) ];
                }
                else if ($planet >= 7)
                {
                    $image = 'normaltempplanet' . sprintf('%02d', mt_rand(1, 7));
                }
                else if ($planet >= 4)
                {
                    $image = 'dschjungelplanet' . sprintf('%02d', mt_rand(1, 10));
                }
                else
                {
                    $temp_image = array(
                        'trockenplanet' . sprintf('%02d', mt_rand(1, 10)) ,
                        'wuestenplanet' . sprintf('%02d', mt_rand(1, 4))
                    );
                    $image = $temp_image[array_rand($temp_image) ];
                }

                $planet_name = trim($database[rand(1, count($database) - 1) ]);
                echo mysqli_query($connection, "INSERT INTO uni1_planets (id_owner, name, universe, last_update, galaxy, system, planet, image, metal, crystal) VALUES ($id_bots, '$planet_name', 1, 1, '$galaxy', '$system', '$planet', '$image', 500, 500)");
                mysqli_query($connection, "UPDATE uni1_planets SET metal = metal - 10000 WHERE id = $id_mother_planet");
                mysqli_query($connection, "UPDATE uni1_planets SET crystal = crystal - 20000 WHERE id = $id_mother_planet");
                mysqli_query($connection, "UPDATE uni1_planets SET deuterium = deuterium - 10000 WHERE id = $id_mother_planet");
                $created = 1;
            }
        }

    }

}

