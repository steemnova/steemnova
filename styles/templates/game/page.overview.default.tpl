{block name="title" prepend}{$LNG.lm_overview}{/block}
{block name="content"}
    {if $messages}
        <div class="alert alert-info"><a href="?page=messages">{$messages}</a></div>
    {/if}
    <div class="row row-cols-1 row-cols-md-2 g-4">
        <div class="col mb-2">
            <div class="card">
                <div class="card-header">
                    <div class="float-end">
                        <a class="btn btn-primary" onclick="return Dialog.PlanetAction();"
                           title="{$LNG.ov_planetmenu}">Edit</a>
                    </div>
                    <h2 class="card-title">{$LNG["type_planet_{$planet_type}"]} {$planetname}</h2>
                </div>
                <div class="card-body">
                    {$LNG.ov_server_time}:
                    <span class="servertime">{$servertime}</span>
                    <br/>
                    {$LNG.ov_admins_online}
                    :&nbsp;{foreach $AdminsOnline as $ID => $Name}{if !$Name@first}&nbsp;&bull;&nbsp;{/if}
                    <a href="#" onclick="return Dialog.PM({$ID})" style="color:lime">{$Name}</a>{foreachelse}{/foreach}
                    <br/>
                    {$LNG.ov_online}
                    <a style="color:lime">{$usersOnline}</a> {$LNG.ov_players}<br/>
                    <a style="color:lime">{$fleetsOnline}</a> {$LNG.ov_moving_fleets}<br/>
                    {$LNG.ov_points} {$rankInfo}<br/>
                    {if $is_news}
                        <div class="collapse" id="news">
                            {$LNG.ov_news}:&nbsp;{$news}
                        </div>
                    {/if}
                </div>
                <div class="card-footer">
                    <button class="btn btn-sm btn-info" data-bs-target="#news"
                            data-bs-toggle="collapse">{$LNG.toggle_news}</button>
                </div>
            </div>
        </div>
        <div class="col mb-2">
            <div class="card">
                <div class="card-header">
                    <h2>{$LNG.ov_events}</h2>
                </div>
                <div class="card-body">
                    <p class="card-text"></p>
                    <ul class="collapse show" id="fleet-info">
                        {foreach $fleets as $index => $fleet}
                            <li style="">
                        <span id="fleettime_{$index}" class="fleets"
                              data-fleet-end-time="{$fleet.returntime}"
                              data-fleet-time="{$fleet.resttime}">{pretty_fly_time({$fleet.resttime})}
		                </span>
                                <span id="fleettime_{$index}">{$fleet.text}</span>
                            </li>
                        {/foreach}
                    </ul>
                </div>
                <div class="card-footer">
                    <button class="btn btn-sm btn-info" data-bs-target="#fleet-info"
                            data-bs-toggle="collapse">{$LNG.toggle_fleets}</button>

                </div>
            </div>
        </div>
    </div>

    <div class="col">
        <div class="card">
            <div class="card-header">
                <h2>{$LNG.lm_overview}</h2>
            </div>
            <div class="card-body">
                {if $Moon}
                    <div class="moon"><a href="game.php?page=overview&amp;cp={$Moon.id}&amp;re=0" title="{$Moon.name}"><img
                                    src="{$dpath}planeten/mond.jpg" height="100" width="100"
                                    style="margin: 20% 0px 5px 0px;"
                                    alt="{$Moon.name} ({$LNG.fcm_moon})"></a><br>{$Moon.name} ({$LNG.fcm_moon})
                    </div>
                {/if}

                <div class="d-inline-block">
                    <img style="float: left;" src="{$dpath}planeten/{$planetimage}.jpg" height="200" width="200"
                         alt="{$planetname}">
                </div>
                <div class="d-inline-block ps-1">
                    {$planetname}<br>

                    {if $buildInfo.buildings}<a class="btn btn-sm btn-warning" href="game.php?page=buildings">{$LNG.lm_buildings}
                        : </a>{$LNG.tech[$buildInfo.buildings['id']]} ({$buildInfo.buildings['level']})
                        <br>
                        <div class="timer"
                             data-time="{$buildInfo.buildings['timeleft']}">{$buildInfo.buildings['starttime']}</div>{else}
                        <a class="btn btn-sm btn-success" href="game.php?page=buildings">{$LNG.lm_buildings}: {$LNG.ov_free}</a>
                        <br>
                    {/if}
                    {if $buildInfo.tech}<a class="btn btn-sm btn-warning" href="game.php?page=research">{$LNG.lm_research}
                        : </a>{$LNG.tech[$buildInfo.tech['id']]} ({$buildInfo.tech['level']})
                        <br>
                        <div class="timer"
                             data-time="{$buildInfo.tech['timeleft']}">{$buildInfo.tech['starttime']}</div>{else}<a
                            class="btn btn-sm btn-success" href="game.php?page=research">{$LNG.lm_research}: {$LNG.ov_free}</a>
                        <br>
                    {/if}
                    {if $buildInfo.fleet}<a class="btn btn-sm btn-warning" href="game.php?page=shipyard&amp;mode=fleet">{$LNG.lm_shipshard}
                    : </a>{$LNG.tech[$buildInfo.fleet['id']]} ({$buildInfo.fleet['level']})<br>
                    <div class="timer"
                         data-time="{$buildInfo.fleet['timeleft']}">{$buildInfo.fleet['starttime']}</div>{else}<a
                            class="btn btn-sm btn-success" href="game.php?page=shipyard&amp;mode=fleet">{$LNG.lm_shipshard}: {$LNG.ov_free}</a><br>{/if}
                    </br>
                    {$LNG.ov_diameter}: {$LNG.ov_distance_unit} (<a
                            title="{$LNG.ov_developed_fields}">{$planet_field_current}</a> / <a
                            title="{$LNG.ov_max_developed_fields}">{$planet_field_max}</a> {$LNG.ov_fields})
                    <br>{$LNG.ov_temperature}
                    : {$LNG.ov_aprox} {$planet_temp_min}{$LNG.ov_temp_unit} {$LNG.ov_to} {$planet_temp_max}{$LNG.ov_temp_unit}
                    <br>{$LNG.ov_position}: <a
                            href="game.php?page=galaxy&amp;galaxy={$galaxy}&amp;system={$system}">[{$galaxy}:{$system}
                        :{$planet}]</a>

                </div>
            </div>
        </div>
    </div>

    <div class="infos">
    </div>
    <br>
    <div class="infos">
        {if $AllPlanets}
            <div class="planeto">{$LNG.lv_planet}</div>
            {foreach $AllPlanets as $PlanetRow}
                {if ($PlanetRow@iteration % $themeSettings.PLANET_ROWS_ON_OVERVIEW) === 1}{/if}
                <div class="planetl"><a href="game.php?page=overview&amp;cp={$PlanetRow.id}"
                                        title="{$PlanetRow.name}"><img style="margin: 5px;"
                                                                       src="{$dpath}planeten/{$PlanetRow.image}.jpg"
                                                                       width="100" height="100"
                                                                       alt="{$PlanetRow.name}"></a><br>{$PlanetRow.name}
                    <br>{$PlanetRow.build}<br></div>
                {if $PlanetRow@last && $PlanetRow@total > 1 && ($PlanetRow@iteration % $themeSettings.PLANET_ROWS_ON_OVERVIEW) !== 0}
                    {$to = $themeSettings.PLANET_ROWS_ON_OVERVIEW - ($PlanetRow@iteration % $themeSettings.PLANET_ROWS_ON_OVERVIEW)}
                    {for $foo=1 to $to}

                    {/for}
                {/if}
                {if ($PlanetRow@iteration % $themeSettings.PLANET_ROWS_ON_OVERVIEW) === 0}</tr>{/if}
            {/foreach}

        {else}&nbsp;{/if}
    </div>
    </div>
    </div>

{/block}
{block name="script" append}
    <script src="scripts/game/overview.js"></script>
{/block}
