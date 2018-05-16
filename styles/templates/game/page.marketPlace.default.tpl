{block name="title" prepend}{$LNG.lm_marketplace}{/block}
{block name="content"}

<table style="width:50%">
	<tr>
		<th colspan="2">
			{$LNG.market_info_header}
		</th>
	</tr>
	<tr>
		<td>
			<button id="resourceMBtn" class="marketOption selected">Resource market</button>
		</td>
		<td>
			<button id="fleetMBtn" class="marketOption">Fleet market</button>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<p>
				{$LNG.market_info_description}
			</p>
		</td>
	</tr>

	<tr>
		<td>
			{$LNG.market_ship_as_first}
		</td>
		<td>
			<select id="shipT">
				<option value="1">{$LNG.shortNames[202]}</option>
				<option value="2" selected>{$LNG.shortNames[203]}</option>
			</select>
		</td>
	</tr>
</table>

<table style="width:50%">
	<tr class="ratio">
		<td>Reference ratio:</td>
		<td>
			<input type="number" name="ratio-metal" value="4" style="width: 30%"/>:<input type="number" name="ratio-cristal" value="2" style="width: 30%"/>:<input type="number"name="ratio-deuterium" value="1" style="width: 30%"/>
		</td>
	</tr>
</table>

{if $message}
<table style="width:50%">
	<tr>
		<th>
			{$LNG.fcm_info}
		</th>
	</tr>
	<tr>
		<td>
			{$message}
		</td>
	</tr>
</table>
{/if}

<hr/>

<div id="resourceMarketBox" style="display:none">
<table id="myTradeList" style="width:50%;white-space: nowrap;" class="tablesorter">
	<thead>
		<tr>
		<th colspan="10">
			<div class="transparent" style="text-align:left;float:left;"> {count($offers)} / {$limit}</div>
		</th>
		</tr>
		<tr>
			<th>ID</th>
			<th>Location</th>
			<th>{$LNG['tech'][901]}</th>
			<th>{$LNG['tech'][902]}</th>
			<th>{$LNG['tech'][903]}</th>
			<th  class="no-background no-border center">-></th>
			<th>{$LNG.market_p_cost_type}</th>
			<th>{$LNG.market_p_cost_amount}</th>
			<th>{$LNG.market_p_visibility}</th>
			<th>{$LNG.market_p_remove}</th>
		</tr>
	</thead>

	{foreach name=Offers item=offer from=$offers}
	{if $offer.transaction_type == 0}
	<tr>
		<td><a class="tooltip" data-tooltip-content="<table width='100%'><tr><th colspan='2' style='text-align:center;'>{$LNG.fl_info_detail}</th></tr>{foreach $offer.fleet as $shipID => $shipCount}<tr><td class='transparent'>{$LNG.tech.{$shipID}}:</td><td class='transparent'>{$shipCount}</td></tr>{/foreach}</table>">{$offer.trade_id}</a></td>
		<td>{$offer.galaxy}:{$offer.system}:{$offer.planet}</td>
		<td>{$offer.resource_metal}</td>
		<td>{$offer.resource_crystal}</td>
		<td>{$offer.resource_deuterium}</td>
		<td class="no-background no-border">
			{if $offer.ex_resource_type == 1}
			<img src="./styles/theme/nova/images/metal.gif"/>
			{elseif $offer.ex_resource_type == 2}
			<img src="./styles/theme/nova/images/crystal.gif"/>
			{elseif $offer.ex_resource_type == 3}
			<img src="./styles/theme/nova/images/deuterium.gif"/>
			{/if}
		</td>
		<td class="wanted-resource-{$offer.ex_resource_type}">{$offer.ex_resource_name }</td>
		<td>{$offer.ex_resource_amount}</td>
		<td>
			{if $offer.filter_visibility == 1}
			{$LNG.fl_visibility_alliance}
			{elseif $offer.filter_visibility == 2}
			{$LNG.fl_visibility_no_enemies}
			{elseif $offer.filter_visibility == 0}
			{$LNG.fl_visibility_all}
			{/if}
		</td>
		<td><form class="market_form" action="game.php?page=marketPlace&amp;action=removeoffer#resourcemarket" method="post">
			<input name="trade_id" value="{$offer.trade_id}" type="hidden">
			<input value="{$LNG.market_p_remove}" type="submit">
		</form></td>
	</tr>
	{/if}
	{/foreach}
	<tr><td colspan="10"><a id="addResourceOfferButton" href="#addResourceOffer">Add offer</a></td></tr>
</table>


