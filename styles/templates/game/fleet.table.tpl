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
                               data-count="{$FleetRow.count}"
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