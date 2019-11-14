{block name="title" prepend}{$LNG.lm_buildings}{/block}
{block name="content"}

		{if $messages}
	<div class="message"><a href="?page=messages">{$messages}</a></div>
	
	{/if}
{if !empty($Queue)}
<div id="buildlist" class="infos1">
	
		{foreach $Queue as $List}
		{$ID = $List.element}
		<div class="buildb">

				{$List@iteration}.: 
				{if !($isBusy.research && ($ID == 6 || $ID == 31)) && !($isBusy.shipyard && ($ID == 15 || $ID == 21)) && $RoomIsOk && $CanBuildElement && $BuildInfoList[$ID].buyable}
				<form class="build_form" action="game.php?page=buildings" method="post">
					<input type="hidden" name="cmd" value="insert">
					<input type="hidden" name="building" value="{$ID}">
					<button type="submit" class="build_submit onlist">{$LNG.tech.{$ID}} {$List.level}{if $List.destroy} {$LNG.bd_dismantle}{/if}</button>
				</form>
				{else}{$LNG.tech.{$ID}} {$List.level} {if $List.destroy}{$LNG.bd_dismantle}{/if}{/if}
				{if $List@first}
				<br><br><div id="progressbar" data-time="{$List.resttime}"></div></div>
			<div class="bulida">
				<div id="time" data-time="{$List.time}"><br></div>
				<form action="game.php?page=buildings" method="post" class="build_form">
					<input type="hidden" name="cmd" value="cancel">
					<button type="submit" class="build_submit onlist">{$LNG.bd_cancel}</button>
				</form>
				{else}
			</div><div class="bulida">
				<form action="game.php?page=buildings" method="post" class="build_form">
					<input type="hidden" name="cmd" value="remove">
					<input type="hidden" name="listid" value="{$List@iteration}">
					<button type="submit" class="build_submit onlist">{$LNG.bd_cancel}</button>
				</form>
				{/if}
				<br><span style="color:lime" data-time="{$List.endtime}" class="timer">{$List.display}</span>
			</div>
	{/foreach}

	
</div >

{/if}

	<div>
<div class="planeto"> <button id="btn1">Mining</button> | <button id="btn2">Other</button> | <button id="btn3">All</button></div>		

{foreach $BuildInfoList as $ID => $Element}
{if ($ID == 1 || $ID == 2 || $ID == 3 || $ID == 4 || $ID == 12 || $ID == 22 || $ID == 23 || $ID == 24)}
<div class="infos">
<div class="buildn">
<a href="#" onclick="return Dialog.info({$ID})">{$LNG.tech.{$ID}}</a>{if $Element.level > 0} ({$LNG.bd_lvl} {$Element.level}{if $Element.maxLevel != 255}/{$Element.maxLevel}{/if}){/if}
	</div>
		<div class="buildl">
			<a href="#" onclick="return Dialog.info({$ID})">
				<img style="float: left;" src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}" width="120" height="120">
			</a>
		{$LNG.bd_remaining}
						{foreach $Element.costOverflow as $ResType => $ResCount}
						<a href='#' onclick="return Dialog.info({$ResType});" class='tooltip' data-tooltip-content="<table><tr><th>{$LNG.tech.{$ResType}}</th></tr><tr><table class='hoverinfo'><tr><td>{$LNG.shortDescription.$ResType}</td></tr></table></tr></table>">{$LNG.tech.{$ResType}}</a>: <span style="font-weight:700">{$ResCount|number}</span><br>
						{/foreach}
						<br>
{if !empty($Element.infoEnergy)}
							{$LNG.bd_next_level}<br>
							{$Element.infoEnergy}<br>
						{/if}
					
		
		

		
