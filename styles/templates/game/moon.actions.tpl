<h3>{$LNG.gl_moon} {$currentPlanet.moon.name} [{$galaxy}:{$system}:{$planet}]</h3>
<div>{$LNG.gl_diameter}: {$currentPlanet.moon.diameter|number}</div>
<div>{$LNG.gl_temperature}: {$currentPlanet.moon.temp_min}</div>
<div>
    <img src='{$dpath}planeten/mond.jpg' height='75' width='75'>

    {if $currentPlanet.missions.6}
        <a class='btn btn-primary' href='javascript:doit(6,{$currentPlanet.planet.id});'
           title='{$LNG["type_mission_6"]}'><i class='fas fa-user-secret'></i></a>
    {/if}
    {if $currentPlanet.missions.1}
        <a class='btn btn-danger'
           href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=3&amp;target_mission=1'
           title='{$LNG["type_mission_1"]}'><i class='fas fa-horse'></i></a>
    {/if}
    {if $currentPlanet.missions.5}
        <a class='btn btn-secondary'
           href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=3&amp;target_mission=5'
           title='{$LNG["type_mission_5"]}'><i class='fas fa-hands'></i></a>
    {/if}
    {if $currentPlanet.missions.4}
        <a class='btn btn-secondary'
           href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=3&amp;target_mission=4'
           title='{$LNG["type_mission_4"]}'><i class='fas fa-bus'></i></a>
    {/if}
    {if $currentPlanet.missions.3}
        <a class='btn btn-secondary'
           href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=3&amp;target_mission=3'
           title='{$LNG["type_mission_3"]}'><i class='fas fa-dolly'></i></a>
    {/if}
    {if $currentPlanet.missions.9}
        <a class='btn btn-secondary'
           href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=3&amp;target_mission=9'
           title='{$LNG["type_mission_9"]}'><i class='fas fa-dolly'></i></a>
    {/if}

    {if $currentPlanet.missions.10}
        <a class='btn btn-danger'
           href='?page=galaxy&amp;action=sendMissle&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;type=3'
           title='{$LNG["type_mission_10"]}'><i class='fas fa-rocket'></i></a>
    {/if}
</div>