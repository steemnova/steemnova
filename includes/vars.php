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

// VARS DB -> SCRIPT WRAPPER

$cache	= Cache::get();
$cache->add('vars', 'VarsBuildCache');
extract($cache->getData('vars'));

$resource[RESS_METAL] = 'metal';
$resource[RESS_CRYSTAL] = 'crystal';
$resource[RESS_DEUTERIUM] = 'deuterium';
$resource[RESS_ENGERGY] = 'energy';
$resource[RESS_DARKMATTER] = 'darkmatter';

$reslist['ressources']  = array(RESS_METAL, RESS_CRYSTAL, RESS_DEUTERIUM, RESS_ENGERGY, RESS_DARKMATTER);
$reslist['resstype'][1] = array(RESS_METAL, RESS_CRYSTAL, RESS_DEUTERIUM);
$reslist['resstype'][2] = array(RESS_ENGERGY);
$reslist['resstype'][3] = array(RESS_DARKMATTER);