<nav class="navbar navbar-expand navbar-dark fixed-top bg-dark">
    <div class="container-fluid">
        <button id="navToggler" class="d-inline-block d-md-none btn-sm btn btn-outline-secondary" type="button">
            <span class="navbar-toggler-icon"></span>
        </button>
        <script>
            document.getElementById("navToggler").onclick = function(item) {
                document.querySelector("body").classList.toggle("show_menu");
            }
        </script>
        <a href="game.php?page=overview" class="navbar-brand d-none d-md-inline-block">
            <img src="{$dpath}planeten/{$image}.jpg" width="50" height="50"
                 alt="{$LNG.lm_overview}"></a>
        <a class="navbar-brand d-none d-md-inline-block" href="game.php?page=overview">Quest of Galaxy</a>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <div class="d-flex flex-grow-1">
                <ul class="navbar-nav me-auto mb-2 mb-md-0">
                    {foreach $resourceTable as $resourceID => $resourceData}
                        <li class="nav-item res-item">
                            <a {if (!$resourceID|in_array:[921,911])}title="{$resourceData.production|number}/h"{/if} class="nav-link {if (!$resourceID|in_array:[921,911] and $resourceData.max <= $resourceData.current) or ($resourceID==911 and $resourceData.max+$resourceData.used<0)}text-danger{/if}" href="#" onclick="return Dialog.info({$resourceID});">
                                <img src="{$dpath}images/{$resourceData.name}.gif">
                                <span class="d-lg-block d-none">{$LNG.tech.$resourceID}</span>
                                {if $resourceID == 911} <!-- energy -->
                                    {$resourceData.currentt = $resourceData.max + $resourceData.used}
                                    <span title="{$resourceData.currentt|number}">
                                        <span{if $resourceData.currentt < 0} style="color:red"{/if}>{if $resourceData.currentt > 0}+{$resourceData.currentt|number}{else}-{-$resourceData.currentt|number}{/if}</span>
                                    </span>
                                {else}
                                    <span class="res_current" id="current_{$resourceData.name}" data-real="{$resourceData.current}">
                                        {$resourceData.current|number}
                                    </span>
                                {if $resourceID != 921} <!-- not dark matter --> / <span class="res_max" id="max_{$resourceData.name}"
                                          data-real="{$resourceData.current}">{$resourceData.max|number}</span>
                                {/if}
                                {/if}
                            </a>
                        </li>
                    {/foreach}

                </ul>
                <ul class="navbar-nav ms-auto flex-nowrap">

                    {if isModuleAvailable($smarty.const.MODULE_BUILDING)}<li class="d-none d-md-inline-block nav-item"><a class="mt-2 nav-link link-dark rounded" href="game.php?page=buildings" title="{$LNG.lm_buildings}"><i class="fs-2 fas fa-hammer"></i></a></li>{/if}
                    {if isModuleAvailable($smarty.const.MODULE_SHIPYARD_FLEET)}<li class="d-none d-md-inline-block nav-item"><a class="mt-2 nav-link link-dark rounded" href="game.php?page=shipyard&amp;mode=fleet" title="{$LNG.lm_shipshard}"><i class="fs-2 fas fa-space-shuttle"></i></a></li>{/if}
                    {if isModuleAvailable($smarty.const.MODULE_SHIPYARD_DEFENSIVE)}<li class="d-none d-md-inline-block nav-item"><a class="mt-2 nav-link link-dark rounded" href="game.php?page=shipyard&amp;mode=defense" title="{$LNG.lm_defenses}"><i class="fs-2 fas fa-shield-alt"></i></a></li>{/if}
                    {if isModuleAvailable($smarty.const.MODULE_RESEARCH)}<li class="d-none d-md-inline-block nav-item"><a class="mt-2 nav-link link-dark rounded" href="game.php?page=research" title="{$LNG.lm_research}"><i class="fs-2 fas fa-flask"></i></a></li>{/if}
                    <li class="nav-item ps-4 fs-1" title=""></li>

                    <li class="nav-item pe-2 pt-2 d-none d-md-inline-block ">
                        <select id="planetSelector" class="form-control">
                            {html_options options=$PlanetSelect selected=$current_pid}
                        </select>
                    </li>
                    <li class="nav-item">
                        <div class="dropdown">
                            <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                                <img src="{$avatar}" alt="" width="50" height="50" class="rounded-circle me-2 d-none d-md-inline-block ">
                                <strong>{$username}</strong>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-dark text-small shadow" aria-labelledby="dropdownUser1">
                                {if isModuleAvailable($smarty.const.MODULE_MESSAGES)}<li class="nav-item"><a class="nav-link" href="game.php?page=messages&amp;category=100">{$LNG.lm_messages}{nocache}{if $new_message > 0}<span id="newmes"> (<span id="newmesnum">{$new_message}</span>)</span>{/if}{/nocache}</a></li>{/if}
                                <li class="nav-item"><a class="nav-link" href="game.php?page=settings">{$LNG.lm_options}</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li class="nav-item"><a class="nav-link" href="game.php?page=logout">{$LNG.lm_logout}</a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>

</nav>


<div class="planetImage no-mobile">
</div>


{if !$vmode}
    <script type="text/javascript">
        var viewShortlyNumber = {$shortlyNumber|json};
        var vacation = {$vmode};
        $(function () {
            {foreach $resourceTable as $resourceID => $resourceData}
            {if isset($resourceData.production)}
            resourceTicker({
                available: {$resourceData.current|json},
                limit: [0, {$resourceData.max|json}],
                production: {$resourceData.production|json},
                valueElem: "current_{$resourceData.name}"
            }, true);
            {/if}
            {/foreach}
        });
    </script>
    <script src="scripts/game/topnav.js"></script>
    {if $hasGate}
        <script src="scripts/game/gate.js"></script>
    {/if}
{/if}