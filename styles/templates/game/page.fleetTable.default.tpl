{block name="title" prepend}{$LNG.lm_fleet}{/block}
{block name="content"}
<div class="col mb-2">
    <div class="card">
        <div class="card-header">
            <h2 class="float-end card-title">
                {$activeExpedition} / {$maxExpedition} {$LNG.fl_expeditions}
            </h2>
            <h2 class="card-title">
                {$LNG.fl_fleets} {$activeFleetSlots} / {$maxFleetSlots}
            </h2>
        </div>
        <div class="card-body">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>{$LNG.fl_number}</th>
                    <th>{$LNG.fl_mission}</th>
                    <th>{$LNG.fl_ammount}</th>
                    <th>{$LNG.fl_beginning}</th>
                    <th>{$LNG.fl_departure}</th>
                    <th>{$LNG.fl_destiny}</th>
                    <th>{$LNG.fl_arrival}</th>
                    <th>{$LNG.fl_objective}</th>
                    <th>{$LNG.fl_order}</th>
                </tr>
                </thead>
                <tbody>
                {foreach name=FlyingFleets item=FlyingFleetRow from=$FlyingFleetList}
                    <tr>
                        <td>{$smarty.foreach.FlyingFleets.iteration}</td>
                        <td>
                            {if $FlyingFleetRow.state == 0}
                                <i class="fas fa-arrow-right" title="{$LNG.fl_onway}"></i>
                                {else}
                                <i class="fas fa-arrow-left" title="{$LNG.fl_returning}"></i>
                            {/if}
                            <a data-tooltip-content="{include "fleet.resources.tpl"}"
                               class="tooltip">
                                {$LNG["type_mission_{$FlyingFleetRow.mission}"]}
                            </a>
                        </td>
                        <td><a class="tooltip_sticky"
                               data-tooltip-content="{include "fleet.info.tpl"}">{$FlyingFleetRow.amount}</a>
                        </td>
                        <td>
                            <a href="game.php?page=galaxy&amp;galaxy={$FlyingFleetRow.startGalaxy}&amp;system={$FlyingFleetRow.startSystem}">[{$FlyingFleetRow.startGalaxy}
                                :{$FlyingFleetRow.startSystem}:{$FlyingFleetRow.startPlanet}]</a></td>
                        <td{if $FlyingFleetRow.state == 0} style="color:darkgreen"{/if}>{$FlyingFleetRow.startTime}</td>
                        <td>
                            <a href="game.php?page=galaxy&amp;galaxy={$FlyingFleetRow.endGalaxy}&amp;system={$FlyingFleetRow.endSystem}">[{$FlyingFleetRow.endGalaxy}
                                :{$FlyingFleetRow.endSystem}:{$FlyingFleetRow.endPlanet}]</a></td>
                        {if $FlyingFleetRow.mission == 4 && $FlyingFleetRow.state == 0}
                            <td>-</td>
                        {else}
                            <td{if $FlyingFleetRow.state != 0} style="color:darkgreen"{/if}>{$FlyingFleetRow.endTime}</td>
                        {/if}
                        <td id="fleettime_{$smarty.foreach.FlyingFleets.iteration}" class="fleets"
                            data-fleet-end-time="{$FlyingFleetRow.returntime}"
                            data-fleet-time="{$FlyingFleetRow.resttime}">{pretty_fly_time({$FlyingFleetRow.resttime})}</td>
                        <td>
                            {if !$isVacation && $FlyingFleetRow.state != 1 && $FlyingFleetRow.no_returnable != 1}
                                <form action="game.php?page=fleetTable&amp;action=sendfleetback" method="post">
                                    <input name="fleetID" value="{$FlyingFleetRow.id}" type="hidden">
                                    <input value="{$LNG.fl_send_back}" type="submit" class="btn btn-sm btn-danger">
                                </form>
                                {if $FlyingFleetRow.mission == 1}
                                    <form action="game.php?page=fleetTable&amp;action=acs" method="post">
                                        <input name="fleetID" value="{$FlyingFleetRow.id}" type="hidden">
                                        <input value="{$LNG.fl_acs}" type="submit" class="btn btn-sm btn-primary">
                                    </form>
                                {/if}
                            {else}
                                &nbsp;-&nbsp;
                            {/if}
                        </td>
                    </tr>
                    {foreachelse}
                    <tr>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                    </tr>
                {/foreach}
                </tbody>
                {if $maxFleetSlots == $activeFleetSlots}
                    <tr>
                        <td colspan="9">{$LNG.fl_no_more_slots}</td>
                    </tr>
                {/if}
            </table>
            {if !empty($acsData)}
                {include file="shared.fleetTable.acsTable.tpl"}
            {/if}
        </div>
    </div>
