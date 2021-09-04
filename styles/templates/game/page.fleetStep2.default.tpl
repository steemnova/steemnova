{block name="title" prepend}{$LNG.lm_fleet}{/block}
{block name="content"}
    <form action="game.php?page=fleetStep3" method="post">
        <input type="hidden" name="token" value="{$token}">
        <div class="row row-cols-1 row-cols-md-2 row-cols-xl-2 g-2 ">
            <div class="col">
                <div class="card">
                    <div class="card-header">
                        <h3>{$LNG.fl_mission}: {$galaxy}:{$system}:{$planet} - {$LNG["type_planet_{$type}"]}</h3>
                    </div>
                    <div class="card-body">
                        <div class="btn-group-vertical w-75">
                            {foreach $MissionSelector as $MissionID}
                                <input type="radio" value="{$MissionID}" class="btn-check" name="mission"
                                       id="radio_{$MissionID}" autocomplete="off" onclick="toggleInfo({$MissionID});"
                                       {if $mission == $MissionID || (!isset($mission) && $MissionID@iteration == 1)}checked="checked"{/if}>
                                <label class="btn btn-outline-dark"
                                       for="radio_{$MissionID}">{$LNG["type_mission_{$MissionID}"]}</label>
                            {/foreach}
                        </div>

                        <hr/>
                        {if $StaySelector}
                            <label for="id-stay" class="form-label">{$LNG.fl_hold_time}</label>
                            {html_options name=staytime options=$StaySelector id="id-stay"} {$LNG.fl_hours}
                        {/if}
                    </div>
                    <div class="card-footer">
                        {if $own_ally}
                            <div class="d-none info-warn mission-1 p-1 alert alert-warning">{$LNG.attack_own_ally}</div>
                        {/if}
                        <div class="d-none info-warn mission-17 p-1 alert alert-warning">{$LNG.fl_transfer_alert_message}</div>
                        <div class="d-none info-warn mission-15 p-1 alert alert-warning">{$LNG.fl_expedition_alert_message}</div>
                        <div class="d-none info-warn mission-11 p-1 alert alert-warning">{$LNG.fl_dm_alert_message}</div>
                        {if $max_planet_exceeded}
                            <div class="d-none info-warn mission-7 p-1 alert alert-warning">{sprintf($LNG.fl_colonize_alert_message, $min_astro_level)}</div>
                        {/if}
                        {if $colonize_notech}
                            <div class="d-none info-warn mission-7 p-1 alert alert-danger">{sprintf($LNG.fl_colonize_alert_message_tech, $min_astro_level)}</div>
                        {/if}

                        <input value="{$LNG.fl_continue}" type="submit" class="btn btn-primary float-end"/>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card">
                    <div class="card-header">
                        <h3>{$LNG.fl_resources}</h3>
                    </div>
                    <div class="card-body">
                        {for $ElementID=901 to 903}
                            {if $ElementID == 901}
                                {$resource="metal"}
                            {elseif $ElementID == 902}
                                {$resource="crystal"}
                            {elseif $ElementID == 903}
                                {$resource="deuterium"}
                            {/if}
                            <div class="row">
                                <div class="col">
                                    <label class="form-label" for="id-{$ElementID}">{$LNG.tech.$ElementID}</label>
                                </div>
                                <div class="col">
                                    <input name="{$resource}" id="id-{$ElementID}" size="10"
                                           class="form-control d-inline-block w-75"
                                           onchange="calculateTransportCapacity();" type="number">
                                    <a href="javascript:maxResource('{$resource}');"
                                       class="btn btn-secondary btn-sm">{$LNG.fl_max}</a>
                                </div>
                            </div>
                        {/for}
                    </div>


                </div>
            </div>

            {if $Exchange}
                <div class="col">
                    <div class="card">
                        <div class="card-header">
                            <h3>{$LNG.fl_exchange}</h3>
                        </div>
                        <div class="card-body">
                            <select name="resEx">
                                <option value="1">{$LNG.tech.901}</option>
                                <option value="2">{$LNG.tech.902}</option>
                                <option value="3">{$LNG.tech.903}</option>
                            </select>
                            <input name="exchange" size="10" type="number">
                            <hr/>
                            <span id="remainingresources"></span>
                            <label for="id-visibility" class="form-label">{$LNG.fl_visibility}</label>
                            <select name="visibility" id="id-visibility">
                                <option value="2" selected>{$LNG.fl_visibility_no_enemies}</option>
                                <option value="1">{$LNG.fl_visibility_alliance}</option>
                                <option value="0">{$LNG.fl_visibility_all}</option>
                            </select>
                            <label class="form-label" for="id-markettype">{$LNG.fl_market_type}</label>
                            <select name="markettype" id="id-markettype">
                                <option value="0" selected>{$LNG.fl_mt_resources}</option>
                                <option value="1">{$LNG.fl_mt_fleet}</option>
                            </select>
                        </div>
                    </div>
                </div>
            {/if}
        </div>
    </form>
    <script type="text/javascript">
        data = {$fleetdata|json};
    </script>
    <script>
        {literal}
        function toggleInfo(missionID) {
            document.querySelectorAll(".info-warn").forEach(function (item) {
                item.classList.add("d-none");
            });
            document.querySelectorAll(`.info-warn.mission-${missionID}`).forEach(function (item) {
                item.classList.remove("d-none");
            });
        }
        {/literal}
    </script>
{/block}
