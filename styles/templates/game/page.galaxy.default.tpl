{block name="title" prepend}{$LNG.lm_galaxy}{/block}
{block name="content"}
    <div class="row row-cols-1 row-cols-xl-2 g-4">
        <div class="col mb-2">
            <div class="card">
                <form action="?page=galaxy" method="post" id="galaxy_form">
                    <input type="hidden" id="auto" value="dr">
                    <input type="hidden" name="system" value="{$system}">
                    <input type="hidden" name="galaxy" value="{$galaxy}">
                    <div class="card-header">
                        <h2 class="card-title">{$LNG.gl_galaxy}</h2>
                    </div>
                    <div class="card-body">
                        <div class="btn-group btn-group-sm">
                            <div class="btn btn-primary">{$LNG.gl_galaxy}</div>
                            <a class="btn btn-primary btn-sm" onclick="galaxy_submit('galaxyLeft')"><i
                                        class="fas fa-arrow-left"></i></a>
                            <div class="btn btn-primary btn-sm">{$galaxy}</div>
                            <a class="btn btn-primary btn-sm" onclick="galaxy_submit('galaxyRight')"><i
                                        class="fas fa-arrow-right"></i></a>
                        </div>

                        <div class="btn-group btn-group-sm float-end">
                            <div class="btn btn-secondary">{$LNG.gl_solar_system}</div>
                            <a class="btn btn-secondary btn-sm" onclick="galaxy_submit('systemLeft')"><i
                                        class="fas fa-arrow-left"></i></a>
                            <div class="btn btn-secondary btn-sm">{$system}</div>
                            <a class="btn btn-secondary btn-sm" onclick="galaxy_submit('systemRight')"><i
                                        class="fas fa-arrow-right"></i></a>
                        </div>

                        <h3>{$LNG.gl_solar_system} {$galaxy}:{$system}</h3>
                        <div class="solar-system d-none">
                        <div class="sun"><img src="{$dpath}/img/sun.gif" /></div>
                        {for $planet=1 to $max_planets}
                            <div class="planet-ring planet-ring-{$planet}"></div>

                            {if !isset($GalaxyRows[$planet])}
                                <div class="planet planet-{$planet}">
                                <a href="?page=fleetTable&amp;galaxy={$galaxy}&amp;system={$system}&amp;planet={$planet}&amp;planettype=1&amp;target_mission=7">{$planet}</a>
                                </div>
                            {elseif $GalaxyRows[$planet] === false}
                                {$LNG.gl_planet_destroyed}
                                {else}
                            {$currentPlanet = $GalaxyRows[$planet]}
                                <a class="tooltip_sticky planet planet-{$planet}"
                                   data-tooltip-content="{include "planet.actions.tpl"}">
                                    <img src="{$dpath}planeten/{$currentPlanet.planet.image}.jpg"
                                         height="30" width="30" alt="">
                                </a>

                                {/if}
                        {/for}
                        </div>
                        <table class="table table-striped">
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
                                                <a href="javascript:doit(6,{$currentPlanet.planet.id},{$spyShips|json|escape:'html'})">
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
                    </div>
                </form>
            </div>
        </div>
        {if $action == 'sendMissle'}
            <div class="col">
                <div class="card">
                    <form action="?page=fleetMissile" method="post">
                        <input type="hidden" name="galaxy" value="{$galaxy}">
                        <input type="hidden" name="system" value="{$system}">
                        <input type="hidden" name="planet" value="{$target_planet}">
                        <input type="hidden" name="type" value="{$type}">

                        <div class="card-header">
                            <h2 class="card-title">{$LNG.gl_missil_launch}</h2>
                            <small class="card-subtitle">[{$galaxy}:{$system}:{$target_planet}]</small>
                        </div>
                        <div class="card-body">
                            <div class="mb-2">
                                <label class="form-label" for="id_missile_count">{$missile_count}</label>
                                <input type="number" name="SendMI" size="2" maxlength="7" class="form-control">
                            </div>
                            <div class="mb-2">
                                <label class="form-label" for="id_objective">{$LNG.gl_objective}</label>
                                {html_options name=Target options=$missileSelector id="id_objective"}
                            </div>
                        </div>
                        <div class="card-footer">
                            <input class="btn btn-danger" type="submit" value="{$LNG.gl_missil_launch_action}">
                        </div>
                </div>
            </div>
        {/if}
    </div>
    <script type="text/javascript">
        status_ok = '{$LNG.gl_ajax_status_ok}';
        status_fail = '{$LNG.gl_ajax_status_fail}';
        MaxFleetSetting = {$settings_fleetactions};
    </script>
{/block}
