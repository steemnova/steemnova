<form action="game.php?page=fleetStep2" method="post" onsubmit="return SubmitFleetPage1()" id="form-step1">
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="fleet_group" value="0">
    <input type="hidden" name="target_mission" value="{$mission}">
<table class="table table-striped">
    <tr>
        <td>{$LNG.fl_destiny}</td>
        <td>
            <input type="text" id="galaxy" name="galaxy" size="3" maxlength="2" onkeyup="updateVars()"
                   value="{$galaxy}">
            <input type="text" id="system" name="system" size="3" maxlength="3" onkeyup="updateVars()"
                   value="{$system}">
            <input type="text" id="planet" name="planet" size="3" maxlength="2" onkeyup="updateVars()"
                   value="{$planet}">
            <select id="type" name="type" onchange="updateVars()">
                {html_options options=$typeSelect selected=$type}
            </select>
            <a class="float-end btn btn-sm btn-primary" data-bs-target="#ownPlanetsModal" data-bs-toggle="modal">{$LNG.fl_my_planets}</a>
        </td>
    </tr>
    <tr>
        <td>{$LNG.fl_fleet_speed}</td>
        <td>
            <select id="speed" name="speed" onChange="updateVars(false)">
                {html_options options=$speedSelect}
            </select> %
        </td>
    </tr>
    <tr>
        <td>{$LNG.fl_distance}</td>
        <td><span id="distance"></span> {$LNG.ov_distance_unit}</td>
    </tr>
    <tr>
        <td>
        {$LNG.fl_flying_time}</th>
        <td id="duration">-</td>
    </tr>
    <tr>
        <td>
        {$LNG.fl_flying_arrival}</th>
        <td id="arrival">-</td>
    </tr>
    <tr>
        <td>
        {$LNG.fl_flying_return}</th>
        <td id="return">-</td>
    </tr>
    <tr>
        <td>{$LNG.fl_fuel_consumption}</td>
        <td id="consumption">-</td>
    </tr>
    <tr>
        <td>{$LNG.fl_max_speed}</td>
        <td id="maxspeed">-</td>
    </tr>
    <tr>
        <td>{$LNG.fl_cargo_capacity}</td>
        <td id="storage">-</td>
    </tr>
</table>
    <input type="submit" value="{$LNG.fl_continue}" class="btn btn-primary">

</form>

<div class="modal fade" id="ownPlanetsModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3>{$LNG.fl_my_planets}</h3>
            </div>
            <div class="modal-body">
                <ul class="list-group">

                    {foreach $colonyList as $ColonyRow}
                        <li class="list-group-item cursor-pointer" onclick="setTarget({$ColonyRow.galaxy},{$ColonyRow.system},{$ColonyRow.planet},{$ColonyRow.type});updateVars();">
                            {$ColonyRow.name}{if $ColonyRow.type == 3}{$LNG.fl_moon_shortcut}{/if}
                                [{$ColonyRow.galaxy}:{$ColonyRow.system}:{$ColonyRow.planet}]
                        </li>
                    {/foreach}
                </ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">{$LNG.window_close}</button>
            </div>
        </div>
    </div>
</div>

