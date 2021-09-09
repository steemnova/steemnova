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

class ShowResourcesPage extends AbstractGamePage
{
    public static $requireModule = MODULE_RESSOURCE_LIST;

    function __construct()
    {
        parent::__construct();
    }

    function send()
    {
        global $resource, $USER, $PLANET;
        if ($USER['urlaubs_modus'] == 0) {
            $updateSQL = array();
            if (!isset($_POST['prod']))
                $_POST['prod'] = array();


            $param = array(':planetId' => $PLANET['id']);

            foreach ($_POST['prod'] as $resourceId => $Value) {
                $FieldName = $resource[$resourceId] . '_porcent';
                if (!isset($PLANET[$FieldName]) || !in_array($Value, range(0, 10)))
                    continue;

                $updateSQL[] = $FieldName . " = :" . $FieldName;
                $param[':' . $FieldName] = (int)$Value;
                $PLANET[$FieldName] = $Value;
            }

            if (!empty($updateSQL)) {
                $sql = 'UPDATE %%PLANETS%% SET ' . implode(', ', $updateSQL) . ' WHERE id = :planetId;';

                Database::get()->update($sql, $param);

                $this->ecoObj->setData($USER, $PLANET);
                $this->ecoObj->ReBuildCache();
                list($USER, $PLANET) = $this->ecoObj->getData();
                $PLANET['eco_hash'] = $this->ecoObj->CreateHash();
            }
        }

        $this->save();
        $this->redirectTo('game.php?page=resources');
    }

