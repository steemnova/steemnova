<a class='float-end btn btn-secondary tooltip_hide'>X</a>
{if $currentPlanet.npcType == 0}
    {include 'user.actions.tpl'}
    {if $currentPlanet.alliance}
        <hr/>
        {include 'alliance.actions.tpl'}
    {/if}
{else}
    <h3>{$currentPlanet.user.username}</h3>
    <h5>{$LNG.npc_owned.{$currentPlanet.npcType}}</h5>
    <h6>{$LNG.cuneros_treasure}: {$currentPlanet.coins|number}</h6>
{/if}
<hr/>
<div class='float-end'>
    <img class='planet-image' src='{$dpath}planeten/{$currentPlanet.planet.image}.jpg' height='75' width='75'>
</div>
<h3>{$currentPlanet.planet.name} [{$galaxy}:{$system}:{$planet}]</h3>
<h6>{$LNG.gl_planet}</h6>
<div>{$LNG.gl_diameter}: {$currentPlanet.planet.diameter} {$LNG.ov_distance_unit}</div>
<div>{$LNG.gl_temperature}: {$currentPlanet.planet.temp_min} {$LNG.ov_temp_unit}</div>

<div class='list-group'>
    {if $currentPlanet.missions.6}
        <a class='list-group-item' href='javascript:send_fleet(6,{$currentPlanet.planet.id});'
           title='{$LNG['type_mission_6']}'><i class='fas fa-user-secret'></i> {$LNG['type_mission_6']}</a>
    {/if}
    {if !'vacation'|in_array:$currentPlanet.user.class && $currentPlanet.planet.phalanx}
        <a class='list-group-item'
           href='javascript:OpenPopup(&quot;?page=phalanx&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&quot;, &quot;&quot;, 640, 510);'>{$LNG.gl_phalanx}</a>
    {/if}
    {if $currentPlanet.missions.1}
        <a class='list-group-item text-danger'
           data-bs-toggle='modal' data-bs-target='#fleetTable' data-planet='{$currentPlanet.planet.id}' href='#'
           data-href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=1'
           title='{$LNG['type_mission_1']}'><i class='fas fa-horse'></i> {$LNG['type_mission_1']}</a>
    {/if}
    {if $currentPlanet.missions.10}
        <a class='text-danger list-group-item'
           href='?page=galaxy&amp;action=sendMissle&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}'><i
                    class='fas fa-rocket'></i> {$LNG['type_mission_10']}</a>
    {/if}
    {if $currentPlanet.missions.5}
        <a class='list-group-item'
           href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=5'
           title='{$LNG['type_mission_5']}'><i class='fas fa-hands'></i> {$LNG['type_mission_5']}</a>
    {/if}
    {if $currentPlanet.missions.4}
        <a class='list-group-item'
           href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=4'
           title='{$LNG['type_mission_4']}'><i class='fas fa-bus'></i> {$LNG['type_mission_4']}</a>
    {/if}
    {if $currentPlanet.missions.3}
        <a class='list-group-item'
           href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=3'
           title='{$LNG['type_mission_3']}'><i class='fas fa-dolly'></i> {$LNG['type_mission_3']}</a>
    {/if}
    <a class='list-group-item'
       href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=17'
       title='{$LNG['type_mission_17']}'><i class='fas fa-share'></i> {$LNG['type_mission_17']}</a>
</div>

