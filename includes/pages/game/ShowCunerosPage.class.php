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

    protected $_message = '';

    function __construct()
    {
        parent::__construct();
    }

    public function UpdateDarkMatter()
    {
    }

    public function payin()
    {
        global $PLANET, $USER, $resource, $cuneros, $LNG;
        $config = Config::get();
        $pot_factor = $config->coinpot_increase / 100;
        if ($_POST['amount'] < 0) exit;
        $api = new \Access($_POST['password'], $USER['coins_username'], $cuneros['api_key'], $cuneros['project_id']);
        $api->get($_POST['amount'], $cuneros['payin_subject']);
        if ($api->get_status()) {
            $USER[$resource[921]] += intval($_POST['amount']) * $cuneros['factor'];
            $this->_message = $LNG['cuneros_payin_successful'];

            $sql = 'UPDATE %%COINPOT%% SET amount = amount + :addAmount WHERE is_active=1 LIMIT 1';
            Database::get()->update($sql, [':addAmount' => intval($_POST['amount'] * $pot_factor)]);


        } else {
            $this->_message = sprintf($LNG['cuneros_payin_unsuccessful'], $api->get_error_message());
        }
        $this->show();
    }

    public function payout()
    {
        global $PLANET, $USER, $resource, $cuneros, $LNG;
        $this->checkAmount(1000);

        $USER['coins'] -= $_POST['amount'];
        $api = new \Access($_POST['password'], $USER['coins_username'], $cuneros['api_key'], $cuneros['project_id']);
        $api->send($_POST['amount'], $cuneros['payout_subject']);
        if ($api->get_status()) {
            $this->_message = $LNG['cuneros_payout_successful'];
        } else {
            $this->_message = sprintf($LNG['cuneros_payout_unsuccessful'], $api->get_error_message());
        }
        $this->show();
    }

    protected function checkAmount($min = 0)
    {
        global $LNG, $USER;
        if ($_POST['amount'] < $min) $this->_message = $LNG['cuneros_invalid'];
        elseif ($_POST['amount'] > $USER['coins']) $this->_message = $LNG['cuneros_unsufficient'];
        else return true;

        $this->show();
    }

    public function exchange()
    {
        global $PLANET, $USER, $resource, $cuneros, $LNG;
        $this->checkAmount();

        $USER[$resource[RESS_DARKMATTER]] += intval($_POST['amount']) * $cuneros['factor'];
        $USER['coins'] -= $_POST['amount'];
        $this->show();
    }

    public function validate()
    {
        global $cuneros, $USER, $LNG, $resource;
        $api = new \Access($_POST['password'], $_POST['username'], $cuneros['api_key'], $cuneros['project_id']);
        $data = $api->info();
        if ($api->get_status()) {
            $sql = "UPDATE %%USERS%% SET `coins_username` = ':coinsUsername', `avatar_url` = ':avatarUrl' WHERE id=:userId";
            Database::get()->update($sql, [":coinsUsername" => $_POST['username'], ":avatarUrl" => $data->transaction_data->avatar, ":userId" => $USER['id']]);
            $this->_message = $LNG['cuneros_validation_successful'];
            if(empty($USER['coins_username'])) {
                $USER[$resource[RESS_DARKMATTER]] += 1000;
            }
            $USER['coins_username'] = $_POST['username'];
        } else {
            $this->_message = sprintf($LNG['cuneros_validation_unsuccessful'], $api->get_error_message());
        }

        $this->show();
    }

    public function show()
    {
        global $USER, $PLANET, $resource, $reslist, $LNG, $cuneros;

        if (isModuleAvailable(MODULE_CUNEROS)) {

            $this->assign(array(
                'project_id' => $cuneros['project_id'],
                'info_data' => sprintf($LNG['cun_info'], $cuneros['factor']),
                'return_message' => $this->_message,
                'user_coins' => floor($USER['coins']),
                'user_name' => $USER['coins_username'],
            ));

            $this->display('page.cuneros.default.tpl');
        }
    }
}