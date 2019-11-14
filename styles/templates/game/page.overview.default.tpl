
{block name="title" prepend}{$LNG.lm_overview}{/block}
{block name="script" append}
    <script>

              $(function(){
            $("#chkbtn").on('click',function() {
                $(this).hide();
                $("#hidden-div").show();
            }); 
        });

 $(function(){
            $("#chkbtn2").on('click',function() {
                $("#chkbtn").show();
                $("#hidden-div").hide();
            }); 
        });
 $(function(){
            $("#chkbtn1").on('click',function() {
                $(this).hide();
                $("#hidden-div2").hide()
$("#tn3").show();
            }); 
        });
 $(function(){
            $("#chkbtn3").on('click',function() {
                $("#chkbtn1").show();
                $("#hidden-div2").show();
$("#tn3").hide();

            }); 
        });
    </script>

{/block}
{block name="content"}

   
<style>
	.hidden-div {
        display:none;	}
</style>	

<div>
	{if $messages}
	<div class="message"><a href="?page=messages">{$messages}</a></div>
	
	{/if}
<div class="infos">
<div class="planeto"><a href="#" onclick="return Dialog.PlanetAction();" title="{$LNG.ov_planetmenu}">{$LNG["type_planet_{$planet_type}"]} {$planetname}</a> ({$username})</div>

	{$LNG.ov_server_time}:
		<span class="servertime">{$servertime}</span>
	
	
</br>

{$LNG.ov_admins_online}:&nbsp;{foreach $AdminsOnline as $ID => $Name}{if !$Name@first}&nbsp;&bull;&nbsp;{/if}<a href="#" onclick="return Dialog.PM({$ID})"><a style="color:lime">{$Name}</a>{foreachelse}{/foreach} </br>
{$LNG.ov_online}

			<a style="color:lime">{$usersOnline}</a> {$LNG.ov_players}
		
			<a style="color:lime">{$fleetsOnline}</a> {$LNG.ov_moving_fleets}
<br>{$LNG.ov_points} {$rankInfo}
{if $is_news}

                <div class="hidden-div" id="hidden-div">

         
                 {$LNG.ov_news}:&nbsp;{$news} </br><span style="display:block; margin-top:10px;"><button id="chkbtn2">Hide News</button></span>
 
                </div>
                <span style="display:block; margin-top:10px;"><button id="chkbtn">Check News</button></span>
{/if}

    </div>
		
<div class="infos" >
<div class="planeto">
		{$LNG.ov_events} <button id="chkbtn1">Hide fleets</button> </div>

	<ul style="list-style-type:none;" id="hidden-div2">
	{foreach $fleets as $index => $fleet}


		<li style=" padding: 3px; "><span id="fleettime_{$index}" class="fleets" data-fleet-end-time="{$fleet.returntime}" data-fleet-time="{$fleet.resttime}">{pretty_fly_time({$fleet.resttime})}
		</span> <td id="fleettime_{$index}">{$fleet.text}</td></li> 
	
	{/foreach}
</ul>
 &nbsp;<span style="display:none" id="tn3"><button id="chkbtn3">Show fleets</button></span>
	</div>
<br>
<div class="infos">
{if $Moon}<div class="moon"><a href="game.php?page=overview&amp;cp={$Moon.id}&amp;re=0" title="{$Moon.name}"><img src="{$dpath}planeten/mond.jpg" height="100" width="100" style="margin: 20% 0px 5px 0px;" alt="{$Moon.name} ({$LNG.fcm_moon})"></a><br>{$Moon.name} ({$LNG.fcm_moon})
</div>
{else}&nbsp;{/if}
		<div class="planeth">
			<img style="float: left;" src="{$dpath}planeten/{$planetimage}.jpg" height="200" width="200" alt="{$planetname}"></div><div class="planeth">
 {$planetname}<br>
			
			{if $buildInfo.buildings}<a href="game.php?page=buildings">{$LNG.lm_buildings}: </a>{$LNG.tech[$buildInfo.buildings['id']]} ({$buildInfo.buildings['level']})<br><div class="timer" data-time="{$buildInfo.buildings['timeleft']}">{$buildInfo.buildings['starttime']}</div>{else}<a href="game.php?page=buildings">{$LNG.lm_buildings}: {$LNG.ov_free}</a><br>{/if}
			{if $buildInfo.tech}<a href="game.php?page=research">{$LNG.lm_research}: </a>{$LNG.tech[$buildInfo.tech['id']]} ({$buildInfo.tech['level']})<br><div class="timer" data-time="{$buildInfo.tech['timeleft']}">{$buildInfo.tech['starttime']}</div>{else}<a href="game.php?page=research">{$LNG.lm_research}: {$LNG.ov_free}</a><br>{/if}
			{if $buildInfo.fleet}<a href="game.php?page=shipyard&amp;mode=fleet">{$LNG.lm_shipshard}: </a>{$LNG.tech[$buildInfo.fleet['id']]} ({$buildInfo.fleet['level']})<br><div class="timer" data-time="{$buildInfo.fleet['timeleft']}">{$buildInfo.fleet['starttime']}</div>{else}<a href="game.php?page=shipyard&amp;mode=fleet">{$LNG.lm_shipshard}: {$LNG.ov_free}</a><br>{/if}
</br>
{$LNG.ov_diameter}: {$LNG.ov_distance_unit} (<a title="{$LNG.ov_developed_fields}">{$planet_field_current}</a> / <a title="{$LNG.ov_max_developed_fields}">{$planet_field_max}</a> {$LNG.ov_fields})
<br>{$LNG.ov_temperature}: {$LNG.ov_aprox} {$planet_temp_min}{$LNG.ov_temp_unit} {$LNG.ov_to} {$planet_temp_max}{$LNG.ov_temp_unit}
<br>{$LNG.ov_position}: <a href="game.php?page=galaxy&amp;galaxy={$galaxy}&amp;system={$system}">[{$galaxy}:{$system}:{$planet}]</a>

</div>
&nbsp;</br>
</div>
<br>
<div class="infos">		
{if $AllPlanets}<div class="planeto">{$LNG.lv_planet}</div>




		
			{foreach $AllPlanets as $PlanetRow}
			{if ($PlanetRow@iteration % $themeSettings.PLANET_ROWS_ON_OVERVIEW) === 1}{/if}
			<div class="planetl"><a href="game.php?page=overview&amp;cp={$PlanetRow.id}" title="{$PlanetRow.name}"><img style="margin: 5px;" src="{$dpath}planeten/{$PlanetRow.image}.jpg" width="100" height="100" alt="{$PlanetRow.name}"></a><br>{$PlanetRow.name}<br>{$PlanetRow.build}<br></div>
			{if $PlanetRow@last && $PlanetRow@total > 1 && ($PlanetRow@iteration % $themeSettings.PLANET_ROWS_ON_OVERVIEW) !== 0}
			{$to = $themeSettings.PLANET_ROWS_ON_OVERVIEW - ($PlanetRow@iteration % $themeSettings.PLANET_ROWS_ON_OVERVIEW)}
			{for $foo=1 to $to}
			
			{/for}
			{/if}
			{if ($PlanetRow@iteration % $themeSettings.PLANET_ROWS_ON_OVERVIEW) === 0}</tr>{/if}
			{/foreach}

		{else}&nbsp;{/if}
</div></div>
	
	
	
	
</div>

{/block}
{block name="script" append}
    <script src="scripts/game/overview.js"></script>
{/block}