</div>

	<div class="buildl">
							<span>{foreach $Element.costResources as $RessID => $RessAmount}
					<a href='#' onclick="return Dialog.info({$RessID});" class='tooltip' data-tooltip-content="<table><tr><th>{$LNG.tech.{$RessID}}</th></tr><tr><table class='hoverinfo'><tr><td><img src='{$dpath}gebaeude/{$RessID}.{if $RessID >=600 && $RessID <= 699}jpg{else}gif{/if}'></td><td>{$LNG.shortDescription.$RessID}</td></tr></table></tr></table>">{$LNG.tech.{$RessID}}</a>: <b><span style="color:{if $Element.costOverflow[$RessID] == 0}lime{else}#ffd600{/if}">{$RessAmount|number}</span></b>
					{/foreach}</span><br><br>
					
					{if $Element.maxLevel == $Element.levelToBuild}
						<span style="color:#ffd600">{$LNG.bd_maxlevel} || <button>End Game</button></span>
					{elseif ($isBusy.research && ($ID == 6 || $ID == 31)) || ($isBusy.shipyard && ($ID == 15 || $ID == 21))}
						<span style="color:#ffd600">{$LNG.bd_working}</span>
					{else}
						{if $RoomIsOk}
							{if $CanBuildElement && $Element.buyable}
							<form action="game.php?page=buildings" method="post" class="build_form">
								<input type="hidden" name="cmd" value="insert">
								<input type="hidden" name="building" value="{$ID}">
								<button type="submit" class="build_submit">{if $Element.level == 0 && $Element.levelToBuild == 0}{$LNG.bd_build}{else}{$LNG.bd_build_next_level}{$Element.levelToBuild + 1}{/if}</button>
							</form>
							{else}
							<span style="color:#ffd600">{if $Element.level == 0 && $Element.levelToBuild == 0}{$LNG.bd_build}{else}{$LNG.bd_build_next_level}{$Element.levelToBuild + 1}{/if}</span>
							{/if}
						{else}
						<span style="color:#ffd600">{$LNG.bd_no_more_fields}</span>
						{/if}
					{/if}
						
				<br>
						{$LNG.fgf_time}:{$Element.elementTime|time}
{if $Element.level > 0}
							{if $ID == 43}<a href="#" onclick="return Dialog.info({$ID})">{$LNG.bd_jump_gate_action}</a>{/if}
							{if ($ID == 44 && !$HaveMissiles) ||  $ID != 44}<br><a class="tooltip_sticky" data-tooltip-content="
								{* Start Destruction Popup *}
								<table style='width:300px'>
									<tr>
										<th colspan='2'>{$LNG.bd_price_for_destroy} {$LNG.tech.{$ID}} {$Element.level}</th>
									</tr>
									{foreach $Element.destroyResources as $ResType => $ResCount}
									<tr>
										<td>{$LNG.tech.{$ResType}}</td>
										<td><span style='color:{if empty($Element.destroyOverflow[$RessID])}lime{else}#ffd600{/if}'>{$ResCount|number}</span></td>
									</tr>
									{/foreach}
									<tr>
										<td>{$LNG.bd_destroy_time}</td>
										<td>{$Element.destroyTime|time}</td>
									</tr>
									<tr>
										<td colspan='2'>
											<form action='game.php?page=buildings' method='post' class='build_form'>
												<input type='hidden' name='cmd' value='destroy'>
												<input type='hidden' name='building' value='{$ID}'>
												<button type='submit' class='build_submit onlist'>{$LNG.bd_dismantle}</button>
											</form>
										</td>
									</tr>
								</table>
								{* End Destruction Popup *}
								">{$LNG.bd_dismantle}</a>{/if}
						{else}
							&nbsp;
						{/if}
					</div>
</div>
 {else} <div class="infoso">
<div class="buildn">
<a href="#" onclick="return Dialog.info({$ID})">{$LNG.tech.{$ID}}</a>{if $Element.level > 0} ({$LNG.bd_lvl} {$Element.level}{if $Element.maxLevel != 255}/{$Element.maxLevel}{/if}){/if}
	</div>
		<div class="buildl">
			<a href="#" onclick="return Dialog.info({$ID})">
				<img style="float: left;" src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}" width="120" height="120">
			</a>
		{$LNG.bd_remaining}
						{foreach $Element.costOverflow as $ResType => $ResCount}
						<a href='#' onclick="return Dialog.info({$ResType});" class='tooltip' data-tooltip-content="<table><tr><th>{$LNG.tech.{$ResType}}</th></tr><tr><table class='hoverinfo'><tr><td>{$LNG.shortDescription.$ResType}</td></tr></table></tr></table>">{$LNG.tech.{$ResType}}</a>: <span style="font-weight:700">{$ResCount|number}</span><br>
						{/foreach}
						<br>
{if !empty($Element.infoEnergy)}
							{$LNG.bd_next_level}<br>
							{$Element.infoEnergy}<br>
						{/if}
					
		
		

		
