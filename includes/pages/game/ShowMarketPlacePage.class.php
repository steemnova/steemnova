<?php

/**
 *  Steemnova
 *   by Adam "dotevo" Jordanek 2018
 *
 * For the full copyright and license information, please view the LICENSE
 *
 */

class ShowMarketPlacePage extends AbstractGamePage
{
	public static $requireModule = MODULE_BATTLEHALL;

	function __construct()
    {
		parent::__construct();
	}

	private function checkSlots($USER) {
		global $LNG;
		$ActualFleets		= FleetFunctions::GetCurrentFleets($USER['id']);
		if (FleetFunctions::GetMaxFleetSlots($USER) <= $ActualFleets)
		{
			return array('result' => -1, 'reason' => $LNG['fl_no_slots']);
		}
		return array('result' => 0);
	}

	private function checkTechs($SELLER){
		global $USER, $resource, $LNG;

		$attack = $USER[$resource[109]] * 10 + $USER['factor']['Attack'] * 100;
		$defensive = $USER[$resource[110]] * 10 + $USER['factor']['Defensive'] * 100;
		$shield = $USER[$resource[111]] * 10 + $USER['factor']['Shield'] * 100;

		$SELLER['factor']		= getFactors($SELLER);
		$attack_targ = $SELLER[$resource[109]] * 10 + $SELLER['factor']['Attack'] * 100;
		$defensive_targ = $SELLER[$resource[110]] * 10 + $SELLER['factor']['Defensive'] * 100;
		$shield_targ = $SELLER[$resource[111]] * 10 + $SELLER['factor']['Shield'] * 100;

		if($attack > $attack_targ || $defensive > $defensive_targ || $shield > $shield_targ) {
			return array(
				'buyable' => false,
				'reason' => $LNG['market_buyable_no_tech']
			);
		}

		return array("buyable" => true,
			'reason' => '');
	}

	private function checkDiplo($visibility, $level, $seller_ally, $ally) {
		global $LNG;
		if($visibility == 2 && $level == 5 ) {
			return array(
				'buyable' => false,
				'reason' => $LNG['market_buyable_no_enemies']
			);
		}

		if($visibility == 1 && $ally != $seller_ally && ($level == NULL || $level >3)) {
			return array(
				'buyable' => false,
				'reason' => $LNG['market_buyable_only_trade_partners']
			);
		}

		return array("buyable" => true,
			'reason' => '');
	}

	private function getResourceTradeHistory() {
		$db = Database::get();
		$sql = 'SELECT
			buy_time as time,
			ex_resource_type as res_type,
			ex_resource_amount as amount,
			seller.fleet_resource_metal as metal,
			seller.fleet_resource_crystal as crystal,
			seller.fleet_resource_deuterium as deuterium
			FROM %%TRADES%%
			JOIN %%LOG_FLEETS%% seller ON seller.fleet_id = seller_fleet_id
			JOIN %%LOG_FLEETS%% buyer ON buyer.fleet_id = buyer_fleet_id
			WHERE transaction_type = 0 ORDER BY time DESC LIMIT 40;';
		$trades = $db->select($sql, array(
			//TODO LIMIT
		));
		return $trades;
	}

	private function getFleetTradeHistory() {
		global $LNG;
		$db = Database::get();
		$sql = 'SELECT
			seller.fleet_array as fleet,
			buy_time as time,
			ex_resource_type as res_type,
			ex_resource_amount as amount
			FROM %%TRADES%%
			JOIN %%LOG_FLEETS%% seller ON seller.fleet_id = seller_fleet_id
			JOIN %%LOG_FLEETS%% buyer ON buyer.fleet_id = buyer_fleet_id
			WHERE transaction_type = 1 ORDER BY time DESC LIMIT 40;';
		$trades = $db->select($sql, array(
			//TODO LIMIT
		));
		for($i =0; $i< count($trades);$i++){
			$fleet =  FleetFunctions::unserialize($trades[$i]['fleet']);
			$fleet_str = '';
			foreach($fleet as $name => $amount) {
				$fleet_str .= $LNG['shortNames'][$name].' x'.$amount."\n";
			}
			$trades[$i]['fleet_str'] = $fleet_str;
		}
		return $trades;
	}


