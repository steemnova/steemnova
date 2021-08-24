{block name="title" prepend}{$LNG.lm_resources}{/block}
{block name="content"}
	<div class="card">
		<div class="card-header">
			<h2 class="card-title">
				{$header}
			</h2>
		</div>
		<div class="card-body">
			<form action="?page=resources" method="post">
				<input type="hidden" name="mode" value="send">
				<table class="table table-striped">
					<tbody>
					<tr style="height:22px">
						<td style="width:40%">&nbsp;</td>
						{for $elementID = 901 to 903}
							<td style="width:10%"><a href='#' onclick='return Dialog.info({$elementID})' class='tooltip' data-tooltip-content="{include 'resource.info.tpl'}">{$LNG.tech.$elementID}</a></td>
						{/for}
						{$elementID = 911}
						<td style="width:10%"><a href='#' onclick='return Dialog.info({$elementID})' class='tooltip' data-tooltip-content="{include 'resource.info.tpl'}">{$LNG.tech.$elementID}</a></td>
					</tr>
					<tr style="height:22px">
						<td>{$LNG.rs_basic_income}</td>
						<td>{$basicProduction.901|number}</td>
						<td>{$basicProduction.902|number}</td>
						<td>{$basicProduction.903|number}</td>
						<td>{$basicProduction.911|number}</td>
					</tr>
					{foreach $productionList as $productionID => $productionRow}
						{$elementID = $productionID}

						<tr style="height:22px">
							<td><a href='#' onclick='return Dialog.info({$productionID});' class='tooltip' data-tooltip-content="{include 'building.info.tpl'}">{$LNG.tech.$productionID }</a> ({if $productionID  > 200}{$LNG.rs_amount}{else}{$LNG.rs_lvl}{/if} {$productionRow.elementLevel})</td>
							<td><span style="color:{if $productionRow.production.901 > 0}darkgreen{elseif $productionRow.production.901 < 0}darkred{else}white{/if}">{$productionRow.production.901|number}</span></td>
							<td><span style="color:{if $productionRow.production.902 > 0}darkgreen{elseif $productionRow.production.902 < 0}darkred{else}white{/if}">{$productionRow.production.902|number}</span></td>
							<td><span style="color:{if $productionRow.production.903 > 0}darkgreen{elseif $productionRow.production.903 < 0}darkred{else}white{/if}">{$productionRow.production.903|number}</span></td>
							<td><span style="color:{if $productionRow.production.911 > 0}darkgreen{elseif $productionRow.production.911 < 0}darkred{else}white{/if}">{$productionRow.production.911|number}</span></td>
							<td style="width:10%">
								{html_options name="prod[{$productionID}]" options=$prodSelector selected=$productionRow.prodLevel}
							</td>
						</tr>
					{/foreach}
					<tr style="height:22px">
						<td>{$LNG.rs_ress_bonus}</td>
						<td><span style="color:{if $bonusProduction.901 > 0}darkgreen{elseif $bonusProduction.901 < 0}darkred{else}white{/if}">{$bonusProduction.901|number}</span></td>
						<td><span style="color:{if $bonusProduction.902 > 0}darkgreen{elseif $bonusProduction.902 < 0}darkred{else}white{/if}">{$bonusProduction.902|number}</span></td>
						<td><span style="color:{if $bonusProduction.903 > 0}darkgreen{elseif $bonusProduction.903 < 0}darkred{else}white{/if}">{$bonusProduction.903|number}</span></td>
						<td><span style="color:{if $bonusProduction.911 > 0}darkgreen{elseif $bonusProduction.911 < 0}darkred{else}white{/if}">{$bonusProduction.911|number}</span></td>
						<td><input value="{$LNG.rs_calculate}" type="submit"></td>
					</tr>
					<tr style="height:22px">
						<td>{$LNG.rs_storage_capacity}</td>
						<td><span style="color:darkgreen;">{$storage.901}</span></td>
						<td><span style="color:darkgreen;">{$storage.902}</span></td>
						<td><span style="color:darkgreen;">{$storage.903}</span></td>
						<td>-</td>
					</tr>
					<tr style="height:22px">
						<td>{$LNG.rs_sum}:</td>
						<td><span style="color:{if $totalProduction.901 > 0}darkgreen{elseif $totalProduction.901 < 0}darkred{else}white{/if}">{$totalProduction.901|number}</span></td>
						<td><span style="color:{if $totalProduction.902 > 0}darkgreen{elseif $totalProduction.902 < 0}darkred{else}white{/if}">{$totalProduction.902|number}</span></td>
						<td><span style="color:{if $totalProduction.903 > 0}darkgreen{elseif $totalProduction.903 < 0}darkred{else}white{/if}">{$totalProduction.903|number}</span></td>
						<td><span style="color:{if $totalProduction.911 > 0}darkgreen{elseif $totalProduction.911 < 0}darkred{else}white{/if}">{$totalProduction.911|number}</span></td>
					</tr>
					<tr style="height:22px">
						<td>{$LNG.rs_daily}</td>
						<td><span style="color:{if $dailyProduction.901 > 0}darkgreen{elseif $dailyProduction.901 < 0}darkred{else}white{/if}">{$dailyProduction.901|number}</span></td>
						<td><span style="color:{if $dailyProduction.902 > 0}darkgreen{elseif $dailyProduction.902 < 0}darkred{else}white{/if}">{$dailyProduction.902|number}</span></td>
						<td><span style="color:{if $dailyProduction.903 > 0}darkgreen{elseif $dailyProduction.903 < 0}darkred{else}white{/if}">{$dailyProduction.903|number}</span></td>
						<td><span style="color:{if $dailyProduction.911 > 0}darkgreen{elseif $dailyProduction.911 < 0}darkred{else}white{/if}">{$dailyProduction.911|number}</span></td>
					</tr>
					<tr style="height:22px">
						<td>{$LNG.rs_weekly}</td>
						<td><span style="color:{if $weeklyProduction.901 > 0}darkgreen{elseif $weeklyProduction.901 < 0}darkred{else}white{/if}">{$weeklyProduction.901|number}</span></td>
						<td><span style="color:{if $weeklyProduction.902 > 0}darkgreen{elseif $weeklyProduction.902 < 0}darkred{else}white{/if}">{$weeklyProduction.902|number}</span></td>
						<td><span style="color:{if $weeklyProduction.903 > 0}darkgreen{elseif $weeklyProduction.903 < 0}darkred{else}white{/if}">{$weeklyProduction.903|number}</span></td>
						<td><span style="color:{if $weeklyProduction.911 > 0}darkgreen{elseif $weeklyProduction.911 < 0}darkred{else}white{/if}">{$weeklyProduction.911|number}</span></td>
					</tr>
					</tbody>
				</table>
			</form>

		</div>
	</div>
{/block}
