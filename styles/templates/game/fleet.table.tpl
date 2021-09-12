<table class="table table-striped">
    <thead>
    <tr>
        <th style="width: 40%;">{$LNG.fl_ship_type}</th>
        <th style="width: 15%;">{$LNG.fl_ship_available}</th>
        <th style="width: 45%;">{$LNG.fl_ship_selection}</th>
    </tr>
    </thead>
    <tbody>
    {foreach $FleetsOnPlanet as $FleetRow}
        {if $FleetRow.speed != 0}
            <tr>
                <td>
                    <a class='tooltip'
                       data-tooltip-content="{include 'ship.information.tpl'}">{$LNG.tech.{$FleetRow.id}}</a>
                </td>
                <td id="ship{$FleetRow.id}_value">{$FleetRow.count|number}</td>
                <td>
                    <div class="input-group">
                        <a href="javascript:noShip('ship{$FleetRow.id}');"
                           class="btn btn-sm btn-secondary me-2">{$LNG.fl_none}</a>
                        <input name="ship{$FleetRow.id}" id="ship{$FleetRow.id}_input"
                               class="form-control fleet-data" data-type="{$FleetRow.id}"
                               data-attack="{$FleetRow.attack}"
                               data-shields="{$FleetRow.shield}"
                               data-count="{$FleetRow.count}"
                               onchange="computeFleetPower();"
                               autocomplete="off"
                               value="0" type="number"/>
                        <a href="javascript:maxShip('ship{$FleetRow.id}');"
                           class="btn btn-sm btn-primary ms-2">{$LNG.fl_max}</a>
                    </div>
                </td>
            </tr>
        {/if}

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