	private function getOffers() {
		global $LNG, $PLANET;
		$db = Database::get();
		$sql = 'SELECT *
			FROM %%TRADES%%
			WHERE closed = 0 AND planet_id = :planet;';

		$offers = $db->select($sql, array(
			':planet' => $PLANET['id']
		));
		for($i =0;$i<count($offers);$i++) {
			$offers[$i]['fleet'] = FleetFunctions::unserialize($offers[$i]['trade_fleet_array']);
		}
		return $offers;
	}


	private function doBuy() {
		global $USER, $PLANET, $reslist, $resource, $LNG, $pricelist;
		$tradeID			= HTTP::_GP('tradeID', 0);
		$shipType		= HTTP::_GP('shipType', "");
		$db = Database::get();

		//Slots checking
		$checkResult = $this->checkSlots($USER);
		if ($checkResult['result'] < 0)
		{
			return $checkResult['reason'];
		}

		$sql = 'SELECT *
			FROM %%TRADES%%
			JOIN %%PLANETS%% as planet ON planet_id = planet.id
			JOIN %%USERS%% as users ON id_owner = users.id
			LEFT JOIN (
				SELECT owner_2 as al ,level, accept  FROM %%DIPLO%% WHERE owner_1 = :al
				UNION
				SELECT owner_1 as al,level, accept  FROM %%DIPLO%% WHERE owner_2 = :al) as packts
			ON al = ally_id
			WHERE closed = 0 AND trade_id = :trade_id;';
		$fleetResult = $db->select($sql, array(
			':al' => $USER['ally_id'],
			':trade_id' => $tradeID
		));

		//Error: no results
		if ($db->rowCount() == 0) {
			return $LNG['market_p_msg_not_found'];
		}

		$fleetResult = $fleetResult[0];

		$fleetResult['factor'] = getFactors($fleetResult);
		$buy = $this->checkOffer($fleetResult);

		//if not in range 1-3
		if($fleetResult['ex_resource_type'] >= 4 ||
			$fleetResult['ex_resource_type'] <= 0) {
				return $LNG['market_p_msg_wrong_resource_type'];
		}
		$factor = 1 + $USER['factor']['ShipStorage'];

		//-------------FLEET SIZE CALCULATION---------------
		$amount = $fleetResult['ex_resource_amount'];

		$F1capacity = 0;
		$F1type = 0;
		//PRIO for LC
		if($shipType == 1) {
			$F1capacity = $pricelist[202]['capacity'] * $factor;
			$F1type = 202;
		}
		// PRIO for HC
		else {
			$F1capacity = $pricelist[203]['capacity'] * $factor;
			$F1type = 203;
		}

		$F1 = min($PLANET[$resource[$F1type]], ceil($amount / $F1capacity));

			//taken
		$amountTMP = $amount - $F1 * $F1capacity;
		// If still fleet needed
		$F2 = 0;
		$F2capacity = 0;
		$F2type = 0;
		if ($amountTMP > 0) {
			//We need HC
			if($shipType == 1) {
				$F2capacity = $pricelist[203]['capacity'] * $factor;
				$F2type = 203;
			}
			//We need LC
			else{
				$F2capacity = $pricelist[202]['capacity'] * $factor;
				$F2type = 202;
			}
			$F2 = min($PLANET[$resource[$F2type]], ceil($amountTMP / $F2capacity));
			$amountTMP -= $F2 * $F2capacity;
		}
		//------------------------------------------------------------------------

		if($amountTMP > 0) {
			return $LNG['market_p_msg_more_ships_is_needed'];
		}

		$fleetArrayTMP = array();
		$fleetArrayTMP = array($F1type => $F1, $F2type => $F2);
		$fleetArray = $fleetArrayTMP;
		$fleetArray						= array_filter($fleetArrayTMP);
		$SpeedFactor    	= FleetFunctions::GetGameSpeedFactor();
		$Distance    		= FleetFunctions::GetTargetDistance(array($PLANET['galaxy'], $PLANET['system'], $PLANET['planet']), array($fleetResult['galaxy'], $fleetResult['system'], $fleetResult['planet']));
		$SpeedAllMin		= FleetFunctions::GetFleetMaxSpeed($fleetArray, $USER);
		$Duration			= FleetFunctions::GetMissionDuration(10, $SpeedAllMin, $Distance, $SpeedFactor, $USER);
		$consumption		= FleetFunctions::GetFleetConsumption($fleetArray, $Duration, $Distance, $USER, $SpeedFactor);

		$fleetStartTime		= $Duration + TIMESTAMP;
		$fleetStayTime		= $fleetStartTime;
		$fleetEndTime		= $fleetStayTime + $Duration;

		$met = 0;
		$cry = 0;
		$deu = 0;
		if ($fleetResult['ex_resource_type'] == 1)
			$met = $amount;
		elseif ($fleetResult['ex_resource_type'] == 2)
			$cry = $amount;
		elseif ($fleetResult['ex_resource_type'] == 3)
			$deu = $amount;

		$fleetResource	= array(
			901	=> $met,
			902	=> $cry,
			903	=> $deu,
		);

		if($PLANET[$resource[901]]-$fleetResource[901] < 0 ||
			$PLANET[$resource[902]]	-$fleetResource[902] <0 ||
			$PLANET[$resource[903]]	-$fleetResource[903] - $consumption < 0) {
			return $LNG['market_p_msg_resources_error'];
		}

		$PLANET[$resource[901]]	-= $fleetResource[901];
		$PLANET[$resource[902]]	-= $fleetResource[902];
		$PLANET[$resource[903]]	-= $fleetResource[903] + $consumption;

		$buyerfleet = FleetFunctions::sendFleet($fleetArray, 3/*Transport*/, $USER['id'], $PLANET['id'], $PLANET['galaxy'],
			$PLANET['system'], $PLANET['planet'], $PLANET['planet_type'], $fleetResult['id_owner'], $fleetResult['planet_id'],
			$fleetResult['galaxy'], $fleetResult['system'], $fleetResult['planet'], $fleetResult['planet_type'],
			$fleetResource, $fleetStartTime, $fleetStayTime, $fleetEndTime,0,0,1);



		/////////////////////////////////////////////////////////////////////////////
		/// SEND/
		$fleetArray						= FleetFunctions::unserialize($fleetResult['trade_fleet_array']);
		$SpeedFactor    	= FleetFunctions::GetGameSpeedFactor();
		$Distance    		= FleetFunctions::GetTargetDistance(array($PLANET['galaxy'], $PLANET['system'], $PLANET['planet']), array($fleetResult['galaxy'], $fleetResult['system'], $fleetResult['planet']));
		$SpeedAllMin		= FleetFunctions::GetFleetMaxSpeed($fleetArray, $fleetResult);
		$Duration			= FleetFunctions::GetMissionDuration(10, $SpeedAllMin, $Distance, $SpeedFactor, $fleetResult);
		//TODO: $consumption		= FleetFunctions::GetFleetConsumption($fleetArray, $Duration, $Distance, $fleetResult['fleet_owner'], $SpeedFactor);

		$fleetStartTime		= $Duration + TIMESTAMP;
		$fleetStayTime		= $fleetStartTime;
		$fleetEndTime		= $fleetStayTime + $Duration;

		$planetUpdater	= new ResourceUpdate();
		$planetUpdater->CalcResource($fleetResult, $fleetResult, true);

		$sql = 'UPDATE %%PLANETS%% SET
		metal		= metal - :metal,
		crystal		= crystal - :crystal,
		deuterium	= deuterium - :deuterium
		WHERE id = :planetId;';

		$db->update($sql, array(
			':metal'		=> $fleetResult['resource_metal'],
			':crystal'		=> $fleetResult['resource_crystal'],
			':deuterium'	=> $fleetResult['resource_deuterium'],
			':planetId'		=> $fleetResult['planet_id']
		));

		$mission = 3;
		if ($fleetResult['transaction_type'] == 1) {
			$mission = 16;
		}

		$sellerfleet = FleetFunctions::sendFleet($fleetArray, $mission, $fleetResult['id_owner'], $fleetResult['planet_id'],
			$fleetResult['galaxy'], $fleetResult['system'], $fleetResult['planet'], $fleetResult['planet_type'], $USER['id'], $PLANET['id'], $PLANET['galaxy'],
			$PLANET['system'], $PLANET['planet'], $PLANET['planet_type'],
			array(901	=> $fleetResult['resource_metal'], 902	=> $fleetResult['resource_crystal'], 903	=> $fleetResult['resource_deuterium']), $fleetStartTime, $fleetStayTime, $fleetEndTime,0,0,1);


		$sql	= 'UPDATE %%TRADES%% SET `seller_fleet_id` = :sellerFleetId, `buyer_fleet_id` = :buyerFleetId,`buy_time` = NOW(), `closed` = :closed WHERE trade_id	= :tradeId;';
		$db->update($sql, array(
			':tradeId'	=> $tradeID,
			':buyerFleetId' =>$buyerfleet,
			':sellerFleetId' =>$sellerfleet,
			':closed' => 1
		));

		$LC = 0;
		$HC = 0;
		if(array_key_exists(202,$fleetArrayTMP))
			$LC = $fleetArrayTMP[202];
		if(array_key_exists(203,$fleetArrayTMP))
			$HC = $fleetArrayTMP[203];

		// To customer
		$Message	= sprintf($LNG['market_msg_trade_bought'], $fleetResult['galaxy'].":".$fleetResult['system'].":".$fleetResult['planet'],
			$fleetResource[901],$LNG['tech'][901],
			$fleetResource[902],$LNG['tech'][902],
			$fleetResource[903],$LNG['tech'][903],
			$consumption, $LNG['tech'][903]);
		PlayerUtil::sendMessage($USER['id'], 0, $LNG['market_msg_trade_from'], 4, $LNG['market_msg_trade_topic'],
			$Message, TIMESTAMP, NULL, 1, $fleetResult['universe']);

		// To salesmen
		$Message	= sprintf($LNG['market_msg_trade_sold'], $PLANET['galaxy'].":".$PLANET['system'].":".$PLANET['planet'],
			$fleetResult['resource_metal'],$LNG['tech'][901],
			$fleetResult['resource_crystal'],$LNG['tech'][902],
			$fleetResult['resource_deuterium'],$LNG['tech'][903]);
		PlayerUtil::sendMessage($fleetResult['id_owner'], 0, $LNG['market_msg_trade_from'], 4, $LNG['market_msg_trade_topic'],
			$Message, TIMESTAMP, NULL, 1, $fleetResult['universe']);
		return sprintf($LNG['market_p_msg_sent'], $LC, $HC);
	}

