{block name="title" prepend}{$LNG.lm_galaxy}{/block}
{block name="content"}
    {include "fleet.modal.tpl"}
    <div class="row row-cols-1 row-cols-xl-2 g-4">
        <div class="col mb-2">
            <div class="card">
                <form action="?page=galaxy" method="post" id="galaxy_form">
                    <input type="hidden" id="auto" value="dr">
                    <div class="card-header">
                        <div class="btn-group btn-group-sm ms-4 float-end">
                            <div class="btn btn-primary" onclick="switchLayout();">{$LNG.toggle_view}</div>
                        </div>
                        <h2 class="card-title">{$LNG.gl_galaxy}</h2>
                        <h5 class="card-subtitle"><span id="slots">{$maxfleetcount}</span>/{$fleetmax} {$LNG.gl_fleets}
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="btn-group btn-group-sm">
                            <div class="btn btn-primary">{$LNG.gl_galaxy}</div>
                            <a class="btn btn-primary btn-sm" onclick="galaxy_submit('galaxyLeft')"><i
                                        class="fas fa-arrow-left"></i></a>
                            <select name="galaxy" class="form-control form-control-sm btn btn-primary" onchange="$('#galaxy_form').submit();">
                                {for $sysCount=1 to $max_galaxies}
                                    <option value="{$sysCount}" {if $sysCount == $galaxy}selected{/if}>{$sysCount}</option>
                                {/for}
                            </select>

                            <a class="btn btn-primary btn-sm" onclick="galaxy_submit('galaxyRight')"><i
                                        class="fas fa-arrow-right"></i></a>
                        </div>

                        <div class="btn-group btn-group-sm float-end">
                            <div class="btn btn-secondary">{$LNG.gl_solar_system}</div>
                            <a class="btn btn-secondary btn-sm" onclick="galaxy_submit('systemLeft')"><i
                                        class="fas fa-arrow-left"></i></a>
                            <input type="hidden" name="system" value="{$system}">

                            <select name="system" class="form-control form-control-sm btn btn-secondary" onchange="$('#galaxy_form').submit();">
                            {for $sysCount=1 to $max_systems}
                                <option value="{$sysCount}" {if $sysCount == $system}selected{/if}>{$sysCount}</option>
                            {/for}
                            </select>
                            <a class="btn btn-secondary btn-sm" onclick="galaxy_submit('systemRight')"><i
                                        class="fas fa-arrow-right"></i></a>
                        </div>

                        <h3>{$LNG.gl_solar_system} {$galaxy}:{$system}</h3>
                        {include "galaxy.circle.view.tpl"}
                        {include "galaxy.table.view.tpl"}
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
                    </form>
                </div>
            </div>
        {/if}
    </div>
    <script type="text/javascript">
        status_ok = '{$LNG.gl_ajax_status_ok}';
        status_fail = '{$LNG.gl_ajax_status_fail}';
        MaxFleetSetting = {$settings_fleetactions};

        function loadLayout() {
            let ls = window.localStorage.getItem("qog_galaxy_style");
            if (!ls || ls !== "table") {
                document.querySelector("#solar-system-view").classList.remove("d-none");
                document.querySelector("#table-view").classList.add("d-none");
                window.localStorage.setItem("qog_galaxy_style", "solar");
            } else {
                document.querySelector("#solar-system-view").classList.add("d-none");
                document.querySelector("#table-view").classList.remove("d-none");
                window.localStorage.setItem("qog_galaxy_style", "table");
            }
        }

        function switchLayout() {
            if (window.localStorage.getItem("qog_galaxy_style") === "table") {
                window.localStorage.setItem("qog_galaxy_style", "solar");
            } else {
                window.localStorage.setItem("qog_galaxy_style", "table");
            }
            loadLayout();
        }

        loadLayout();
    </script>
{/block}
