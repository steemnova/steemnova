<table class="table table-striped d-none" id="table-view">
    <tr>
        <th>{$LNG.gl_pos}</th>
        <th>{$LNG.gl_planet}</th>
        <th>{$LNG.sh_name}</th>
        <th>{$LNG.gl_moon}</th>
        <th>{$LNG.gl_debris}</th>
        <th>{$LNG.gl_player_estate}</th>
        <th>{$LNG.gl_alliance}</th>
        <th>{$LNG.gl_actions}</th>
    </tr>
    {for $planet=1 to $max_planets}
        <tr>
            {if !isset($GalaxyRows[$planet])}
                <td>
                    <a href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=7">{$planet}</a>
                </td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            {elseif $GalaxyRows[$planet] === false}
                <td>
                    {$planet}
                </td>
                <td></td>
                <td>{$LNG.gl_planet_destroyed}</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            {else}
                <td>
                    {$planet}
                </td>
                {$currentPlanet = $GalaxyRows[$planet]}
                <td>
                    <a class="tooltip_sticky"
                       data-tooltip-content="{include "planet.actions.tpl"}">
                        <img src="{$dpath}planeten/{$currentPlanet.planet.image}.jpg"
                             height="30" width="30" alt="">
                    </a>
                </td>
                <td>{$currentPlanet.planet.name} {$currentPlanet.lastActivity}</td>
                <td>
                    {if $currentPlanet.moon}
                        <a class="tooltip_sticky"
                           data-tooltip-content="{include "moon.actions.tpl"}">
                            <img src="{$dpath}planeten/mond.jpg" height="22" width="22"
                                 alt="{$currentPlanet.moon.name}">
                        </a>
                    {/if}
                </td>
                <td>
                    {if $currentPlanet.debris}
                        <a class="tooltip_sticky"
                           data-tooltip-content="{include "debris.actions.tpl"}">
                            <img src="{$dpath}planeten/debris.jpg" height="22" width="22"
                                 alt="">
                        </a>
                    {/if}
                </td>
                <td>
                    <a class="tooltip_sticky"
                       data-tooltip-content="{include "user.actions.tpl"}">
                        <span class="{foreach $currentPlanet.user.class as $class}{if !$class@first} {/if}galaxy-username-{$class}{/foreach} galaxy-username">{$currentPlanet.user.username}</span>

                        {if !empty($currentPlanet.user.class)}
                            <span>(</span>
                            {foreach $currentPlanet.user.class as $class}{if !$class@first}&nbsp;{/if}
                                <span
                                class="galaxy-short-{$class} galaxy-short">{$ShortStatus.$class}</span>{/foreach}
                            <span>)</span>
                        {/if}
                    </a>
                </td>
                <td>
                    {if $currentPlanet.alliance}
                        <a class="tooltip_sticky"
                           data-tooltip-content="{include "alliance.actions.tpl"}">
                            <span class="{foreach $currentPlanet.alliance.class as $class}{if !$class@first} {/if}galaxy-alliance-{$class}{/foreach} galaxy-alliance">{$currentPlanet.alliance.tag}</span>
                        </a>
                    {else}-{/if}
                </td>
                <td>
                    {if $currentPlanet.action}
                        {if $currentPlanet.action.esp}
                        <a href="javascript:send_fleet(6,{$currentPlanet.planet.id},{$spyShips|json|escape:'html'})">
                            <img src="{$dpath}img/e.gif" title="{$LNG.gl_spy}" alt="">
                            </a>{/if}
                        {if $currentPlanet.action.message}
                        <a href="#" onclick="return Dialog.PM({$currentPlanet.user.id})">
                            <img src="{$dpath}img/m.gif" title="{$LNG.write_message}" alt="">
                            </a>{/if}
                        {if $currentPlanet.action.buddy}
                        <a href="#" onclick="return Dialog.Buddy({$currentPlanet.user.id})">
                            <img src="{$dpath}img/b.gif" title="{$LNG.gl_buddy_request}" alt="">
                            </a>{/if}
                        {if $currentPlanet.action.missle}<a
                            href="?page=galaxy&amp;action=sendMissle&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;type=1">
                            <img src="{$dpath}img/r.gif" title="{$LNG.gl_missile_attack}"
                                 alt="">
                            </a>{/if}
                    {else}-{/if}
                    {if $currentPlanet.planet.phalanx}<a class="textForBlind" href="#"
                                                         onclick="OpenPopup('?page=phalanx&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1','',640,510);return false;">
                        <span>{$LNG.gl_phalanx}</span></a>{/if}
                </td>
            {/if}
        </tr>
    {/for}
    <tr>
        <td>{$max_planets + 1}</td>
        <td colspan="7"><a
                    href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$max_planets + 1}&amp;planettype=1&amp;target_mission=15">{$LNG.gl_out_space}</a>
        </td>
    </tr>
    <!--                            <tr>
                                <td>Trade</td>
                                <td colspan="7"><a
                                            href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$max_planets + 2}&amp;planettype=1&amp;target_mission=16">{$LNG.gl_trade_space}</a>
                                </td>
                            </tr>-->

    <tr>
        <td colspan="6">({$planetcount})</td>
        <td colspan="2">
            <a class="tooltip"
               data-tooltip-content="<table style='width:240px'><tr><th colspan='2'>{$LNG.gl_legend}</td></tr><tr><td style='width:220px'>{$LNG.gl_strong_player}</td><td><span class='galaxy-short-strong'>{$LNG.gl_short_strong}</span></td></tr><tr><td style='width:220px'>{$LNG.gl_week_player}</td><td><span class='galaxy-short-noob'>{$LNG.gl_short_newbie}</span></td></tr><tr><td style='width:220px'>{$LNG.gl_vacation}</td><td><span class='galaxy-short-vacation'>{$LNG.gl_short_vacation}</span></td></tr><tr><td style='width:220px'>{$LNG.gl_banned}</td><td><span class='galaxy-short-banned'>{$LNG.gl_short_ban}</span></td></tr><tr><td style='width:220px'>{$LNG.gl_inactive_seven}</td><td><span class='galaxy-short-inactive'>{$LNG.gl_short_inactive}</span></td></tr><tr><td style='width:220px'>{$LNG.gl_inactive_twentyeight}</td><td><span class='galaxy-short-longinactive'>{$LNG.gl_short_long_inactive}</span></td></tr></table>">{$LNG.gl_legend}</a>
        </td>
    </tr>
    <tr>
        <td colspan="3"><span
                    id="missiles">{$currentmip|number}</span> {$LNG.gl_avaible_missiles}</td>
        <td colspan="5"><span id="slots">{$maxfleetcount}</span>/{$fleetmax} {$LNG.gl_fleets}
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <span id="elementID210">{$spyprobes|number}</span> {$LNG.gl_avaible_spyprobes}
        </td>
        <td colspan="4">
            <span id="elementID209">{$recyclers|number}</span> {$LNG.gl_avaible_recyclers}
        </td>
    </tr>
    <tr style="display: none;" id="fleetstatusrow">
        <th colspan="8">{$LNG.cff_fleet_target}</th>
    </tr>
</table>