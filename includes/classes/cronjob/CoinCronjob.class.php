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
	    $config = Config::get();
        $defaultAmount = $config->coinpot_start * (1-$config->referral_earn);
	    // check if coinpot is valid
        $sql = 'SELECT * from %%COINPOT%% WHERE next_payout < :time AND is_active=1 LIMIT 1';
        $data = Database::get()->selectSingle($sql, [':time' => time()]);
        if (!$data)
            return;
        $coinPot = $data['amount'];
        $sql = 'UPDATE %%COINPOT%% SET `time_paid`=:nowTime, is_active=0 WHERE `id` = :id LIMIT 1';
        Database::get()->update($sql, [':nowTime' => time(), ':id' => $data['id'] ]);
        $sql = 'UPDATE %%STATS%% SET stat_value = stat_value + :addAmount WHERE stat_key = "coins_out" LIMIT 1';
        Database::get()->update($sql, [':addAmount' => $coinPot]);

        $sql = 'INSERT INTO %%COINPOT%% (next_payout, amount, is_active, universe_id) VALUES(:nextTime, :amount, 1, :universeId)';
        Database::get()->insert($sql, [':nextTime' => time()+($config->coinpot_wait_minutes+mt_rand(0,$config->coinpot_random_minutes))*60, ':amount' => $defaultAmount, ':universeId' => $data['universe_id']]);
		// get active user planets
		$sql	= 'SELECT COUNT(p.id) as counter FROM %%PLANETS%% AS p LEFT JOIN %%USERS%% as u on p.id_owner = u.id WHERE p.universe = :universeId AND u.onlinetime > :validTime';
        $planets = Database::get()->selectSingle($sql, array(
            ':validTime' => time()-60*60*3,
            ':universeId' => $data['universe_id'],
        ), 'counter');
        $coinPotPart = $coinPot * 0.5 / max(1,$planets);
        $sql	= 'UPDATE %%PLANETS%% SET `coins` = coins + :coinCount WHERE `id` IN(SELECT p.id FROM %%PLANETS%% AS p LEFT JOIN %%USERS%% as u on p.id_owner = u.id WHERE p.universe = :universeId AND u.onlinetime > :validTime)';
        $planets = Database::get()->update($sql, array(
            ':coinCount' => $coinPotPart,
            ':universeId' => $data['universe_id'],
            ':validTime' => time()-60*60*3,
        ));


        // foreach

		// ress bonus by production
        $sql	= 'SELECT SUM(metal_perhour) as sumMetal, SUM(crystal_perhour) as sumCrystal, SUM(deuterium_perhour) as sumDeuterium FROM %%PLANETS%% WHERE universe = :universeId';
        $totalData = Database::get()->select($sql, array(':universeId' => $data['universe_id']))[0];
        print_r($totalData);
        $sql	= 'UPDATE %%PLANETS%% SET `coins` = `coins` + `metal_perhour`*:metalFactor+ `crystal_perhour`*:crystalFactor+ `deuterium_perhour` * :deuteriumFactor WHERE universe = :universeId';
        Database::get()->update($sql, array(
            ":metalFactor" =>$coinPot*0.1/max(1,$totalData['sumMetal']),
            ":crystalFactor" => $coinPot*0.2/max(1,$totalData['sumCrystal']),
            ":deuteriumFactor" => $coinPot*0.2/max(1,$totalData['sumDeuterium']),
            ':universeId' => $data['universe_id']
        ));
        return true;
	}
}