	private function doAdd()
	{
		global $USER, $PLANET, $pricelist, $resource, $LNG;

		$ship					= HTTP::_GP('ship', 0);
		$resEx				= HTTP::_GP('resEx', "");
		$fleet_size		= (int)(HTTP::_GP('fleet_size', 0));
		$exchange			= (int)(HTTP::_GP('exchange', 0));
		$visibility		= HTTP::_GP('visibility', 0);
		$markettype		= HTTP::_GP('markettype', 0);
		$metal		= (int)HTTP::_GP('metal', 0);
		$crystal		= (int)HTTP::_GP('crystal', 0);
		$deuterium		= (int)HTTP::_GP('deuterium', 0);


		if ($metal < 0 || $crystal < 0 || $deuterium < 0) {
			return $LNG['market_add_negative_resource'];
		}

		if ($metal + $crystal + $deuterium == 0 && $markettype == 0) {
			return $LNG['market_add_empty_resource'];
		}

		if ($fleet_size <= 0) {
			return $LNG['market_add_wrong_fleet_amount'];
		}

		if ($exchange <= 0) {
			return $LNG['market_add_wrong_amount'];
		}

		$factor = 1 + $USER['factor']['ShipStorage'];
		$capacity = $pricelist[$ship]['capacity'] * $factor;
		if ($metal+ $crystal + $deuterium > $capacity * $fleet_size) {
			return $LNG['market_add_fleet_too_small'];
		}

		$db = Database::get();

		$sql    = 'INSERT INTO %%TRADES%% SET
								resource_metal													= :metal,
								resource_crystal												= :crystal,
								resource_deuterium											= :deuterium,
								transaction_type                        = :transaction,
								filter_visibility                       = :visibility,
								ex_resource_type                        = :resType,
								ex_resource_amount              				= :resAmount,
								planet_id																= :planet,
								trade_fleet_array												= :fleet;';
		$db->insert($sql, array(
			':metal'	=> $metal,
			':crystal'	=> $crystal,
			':deuterium'	=> $deuterium,
			':transaction'	=> $markettype,
			':resType'  => $resEx,
			':resAmount' => $exchange,
			':visibility' => $visibility,
			':planet' => $PLANET['id'],
			':fleet'  => $ship.",".$fleet_size
		));
	}


