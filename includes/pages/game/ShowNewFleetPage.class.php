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

class ShowNewFleetPage extends AbstractGamePage
{
	public static $requireModule = MODULE_FLEET_TABLE;

	function __construct() 
	{
		parent::__construct();
	}
	
	public function show()
	{
		global $USER, $PLANET, $pricelist, $reslist, $LNG;
		
		$targetGalaxy 			= HTTP::_GP('galaxy', (int) $PLANET['galaxy']);
		$targetSystem 			= HTTP::_GP('system', (int) $PLANET['system']);
		$targetPlanet			= HTTP::_GP('planet', (int) $PLANET['planet']);
		$targetType 			= HTTP::_GP('type', (int) $PLANET['planet_type']);
		
		$mission				= HTTP::_GP('target_mission', 0);
				
		$Fleet		= array();
		$FleetRoom	= 0;
		foreach ($reslist['fleet'] as $id => $ShipID)
		{
			$amount		 				= max(0, round(HTTP::_GP('ship'.$ShipID, 0.0, 0.0)));
			
			if ($amount < 1 || $ShipID == 212) continue;

			$Fleet[$ShipID]				= $amount;
			$FleetRoom			   	   += $pricelist[$ShipID]['capacity'] * $amount;
		}
		
		$FleetRoom	*= 1 + $USER['factor']['ShipStorage'];
		
		if (empty($Fleet))
			FleetFunctions::GotoFleetPage();
	
		$FleetData	= array(
			'fleetroom'			=> floatToString($FleetRoom),
			'gamespeed'			=> FleetFunctions::GetGameSpeedFactor(),
			'fleetspeedfactor'	=> max(0, 1 + $USER['factor']['FlyTime']),
			'planet'			=> array('galaxy' => $PLANET['galaxy'], 'system' => $PLANET['system'], 'planet' => $PLANET['planet'], 'planet_type' => $PLANET['planet_type']),
			'maxspeed'			=> FleetFunctions::GetFleetMaxSpeed($Fleet, $USER),
			'ships'				=> FleetFunctions::GetFleetShipInfo($Fleet, $USER),
			'fleetMinDuration'	=> MIN_FLEET_TIME,
		);
		
		$token		= getRandomString();
		
		$_SESSION['fleet'][$token]	= array(
			'time'		=> TIMESTAMP,
			'fleet'		=> $Fleet,
			'fleetRoom'	=> $FleetRoom,
		);

		$shortcutList	= $this->GetUserShotcut();
		$colonyList 	= $this->GetColonyList();
		$ACSList 		= $this->GetAvalibleACS();
		
		if(!empty($shortcutList)) {
			$shortcutAmount	= max(array_keys($shortcutList));
		} else {
			$shortcutAmount	= 0;
		}
		
		$this->tplObj->loadscript('flotten.js');
		$this->tplObj->execscript('updateVars();FleetTime();var relativeTime3 = Math.floor(Date.now() / 1000);window.setInterval(function() {if(relativeTime3 < Math.floor(Date.now() / 1000)) {FleetTime();relativeTime3++;}}, 25);');



		$this->assign(array(
			'token'			=> $token,
			'mission'		=> $mission,
			'shortcutList'	=> $shortcutList,
			'shortcutMax'	=> $shortcutAmount,
			'colonyList' 	=> $colonyList,
			'ACSList' 		=> $ACSList,
			'galaxy' 		=> $targetGalaxy,
			'system' 		=> $targetSystem,
			'planet' 		=> $targetPlanet,
			'type'			=> $targetType,
			'speedSelect'	=> FleetFunctions::$allowedSpeed,
			'typeSelect'   	=> array(1 => $LNG['type_planet_1'], 2 => $LNG['type_planet_2'], 3 => $LNG['type_planet_3']),
			'fleetdata'		=> $FleetData,
		));
		
		$this->display('page.newfleet.default.tpl');
	}


