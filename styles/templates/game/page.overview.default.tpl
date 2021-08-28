{block name="title" prepend}{$LNG.lm_overview}{/block}
{block name="content"}
    {include "messages.partial.tpl"}

    <div class="row row-cols-1 row-cols-lg-2 g-4">
        <div class="col mb-2">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">{$LNG.lm_overview}</h2>
                </div>
                <div class="card-body">
                    {$LNG.ov_server_time}:
                    <span class="servertime">{$servertime}</span>
                    <br/>
                    {$LNG.ov_admins_online}
                    :&nbsp;{foreach $AdminsOnline as $ID => $Name}{if !$Name@first}&nbsp;&bull;&nbsp;{/if}
                    <a href="#" onclick="return Dialog.PM({$ID})">{$Name}</a>{foreachelse}{/foreach}
                    <br/>
                    {$LNG.ov_online}
                    {$usersOnline} {$LNG.ov_players}<br/>
                    {$fleetsOnline} {$LNG.ov_moving_fleets}<br/>
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
                    <h2>{$LNG.in_units}</h2>
                </div>
                <div class="card-body">
                    <h5 class="card-subtitle mb-2">{$LNG.ov_fleet_incoming}</h5>
                    <ul class="collapse show list-group" id="fleet-info">
                        {foreach $fleets as $index => $fleet}
                            <li class="list-group-item"><span id="fleettime_{$index}" class="fleets" data-fleet-end-time="{$fleet.returntime}" data-fleet-time="{$fleet.resttime}">{pretty_fly_time({$fleet.resttime})}</span>
                                <span id="fleettime_{$index}">{$fleet.text}</span>
                            </li>
                        {/foreach}
                    </ul>
                    <hr />
                    <h5 class="card-subtitle mb-2">{$LNG.ov_fleet_planet}</h5>
                    <div class="d-flex w-100">
                    <ul class="list-group flex-grow-1">
                        <li class="list-group-item"><a class="nav-link" href="game.php?page=shipyard&amp;mode=fleet">{$LNG.lm_fleet}</a></li>
                        {foreach $offMissiles as $ID => $amount}
                            {if $amount > 0}
                                <li class="list-group-item d-flex justify-content-between align-items-center"><span class="badge bg-primary rounded-pill">{$amount|number}</span> <a href="#" onclick="return Dialog.info({$ID});">{$LNG.tech.{$ID}}</a></li>
                            {/if}
                        {/foreach}
                    </ul>
                    <ul class="list-group flex-grow-1">
                        <li class="list-group-item"><a class="nav-link" href="game.php?page=shipyard&amp;mode=defense">{$LNG.lm_defenses}</a></li>
                        {foreach $defMissiles as $ID => $amount}
                            {if $amount > 0}
                                <li class="list-group-item d-flex justify-content-between align-items-center"> <span class="badge bg-info rounded-pill">{$amount|number}</span> <a href="#" onclick="return Dialog.info({$ID});">{$LNG.tech.{$ID}}</a></li>
                            {/if}
                        {/foreach}
                    </ul>
                    </div>
                </div>
                <div class="card-footer">
                    <button class="btn btn-sm btn-info" data-bs-target="#fleet-info"
                            data-bs-toggle="collapse">{$LNG.toggle_fleets}</button>

                </div>
            </div>
        </div>

        <div class="col">
            <div class="card">
                <div class="card-header">
                    <div class="float-end">
                        <a class="btn btn-primary" onclick="return Dialog.PlanetAction();"
                           title="{$LNG.ov_planetmenu}">Edit</a>
                    </div>
                    <h2>{$LNG["type_planet_{$planet_type}"]} {$planetname}</h2>
                </div>
                <div class="card-body d-flex">
                    <div class="d-inline-block">
                        <img style="float: left;" src="{$dpath}planeten/{$planetimage}.jpg" height="200" width="200"
                             alt="{$planetname}">
                    </div>
                    <div class="d-inline-block ps-1 flex-grow-1">
                        <ul class="list-group">
                        {if $buildInfo.buildings}
                            <li class="list-group-item list-group-item-warning"><a href="game.php?page=buildings">{$LNG.lm_buildings}:</a> {$LNG.tech[$buildInfo.buildings['id']]} ({$buildInfo.buildings['level']})
                                <span class="timer float-end" data-time="{$buildInfo.buildings['timeleft']}"></span></li>
                        {else}
                            <li class="list-group-item list-group-item-success"><a href="game.php?page=buildings">{$LNG.lm_buildings}
                                : {$LNG.ov_free}</a></li>
                        {/if}
                        {if $buildInfo.tech}
                            <li class="list-group-item list-group-item-warning"><a href="game.php?page=research">{$LNG.lm_research}:</a> {$LNG.tech[$buildInfo.tech['id']]} ({$buildInfo.tech['level']})

                            <span class="timer float-end" data-time="{$buildInfo.tech['timeleft']}"></span></li>
                                {else}
                            <li class="list-group-item list-group-item-success"><a href="game.php?page=research">{$LNG.lm_research}: {$LNG.ov_free}</a></li>
                        {/if}
                        {if $buildInfo.fleet}
                            <li class="list-group-item list-group-item-warning"><a href="game.php?page=shipyard&amp;mode=fleet">{$LNG.lm_shipshard}:</a> {$LNG.tech[$buildInfo.fleet['id']]} ({$buildInfo.fleet['level']})
                                <span class="timer float-end" data-time="{$buildInfo.fleet['timeleft']}"></span></li>
                                {else}
                            <li class="list-group-item list-group-item-success"><a href="game.php?page=shipyard&amp;mode=fleet">{$LNG.lm_shipshard}: {$LNG.ov_free}</a></li>
                        {/if}
                            <li class="list-group-item {if $planet_coins > 0}list-group-item-danger{/if}">{$LNG.cuneros_coins}: {$planet_coins|number_format}{if $planet_coins > 0}<a class="btn btn-primary btn-sm float-end json-request" data-href="game.php?page=overview&amp;mode=claim_coins">{$LNG.cuneros_claim}</a>{/if}</li>
                        </ul>
                        <br>
                        {$LNG.ov_diameter}: {$planet_diameter} {$LNG.ov_distance_unit} (<a
                                title="{$LNG.ov_developed_fields}">{$planet_field_current}</a> / <a
                                title="{$LNG.ov_max_developed_fields}">{$planet_field_max}</a> {$LNG.ov_fields})
                        <br>{$LNG.ov_temperature}
                        : {$LNG.ov_aprox} {$planet_temp_min}{$LNG.ov_temp_unit} {$LNG.ov_to} {$planet_temp_max}{$LNG.ov_temp_unit}
                        <br>{$LNG.ov_position}: <a
                                href="game.php?page=galaxy&amp;galaxy={$galaxy}&amp;system={$system}">[{$galaxy}
                            :{$system}
                            :{$planet}]</a>

                    </div>
                </div>
            </div>
        </div>
        {if $Moon}
            <div class="col">
                <div class="card">
                    <div class="card-header">
                        <h2>{$LNG.fcm_moon}</h2>
                    </div>
                    <div class="card-body">
                        <div class="moon">
                            <a href="game.php?page=overview&amp;cp={$Moon.id}&amp;re=0" title="{$Moon.name}">
                                <img src="{$dpath}planeten/mond.jpg" height="100" width="100 "
                                     alt="{$Moon.name} ({$LNG.fcm_moon})"></a><br/>
                            {$Moon.name} ({$LNG.fcm_moon})
                        </div>
                    </div>
                </div>
            </div>
        {/if}

        {if $AllPlanets}
            <div class="col">
                <div class="card">
                    <div class="card-header">
                        <h2 class="card-title">{$LNG.lv_planet}</h2>
                    </div>
                    <div class="card-body">
                        {foreach $AllPlanets as $PlanetRow}
                            {if ($PlanetRow@iteration % $themeSettings.PLANET_ROWS_ON_OVERVIEW) === 1}{/if}
                            <div class="planetl">
                                <a href="game.php?page=overview&amp;cp={$PlanetRow.id}" title="{$PlanetRow.name}">
                                    <img src="{$dpath}planeten/{$PlanetRow.image}.jpg" width="100" height="100"
                                                                                   alt="{$PlanetRow.name}"><br />
                                    {$PlanetRow.name}
                                </a>
                                <br>{$PlanetRow.build}<br>
                            </div>
                        {/foreach}
                    </div>
                </div>
            </div>
        {/if}
    </div>
{/block}
{block name="script" append}
    <script src="scripts/game/overview.js?2"></script>
{/block}
