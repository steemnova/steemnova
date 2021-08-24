{block name="title" prepend}{$LNG.lm_statistics}{/block}
{block name="content"}
<form name="stats" id="stats" method="post" action="">
	<div class="card">
		<div class="card-header">
			<h2>{$LNG.st_statistics} ({$LNG.st_updated}: {$stat_date})</h2>
		</div>
		<div class="card-body">
			<label for="who">{$LNG.st_show}</label> <select name="who" id="who" onchange="$('#stats').submit();">{html_options options=$Selectors.who selected=$who}</select>
			<label for="type">{$LNG.st_per}</label> <select name="type" id="type" onchange="$('#stats').submit();">{html_options options=$Selectors.type selected=$type}</select>
			<label for="range">{$LNG.st_in_the_positions}</label> <select name="range" id="range" onchange="$('#stats').submit();">{html_options options=$Selectors.range selected=$range}</select>
			<table class="table table-striped">
				{if $who == 1}
					{include file="shared.statistics.playerTable.tpl"}
				{elseif $who == 2}
					{include file="shared.statistics.allianceTable.tpl"}
				{/if}
			</table>
		</div>
	</div>
</form>

{/block}
{block name="script" append}
    <script src="scripts/game/statistics.js"></script>
{/block}