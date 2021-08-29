<a class='float-end btn btn-secondary tooltip_hide'>X</a>
<h3>{$LNG.gl_debris_field} [{$galaxy}:{$system}:{$planet}]</h3>
<div>
    <img src='{$dpath}planeten/debris.jpg' height='75' width='75'>
    <ul class='list-group'>
        <li class='list-group-item'>{$LNG.gl_resources}</li>
        <li class='list-group-item'>{$LNG.tech.901}: {$currentPlanet.debris.metal|number}</li>
        <li class='list-group-item'>{$LNG.tech.902}: {$currentPlanet.debris.crystal|number}</li>
    </ul>

    {if $currentPlanet.missions.8 and $recyclers|number > 0}
    <div class='list-group'>
        <a class='list-group-item' href='javascript:doit(8, {$currentPlanet.planet.id});'
           title='{$LNG['type_mission_8']}'><i class='fas fa-recycle'></i> {$LNG['type_mission_8']}</a>
    </div>
    {/if}
</div>