<?php

/**
 *  2Moons 
 *   by Jan-Otto Kröpke 2009-2016
 *
 * For the full copyright and license information, please view the LICENSE
 *
 * @package 2Moons
 * @author Jan-Otto Kröpke <slaver7@gmail.com>
 * @copyright 2009 Lucky
 * @copyright 2016 Jan-Otto Kröpke <slaver7@gmail.com>
 * @licence MIT
 * @version 1.8.0
 * @link https://github.com/jkroepke/2Moons
 */

require_once 'includes/classes/cronjob/CronjobTask.interface.php';

class CoinCronJob implements CronjobTask
{
	function run()
	{		
		$db	= Database::get();
        $coinPot = 100;
		// get active user planets
		$sql	= 'SELECT COUNT(p.id) as counter FROM %%PLANETS%% AS p LEFT JOIN %%USERS%% as u on p.id_owner = u.id WHERE u.onlinetime > :validTime';
        $planets = Database::get()->selectSingle($sql, array(
            ':validTime' => time()-60*60*3,
        ), 'counter');
        $coinPotPart = $coinPot * 0.5 / $planets;
        $sql	= 'UPDATE %%PLANETS%% SET `coins` = coins + :coinCount WHERE `id` IN(SELECT p.id FROM %%PLANETS%% AS p LEFT JOIN %%USERS%% as u on p.id_owner = u.id WHERE u.onlinetime > :validTime)';
        $planets = Database::get()->update($sql, array(
            ':coinCount' => $coinPotPart,
            ':validTime' => time()-60*60*3,
        ));


        // foreach

		// ress bonus by production
        $sql	= 'SELECT SUM(metal_perhour) as sumMetal, SUM(crystal_perhour) as sumCrystal, SUM(deuterium_perhour) as sumDeuterium FROM %%PLANETS%%';
        $totalData = Database::get()->select($sql, array())[0];
        print_r($totalData);
        $sql	= 'UPDATE %%PLANETS%% SET `coins` = `coins` + `metal_perhour`*:metalFactor+ `crystal_perhour`*:crystalFactor+ `deuterium_perhour` * :deuteriumFactor';
        Database::get()->update($sql, array(
            ":metalFactor" =>$coinPot*0.1/max(1,$totalData['sumMetal']),
            ":crystalFactor" => $coinPot*0.2/max(1,$totalData['sumCrystal']),
            ":deuteriumFactor" => $coinPot*0.2/max(1,$totalData['sumDeuterium'])
        ));
        return true;
	}
}
