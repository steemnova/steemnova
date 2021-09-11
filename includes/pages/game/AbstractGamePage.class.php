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

abstract class AbstractGamePage
{
    /**
     * reference of the template object
     * @var template
     */
    protected $tplObj;

    /**
     * reference of the template object
     * @var ResourceUpdate
     */
    protected $ecoObj;
    protected $window;
    protected $disableEcoSystem = false;
    protected $resourceTable;

    protected $user;
    protected $planet;
    protected function __construct()
    {
        global $PLANET, $USER;

        $this->user = &$USER;
        $this->planet = &$PLANET;
        $this->checkBan();
        if (!$this->disableEcoSystem) {
            $this->ecoObj = new ResourceUpdate();
            $this->ecoObj->CalcResource();
        }

        if (!AJAX_REQUEST) {
            $this->setWindow('full');
            $this->initTemplate();
        } else {
            $this->setWindow('ajax');
        }
    }

    protected function checkBan()
    {
        if ($this->user['bana'] == 1) {
            die('You received a Ban. If you think this is a mistake, contact us.');
        }
    }

    protected function initTemplate()
    {
        if (isset($this->tplObj))
            return true;

        $this->tplObj = new template;
        list($tplDir) = $this->tplObj->getTemplateDir();
        $this->tplObj->setTemplateDir($tplDir . 'game/');
        return true;
    }

    protected function setWindow($window)
    {
        $this->window = $window;
    }

    protected function getWindow()
    {
        return $this->window;
    }

    protected function getQueryString()
    {
        $queryString = array();
        $page = HTTP::_GP('page', '');

        if (!empty($page)) {
            $queryString['page'] = $page;
        }

        $mode = HTTP::_GP('mode', '');
        if (!empty($mode)) {
            $queryString['mode'] = $mode;
        }

        return http_build_query($queryString);
    }

    protected function getUserPlanets()
    {
        global $LNG;
        $PlanetSelect = array();
        if (!isset($this->user['PLANETS'])) {
            $this->user['PLANETS'] = getPlanets($this->user);
        }

        foreach ($this->user['PLANETS'] as $PlanetQuery) {
            $PlanetSelect[$PlanetQuery['id']] = $PlanetQuery['name'] . (($PlanetQuery['planet_type'] == 3) ? " (" . $LNG['fcm_moon'] . ")" : "") . " [" . $PlanetQuery['galaxy'] . ":" . $PlanetQuery['system'] . ":" . $PlanetQuery['planet'] . "]";
        }
        return $PlanetSelect;
    }

    protected function computeResourceTable()
    {
        global $reslist, $resource;
        $config = Config::get();

        $resourceTable = array();
        $resourceSpeed = $config->resource_multiplier;
        foreach ($reslist['resstype'][1] as $resourceID) {
            $resourceTable[$resourceID]['name'] = $resource[$resourceID];
            $resourceTable[$resourceID]['current'] = $this->planet[$resource[$resourceID]];
            $resourceTable[$resourceID]['max'] = $this->planet[$resource[$resourceID] . '_max'];
            if ($this->user['urlaubs_modus'] == 1 || $this->planet['planet_type'] != 1) {
                $resourceTable[$resourceID]['production'] = $this->planet[$resource[$resourceID] . '_perhour'];
            } else {
                $resourceTable[$resourceID]['production'] = $this->planet[$resource[$resourceID] . '_perhour'] + $config->{$resource[$resourceID] . '_basic_income'} * $resourceSpeed;
            }
            if ($resourceTable[$resourceID]['production'] > 0) {
                $resourceTable[$resourceID]['full_date'] = TIMESTAMP + round(($this->planet[$resource[$resourceID] . '_max'] - $this->planet[$resource[$resourceID]]) * 3600 / $resourceTable[$resourceID]['production']);
            } else {
                $resourceTable[$resourceID]['full_date'] = TIMESTAMP;
            }
        }

        foreach ($reslist['resstype'][2] as $resourceID) {
            $resourceTable[$resourceID]['name'] = $resource[$resourceID];
            $resourceTable[$resourceID]['used'] = $this->planet[$resource[$resourceID] . '_used'];
            $resourceTable[$resourceID]['max'] = $this->planet[$resource[$resourceID]];
        }

        foreach ($reslist['resstype'][3] as $resourceID) {
            $resourceTable[$resourceID]['name'] = $resource[$resourceID];
            $resourceTable[$resourceID]['current'] = $this->user[$resource[$resourceID]];
        }
        $this->resourceTable = $resourceTable;

    }

