{block name="title" prepend}{$LNG.lm_fleet}{/block}
{block name="content"}
    <div class="col">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">
                    {$LNG.fl_send_fleet}
                </h2>
            </div>
            <div class="card-body">
                <ul class="nav nav-tabs px-3" id="myTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <a class="nav-link p-3 active"
                           id="tab-step1" data-bs-toggle="tab"
                           data-bs-target="#content-step1" type="button" role="tab"
                           aria-controls="content-step1"
                           aria-selected="true">{$LNG.fl_send_fleet}</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link p-3 disabled"
                           id="tab-step2" data-bs-toggle="tab"
                           data-bs-target="#content-step2" type="button" role="tab"
                           aria-controls="content-step2"
                           aria-selected="true">{$LNG.fl_mission}</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link p-3 disabled"
                           id="tab-step3" data-bs-toggle="tab"
                           data-bs-target="#content-step3" type="button" role="tab"
                           aria-controls="content-step3"
                           aria-selected="true">{$LNG.fl_send_fleet}</a>
                    </li>
                </ul>
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active"
                         id="content-step1" role="tabpanel" aria-labelledby="tab-step1">
                        {include 'page.newfleet.step1.tpl'}
                    </div>
                </div>

                {if $ACSList}
                    <table class="table519" style="table-layout: fixed;">
                        <tr>
                            <th colspan="{$themeSettings.COLONY_ROWS_ON_FLEET1}">{$LNG.fl_acs_title}</th>
                        </tr>
                        {foreach $ACSList as $ACSRow}
                            {if ($ACSRow@iteration % $themeSettings.ACS_ROWS_ON_FLEET1) === 1}<tr>{/if}
                            <tr>
                                <td>
                                    <a href="javascript:setACSTarget({$ACSRow.galaxy},{$ACSRow.system},{$ACSRow.planet},{$ACSRow.planet_type},{$ACSRow.id});">{$ACSRow.name}
                                        - [{$ACSRow.galaxy}:{$ACSRow.system}:{$ACSRow.planet}]</a></td>
                            </tr>
                            {if $ACSRow@last && ($ACSRow@iteration % $themeSettings.ACS_ROWS_ON_FLEET1) !== 0}
                                {$to = $themeSettings.ACS_ROWS_ON_FLEET1 - ($ACSRow@iteration % $themeSettings.ACS_ROWS_ON_FLEET1)}
                                {for $foo=1 to $to}
                                    <td>&nbsp;</td>
                                {/for}
                            {/if}
                            {if ($ACSRow@iteration % $themeSettings.ACS_ROWS_ON_FLEET1) === 0}</tr>{/if}
                        {/foreach}
                    </table>
                {/if}
            </div>
        </div>
    </div>
    <script type="text/javascript">
        data = {$fleetdata|json};
        shortCutRows = {$themeSettings.SHORTCUT_ROWS_ON_FLEET1};
        fl_no_shortcuts = '{$LNG.fl_no_shortcuts}';
    </script>
{/block}
