<?php

/**
 *  Quest of Galaxy
 *   by Bastian Luettig - 2021
 *
 * For the full copyright and license information, please view the LICENSE
 *
 * @package QoG
 * @author Bastian Luettig <bastian.luettig@bastie.space>
 * @copyright 2009 Lucky
 * @copyright 2016 Jan-Otto Kröpke <slaver7@gmail.com>
 * @copyright 2021 Bastian Luettig <bastian.luettig@bastie.space>
 * @licence MIT
 * @version 2.0
 * @link https://github.com/bastiedotorg/quest-of-galaxy
 */
define('MODE', 'CRON');
define('ROOT_PATH', str_replace('\\', '/',dirname(__FILE__)).'/');
define('TIMESTAMP', time());
require 'includes/constants.php';
require 'includes/GeneralFunctions.php';

set_include_path(ROOT_PATH);
require 'includes/classes/ArrayUtil.class.php';
require 'includes/classes/Cache.class.php';
require 'includes/classes/Database.class.php';
require 'includes/classes/Config.class.php';
require 'includes/classes/class.FleetFunctions.php';
require 'includes/classes/Language.class.php';
require 'includes/classes/PlayerUtil.class.php';
require 'includes/classes/Session.class.php';
require 'includes/classes/Universe.class.php';
require 'includes/classes/Cronjob.class.php';

require 'includes/classes/class.theme.php';
require 'includes/classes/class.template.php';


require 'includes/vars.php';

require 'includes/classes/class.BuildFunctions.php';
require 'includes/classes/class.PlanetRessUpdate.php';

foreach(Cronjob::getNeedTodoExecutedJobs() as $cronjobID) {
    Cronjob::execute($cronjobID);
}
print("done");