</div>

	<div class="buildl">
<span>{foreach $Element.costResources as $RessID => $RessAmount}
					<a href='#' onclick="return Dialog.info({$RessID});" class='tooltip' data-tooltip-content="<table><tr><th>{$LNG.tech.{$RessID}}</th></tr><tr><table class='hoverinfo'><tr><td><img src='{$dpath}gebaeude/{$RessID}.{if $RessID >=600 && $RessID <= 699}jpg{else}gif{/if}'></td><td>{$LNG.shortDescription.$RessID}</td></tr></table></tr></table>">{$LNG.tech.{$RessID}}</a>: <b><span style="color:{if $Element.costOverflow[$RessID] == 0}lime{else}#ffd600{/if}">{$RessAmount|number}</span></b>
					{/foreach}</span><br><br>
					
					{if $Element.maxLevel == $Element.levelToBuild}
						<span style="color:#ffd600">{$LNG.bd_maxlevel}</span>
					{elseif ($isBusy.research && ($ID == 6 || $ID == 31)) || ($isBusy.shipyard && ($ID == 15 || $ID == 21))}
						<span style="color:#ffd600">{$LNG.bd_working}</span>
					{else}
						{if $RoomIsOk}
							{if $CanBuildElement && $Element.buyable}
							<form action="game.php?page=buildings" method="post" class="build_form">
								<input type="hidden" name="cmd" value="insert">
								<input type="hidden" name="building" value="{$ID}">
								<button type="submit" class="build_submit">{if $Element.level == 0 && $Element.levelToBuild == 0}{$LNG.bd_build}{else}{$LNG.bd_build_next_level}{$Element.levelToBuild + 1}{/if}</button>
							</form>
							{else}
							<span style="color:#ffd600">{if $Element.level == 0 && $Element.levelToBuild == 0}{$LNG.bd_build}{else}{$LNG.bd_build_next_level}{$Element.levelToBuild + 1}{/if}</span>
							{/if}
						{else}
						<span style="color:#ffd600">{$LNG.bd_no_more_fields}</span>
						{/if}
					{/if}
						
				<br>
						{$LNG.fgf_time}:{$Element.elementTime|time}
{if $Element.level > 0}
							{if $ID == 43}<a href="#" onclick="return Dialog.info({$ID})">{$LNG.bd_jump_gate_action}</a>{/if}
							{if ($ID == 44 && !$HaveMissiles) ||  $ID != 44}<br><a class="tooltip_sticky" data-tooltip-content="
								{* Start Destruction Popup *}
								<table style='width:300px'>
									<tr>
										<th colspan='2'>{$LNG.bd_price_for_destroy} {$LNG.tech.{$ID}} {$Element.level}</th>
									</tr>
									{foreach $Element.destroyResources as $ResType => $ResCount}
									<tr>
										<td>{$LNG.tech.{$ResType}}</td>
										<td><span style='color:{if empty($Element.destroyOverflow[$RessID])}lime{else}#ffd600{/if}'>{$ResCount|number}</span></td>
									</tr>
									{/foreach}
									<tr>
										<td>{$LNG.bd_destroy_time}</td>
										<td>{$Element.destroyTime|time}</td>
									</tr>
									<tr>
										<td colspan='2'>
											<form action='game.php?page=buildings' method='post' class='build_form'>
												<input type='hidden' name='cmd' value='destroy'>
												<input type='hidden' name='building' value='{$ID}'>
												<button type='submit' class='build_submit onlist'>{$LNG.bd_dismantle}</button>
											</form>
										</td>
									</tr>
								</table>
								{* End Destruction Popup *}
								">{$LNG.bd_dismantle}</a>{/if}
						{else}
							&nbsp;
						{/if}
					</div>
</div>
{/if}


	{/foreach}
</div>
{/block}
