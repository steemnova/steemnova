<?php

class ShowNpcPage extends AbstractGamePage
{
    public function __construct()
    {
    }

    public function dispatch()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $this->postMethod();
        } else {
            $this->getMethod();
        }
    }

    protected function postMethod()
    {
        global $resource, $reslist;
        $pirateId = HTTP::_GP('pirateId', 2);
        $universeId = HTTP::_GP('universeId', 1);
        $config = Config::get($universeId);
        // get min/max galaxy
        $sql = 'SELECT MAX(galaxy) as max_galaxy FROM %%PLANETS%% WHERE universe = :universeID';
        $maxGalaxy = Database::get()->selectSingle($sql, [":universeID" => $universeId], "max_galaxy");
        $fleetData = [];
        foreach ($reslist['defense'] as $item) {
            $fleetData[] = "`".$resource[$item] . "`=" . HTTP::_GP('deff_' . $item, 0);
        }
        $fleetSql = "UPDATE %%PLANETS%% SET ".implode(",", $fleetData).", `coins`=:coins WHERE `id` = :planetID;";

        for ($i = 0; $i < HTTP::_GP('numPlanets', ''); $i++) {
            // get min/max system
            $targetGalaxy = mt_rand(1, $maxGalaxy);
            $sql = 'SELECT MAX(system) as max_system FROM %%PLANETS%% WHERE galaxy = :galaxyID AND universe = :universeID';
            $maxSystem = Database::get()->selectSingle($sql, [":universeID" => $universeId, ":galaxyID" => $targetGalaxy], "max_system");
            $targetSystem = mt_rand(1, $maxSystem);
            $tries = 0;
            do {
                try {
                    $planetId = PlayerUtil::createPlanet($targetGalaxy, $targetSystem, mt_rand(1, $config->max_planets), $universeId, $pirateId, NULL, false, 0);
                    $go_on = false;
                } catch (Exception) {
                    $tries++;
                    $go_on = true;
                    if ($tries > 5) {
                        $targetSystem++;
                    }

                    continue;
                }
                // add deff
                Database::get()->update($fleetSql, [":planetID" => $planetId, ":coins" => HTTP::_GP('numCuneros', 0)]);

            } while ($go_on);


        }
    }

    protected function getMethod()
    {

    }

    public function show()
    {
        global $LNG, $USER, $reslist;


        $template = new template();

        $this->dispatch();

        $template->assign_vars(array(
            'deffList' => $reslist['defense'],
        ));

        $template->show('NpcBody.tpl');
    }
}