<div style="display:none"><div id="addResourceOffer" style="background-color: black;">
	<form class="market_form" action="game.php?page=marketPlace&amp;action=add#resourcemarket" method="post">
		<table>
			<tr class="no-border">
				<td>
					{$LNG.tech.901}
				</td>
				<td>
					<input name="metal" size="10" type="number">
				</td>
			</tr>

			<tr class="no-border">
				<td>
					{$LNG.tech.902}
				</td>
				<td>
					<input name="crystal" size="10" type="number">
				</td>
			</tr>

			<tr class="no-border">
				<td>
					{$LNG.tech.903}
				</td>
				<td>
					<input name="deuterium" size="10" type="number">
				</td>
			</tr>

			<tr class="no-border">
				<td>
					<select name="ship">
						{foreach $FleetsOnPlanet as $ship}
						<option value="{$ship}">{$LNG.tech.$ship}</option>
						{/foreach}
					</select>
				</td>
				<td>
					<input name="fleet_size" size="10" type="number">
				</td>
			</tr>

			<tr><td colspan="2">Price</td></tr>

			<tr class="no-border">
				<td>
					<select name="resEx">
						<option value="1">{$LNG.tech.901}</option>
						<option value="2">{$LNG.tech.902}</option>
						<option value="3">{$LNG.tech.903}</option>
					</select>
				</td>
				<td>
					<input name="exchange" size="10" type="number">
				</td>
			</tr>

			<tr><td colspan="2">Filters</td></tr>

			<tr class="no-border">
				<td>
					{$LNG.fl_visibility}
				</td>
				<td>
					<select name="visibility">
						<option value="2" selected>{$LNG.fl_visibility_no_enemies}</option>
						<option value="1">{$LNG.fl_visibility_alliance}</option>
						<option value="0">{$LNG.fl_visibility_all}</option>
					</select>
				</td>
			</tr>
		</table><br/>
		<input type="hidden" name="markettype" value="0"/>
		<input value="Add" type="submit">
	</form>
</div></div>

<hr/>

<table id="tradeList" style="width:50%;white-space: nowrap;" class="tablesorter">
	<thead>
		<tr class="no-background no-border center">
			<td></th>
			<th></th>
			<th><img src="./styles/theme/nova/images/metal.gif"/></th>
			<th><img src="./styles/theme/nova/images/crystal.gif"/></th>
			<th><img src="./styles/theme/nova/images/deuterium.gif"/></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th class="LC" style="display: none;"></th>
			<th class="HC"></th>
			<th></th>
		</tr>
		<tr>
			<th>ID</th>
			<th>{$LNG['gl_player']}</th>
			<th>{$LNG['tech'][901]}</th>
			<th>{$LNG['tech'][902]}</th>
			<th>{$LNG['tech'][903]}</th>
			<th>{$LNG.market_p_total}</th>
			<th>{$LNG.market_p_ratio}</th>
			<th  class="no-background no-border center">-></th>
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
		<td class="no-background no-border">
			{if $FlyingFleetRow.fleet_wanted_resource_id == 1}
			<img src="./styles/theme/nova/images/metal.gif"/>
			{elseif $FlyingFleetRow.fleet_wanted_resource_id == 2}
			<img src="./styles/theme/nova/images/crystal.gif"/>
			{elseif $FlyingFleetRow.fleet_wanted_resource_id == 3}
			<img src="./styles/theme/nova/images/deuterium.gif"/>
			{/if}
		</td>
		<td class="wanted-resource-{$FlyingFleetRow.fleet_wanted_resource_id}">{$FlyingFleetRow.fleet_wanted_resource}</td>
		<td class="wanted-resource-amount">{$FlyingFleetRow.fleet_wanted_resource_amount|number}</td>
		<td>{pretty_fly_time({$FlyingFleetRow.from_duration})}</td>
		<td class="LC" style="display: none;">{pretty_fly_time({$FlyingFleetRow.to_lc_duration})}</td>
		<td class="HC">{pretty_fly_time({$FlyingFleetRow.to_hc_duration})}</td>
		<td>
			{if $FlyingFleetRow.possible_to_buy == true}
			<form class="market_form" action="game.php?page=marketPlace&amp;action=buy#resourcemarket" method="post">
				<input name="tradeID" value="{$FlyingFleetRow.id}" type="hidden">
				<input value="{$LNG.market_p_submit}" type="submit">
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