	private function doRemoveOffer()
	{
		global $PLANET, $LNG;

		$trade_id					= HTTP::_GP('trade_id', 0);

		$db = Database::get();
		$sql    = 'DELETE FROM %%TRADES%% WHERE
								planet_id	= :planet AND trade_id = :trade_id;';
		$db->delete($sql, array(
			':planet'	=> $PLANET['id'],
			':trade_id'	=> $trade_id
		));
	}

	private function checkOffer($offer) {
		global $USER, $LNG, $resource;
		$buy = array();
		//Filters: ex. Diplo
		{
			//Level 5 - enemies
			//Level 0 - 3 alliance
			$buy = $this->checkDiplo($offer['filter_visibility'], $offer['level'], $offer['ally_id'], $USER['ally_id']);
			//Fleet market
			if ($buy['buyable'] && $offer['transaction_type'] == 1)
				$buy = $this->checkTechs($offer);
			if (!$buy['buyable'])
				return $buy;
		}
		//Is enough resources?
		if($offer['metal'] < $offer['resource_metal'] || $offer['crystal'] < $offer['resource_crystal'] || $offer['deuterium'] < $offer['resource_deuterium'])
			return array("buyable" => false, 'reason' => 'TODO');
		//Does planet has fleet?
		{
			$fleet =  FleetFunctions::unserialize($offer['trade_fleet_array']);
			foreach($fleet as $name => $amount) {
				if($offer[$resource[$name]] < $amount)
					return array("buyable" => false, 'reason' => 'TODO2');
			}
		}
		{
			//Slots checking
			$checkResult = $this->checkSlots($offer);
			if ($checkResult['result'] < 0)
			{
				return array("buyable" => false, 'reason' => $checkResult['reason']);
			}
		}
		return array("buyable" => true, 'reason' => '');
	}

