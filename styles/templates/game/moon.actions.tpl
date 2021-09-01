<a class='float-end btn btn-secondary tooltip_hide'>X</a>
<h3>{$LNG.gl_moon} {$currentPlanet.moon.name} [{$galaxy}:{$system}:{$planet}]</h3>
<div>{$LNG.gl_diameter}: {$currentPlanet.moon.diameter} {$LNG.ov_distance_unit}</div>
<div>{$LNG.gl_temperature}: {$currentPlanet.moon.temp_min} {$LNG.ov_temp_unit}</div>
<div>
    <img src='{$dpath}planeten/mond.jpg' height='75' width='75'>
<div class='list-group'>
    {if $currentPlanet.missions.6}
        <a class='list-group-item' href='javascript:send_fleet(6,{$currentPlanet.planet.id});'
           title='{$LNG['type_mission_6']}'><i class='fas fa-user-secret'></i> {$LNG['type_mission_6']}</a>
    {/if}
    {if $currentPlanet.missions.1}
        <a class='list-group-item list-group-item-danger'
           href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=3&amp;target_mission=1'
           title='{$LNG['type_mission_1']}'><i class='fas fa-horse'></i> {$LNG['type_mission_1']}</a>
    {/if}
    {if $currentPlanet.missions.5}
        <a class='list-group-item'
           href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=3&amp;target_mission=5'
           title='{$LNG['type_mission_5']}'><i class='fas fa-hands'></i> {$LNG['type_mission_5']}</a>
    {/if}
    {if $currentPlanet.missions.4}
        <a class='list-group-item'
           href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=3&amp;target_mission=4'
           title='{$LNG['type_mission_4']}'><i class='fas fa-bus'></i> {$LNG['type_mission_4']}</a>
    {/if}
    {if $currentPlanet.missions.3}
        <a class='list-group-item'
           href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=3&amp;target_mission=3'
           title='{$LNG['type_mission_3']}'><i class='fas fa-dolly'></i> {$LNG['type_mission_3']}</a>
    {/if}
    {if $currentPlanet.missions.9}
        <a class='list-group-item'
           href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=3&amp;target_mission=9'
           title='{$LNG['type_mission_9']}'><i class='fas fa-dolly'></i> {$LNG['type_mission_9']}</a>
    {/if}

    {if $currentPlanet.missions.10}
        <a class='btn btn-danger'
           href='?page=galaxy&amp;action=sendMissle&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;type=3'
           title='{$LNG['type_mission_10']}'><i class='fas fa-rocket'></i></a>
    {/if}
</div>
</div>