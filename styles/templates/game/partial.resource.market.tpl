<h4>{$LNG.market_current}</h4>

<table id="tradeList" class="tablesorter table table-striped">
    <thead>
    <tr>
        <th>ID</th>
        <th>{$LNG['gl_player']}</th>
        <th>{$LNG['tech'][901]}</th>
        <th>{$LNG['tech'][902]}</th>
        <th>{$LNG['tech'][903]}</th>
        <th>{$LNG.market_p_total}</th>
        <th>{$LNG.market_p_ratio}</th>
        <th>{$LNG.market_p_end}</th>
        <th class="no-background no-border center">-></th>
        <th>{$LNG.market_p_cost_type}</th>
        <th>{$LNG.market_p_cost_amount}</th>
        <th>{$LNG.market_p_from_duration}</th>
        <th class="LC" style="display: none;">{$LNG.market_p_to_duration}</th>
        <th class="HC">{$LNG.market_p_to_duration}</th>
        <th>{$LNG.market_p_buy}</th>
    </tr>
    </thead>
    <tbody>

    {foreach name=FlyingFleets item=FlyingFleetRow from=$FlyingFleetList}
        {if $FlyingFleetRow.type == 0}
            <tr class='{if {$FlyingFleetRow.diplo} == 5}
	 trade-enemy
		{elseif ({$FlyingFleetRow.diplo} != NULL && {$FlyingFleetRow.diplo} <= 3) || {$FlyingFleetRow.from_alliance} == 1}
		 trade-ally
		  {/if}
	{if $FlyingFleetRow.possible_to_buy != true} trade-disallowed {/if}'>
                <td>{$smarty.foreach.FlyingFleets.iteration}</td>
                <td class="table_username">{$FlyingFleetRow.username}</td>
                <td class="resource_metal">{$FlyingFleetRow.fleet_resource_metal|number}</td>
                <td class="resource_crystal">{$FlyingFleetRow.fleet_resource_crystal|number}</td>
                <td class="resource_deuterium">{$FlyingFleetRow.fleet_resource_deuterium|number}</td>
                <td class="total_value"></td>
                <td class="ratio"></td>
                <td data-time="{$FlyingFleetRow.end}">{pretty_fly_time({$FlyingFleetRow.end})}</td>
                <td class="no-background no-border">
                    {if $FlyingFleetRow.fleet_wanted_resource_id == 1}
                        <img src="./styles/theme/qog/images/metal.gif"/>
                    {elseif $FlyingFleetRow.fleet_wanted_resource_id == 2}
                        <img src="./styles/theme/qog/images/crystal.gif"/>
                    {elseif $FlyingFleetRow.fleet_wanted_resource_id == 3}
                        <img src="./styles/theme/qog/images/deuterium.gif"/>
                    {/if}
                </td>
                <td class="wanted-resource-{$FlyingFleetRow.fleet_wanted_resource_id}">{$FlyingFleetRow.fleet_wanted_resource}</td>
                <td class="wanted-resource-amount">{$FlyingFleetRow.fleet_wanted_resource_amount|number}</td>
                <td>{pretty_fly_time({$FlyingFleetRow.from_duration})}</td>
                <td class="LC" style="display: none;">{pretty_fly_time({$FlyingFleetRow.to_lc_duration})}</td>
                <td class="HC">{pretty_fly_time({$FlyingFleetRow.to_hc_duration})}</td>
                <td>
                    {if $FlyingFleetRow.possible_to_buy == true}
                        <form class="market_form" action="game.php?page=marketPlace&amp;action=buy" method="post">
                            <input name="fleetID" value="{$FlyingFleetRow.id}" type="hidden">
                            <input value="{$LNG.market_p_submit}" type="submit" class="btn btn-sm btn-primary">
                        </form>
                    {else}
                        {$FlyingFleetRow.reason}
                    {/if}
                </td>
            </tr>
        {/if}
    {/foreach}
    </tbody>
</table>
<hr>

<h4>{$LNG.market_history}</h4>
<table id="resourceHistoryList" class="tablesorter table table-striped">
    <thead>
    <tr>
        <th>ID</th>
        <th>{$LNG.tkb_datum}</th>
        <th>{$LNG['tech'][901]}</th>
        <th>{$LNG['tech'][902]}</th>
        <th>{$LNG['tech'][903]}</th>
        <th class="no-background no-border center">-></th>
        <th>{$LNG.market_p_cost_amount}</th>
    </tr>
    </thead>
    <tbody>
    {foreach name=History item=row from=$resourceHistory}
        <tr>
            <td>{$smarty.foreach.History.iteration}</td>
            <td>{$row.time}</td>
            <td>{$row.metal}</td>
            <td>{$row.crystal}</td>
            <td>{$row.deuterium}</td>
            <td class="no-background no-border center">
                {if $row.res_type == 1}
                    <img src="./styles/theme/qog/images/metal.gif"/>
                {elseif $row.res_type == 2}
                    <img src="./styles/theme/qog/images/crystal.gif"/>
                {elseif $row.res_type == 3}
                    <img src="./styles/theme/qog/images/deuterium.gif"/>
                {/if}</td>
            <td>{$row.amount}</td>
        </tr>
    {/foreach}
    </tbody>
</table>