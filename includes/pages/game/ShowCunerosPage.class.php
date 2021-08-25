<?php

/**
 *  Quest of Galaxy
 *   by Bastian Lüttig 2021
 *
 * For the full copyright and license information, please view the LICENSE
 *
 * @package 2Quest of Galaxy
 * @author Bastian Lüttig <bastian.luettig@bastie.space>
 * @copyright 2009 Lucky
 * @copyright Bastian Lüttig <bastian.luettig@bastie.space>
 * @licence MIT
 * @version 1.8.0
 * @link https://github.com/jkroepke/2Moons
 */
require 'includes/libs/cuneros/cuneros_api.class.inc.php';
require 'includes/config.php';
class ShowCunerosPage extends AbstractGamePage
{
    public static $requireModule = 0;

    function __construct()
    {
        parent::__construct();
    }

    public function UpdateDarkMatter()
    {
        global $PLANET, $USER, $resource, $cuneros, $LNG;

        $api = new \Access($_POST['password'], $_POST['username'], $cuneros['api_key'], $cuneros['project_id']);
        $api->get($_POST['amount'], $cuneros['payin_subject']);
        if($api->get_status()) {
            $USER[$resource[921]]	+= intval($_POST['amount'])*$cuneros['factor'];
            $this->assign(['return_message'=> $LNG['cuneros_payin_successful']] );
        } else {
            $this->assign(['return_message'=> sprintf($LNG['cuneros_payin_unsuccessful'], $api->get_error_message())] );
        }
    }

    public function show()
    {
        global $USER, $PLANET, $resource, $reslist, $LNG, $cuneros;

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (isModuleAvailable(MODULE_CUNEROS)) {
                $this->UpdateDarkMatter();
            }
        }

        if (isModuleAvailable(MODULE_CUNEROS)) {

            $this->assign(array(
                'project_id' => $cuneros['project_id'],
                'info_data'=> sprintf($LNG['cun_info'], $cuneros['factor']),
        ));

            $this->display('page.cuneros.default.tpl');
        }
    }
}