    public function step2()
    {
        global $USER, $PLANET, $LNG;

        $targetGalaxy  				= HTTP::_GP('galaxy', 0);
        $targetSystem   			= HTTP::_GP('system', 0);
        $targetPlanet   			= HTTP::_GP('planet', 0);
        $targetType 				= HTTP::_GP('type', 0);
        $targetMission 				= HTTP::_GP('target_mission', 0);
        $fleetSpeed  				= HTTP::_GP('speed', 0);
        $fleetGroup 				= HTTP::_GP('fleet_group', 0);
        $token						= HTTP::_GP('token', '');

        if (!isset($_SESSION['fleet'][$token]))
        {
            $this->sendJSON(array("error" => "return"));
        }

        $fleetArray    				= $_SESSION['fleet'][$token]['fleet'];

        $db = Database::get();
        $sql = "SELECT id, id_owner, der_metal, der_crystal, id_owner FROM %%PLANETS%% WHERE universe = :universe AND galaxy = :targetGalaxy AND system = :targetSystem AND planet = :targetPlanet AND planet_type = '1';";
        $targetPlanetData = $db->selectSingle($sql, array(
            ':universe' => Universe::current(),
            ':targetGalaxy' => $targetGalaxy,
            ':targetSystem' => $targetSystem,
            ':targetPlanet' => $targetPlanet
        ));

        // check if planet has owner
        if($targetPlanetData && $targetPlanetData['id_owner']) {
            $sql = 'SELECT a.username, a.ally_id, b.ally_name, b.ally_tag FROM %%USERS%% as a LEFT JOIN %%ALLIANCE%% as b ON a.ally_id=b.id WHERE a.id=:ownerId';
            $ownerData = $db->selectSingle($sql, [':ownerId' => $targetPlanetData['id_owner']]);
        } else {
            $ownerData = ["username" => "", "ally_id" => 0, "ally_name" => "", "ally_tag" => ""];
        }
        if($targetType == 2 && $targetPlanetData['der_metal'] == 0 && $targetPlanetData['der_crystal'] == 0)
        {
            $this->sendJSON(array("error" => "return", "message" => $LNG['fl_error_empty_derbis']));
            /*$this->printMessage($LNG['fl_error_empty_derbis'], array(array(
                'label'	=> $LNG['sys_back'],
                'url'	=> 'game.php?page=fleetTable'
            )));*/
        }

        $MisInfo		     		= array();
        $MisInfo['galaxy']     		= $targetGalaxy;
        $MisInfo['system'] 	  		= $targetSystem;
        $MisInfo['planet'] 	  		= $targetPlanet;
        $MisInfo['planettype'] 		= $targetType;
        $MisInfo['IsAKS']			= $fleetGroup;
        $MisInfo['Ship'] 			= $fleetArray;

        $MissionOutput	 			= FleetFunctions::GetFleetMissions($USER, $MisInfo, $targetPlanetData);

        if(empty($MissionOutput['MissionSelector']))
        {
            $this->sendJSON(array("error" => "return", "message" => $LNG['fl_empty_target']));
        }

        $GameSpeedFactor   		 	= FleetFunctions::GetGameSpeedFactor();
        $MaxFleetSpeed 				= FleetFunctions::GetFleetMaxSpeed($fleetArray, $USER);
        $distance      				= FleetFunctions::GetTargetDistance(array($PLANET['galaxy'], $PLANET['system'], $PLANET['planet']), array($targetGalaxy, $targetSystem, $targetPlanet));
        $duration      				= FleetFunctions::GetMissionDuration($fleetSpeed, $MaxFleetSpeed, $distance, $GameSpeedFactor, $USER);
        $consumption				= FleetFunctions::GetFleetConsumption($fleetArray, $duration, $distance, $USER, $GameSpeedFactor);

        if($consumption > $PLANET['deuterium'])
        {
            $this->sendJSON(array("error" => "return", "message" => $LNG['fl_not_enough_deuterium']));
        }

        if(!FleetFunctions::CheckUserSpeed($fleetSpeed))
        {
            $this->sendJSON(array("error" => "return"));

//            FleetFunctions::GotoFleetPage(0);
        }

        $_SESSION['fleet'][$token]['speed']			= $MaxFleetSpeed;
        $_SESSION['fleet'][$token]['distance']		= $distance;
        $_SESSION['fleet'][$token]['targetGalaxy']	= $targetGalaxy;
        $_SESSION['fleet'][$token]['targetSystem']	= $targetSystem;
        $_SESSION['fleet'][$token]['targetPlanet']	= $targetPlanet;
        $_SESSION['fleet'][$token]['targetType']	= $targetType;
        $_SESSION['fleet'][$token]['fleetGroup']	= $fleetGroup;
        $_SESSION['fleet'][$token]['fleetSpeed']	= $fleetSpeed;
        $_SESSION['fleet'][$token]['ownPlanet']		= $PLANET['id'];

        if(!empty($fleet_group))
            $targetMission	= 2;

        $fleetData	= array(
            'fleetroom'			=> floatToString($_SESSION['fleet'][$token]['fleetRoom']),
            'consumption'		=> floatToString($consumption),
        );
        $sql	= 'SELECT COUNT(*) as state
				FROM %%PLANETS%%
				WHERE `id_owner`	= :userId
				AND `planet_type`	= :type
				AND `destruyed`		= :destroyed;';
        $currentPlanetCount	= $db->selectSingle($sql, array(
            ':userId'		=> $USER['id'],
            ':type'			=> 1,
            ':destroyed'	=> 0
        ), 'state');
        $config	= Config::get($USER['universe']);

        $this->sendJSON(array(
            'fleetdata'						=> $fleetData,
            'consumption'					=> floatToString($consumption),
            'mission'						=> $targetMission,
            'colonize_notech'               => !PlayerUtil::allowPlanetPosition($targetPlanet, $USER),
            'max_planet_exceeded'           => $currentPlanetCount >= PlayerUtil::maxPlanetCount($USER),
            'min_astro_level'               => max(PlayerUtil::getPositionRequirement($targetPlanet, $USER), ($currentPlanetCount)/$config->planets_tech),
            'galaxy'			 			=> $PLANET['galaxy'],
            'system'			 			=> $PLANET['system'],
            'planet'			 			=> $PLANET['planet'],
            'type'			 				=> $PLANET['planet_type'],
            'MissionSelector' 				=> $MissionOutput['MissionSelector'],
            'StaySelector' 					=> $MissionOutput['StayBlock'],
            'Exchange' 					    => $MissionOutput['Exchange'],
            'fl_dm_alert_message'			=> sprintf($LNG['fl_dm_alert_message'], $LNG['type_mission_11'], $LNG['tech'][921]),
            'fl_continue'					=> $LNG['fl_continue'],
            'token' 						=> $token,
            'owner_data'                    => $ownerData,
            'own_ally'                      => $ownerData['ally_id'] == $USER['ally_id'] and $ownerData['ally_id'] != 0,
        ));

    }
	
