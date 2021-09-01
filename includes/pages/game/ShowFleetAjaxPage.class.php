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


class ShowFleetAjaxPage extends AbstractGamePage
{
    public $returnData = array();

    public static $requireModule = 0;

    function __construct()
    {
        parent::__construct();
        $this->setWindow('ajax');
    }

    private function sendData($Code, $Message)
    {
        $this->returnData['code'] = $Code;
        $this->returnData['message'] = $Message;
        $this->sendJSON($this->returnData);
    }

    protected function checkFleet($fleetArray)
    {
        global $PLANET, $resource, $LNG;
        foreach ($fleetArray as $Ship => $Count) {
            if ($Count > $PLANET[$resource[$Ship]]) {
                $this->sendData(613, $LNG['fl_not_all_ship_avalible']);
            }
        }
    }

    public function show()
    {
        global $USER, $PLANET, $resource, $LNG, $pricelist;

        $UserDeuterium = $PLANET['deuterium'];

        $planetID = HTTP::_GP('planetID', 0);
        $targetMission = HTTP::_GP('mission', 0);

        $activeSlots = FleetFunctions::GetCurrentFleets($USER['id']);
        $maxSlots = FleetFunctions::GetMaxFleetSlots($USER);

        $this->returnData['slots'] = $activeSlots;

        if (IsVacationMode($USER)) {
            $this->sendData(620, $LNG['fa_vacation_mode_current']);
        }

        if ($maxSlots <= $activeSlots) {
            $this->sendData(612, $LNG['fa_no_more_slots']);
        }

        $fleetArray = array();

        $db = Database::get();

        switch ($targetMission) {
            case MISSION_SPY:
                if (!isModuleAvailable(MODULE_MISSION_SPY)) {
                    $this->sendData(699, $LNG['sys_module_inactive']);
                }

                $ships = min($USER['spio_anz'], $PLANET[$resource[210]]);

                if (empty($ships)) {
                    $this->sendData(611, $LNG['fa_no_spios']);
                }

                $fleetArray = array(SHIP_SPY_PROBE => $ships);
                $this->returnData['ships'][SHIP_SPY_PROBE] = $PLANET[$resource[SHIP_SPY_PROBE]] - $ships;
                break;
            case MISSION_COLONIZE:
                $targetGalaxy = HTTP::_GP('galaxy', 0);
                $targetSystem = HTTP::_GP('system', 0);
                $targetPlanet = HTTP::_GP('planet', 0);
                $sql = "SELECT id, id_owner, der_metal, der_crystal, destruyed, ally_deposit FROM %%PLANETS%% WHERE universe = :universe AND galaxy = :targetGalaxy AND system = :targetSystem AND planet = :targetPlanet;";
                $targetPlanetData = $db->selectSingle($sql, array(
                    ':universe' => Universe::current(),
                    ':targetGalaxy' => $targetGalaxy,
                    ':targetSystem' => $targetSystem,
                    ':targetPlanet' => $targetPlanet,
                ));
                if (!empty($targetPlanetData)) {
                    $this->sendData(612, $LNG['fl_target_exists']);
                }
                $targetData = [
                    "galaxy" => $targetGalaxy,
                    "system" => $targetSystem,
                    "planet" => $targetPlanet,
                    "planet_type" => TYPE_PLANET,
                    "id_owner" => 0,
                ];
                $fleetArray = [
                    SHIP_COLONYSHIP => 1,
                ];
                $this->checkFleet($fleetArray);

                break;
            case MISSION_RECYCLE:
                if (!isModuleAvailable(MODULE_MISSION_RECYCLE)) {
                    $this->sendData(699, $LNG['sys_module_inactive']);
                }

                $sql = "SELECT (der_metal + der_crystal) as sum FROM %%PLANETS%% WHERE id = :planetID;";
                $totalDebris = $db->selectSingle($sql, array(
                    ':planetID' => $planetID
                ), 'sum');

                $recElementIDs = array(SHIP_BATTLE_RECYCLER, SHIP_RECYCLER);

                $fleetArray = array();

                foreach ($recElementIDs as $elementID) {
                    $a = $pricelist[$elementID]['capacity'] * (1 + $USER['factor']['ShipStorage']);
                    $shipsNeed = min(ceil($totalDebris / $a), $PLANET[$resource[$elementID]]);
                    $totalDebris -= ($shipsNeed * $a);

                    $fleetArray[$elementID] = $shipsNeed;
                    $this->returnData['ships'][$elementID] = $PLANET[$resource[$elementID]] - $shipsNeed;
                    if ($totalDebris <= 0) {
                        break;
                    }
                }

                if (empty($fleetArray)) {
                    $this->sendData(611, $LNG['fa_no_recyclers']);
                }
                break;
            case MISSION_ATTACK:
                $tmpFleetArray = HTTP::_GP('fleet', 0);
                $fleetArray = [];
                foreach ($_POST as $key => $value) {
                    if (strpos($key, 'fleet_') !== false) {
                        $fleetArray[str_replace("fleet_", "", $key)] = $value;
                    }
                }
                break;
            default:
                $this->sendData(610, $LNG['fa_not_enough_probes']);
                break;
        }

        switch ($targetMission) {
            case MISSION_RECYCLE:
            case MISSION_SPY:
            case MISSION_ATTACK:
                if (empty($planetID)) {
                    $this->sendData(601, $LNG['fa_planet_not_exist']);
                }


                $sql = "SELECT planet.id_owner as id_owner,
		planet.galaxy as galaxy,
		planet.system as system,
		planet.planet as planet,
		planet.planet_type as planet_type,
		total_points, onlinetime, urlaubs_modus, banaday, authattack
		FROM %%PLANETS%% planet
		INNER JOIN %%USERS%% user ON planet.id_owner = user.id
		LEFT JOIN %%STATPOINTS%% as stat ON stat.id_owner = user.id AND stat.stat_type = '1'
		WHERE planet.id = :planetID;";

                $targetData = $db->selectSingle($sql, array(
                    ':planetID' => $planetID
                ));
                if (empty($targetData)) {
                    $this->sendData(601, $LNG['fa_planet_not_exist']);
                }
                break;
        }

        $fleetArray = array_filter($fleetArray);

        if (empty($fleetArray)) {
            $this->sendData(610, $LNG['fa_not_enough_probes']);
        }


        if ($targetMission == MISSION_SPY) {
            if (Config::get()->adm_attack == 1 && $targetData['authattack'] > $USER['authlevel']) {
                $this->sendData(619, $LNG['fa_action_not_allowed']);
            }

            if (IsVacationMode($targetData)) {
                $this->sendData(605, $LNG['fa_vacation_mode']);
            }
            $sql = 'SELECT total_points
			FROM %%STATPOINTS%%
			WHERE id_owner = :userId AND stat_type = :statType';

            $USER += Database::get()->selectSingle($sql, array(
                ':userId' => $USER['id'],
                ':statType' => 1
            ));

            $IsNoobProtec = CheckNoobProtec($USER, $targetData, $targetData);

            if ($IsNoobProtec['NoobPlayer']) {
                $this->sendData(603, $LNG['fa_week_player']);
            }

            if ($IsNoobProtec['StrongPlayer']) {
                $this->sendData(604, $LNG['fa_strong_player']);
            }

            if ($USER['id'] == $targetData['id_owner']) {
                $this->sendData(618, $LNG['fa_not_spy_yourself']);
            }
        }

        $SpeedFactor = FleetFunctions::GetGameSpeedFactor();
        $Distance = FleetFunctions::GetTargetDistance(array($PLANET['galaxy'], $PLANET['system'], $PLANET['planet']), array($targetData['galaxy'], $targetData['system'], $targetData['planet']));
        $SpeedAllMin = FleetFunctions::GetFleetMaxSpeed($fleetArray, $USER);
        $Duration = FleetFunctions::GetMissionDuration(10, $SpeedAllMin, $Distance, $SpeedFactor, $USER);
        $consumption = FleetFunctions::GetFleetConsumption($fleetArray, $Duration, $Distance, $USER, $SpeedFactor);

        $UserDeuterium -= $consumption;

        if ($UserDeuterium < 0) {
            $this->sendData(613, $LNG['fa_not_enough_fuel']);
        }

        if ($consumption > FleetFunctions::GetFleetRoom($fleetArray)) {
            $this->sendData(613, $LNG['fa_no_fleetroom']);
        }

        if (connection_aborted())
            exit;

        $this->returnData['slots']++;

        $fleetResource = array(
            901 => 0,
            902 => 0,
            903 => 0,
        );

        $fleetStartTime = $Duration + TIMESTAMP;
        $fleetStayTime = $fleetStartTime;
        $fleetEndTime = $fleetStayTime + $Duration;

        $shipID = array_keys($fleetArray);
        $PLANET['deuterium'] -= $consumption;

        FleetFunctions::sendFleet($fleetArray, $targetMission, $USER['id'], $PLANET['id'], $PLANET['galaxy'],
            $PLANET['system'], $PLANET['planet'], $PLANET['planet_type'], $targetData['id_owner'], $planetID,
            $targetData['galaxy'], $targetData['system'], $targetData['planet'], $targetData['planet_type'],
            $fleetResource, $fleetStartTime, $fleetStayTime, $fleetEndTime, 0, 0, 0, $consumption);

        $this->sendData(600, $LNG['fa_sending'] . " " . array_sum($fleetArray) . " " . $LNG['tech'][$shipID[0]] . " " . $LNG['gl_to'] . " " . $targetData['galaxy'] . ":" . $targetData['system'] . ":" . $targetData['planet'] . " ...");
    }
}
