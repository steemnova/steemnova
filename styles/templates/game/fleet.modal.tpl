<div class="modal fade" id="fleetTable">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <input type="hidden" id="planetId" value="0" name="planet-id"/>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>{$LNG.fl_ship_type}</th>
                        <th>{$LNG.fl_ship_available}</th>
                        <th>{$LNG.fl_ammount}</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $FleetsOnPlanet as $FleetRow}
                        <tr>
                            <td>{if $FleetRow.speed != 0}
                                    <a class='tooltip'
                                       data-tooltip-content='<table><tr><td>{$LNG.fl_speed_title}</td><td>{$FleetRow.speed}</td></tr></table>'>{$LNG.tech.{$FleetRow.id}}</a>
                                {else}
                                    {$LNG.tech.{$FleetRow.id}}
                                {/if}
                            </td>
                            <td id="ship{$FleetRow.id}_value">{$FleetRow.count|number}</td>
                            {if $FleetRow.speed != 0}
                                <td>
                                    <div class="input-group">
                                        <a href="javascript:noShip('ship{$FleetRow.id}');"
                                           class="btn btn-sm btn-secondary me-2">{$LNG.fl_none}</a>
                                        <input name="ship{$FleetRow.id}" id="ship{$FleetRow.id}_input"
                                               class="form-control fleet-data" data-type="{$FleetRow.id}"
                                               data-attack="{$FleetRow.attack}"
                                               data-shields="{$FleetRow.shield}"
                                               onchange="computeFleetPower();"
                                               autocomplete="off"
                                               value="0" type="number"/>
                                        <a href="javascript:maxShip('ship{$FleetRow.id}');"
                                           class="btn btn-sm btn-primary ms-2">{$LNG.fl_max}</a>
                                    </div>
                                </td>
                            {else}
                                <td>&nbsp;</td>
                            {/if}
                        </tr>
                    {/foreach}
                    <tr>
                        {if count($FleetsOnPlanet) == 0}
                            <td colspan="3">{$LNG.fl_no_ships}</td>
                        {else}
                            <td><a href="javascript:noShips();">{$LNG.fl_remove_all_ships}</a></td>
                            <td></td>
                            <td><a href="javascript:maxShips();">{$LNG.fl_select_all_ships}</a></td>
                        {/if}
                    </tr>
                    <tr>
                        <td>Total</td>
                        <td>{$LNG.cr_weapons}</td>
                        <td><span id="totalAttack">0</span></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>{$LNG.cr_shields}</td>
                        <td><span id="totalShields">0</span></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <a class="btn btn-secondary" data-bs-dismiss="modal">{$LNG.btn_abort}</a>
                <a class="btn btn-primary" href="" id="fleetTableView">{$LNG.galaxy_classic_fleets}</a>
                <a class='list-group-item list-group-item-danger' onclick="send_attack_fleet();" href="#"
                   title='{$LNG['type_mission_1']}'><i class='fas fa-horse'></i> {$LNG['type_mission_1']}</a>
            </div>
        </div>
    </div>
</div>
<script src="scripts/game/fleet.modal.js?2"></script>