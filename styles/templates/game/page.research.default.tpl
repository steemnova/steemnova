{block name="title" prepend}{$LNG.lm_research}{/block}
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
                    <span>{$List@iteration}.: {$LNG.tech.{$ID}} {$LNG.bd_tech_next_level} {$List.level}</span>
                    <div id="time" data-time="{$List.time}"><br></div>
                    <span data-time="{$List.endtime}" class="timer">{$List.display}</span>
                    {if isset($ResearchList[$List.element])}
                        {$CQueue = $ResearchList[$List.element]}
                    {/if}
                    {if isset($CQueue) && $CQueue.maxLevel != $CQueue.level && !$IsFullQueue && $CQueue.buyable}
                        <form class="d-inline-block build_form" action="game.php?page=research" method="post">
                            <input type="hidden" name="cmd" value="insert">
                            <input type="hidden" name="building" value="{$ID}">
                            <button type="submit" class="build_submit onlist btn btn-success">{$LNG.tech.{$ID}} {$LNG.bd_tech_next_level} {$List.level+1}</button>
                        </form>
                    {/if}
                    <form action="game.php?page=research" method="post" class="build_form">
                        <input type="hidden" name="cmd" value="cancel">
                        <button type="submit" class="build_submit onlist btn btn-danger">{$LNG.bd_cancel}</button>
                    </form>
                </div>
            {/foreach}
        </div>
    {/if}

    <!-- end queue -->

    <!-- what is this for? -->
    {if $IsLabinBuild}
        <div class="alert alert-info">{$LNG.bd_building_lab}</div>{/if}
    <div class="planeto rounded bg-light mb-2">
        <a class="btn btn-toggle btn-primary" data-bs-toggle="collapse"
           data-bs-target=".imperial">{$LNG.research_toggle_imperial}</a> |
        <a class="btn btn-toggle btn-primary" data-bs-toggle="collapse"
           data-bs-target=".military">{$LNG.research_toggle_military}</a> |
        <a class="btn btn-toggle btn-primary" data-bs-toggle="collapse"
           data-bs-target=".engine">{$LNG.research_toggle_engine}</a> |
        <a class="btn btn-toggle btn-primary" data-bs-toggle="collapse"
           data-bs-target=".mining">{$LNG.research_toggle_mining}</a>
    </div>
    <div class="row row-cols-1 row-cols-md-2 row-cols-xl-4 g-2 build-gutter">
        {foreach $ResearchList as $ID => $Element}
            <div id="t{$ID}" class="col collapse show {if !$Element.buyable}non-buyable{else}buyable{/if} {if $ID|in_array:[106, 108, 113, 114, 123, 124, 199]}imperial{elseif $ID|in_array:[121, 129, 120]}military{elseif $ID|in_array:[115, 117, 118]}engine{else}mining{/if}">
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
                            <span class="btn btn-success disabled">{$LNG.bd_maxlevel}</span>
                        {elseif $IsLabinBuild || $IsFullQueue || !$Element.buyable}
                            <span class="btn btn-secondary disabled">{if $Element.level == 0 && $Element.levelToBuild == 0}{$LNG.bd_tech}{else}{$LNG.bd_tech_next_level}{$Element.levelToBuild + 1}{/if}</span>
                        {else}
                            <form action="game.php?page=research" method="post" class="build_form">
                                <input type="hidden" name="cmd" value="insert">
                                <input type="hidden" name="tech" value="{$ID}">
                                <button type="submit" class="build_submit btn btn-primary">{if $Element.level == 0 && $Element.levelToBuild == 0}{$LNG.bd_tech}{else}{$LNG.bd_tech_next_level}{$Element.levelToBuild + 1}{/if}</button>
                            </form>
                        {/if}
                        {if $Element.level > 0}
                            {if $ID == 43}<a href="#" onclick="return Dialog.info({$ID})">{$LNG.bd_jump_gate_action}</a>{/if}
                        {else}

                        {/if}
                    </div>
                </div>
            </div>
        {/foreach}
    </div>
{/block}
{block name="script" append}
    {if !empty($Queue)}
        <script src="scripts/game/research.js"></script>
    {/if}
{/block}