</div>

<div class="row row-cols-1 row-cols-md-2 g-4">

    <div class="col">
        <div class="card">
            <form action="?page=fleetStep1" method="post">
                <input type="hidden" name="galaxy" value="{$targetGalaxy}">
                <input type="hidden" name="system" value="{$targetSystem}">
                <input type="hidden" name="planet" value="{$targetPlanet}">
                <input type="hidden" name="type" value="{$targetType}">
                <input type="hidden" name="target_mission" value="{$targetMission}">

                <div class="card-header">
                    <h2 class="card-title">
                        {$LNG.fl_new_mission_title}
                    </h2>
                </div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>{$LNG.fl_ship_type}</th>
                            <th>{$LNG.fl_ship_available}</th>
                            <th>-</th>
                            <th>-</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $FleetsOnPlanet as $FleetRow}
                            <tr>
                                <td>{if $FleetRow.speed != 0} <a class='tooltip'
                                                                 data-tooltip-content='<table><tr><td>{$LNG.fl_speed_title}</td><td>{$FleetRow.speed}</td></tr></table>'>{$LNG.tech.{$FleetRow.id}}</a>{else}{$LNG.tech.{$FleetRow.id}}{/if}
                                </td>
                                <td id="ship{$FleetRow.id}_value">{$FleetRow.count|number}</td>
                                {if $FleetRow.speed != 0}
                                    <td><a href="javascript:maxShip('ship{$FleetRow.id}');">{$LNG.fl_max}</a></td>
                                    <td><input name="ship{$FleetRow.id}" id="ship{$FleetRow.id}_input" size="10"
                                               value="0"></td>
                                {else}
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                {/if}
                            </tr>
                        {/foreach}
                        <tr>
                            {if count($FleetsOnPlanet) == 0}
                                <td colspan="4">{$LNG.fl_no_ships}</td>
                            {else}
                                <td colspan="2"><a href="javascript:noShips();">{$LNG.fl_remove_all_ships}</a></td>
                                <td colspan="2"><a href="javascript:maxShips();">{$LNG.fl_select_all_ships}</a></td>
                            {/if}
                        </tr>
                        </tbody>
                    </table>
                </div>
                {if $maxFleetSlots != $activeFleetSlots && count($FleetsOnPlanet) > 0}
                    <div class="card-footer">
                        <input class="btn btn-primary" type="submit" value="{$LNG.fl_continue}">
                    </div>
                {/if}
            </form>
        </div>
    </div>
    <div class="col">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">{$LNG.fl_bonus}</h2>
            </div>
            <div class="card-body">
                <table class="table table-striped text-center">
                    <tr>
                        <th style="width:33%">{$LNG.fl_bonus_attack}</th>
                        <th style="width:33%">{$LNG.fl_bonus_defensive}</th>
                        <th style="width:33%">{$LNG.fl_bonus_shield}</th>
                    </tr>
                    <tr>
                        <td>+{$bonusAttack} %</td>
                        <td>+{$bonusDefensive} %</td>
                        <td>+{$bonusShield} %</td>
                    </tr>
                    <tr>
                        <th style="width:33%">{$LNG.tech.115}</th>
                        <th style="width:33%">{$LNG.tech.117}</th>
                        <th style="width:33%">{$LNG.tech.118}</th>
                    </tr>
                    <tr>
                        <td>+{$bonusCombustion} %</td>
                        <td>+{$bonusImpulse} %</td>
                        <td>+{$bonusHyperspace} %</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    {/block}
    {block name="script" append}
        <script src="scripts/game/fleetTable.js"></script>
    {/block}
