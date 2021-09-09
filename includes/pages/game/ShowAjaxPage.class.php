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
class ShowAjaxPage extends AbstractGamePage
{
    public static $requireModule = 0;

    protected $_message = '';

    function __construct()
    {
        parent::__construct();
    }


    public function show()
    {
        global $USER, $PLANET, $resource, $reslist, $LNG, $cuneros;
        $this->getNavigationData();

        $this->sendJSON([
            "resource-table" => $this->resourceTable,
        ]);
    }
}