<table id="resourceHistoryList" style="width:50%;white-space: nowrap;" class="tablesorter">
	<thead>
		<tr>
			<th>ID</th>
			<th>{$LNG.tkb_datum}</th>
			<th>{$LNG['tech'][901]}</th>
			<th>{$LNG['tech'][902]}</th>
			<th>{$LNG['tech'][903]}</th>
			<th  class="no-background no-border center">-></th>
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
				{if $row.res_type == 1}<img src="./styles/theme/nova/images/metal.gif"/>
				{elseif $row.res_type == 2}<img src="./styles/theme/nova/images/crystal.gif"/>
				{elseif $row.res_type == 3}<img src="./styles/theme/nova/images/deuterium.gif"/>{/if}</td>
			<td>{$row.amount}</td>
		</tr>
		{/foreach}
	</tbody>
</table>

</div>

<div id="fleetMarketBox"  style="display:none">
	<table id="myTradeList" style="width:50%;white-space: nowrap;" class="tablesorter">
		<thead>
			<tr><th colspan="10">
				<div class="transparent" style="text-align:left;float:left;"> {count($offers)} / {$limit}</div>
			</th></tr>
			<tr>
				<th>ID</th>
				<th>Location</th>
				<th>{$LNG['tech'][901]}</th>
				<th  class="no-background no-border center">-></th>
				<th>{$LNG.market_p_cost_type}</th>
				<th>{$LNG.market_p_cost_amount}</th>
				<th>{$LNG.market_p_visibility}</th>
				<th>{$LNG.market_p_remove}</th>
			</tr>
		</thead>

		{foreach name=Offers item=offer from=$offers}
		{if $offer.transaction_type == 1}
		<tr>
			<td><a class="tooltip" data-tooltip-content="<table width='100%'><tr><th colspan='2' style='text-align:center;'>{$LNG.fl_info_detail}</th></tr>{foreach $offer.fleet as $shipID => $shipCount}<tr><td class='transparent'>{$LNG.tech.{$shipID}}:</td><td class='transparent'>{$shipCount}</td></tr>{/foreach}</table>">{$offer.trade_id}</a></td>
			<td>{$offer.galaxy}:{$offer.system}:{$offer.planet}</td>
			<td>{foreach $offer.fleet as $shipID => $shipCount} {$LNG.tech.{$shipID}} x {$shipCount}<br/>{/foreach}</td>
			<td class="no-background no-border">
				{if $offer.ex_resource_type == 1}
				<img src="./styles/theme/nova/images/metal.gif"/>
				{elseif $offer.ex_resource_type == 2}
				<img src="./styles/theme/nova/images/crystal.gif"/>
				{elseif $offer.ex_resource_type == 3}
				<img src="./styles/theme/nova/images/deuterium.gif"/>
				{/if}
			</td>
			<td class="wanted-resource-{$offer.ex_resource_type}">{$offer.ex_resource_name }</td>
			<td>{$offer.ex_resource_amount}</td>
			<td>
				{if $offer.filter_visibility == 1}
				{$LNG.fl_visibility_alliance}
				{elseif $offer.filter_visibility == 2}
				{$LNG.fl_visibility_no_enemies}
				{elseif $offer.filter_visibility == 0}
				{$LNG.fl_visibility_all}
				{/if}
			</td>
			<td><form class="market_form" action="game.php?page=marketPlace&amp;action=removeoffer#fleetmarket" method="post">
				<input name="trade_id" value="{$offer.trade_id}" type="hidden">
				<input value="{$LNG.market_p_remove}" type="submit">
			</form></td>
		</tr>
		{/if}
		{/foreach}
		<tr><td colspan="10"><a id="addFleetOfferButton" href="#addFleetOffer">Add offer</a></td></tr>
	</table>

	<div style="display:none"><div id="addFleetOffer" style="background-color: black;">
		<form class="market_form" action="game.php?page=marketPlace&amp;action=add#fleetmarket" method="post">
			<table>
				<tr class="no-border">
					<td>
						<select name="ship">
							{foreach $FleetsOnPlanet as $ship}
							<option value="{$ship}">{$LNG.tech.$ship}</option>
							{/foreach}
						</select>
					</td>
					<td>
						<input name="fleet_size" size="10" type="number">
					</td>
				</tr>

				<tr><td colspan="2">Price</td></tr>

				<tr class="no-border">
					<td>
						<select name="resEx">
							<option value="1">{$LNG.tech.901}</option>
							<option value="2">{$LNG.tech.902}</option>
							<option value="3">{$LNG.tech.903}</option>
						</select>
					</td>
					<td>
						<input name="exchange" size="10" type="number">
					</td>
				</tr>

				<tr><td colspan="2">Filters</td></tr>

				<tr class="no-border">
					<td>
						{$LNG.fl_visibility}
					</td>
					<td>
						<select name="visibility">
							<option value="2" selected>{$LNG.fl_visibility_no_enemies}</option>
							<option value="1">{$LNG.fl_visibility_alliance}</option>
							<option value="0">{$LNG.fl_visibility_all}</option>
						</select>
					</td>
				</tr>
			</table><br/>
			<input type="hidden" name="markettype" value="1"/>
			<input value="Add" type="submit">
		</form>
	</div></div>

