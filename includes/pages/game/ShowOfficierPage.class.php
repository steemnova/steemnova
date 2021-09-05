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


class ShowOfficierPage extends AbstractGamePage
{
	public static $requireModule = 0;
    protected ?string $error = null;

	function __construct() 
	{
		parent::__construct();
	}
	
	public function UpdateExtra($Element)
	{
		global $PLANET, $USER, $resource, $pricelist;
		
		$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
			
		if (!BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources)) {
			return;
		}
			
		$USER[$resource[$Element]]	= max($USER[$resource[$Element]], TIMESTAMP) + $pricelist[$Element]['time'];

        $this->deductCost($costResources);
        $this->storeUpdate($Element);
	}

	protected function storeUpdate($Element) {
	    global $USER, $resource;
        $sql	= 'UPDATE %%USERS%% SET
				'.$resource[$Element].' = :newTime
				WHERE
				id = :userId;';

        Database::get()->update($sql, array(
            ':newTime'	=> $USER[$resource[$Element]],
            ':userId'	=> $USER['id']
        ));

    }

	protected function deductCost($costResources) {
	    global $PLANET, $USER, $resource;
        if(isset($costResources[RESS_METAL])) { $PLANET[$resource[RESS_METAL]]	-= $costResources[RESS_METAL]; }
        if(isset($costResources[RESS_CRYSTAL])) { $PLANET[$resource[RESS_CRYSTAL]]	-= $costResources[RESS_CRYSTAL]; }
        if(isset($costResources[RESS_DEUTERIUM])) { $PLANET[$resource[RESS_DEUTERIUM]]	-= $costResources[RESS_DEUTERIUM]; }
        if(isset($costResources[RESS_DARKMATTER])) { $USER[$resource[RESS_DARKMATTER]]		-= $costResources[RESS_DARKMATTER]; }

    }

	public function UpdateOfficer($Element)
	{
		global $USER, $PLANET, $resource, $pricelist, $LNG;
		
		$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
			
		if (!BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element) 
			|| !BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources) 
			|| $pricelist[$Element]['max'] <= $USER[$resource[$Element]]) {
            $this->error = $LNG['officer_not_bought'];
			return;
		}
		
		$USER[$resource[$Element]]	+= 1;
        $this->deductCost($costResources);

        $this->storeUpdate($Element);
        $this->error = null;
    }
	
	public function show()
	{
		global $USER, $PLANET, $resource, $reslist, $LNG, $pricelist;
		
		$updateID	  = HTTP::_GP('id', 0);

		if (!empty($updateID) && $_SERVER['REQUEST_METHOD'] === 'POST' && $USER['urlaubs_modus'] == 0)
		{
			if(isModuleAvailable(MODULE_OFFICIER) && in_array($updateID, $reslist['officier'])) {
				$this->UpdateOfficer($updateID);
			} elseif(isModuleAvailable(MODULE_DMEXTRAS) && in_array($updateID, $reslist['dmfunc'])) {
				$this->UpdateExtra($updateID);
			}

            if(HTTP::_GP("ajax", 0) == 1) {
                if($this->error) {
                    $this->sendJSON(["error" => true, "message" => $this->error]);
                } else {
                    $this->sendJSON(["error" => false, "message" => $LNG['officer_bought']]);
                }
            }
		}
		
		$darkmatterList	= array();
		$officierList	= array();
		
		if(isModuleAvailable(MODULE_DMEXTRAS))
		{
			foreach($reslist['dmfunc'] as $Element)
			{
				if($USER[$resource[$Element]] > TIMESTAMP) {
					$this->tplObj->execscript("GetOfficerTime(".$Element.", ".($USER[$resource[$Element]] - TIMESTAMP).");");
				}
			
				$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
				$buyable			= BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources);
				$costOverflow		= BuildFunctions::getRestPrice($USER, $PLANET, $Element, $costResources);
				$elementBonus		= BuildFunctions::getAvalibleBonus($Element);

				$darkmatterList[$Element]	= array(
					'timeLeft'			=> max($USER[$resource[$Element]] - TIMESTAMP, 0),
					'costResources'		=> $costResources,
					'buyable'			=> $buyable,
					'time'				=> $pricelist[$Element]['time'],
					'costOverflow'		=> $costOverflow,
					'elementBonus'		=> $elementBonus,
				);
			}
		}
		
		if(isModuleAvailable(MODULE_OFFICIER))
		{
			foreach($reslist['officier'] as $Element)
			{
				if (!BuildFunctions::isTechnologieAccessible($USER, $PLANET, $Element))
					continue;
					
				$costResources		= BuildFunctions::getElementPrice($USER, $PLANET, $Element);
				$buyable			= $USER[$resource[$Element]] < $pricelist[$Element]['max'] && BuildFunctions::isElementBuyable($USER, $PLANET, $Element, $costResources);
				$costOverflow		= BuildFunctions::getRestPrice($USER, $PLANET, $Element, $costResources);
				$elementBonus		= BuildFunctions::getAvalibleBonus($Element);
				
				$officierList[$Element]	= array(
					'level'				=> $USER[$resource[$Element]],
					'maxLevel'			=> $pricelist[$Element]['max'],
					'costResources'		=> $costResources,
					'buyable'			=> $buyable,
					'costOverflow'		=> $costOverflow,
					'elementBonus'		=> $elementBonus,
				);
			}
		}
		
		$this->assign(array(
			'officierList'		=> $officierList,
			'darkmatterList'	=> $darkmatterList,
			'of_dm_trade'		=> sprintf($LNG['of_dm_trade'], $LNG['tech'][921]),
		));
		
		$this->display('page.officier.default.tpl');
	}
}