    function show()
    {
        global $LNG, $ProdGrid, $resource, $reslist, $USER, $PLANET;

        $config = Config::get();

        if ($USER['urlaubs_modus'] == 1 || $PLANET['planet_type'] != 1) {
            $basicIncome[RESS_METAL] = 0;
            $basicIncome[RESS_CRYSTAL] = 0;
            $basicIncome[RESS_DEUTERIUM] = 0;
            $basicIncome[RESS_ENGERGY] = 0;
        } else {
            $basicIncome[RESS_METAL] = $config->{$resource[RESS_METAL] . '_basic_income'};
            $basicIncome[RESS_CRYSTAL] = $config->{$resource[RESS_CRYSTAL] . '_basic_income'};
            $basicIncome[RESS_DEUTERIUM] = $config->{$resource[RESS_DEUTERIUM] . '_basic_income'};
            $basicIncome[RESS_ENGERGY] = $config->{$resource[RESS_ENGERGY] . '_basic_income'};
        }

        $temp = array(
            RESS_METAL => array(
                'plus' => 0,
                'minus' => 0,
            ),
            RESS_CRYSTAL => array(
                'plus' => 0,
                'minus' => 0,
            ),
            RESS_DEUTERIUM => array(
                'plus' => 0,
                'minus' => 0,
            ),
            RESS_ENGERGY => array(
                'plus' => 0,
                'minus' => 0,
            )
        );

        $ressIDs = array_merge(array(), $reslist['resstype'][1], $reslist['resstype'][2]);

        $productionList = array();

        if ($PLANET['energy_used'] != 0) {
            $prodLevel = min(1, $PLANET['energy'] / abs($PLANET['energy_used']));
        } else {
            $prodLevel = 0;
        }

        /* Data for eval */
        $BuildEnergy = $USER[$resource[113]];
        $BuildTemp = $PLANET['temp_max'];

        foreach ($reslist['prod'] as $ProdID) {
            if (isset($PLANET[$resource[$ProdID]]) && $PLANET[$resource[$ProdID]] == 0)
                continue;

            if (isset($USER[$resource[$ProdID]]) && $USER[$resource[$ProdID]] == 0)
                continue;

            $productionList[$ProdID] = array(
                'production' => array(RESS_METAL => 0, RESS_CRYSTAL => 0, RESS_DEUTERIUM => 0, RESS_ENGERGY => 0),
                'elementLevel' => $PLANET[$resource[$ProdID]],
                'prodLevel' => $PLANET[$resource[$ProdID] . '_porcent'],
            );

            /* Data for eval */
            $BuildLevel = $PLANET[$resource[$ProdID]];
            $BuildLevelFactor = $PLANET[$resource[$ProdID] . '_porcent'];

            foreach ($ressIDs as $ID) {
                if (!isset($ProdGrid[$ProdID]['production'][$ID]))
                    continue;

                $Production = eval(ResourceUpdate::getProd($ProdGrid[$ProdID]['production'][$ID], $ProdID));

                if (in_array($ID, $reslist['resstype'][2])) {
                    $Production *= $config->energySpeed;
                } else {
                    $Production *= $prodLevel * $config->resource_multiplier;
                }

                $productionList[$ProdID]['production'][$ID] = $Production;

                if ($Production > 0) {
                    if ($PLANET[$resource[$ID]] == 0) continue;

                    $temp[$ID]['plus'] += $Production;
                } else {
                    $temp[$ID]['minus'] += $Production;
                }
            }
        }

        $storage = array(
            RESS_METAL => shortly_number($PLANET[$resource[RESS_METAL] . '_max']),
            RESS_CRYSTAL => shortly_number($PLANET[$resource[RESS_CRYSTAL] . '_max']),
            RESS_DEUTERIUM => shortly_number($PLANET[$resource[RESS_DEUTERIUM] . '_max']),
        );

        $basicProduction = array(
            RESS_METAL => $basicIncome[RESS_METAL] * $config->resource_multiplier,
            RESS_CRYSTAL => $basicIncome[RESS_CRYSTAL] * $config->resource_multiplier,
            RESS_DEUTERIUM => $basicIncome[RESS_DEUTERIUM] * $config->resource_multiplier,
            RESS_ENGERGY => $basicIncome[RESS_ENGERGY] * $config->energySpeed,
        );

        $totalProduction = array(
            RESS_METAL => $PLANET[$resource[RESS_METAL] . '_perhour'] + $basicProduction[RESS_METAL],
            RESS_CRYSTAL => $PLANET[$resource[RESS_CRYSTAL] . '_perhour'] + $basicProduction[RESS_CRYSTAL],
            RESS_DEUTERIUM => $PLANET[$resource[RESS_DEUTERIUM] . '_perhour'] + $basicProduction[RESS_DEUTERIUM],
            RESS_ENGERGY => $PLANET[$resource[RESS_ENGERGY]] + $basicProduction[RESS_ENGERGY] + $PLANET[$resource[RESS_ENGERGY] . '_used'],
        );

        $bonusProduction = array(
            RESS_METAL => $temp[RESS_METAL]['plus'] * ($USER['factor']['Resource'] + 0.02 * $USER[$resource[131]]),
            RESS_CRYSTAL => $temp[RESS_CRYSTAL]['plus'] * ($USER['factor']['Resource'] + 0.02 * $USER[$resource[132]]),
            RESS_DEUTERIUM => $temp[RESS_DEUTERIUM]['plus'] * ($USER['factor']['Resource'] + 0.02 * $USER[$resource[133]]),
            RESS_ENGERGY => $temp[RESS_ENGERGY]['plus'] * $USER['factor']['Energy'],
        );

        $dailyProduction = array(
            RESS_METAL => $totalProduction[RESS_METAL] * 24,
            RESS_CRYSTAL => $totalProduction[RESS_CRYSTAL] * 24,
            RESS_DEUTERIUM => $totalProduction[RESS_DEUTERIUM] * 24,
            RESS_ENGERGY => $totalProduction[RESS_ENGERGY],
        );

        $weeklyProduction = array(
            RESS_METAL => $totalProduction[RESS_METAL] * 168,
            RESS_CRYSTAL => $totalProduction[RESS_CRYSTAL] * 168,
            RESS_DEUTERIUM => $totalProduction[RESS_DEUTERIUM] * 168,
            RESS_ENGERGY => $totalProduction[RESS_ENGERGY],
        );

        $prodSelector = array();

        foreach (range(10, 0) as $percent) {
            $prodSelector[$percent] = ($percent * 10) . '%';
        }

        $this->assign(array(
            'header' => sprintf($LNG['rs_production_on_planet'], $PLANET['name']),
            'prodSelector' => $prodSelector,
            'productionList' => $productionList,
            'basicProduction' => $basicProduction,
            'totalProduction' => $totalProduction,
            'bonusProduction' => $bonusProduction,
            'dailyProduction' => $dailyProduction,
            'weeklyProduction' => $weeklyProduction,
            'storage' => $storage,
        ));

        $this->display('page.resources.default.tpl');
    }
}