<hr/>

<table id="tradeFleetList" style="width:50%;white-space: nowrap;" class="tablesorter">
	<thead>
		<tr>
			<th>ID</th>
			<th>{$LNG['gl_player']}</th>
			<th>{$LNG['market_fleet']}</th>
			<th  class="no-background no-border center">-></th>
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
	{if $FlyingFleetRow.type == 1}
	<tr class='{if {$FlyingFleetRow.diplo} == 5}
	 trade-enemy
		{elseif ({$FlyingFleetRow.diplo} != NULL && {$FlyingFleetRow.diplo} <= 3) || {$FlyingFleetRow.from_alliance} == 1}
		 trade-ally
		  {/if}
	{if $FlyingFleetRow.possible_to_buy != true} trade-disallowed {/if}'>
		<td>{$smarty.foreach.FlyingFleets.iteration}</td>
		<td class="table_username">{$FlyingFleetRow.username}</td>
		<td>{$FlyingFleetRow.fleet}</td>
		<td class="no-background no-border">
			{if $FlyingFleetRow.fleet_wanted_resource_id == 1}
			<img src="./styles/theme/nova/images/metal.gif"/>
			{elseif $FlyingFleetRow.fleet_wanted_resource_id == 2}
			<img src="./styles/theme/nova/images/crystal.gif"/>
			{elseif $FlyingFleetRow.fleet_wanted_resource_id == 3}
			<img src="./styles/theme/nova/images/deuterium.gif"/>
			{/if}
		</td>
		<td class="wanted-resource-{$FlyingFleetRow.fleet_wanted_resource_id}">{$FlyingFleetRow.fleet_wanted_resource}</td>
		<td class="wanted-resource-amount">{$FlyingFleetRow.fleet_wanted_resource_amount|number}</td>
		<td>{pretty_fly_time({$FlyingFleetRow.from_duration})}</td>
		<td class="LC" style="display: none;">{pretty_fly_time({$FlyingFleetRow.to_lc_duration})}</td>
		<td class="HC">{pretty_fly_time({$FlyingFleetRow.to_hc_duration})}</td>
		<td>
			{if $FlyingFleetRow.possible_to_buy == true}
			<form class="market_form" action="game.php?page=marketPlace&amp;action=buy#fleetmarket" method="post">
				<input name="tradeID" value="{$FlyingFleetRow.id}" type="hidden">
				<input value="{$LNG.market_p_submit}" type="submit">
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
<hr/>

<table id="fleetHistoryList" style="width:50%;white-space: nowrap;" class="tablesorter">
	<thead>
		<tr>
			<th>ID</th>
			<th>{$LNG.tkb_datum}</th>
			<th>{$LNG['market_fleet']}</th>
			<th  class="no-background no-border center">-></th>
			<th>{$LNG.market_p_cost_amount}</th>
		</tr>
	</thead>
	<tbody>
		{foreach name=History item=row from=$fleetHistory}
		<tr>
			<td>{$smarty.foreach.History.iteration}</td>
			<td>{$row.time}</td>
			<td>{$row.fleet_str}</td>
			<td class="no-background no-border center">
				{if $row.res_type == 1}<img src="./styles/theme/nova/images/metal.gif"/>
				{elseif $row.res_type == 2}<img src="./styles/theme/nova/images/crystal.gif"/>
				{elseif $row.res_type == 3}<img src="./styles/theme/nova/images/deuterium.gif"/>{/if}</td>
			<td>{$row.amount}</td>
		</tr>
		{/foreach}
	</tbody>
</table>

</div>
{/block}
{block name="script" append}
<script src="scripts/base/jquery.tablesorter.js"></script>
<script>
$(function(){
	$(".market_form").submit( function() {
		var c = confirm("{$LNG.market_confirm_are_you_sure}");
		if (c) {
			$(this).append('<input type="hidden" name="shipType" value="' + $("#shipT").val() + '">')
		}
		return c;
	});
});
</script>
{/block}