	public function show()
	{
		global $USER, $PLANET, $reslist, $resource, $LNG;

		$FleetID			= HTTP::_GP('fleetID', 0);
		$GetAction		= HTTP::_GP('action', "");
		$shipType		= HTTP::_GP('shipType', "");

		$message = "";
		$db = Database::get();

		if($GetAction == "buy") {
			$message = $this->doBuy();
		} elseif($GetAction == "add") {
			$message = $this->doAdd();
		} elseif($GetAction == "removeoffer") {
			$message = $this->doRemoveOffer();
		}

		$sql = 'SELECT *
			FROM %%TRADES%%
			JOIN %%PLANETS%% as planet ON planet_id = planet.id
			JOIN %%USERS%% as users ON id_owner = users.id
			LEFT JOIN (
				SELECT owner_2 as al ,level, accept  FROM %%DIPLO%% WHERE owner_1 = :al
				UNION
				SELECT owner_1 as al,level, accept  FROM %%DIPLO%% WHERE owner_2 = :al) as packts
			ON al = ally_id
			WHERE closed = 0;';
		$fleetResult = $db->select($sql, array(
			':al' => $USER['ally_id']
		));


		$FlyingFleetList	= array();

		foreach ($fleetResult as $fleetsRow)
		{
			$fleetsRow['factor'] = getFactors($fleetsRow);
			$buy = $this->checkOffer($fleetsRow);
			$resourceN = " ";
			switch($fleetsRow['ex_resource_type']) {
				case 1:
					$resourceN = $LNG['tech'][901];
					break;
				case 2:
					$resourceN = $LNG['tech'][902];
					break;
				case 3:
					$resourceN = $LNG['tech'][903];
					break;
				default:
					break;
			}

			//Level of diplo
			if($fleetsRow['accept'] == 0){
				$fleetsRow['level'] = NULL;
			}

			$SpeedFactor    	= FleetFunctions::GetGameSpeedFactor();
			//FROM
			$FROM_fleet =  FleetFunctions::unserialize($fleetsRow['trade_fleet_array']);
			$FROM_Distance    		= FleetFunctions::GetTargetDistance(array($PLANET['galaxy'], $PLANET['system'], $PLANET['planet']), array($fleetsRow['galaxy'], $fleetsRow['system'], $fleetsRow['planet']));
			$FROM_SpeedAllMin		= FleetFunctions::GetFleetMaxSpeed($FROM_fleet, $fleetsRow);
			$FROM_Duration			= FleetFunctions::GetMissionDuration(10, $FROM_SpeedAllMin, $FROM_Distance, $SpeedFactor, $fleetsRow);

			//TO
			$TO_Distance    		= FleetFunctions::GetTargetDistance(array($PLANET['galaxy'], $PLANET['system'], $PLANET['planet']), array($fleetsRow['galaxy'], $fleetsRow['system'], $fleetsRow['planet']));
			$TO_LC_SPEED		= FleetFunctions::GetFleetMaxSpeed(array(202 =>1), $USER);
			$TO_LC_DUR			= FleetFunctions::GetMissionDuration(10, $TO_LC_SPEED, $TO_Distance, $SpeedFactor, $USER);
			$TO_HC_SPEED		= FleetFunctions::GetFleetMaxSpeed(array(203 =>1), $USER);
			$TO_HC_DUR			= FleetFunctions::GetMissionDuration(10, $TO_HC_SPEED, $TO_Distance, $SpeedFactor, $USER);

			$fleet_str = '';
			foreach($FROM_fleet as $name => $amount) {
				$fleet_str .= $LNG['shortNames'][$name].' x'.$amount."\n";
			}

			$total = $fleetsRow['resource_metal'] + $fleetsRow['resource_crystal'] + $fleetsRow['resource_deuterium'];
			$FlyingFleetList[]	= array(
				'id'			=> $fleetsRow['trade_id'],
				'username'			=> $fleetsRow['username'],
				'type' => $fleetsRow['transaction_type'],

				'fleet_resource_metal'		=> $fleetsRow['resource_metal'],
				'fleet_resource_crystal'			=> $fleetsRow['resource_crystal'],
				'fleet_resource_deuterium'			=> $fleetsRow['resource_deuterium'],
				'fleet'		=> $fleet_str,
				'diplo' => $fleetsRow['level'],
				'from_alliance' => $fleetsRow['ally_id'] == $USER['ally_id'],
				'possible_to_buy' => $buy['buyable'],
				'reason' => $buy['reason'],
				'fleet_wanted_resource'	=> $resourceN,
				'fleet_wanted_resource_id' => $fleetsRow['ex_resource_type'],
				'fleet_wanted_resource_amount'	=> $fleetsRow['ex_resource_amount'],

				'from_duration' => $FROM_Duration,
				'to_lc_duration' => $TO_LC_DUR,
				'to_hc_duration' => $TO_HC_DUR,
				//'distance' => $FROM_Duration//$Distance    		= FleetFunctions::GetTargetDistance(array($PLANET['galaxy'], $PLANET['system'], $PLANET['planet']), array($fleetsRow['fleet_end_galaxy'], $fleetsRow['fleet_end_system'], $fleetsRow['fleet_end_planet'])),
			);
		}

		$FleetsOnPlanet = [];
		foreach($reslist['fleet'] as $FleetID)
		{
			if ($PLANET[$resource[$FleetID]] == 0 || $FleetID == 212)
				continue;

			$FleetsOnPlanet[]	= $FleetID;
		}

		$this->assign(array(
			'FleetsOnPlanet'	=> $FleetsOnPlanet,
			'message' => $message,
			'FlyingFleetList'		=> $FlyingFleetList,
			'offers' => $this->getOffers(),
			'resourceHistory' => $this->getResourceTradeHistory(),
			'fleetHistory' => $this->getFleetTradeHistory(),
		));
		$this->tplObj->loadscript('marketplace.js');
		$this->display('page.marketPlace.default.tpl');
	}
}