	public function saveShortcuts()
	{
		global $USER, $LNG;
		
		if(!isset($_REQUEST['shortcut'])) {
			$this->sendJSON($LNG['fl_shortcut_saved']);
		}

        $db = Database::get();

		$ShortcutData	= $_REQUEST['shortcut'];
		$ShortcutUser	= $this->GetUserShotcut();
		foreach($ShortcutData as $ID => $planetData) {
			if(!isset($ShortcutUser[$ID])) {
				if(empty($planetData['name']) || empty($planetData['galaxy']) || empty($planetData['system']) || empty($planetData['planet'])) {
					continue;
				}

                $sql = "INSERT INTO %%SHORTCUTS%% SET ownerID = :userID, name = :name, galaxy = :galaxy, system = :system, planet = :planet, type = :type;";
                $db->insert($sql, array(
                    ':userID'   => $USER['id'],
                    ':name'     => $planetData['name'],
                    ':galaxy'   => $planetData['galaxy'],
                    ':system'   => $planetData['system'],
                    ':planet'   => $planetData['planet'],
                    ':type'     => $planetData['type']
                ));
			} elseif(empty($planetData['name'])) {
				$sql = "DELETE FROM %%SHORTCUTS%% WHERE shortcutID = :shortcutID AND ownerID = :userID;";
                $db->delete($sql, array(
                    ':shortcutID'   => $ID,
                    ':userID'       => $USER['id']
                ));
            } else {
				$planetData['ownerID']		= $USER['id'];
				$planetData['shortcutID']		= $ID;
				if($planetData != $ShortcutUser[$ID]) {
                    $sql = "UPDATE %%SHORTCUTS%% SET name = :name, galaxy = :galaxy, system = :system, planet = :planet, type = :type WHERE shortcutID = :shortcutID AND ownerID = :userID;";
                    $db->update($sql, array(
                        ':userID'   => $USER['id'],
                        ':name'     => $planetData['name'],
                        ':galaxy'   => $planetData['galaxy'],
                        ':system'   => $planetData['system'],
                        ':planet'   => $planetData['planet'],
                        ':type'     => $planetData['type'],
                        ':shortcutID'   => $ID
                    ));
                }
			}
		}
		
		$this->sendJSON($LNG['fl_shortcut_saved']);
	}
	
	private function GetColonyList()
	{
		global $PLANET, $USER;
		
		$ColonyList	= array();
		
		foreach($USER['PLANETS'] as $CurPlanetID => $CurPlanet)
		{
			if ($PLANET['id'] == $CurPlanet['id'])
				continue;
			
			$ColonyList[] = array(
				'name'		=> $CurPlanet['name'],
				'galaxy'	=> $CurPlanet['galaxy'],
				'system'	=> $CurPlanet['system'],
				'planet'	=> $CurPlanet['planet'],
				'type'		=> $CurPlanet['planet_type'],
			);	
		}
			
		return $ColonyList;
	}
	
	private function GetUserShotcut()
	{
		global $USER;
		
		if (!isModuleAvailable(MODULE_SHORTCUTS))
			return array();

        $db = Database::get();

        $sql = "SELECT * FROM %%SHORTCUTS%% WHERE ownerID = :userID;";
        $ShortcutResult = $db->select($sql, array(
            ':userID'   => $USER['id']
        ));

        $ShortcutList	= array();

		foreach($ShortcutResult as $ShortcutRow) {
			$ShortcutList[$ShortcutRow['shortcutID']] = $ShortcutRow;
		}
		
		return $ShortcutList;
	}
	