    protected function getNavigationData()
    {
        global $LNG, $THEME, $resource;

        $themeSettings = $THEME->getStyleSettings();

        $this->computeResourceTable();
        $this->assign(array(
            'PlanetSelect' => $this->getUserPlanets($this->user),
            'new_message' => $this->user['messages'],
            'messages' => ($this->user['messages'] > 0) ? (($this->user['messages'] == 1) ? $LNG['ov_have_new_message'] : sprintf($LNG['ov_have_new_messages'], pretty_number($this->user['messages']))) : false,
            'vacation' => $this->user['urlaubs_modus'] ? _date($LNG['php_tdformat'], $this->user['urlaubs_until'], $this->user['timezone']) : false,
            'delete' => $this->user['db_deaktjava'] ? sprintf($LNG['tn_delete_mode'], _date($LNG['php_tdformat'], $this->user['db_deaktjava'] + (Config::get()->del_user_manually * 86400)), $this->user['timezone']) : false,
            'darkmatter' => $this->user['darkmatter'],
            'coins' => $this->user['coins'],
            'current_pid' => $this->planet['id'],
            'image' => $this->planet['image'],
            'username' => $this->user['username'],
            'avatar' => $this->getUserAvatar(),
            'resourceTable' => $this->resourceTable,
            'shortlyNumber' => $themeSettings['TOPNAV_SHORTLY_NUMBER'],
            'closed' => !Config::get()->game_disable,
            'hasBoard' => filter_var(Config::get()->forum_url, FILTER_VALIDATE_URL),
            'hasAdminAccess' => !empty(Session::load()->adminAccess),
            'hasGate' => $this->planet[$resource[43]] > 0,
            'discordUrl' => DISCORD_URL,
            'thisPlanet' => $this->planet,
        ));
    }

    protected function getPageData()
    {
        global $THEME;

        if ($this->getWindow() === 'full') {
            $this->getNavigationData();
        }

        $dateTimeServer = new DateTime("now");
        if (isset($this->user['timezone'])) {
            try {
                $dateTimeUser = new DateTime("now", new DateTimeZone($this->user['timezone']));
            } catch (Exception $e) {
                $dateTimeUser = $dateTimeServer;
            }
        } else {
            $dateTimeUser = $dateTimeServer;
        }

        $config = Config::get();

        $this->assign(array(
            'vmode' => $this->user['urlaubs_modus'],
            'authlevel' => $this->user['authlevel'],
            'userID' => $this->user['id'],
            'hasAlly' => $this->user['ally_id'] != 0,
            'bodyclass' => $this->getWindow(),
            'game_name' => $config->game_name,
            'uni_name' => $config->uni_name,
            'ga_active' => $config->ga_active,
            'ga_key' => $config->ga_key,
            'debug' => $config->debug,
            'VERSION' => $config->VERSION,
            'date' => explode("|", date('Y\|n\|j\|G\|i\|s\|Z', TIMESTAMP)),
            'isPlayerCardActive' => isModuleAvailable(MODULE_PLAYERCARD),
            'REV' => substr($config->VERSION, -4),
            'Offset' => $dateTimeUser->getOffset() - $dateTimeServer->getOffset(),
            'queryString' => $this->getQueryString(),
            'themeSettings' => $THEME->getStyleSettings(),
            'USER' => $this->user,
            'PLANET' => $this->planet,
        ));
    }

    protected function printMessage($message, $redirectButtons = NULL, $redirect = NULL, $fullSide = true)
    {
        $this->assign(array(
            'message' => $message,
            'redirectButtons' => $redirectButtons,
        ));

        if (isset($redirect)) {
            $this->tplObj->gotoside($redirect[0], $redirect[1]);
        }

        if (!$fullSide) {
            $this->setWindow('popup');
        }

        $this->display('error.default.tpl');
    }

    protected function save()
    {
        if (isset($this->ecoObj)) {
            $this->ecoObj->SavePlanetToDB();
        }
    }

    protected function assign($array, $nocache = true)
    {
        $this->tplObj->assign_vars($array, $nocache);
    }

    protected function display($file)
    {
        global $THEME, $LNG;

        $this->save();

        if ($this->getWindow() !== 'ajax') {
            $this->getPageData();
        }

        $this->assign(array(
            'lang' => $LNG->getLanguage(),
            'dpath' => $THEME->getTheme(),
            'scripts' => $this->tplObj->jsscript,
            'execscript' => implode("\n", $this->tplObj->script),
            'basepath' => PROTOCOL . HTTP_HOST . HTTP_BASE,
        ));

        $this->assign(array(
            'LNG' => $LNG,
        ), false);

        $this->tplObj->display('extends:layout.' . $this->getWindow() . '.tpl|' . $file);
        exit;
    }

    protected function sendJSON($data)
    {
        $this->save();
        echo json_encode($data);
        exit;
    }

    protected function redirectTo($url)
    {
        $this->save();
        HTTP::redirectTo($url);
        exit;
    }

    protected function getUserAvatar()
    {
        global $USER;
        if ($USER['id'] && $USER['avatar_url']) {
            return $USER['avatar_url'];
        } else {
            return 'styles/resource/images/user.png';
        }
    }
}
