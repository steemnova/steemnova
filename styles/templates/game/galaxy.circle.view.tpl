<div class="solar-system" id="solar-system-view">
    <div class="sun" data-bs-toggle="tooltip" data-bs-placement="top" title="{$LNG.sun_hot}">
        <img src="{$dpath}/img/sun.gif"/></div>
    {for $planet=1 to $max_planets}
        <div class="planet-ring planet-ring-{$planet}"></div>
        {if !isset($GalaxyRows[$planet])}
            <div class="planet planet-{$planet} planet-empty">
                <a class="tooltip_clicky" data-tooltip-content="{include "empty.actions.tpl"}"
                   old-href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=7">{$planet}</a>
            </div>
        {elseif $GalaxyRows[$planet] === false}
            {$LNG.gl_planet_destroyed}
        {else}
            {$currentPlanet = $GalaxyRows[$planet]}
            <a class="tooltip_clicky planet planet-{$planet} {if $currentPlanet.ownPlanet}own-planet{elseif $currentPlanet.allyPlanet}ally-planet{elseif $currentPlanet.npcType > 0}planet-npc-{$currentPlanet.npcType}{else}other-planet{/if}"
               data-tooltip-content="{include "planet.actions.tpl"}" data-bs-toggle="tooltip"
               data-bs-placement="top"
               title="{$currentPlanet.planet.name} ({$currentPlanet.user.username}{if $currentPlanet.alliance} / {$currentPlanet.alliance.name}{/if})">
                <img src="{$dpath}planeten/{$currentPlanet.planet.image}.jpg"
                     height="30" width="30" alt="">
            </a>
            {if $currentPlanet.moon}
                <a class="tooltip_clicky planet planet-{$planet} moon"
                   data-tooltip-content="{include "moon.actions.tpl"}">
                    <img src="{$dpath}planeten/mond.jpg" height="22" width="22"
                         alt="{$currentPlanet.moon.name}">
                </a>
            {/if}
            {if $currentPlanet.debris}
                <a class="tooltip_clicky planet planet-{$planet} debris"
                   data-tooltip-content="{include "debris.actions.tpl"}">
                    <img src="{$dpath}planeten/debris.jpg" height="22" width="22"
                         alt="">
                </a>
            {/if}
        {/if}
    {/for}
    {if $activeExpedition < $maxExpedition}
        <div class="target target-expedition">
            <a href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$max_planets+1}&amp;planettype=1&amp;target_mission=15">{$LNG.type_mission_15}</a>
        </div>
    {/if}
    <div class="target target-market">
        <a href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$max_planets+2}&amp;planettype=1&amp;target_mission=16">{$LNG.fl_exchange}</a>
    </div>

</div>