{block name="title" prepend}{$LNG.lm_buildings}{/block}
{block name="content"}
    {include "messages.partial.tpl"}
    <!-- building queue-->
    {if !empty($Queue)}
        <div id="buildlist" class="infos1">
            {foreach $Queue as $List}
                {$ID = $List.element}
                {if $List@first}
                    <div id="progressbar" data-time="{$List.resttime}"></div>
                {/if}
                <div class="d-flex justify-content-between alert {if $List@first}alert-info{else}alert-secondary{/if}">
                    <span>{$List@iteration}.: {$LNG.tech.{$ID}} {$List.level}{if $List.destroy} {$LNG.bd_dismantle}{else} {$LNG.bd_build}{/if}</span>
                    <div id="time" data-time="{$List.time}"><br></div>
                    <span data-time="{$List.endtime}" class="timer d-none d-md-inline-block">{$List.display}</span>

                    {if !($isBusy.research && ($ID == 6 || $ID == 31)) && !($isBusy.shipyard && ($ID == 15 || $ID == 21)) && $RoomIsOk && $CanBuildElement && $BuildInfoList[$ID].buyable}
                        <form class="d-inline-block build_form d-none d-md-inline-block" action="game.php?page=buildings" method="post">
                            <input type="hidden" name="cmd" value="insert">
                            <input type="hidden" name="building" value="{$ID}">
                            <button type="submit" class="build_submit onlist btn btn-success">{$LNG.tech.{$ID}} {$List.level+1}{if $List.destroy} {$LNG.bd_dismantle}{else} {$LNG.bd_build}{/if}</button>
                        </form>
                    {/if}
                    <form action="game.php?page=buildings" method="post" class="build_form">
                        <input type="hidden" name="cmd" value="remove">
                        <input type="hidden" name="listid" value="{$List@iteration}">
                        <button type="submit" class="build_submit onlist btn btn-danger">{$LNG.bd_cancel}</button>
                    </form>
                </div>
            {/foreach}
        </div>
    {/if}
    <!-- /building queue-->
    <div class="planeto bg-light rounded mb-2">
        <a class="btn btn-toggle btn-primary" data-bs-toggle="collapse"
           data-bs-target=".mining">{$LNG.build_toggle_mining}</a>
        |
        <a class="btn btn-toggle btn-primary" data-bs-toggle="collapse"
           data-bs-target=".non-mining">{$LNG.build_toggle_other}</a>
        |
        <a class="btn btn-toggle btn-primary" data-bs-toggle="collapse"
           data-bs-target=".building">{$LNG.build_toggle_all}</a>
        |
        <a class="btn btn-toggle btn-primary" data-bs-toggle="collapse"
           data-bs-target=".buyable">{$LNG.build_toggle_buyable}</a>
        |
        <a class="btn btn-toggle btn-primary" data-bs-toggle="collapse"
           data-bs-target=".non-buyable">{$LNG.build_toggle_non_buyable}</a>
    </div>
    <div class="row row-cols-1 row-cols-md-2 row-cols-xl-4 g-2 build-gutter">
        {foreach $BuildInfoList as $ID => $Element}
            <!-- mines? -->
            <div class="col collapse show {if $ID|in_array:[1,2,3,4,12,22,23,24]}mining{else}non-mining{/if} building {if !$Element.buyable}non-buyable{else}buyable{/if}">
                <div class="card">
                    <div class="card-header">
                       <h6 class="card-title" onclick="return Dialog.info({$ID})">{$LNG.tech.{$ID}}
                           <small class="card-subtitle">{if $Element.level > 0} ({$LNG.bd_lvl} {$Element.level}{if $Element.maxLevel != 255}/{$Element.maxLevel}{/if}){/if}</small>
                       </h6>
                    </div>

                    <a href="#" onclick="return Dialog.info({$ID})">
                        <img class="card-img-top" src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}">
                    </a>
                    <div class="card-body">
                        <!-- missing ress -->
                        {if !$Element.buyable}
                            <ul class="list-group">
                                <li class="list-group-item">{$LNG.bd_remaining}</li>
                                {foreach $Element.costOverflow as $ResType => $ResCount}
                                    {if $ResCount > 0}
                                    <li class="list-group-item" onclick="return Dialog.info({$ResType});"
                                        data-bs-toggle="tooltip" data-bs-placement="top"
                                        title="{$LNG.tech.{$ResType}}: {$LNG.shortDescription.$ResType}">{$LNG.tech.{$ResType}}</a>
                                        : <span style="font-weight:700">{$ResCount|number}</span></li>
                                    {/if}
                                {/foreach}
                            </ul>
                        {/if}
                        {$LNG.bd_next_level_cost}<br/>

                        <ul class="list-group">
                        {foreach $Element.costResources as $RessID => $RessAmount}
                            <li class="list-group-item" onclick="return Dialog.info({$RessID});"
                                data-bs-toggle="tooltip"
                                title="{$LNG.tech.{$RessID}}: {$LNG.shortDescription.$RessID}">{$LNG.tech.{$RessID}}</a>
                                <strong><span
                                            style="color:{if $Element.costOverflow[$RessID] == 0}darkgreen{else}darkred{/if}">{$RessAmount|number}</span></strong>
                            </li>
                            {/foreach}
                            {if !empty($Element.infoEnergy)}
                                <li class="list-group-item">{$Element.infoEnergy}</li>
                            {/if}
                            <li class="list-group-item">{$LNG.fgf_time}: {$Element.elementTime|time}</li>
                        </ul>
                    </div>
                    <div class="card-footer">
                        {if $Element.maxLevel == $Element.levelToBuild}
                            <span>{$LNG.bd_maxlevel} || <button>End Game</button></span>
                        {elseif ($isBusy.research && ($ID == 6 || $ID == 31)) || ($isBusy.shipyard && ($ID == 15 || $ID == 21))}
                            <span>{$LNG.bd_working}</span>
                        {else}
                            {if $RoomIsOk}
                                {if $CanBuildElement && $Element.buyable}
                                    <form action="game.php?page=buildings" method="post" class="build_form">
                                        <input type="hidden" name="cmd" value="insert">
                                        <input type="hidden" name="building" value="{$ID}">
                                        <button type="submit"
                                                class="build_submit btn btn-primary">{if $Element.level == 0 && $Element.levelToBuild == 0}{$LNG.bd_build}{else}{$LNG.bd_build_next_level}{$Element.levelToBuild + 1}{/if}</button>
                                    </form>
                                {else}
                                    <span class="btn btn-primary disabled">{if $Element.level == 0 && $Element.levelToBuild == 0}{$LNG.bd_build}{else}{$LNG.bd_build_next_level}{$Element.levelToBuild + 1}{/if}</span>
                                {/if}
                            {else}
                                <span>{$LNG.bd_no_more_fields}</span>
                            {/if}
                        {/if}
                        {if $Element.level > 0}
                            {if $ID == 43}<a href="#"
                                             onclick="return Dialog.info({$ID})">{$LNG.bd_jump_gate_action}</a>{/if}
                        {else}

                        {/if}
                    </div>
                </div>
            </div>
        {/foreach}
    </div>
{/block}
