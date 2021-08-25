<h3>{$LNG.gl_debris_field} [{$galaxy}:{$system}:{$planet}]</h3>
<div>
    <img src='{$dpath}planeten/debris.jpg' height='75' width='75'>
    <ul class='list-group'>
        <li class='list-group-item'>{$LNG.gl_resources}</li>
        <li class='list-group-item'>{$LNG.tech.901}: {$currentPlanet.debris.metal|number}</li>
        <li class='list-group-item'>{$LNG.tech.902}: {$currentPlanet.debris.crystal|number}</li>
    </ul>
    {if $currentPlanet.missions.8 and $recyclers|number > 0}
        <a class='btn btn-primary' href='javascript:doit(8, {$currentPlanet.planet.id});'
           title='{$LNG['type_mission_8']}'><i class='fas fa-recycle'></i></a>
    {/if}
</div>