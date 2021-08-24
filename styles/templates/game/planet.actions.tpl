<h3>{$LNG.gl_planet} {$currentPlanet.planet.name} [{$galaxy}:{$system}:{$planet}]</h3>
<div>
    <img src='{$dpath}planeten/{$currentPlanet.planet.image}.jpg' height='75'
         width='75'>
    {if $currentPlanet.missions.6}
        <a class='btn btn-primary' href='javascript:doit(6,{$currentPlanet.planet.id});' title='{$LNG["type_mission_6"]}'><i class='fas fa-user-secret'></i></a>
    {/if}
    {if !'vacation'|in_array:$currentPlanet.user.class && $currentPlanet.planet.phalanx}
        <a class='btn btn-primary' href='javascript:OpenPopup(&quot;?page=phalanx&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&quot;, &quot;&quot;, 640, 510);'>{$LNG.gl_phalanx}</a>
    {/if}
    {if $currentPlanet.missions.1}
        <a class='btn btn-danger' href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=1' title='{$LNG["type_mission_1"]}'><i class='fas fa-horse'></i></a>
    {/if}
    {if $currentPlanet.missions.5}
        <a class='btn btn-secondary' href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=5' title='{$LNG["type_mission_5"]}'><i class='fas fa-hands'></i></a>
    {/if}
    {if $currentPlanet.missions.4}
        <a class='btn btn-secondary' href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=4' title='{$LNG["type_mission_4"]}'><i class='fas fa-bus'></i></a>
    {/if}
    {if $currentPlanet.missions.3}
        <a class='btn btn-secondary' href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=3' title='{$LNG["type_mission_3"]}'><i class='fas fa-dolly'></i></a>
    {/if}
        <a class='btn btn-secondary' href='?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=17' title='{$LNG["type_mission_17"]}'><i class='fas fa-share'></i></a>
    {if $currentPlanet.missions.10}
        <a class='btn btn-danger' href='?page=galaxy&amp;action=sendMissle&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}' title='{$LNG["type_mission_10"]}'><i class='fas fa-rocket'></i></a>
    {/if}
</div>