	private function GetAvalibleACS()
	{
		global $USER;
		
		$db = Database::get();

        $sql = "SELECT acs.id, acs.name, planet.galaxy, planet.system, planet.planet, planet.planet_type
		FROM %%USERS_ACS%%
		INNER JOIN %%AKS%% acs ON acsID = acs.id
		INNER JOIN %%PLANETS%% planet ON planet.id = acs.target
		WHERE userID = :userID AND :maxFleets > (SELECT COUNT(*) FROM %%FLEETS%% WHERE fleet_group = acsID);";
        $ACSResult = $db->select($sql, array(
            ':userID'       => $USER['id'],
            ':maxFleets'    => Config::get()->max_fleets_per_acs,
        ));

        $ACSList	= array();
		
		foreach ($ACSResult as $ACSRow) {
			$ACSList[]	= $ACSRow;
		}
		
		return $ACSList;
	}
	
	function checkTarget()
	{
		global $PLANET, $LNG, $USER, $resource;

		$targetGalaxy 		= HTTP::_GP('galaxy', 0);
		$targetSystem 		= HTTP::_GP('system', 0);
		$targetPlanet		= HTTP::_GP('planet', 0);
		$targetPlanetType	= HTTP::_GP('planet_type', 1);
	
		if($targetGalaxy == $PLANET['galaxy'] && $targetSystem == $PLANET['system'] && $targetPlanet == $PLANET['planet'] && $targetPlanetType == $PLANET['planet_type'])
		{
			$this->sendJSON($LNG['fl_error_same_planet']);
		}

		// If target is expedition
		if ($targetPlanet != Config::get()->max_planets + 1)
		{
			$db = Database::get();
            $sql = "SELECT u.id, u.urlaubs_modus, u.user_lastip, u.authattack,
            	p.destruyed, p.der_metal, p.der_crystal, p.destruyed
                FROM %%USERS%% as u, %%PLANETS%% as p WHERE
                p.universe = :universe AND
                p.galaxy = :targetGalaxy AND
                p.system = :targetSystem AND
                p.planet = :targetPlanet  AND
                p.planet_type = :targetType AND
                u.id = p.id_owner;";

			$planetData = $db->selectSingle($sql, array(
                ':universe'     => Universe::current(),
                ':targetGalaxy' => $targetGalaxy,
                ':targetSystem' => $targetSystem,
                ':targetPlanet' => $targetPlanet,
                ':targetType' => (($targetPlanetType == 2) ? 1 : $targetPlanetType),
            ));

            if ($targetPlanetType == 3 && !isset($planetData))
			{
				$this->sendJSON($LNG['fl_error_no_moon']);
			}

			if ($targetPlanetType != 2 && !empty($planetData['urlaubs_modus']))
			{
				$this->sendJSON($LNG['fl_in_vacation_player']);
			}

			if(!empty($planetData))
			if ($planetData['id'] != $USER['id'] && Config::get()->adm_attack == 1 && $planetData['authattack'] > $USER['authlevel'])
			{
				$this->sendJSON($LNG['fl_admin_attack']);
			}

			if(!empty($planetData))
			if ($planetData['destruyed'] != 0)
			{
				$this->sendJSON($LNG['fl_error_not_avalible']);
			}

			if($targetPlanetType == 2 && empty($planetData['der_metal']) && empty($planetData['der_crystal']))
			{
				$this->sendJSON($LNG['fl_error_empty_derbis']);
			}

			$sql	= 'SELECT (
				(SELECT COUNT(*) FROM %%MULTI%% WHERE userID = :userID) +
				(SELECT COUNT(*) FROM %%MULTI%% WHERE userID = :dataID)
			) as count;';

			if(!empty($planetData))
			$multiCount	= $db->selectSingle($sql ,array(
				':userID' => $USER['id'],
				':dataID' => $planetData['id']
			), 'count');

			if(ENABLE_MULTIALERT && $USER['id'] != $planetData['id'] && $USER['authlevel'] != AUTH_ADM && $USER['user_lastip'] == $planetData['user_lastip'] && $multiCount != 2)
			{
				$this->sendJSON($LNG['fl_multi_alarm']);
			}
		}
		else
		{
			if ($USER[$resource[124]] == 0)
			{
				$this->sendJSON($LNG['fl_target_not_exists']);
			}
			
			$activeExpedition	= FleetFunctions::GetCurrentFleets($USER['id'], 15, true);

			if ($activeExpedition >= FleetFunctions::getExpeditionLimit($USER))
			{
				$this->sendJSON($LNG['fl_no_expedition_slot']);
			}
		}

		$this->sendJSON('OK');	
	}
}