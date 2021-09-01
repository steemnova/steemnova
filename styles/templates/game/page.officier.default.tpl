{block name="title" prepend}{$LNG.lm_officiers}{/block}
{block name="content"}
    <div class="card">
        <ul class="nav nav-tabs px-3" id="myTab" role="tablist">
            {if !empty($darkmatterList)}
                <li class="nav-item" role="presentation">
                    <button class="nav-link p-3 active" id="tab-dark-matter" data-bs-toggle="tab"
                            data-bs-target="#content-dark-matter" type="button" role="tab"
                            aria-controls="content-dark-matter"
                            aria-selected="true">{$of_dm_trade}</button>
                </li>
            {/if}
            {if $officierList}
                <li class="nav-item" role="presentation">
                    <button class="nav-link p-3" id="tab-officer" data-bs-toggle="tab"
                            data-bs-target="#content-officer" type="button" role="tab"
                            aria-controls="content-officer"
                            aria-selected="true">{$LNG.of_offi}</button>
                </li>
            {/if}
        </ul>
        <div class="tab-content" id="myTabContent">
            {if !empty($darkmatterList)}
                <div class="tab-pane fade show active" id="content-dark-matter" role="tabpanel"
                     aria-labelledby="tab-dark-matter">
                    <div class="row row-cols-1 row-cols-md-2 row-cols-xl-4 g-2 build-gutter">
                        {foreach $darkmatterList as $ID => $Element}
                            <div class="col">
                                <div class="card">
                                    <div class="card-header">
                                        <h5 onclick="return Dialog.info({$ID});">{$LNG.tech.{$ID}}</h5>
                                    </div>
                                    <a href="#" onclick="return Dialog.info({$ID})">
                                        <img class="card-img-top" src="{$dpath}gebaeude/{$ID}.gif"
                                             alt="{$LNG.tech.{$ID}}">
                                    </a>
                                    <div class="card-body">
                                        <p>{$LNG.shortDescription.{$ID}}</p>
                                        <ul class="list-group">
                                            {foreach $Element.elementBonus as $BonusName => $Bonus}
                                                <li class="list-group-item">
                                                    {if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{abs($Bonus[0] * 100)}%{else}{$Bonus[0]}{/if} {$LNG.bonus.$BonusName}
                                                </li>
                                            {/foreach}
                                            <li class="list-group-item">
                                                {$LNG.in_dest_durati}: {$Element.time|time}
                                            </li>
                                            <li class="list-group-item list-group-item-warning">{foreach $Element.costResources as $elementID => $RessAmount}
                                                    <a href='#' onclick='return Dialog.info({$elementID})'
                                                       class='tooltip'
                                                       data-tooltip-content="{include 'resource.info.tpl'}">{$LNG.tech.{$elementID}}
                                                    : {$RessAmount|number}</a>{/foreach}</li>
                                        </ul>
                                    </div>
                                    <div class="card-footer">
                                        {if $Element.timeLeft > 0}
                                            {$LNG.of_still}
                                            <br>
                                            <span id="time_{$ID}">-</span>
                                            {$LNG.of_active}
                                        {/if}
                                        {if $Element.buyable}
                                            <form action="game.php?page=officier" method="post" class="build_form">
                                                <input type="hidden" name="id" value="{$ID}">
                                                <button type="submit"
                                                        class="build_submit btn btn-primary">{$LNG.of_recruit}</button>
                                            </form>
                                        {else}
                                            <button type="submit"
                                                    class="disabled build_submit btn btn-primary">{$LNG.of_recruit}</button>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>
            {/if}
            {if $officierList}
                <div class="tab-pane fade" id="content-officer" role="tabpanel" aria-labelledby="tab-officer">
                    <div class="row row-cols-1 row-cols-md-2 row-cols-xl-4 g-2 build-gutter">
                        {foreach $officierList as $ID => $Element}
                            <div class="col">
                                <div class="card">
                                    <div class="card-header">
                                        <small class="float-end">({$LNG.of_lvl} {$Element.level}/{$Element.maxLevel}
                                            )</small>
                                        <h5 onclick="return Dialog.info({$ID});">{$LNG.tech.{$ID}}</h5>
                                    </div>
                                    <a href="#" onclick="return Dialog.info({$ID})">
                                        <img class="card-img-top" src="{$dpath}gebaeude/{$ID}.jpg"
                                             alt="{$LNG.tech.{$ID}}">
                                    </a>
                                    <div class="card-body">
                                        <p>{$LNG.shortDescription.{$ID}}</p>
                                        <ul class="list-group">
                                            {foreach $Element.elementBonus as $BonusName => $Bonus}
                                                <li class="list-group-item">
                                                    {if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{abs($Bonus[0] * 100)}%{else}{$Bonus[0]}{/if} {$LNG.bonus.$BonusName}
                                                </li>
                                            {/foreach}
                                            <li class="list-group-item list-group-item-warning">{foreach $Element.costResources as $elementID => $RessAmount}
                                                    <a href='#' onclick='return Dialog.info({$elementID})'
                                                       class='tooltip'
                                                       data-tooltip-content="{include 'resource.info.tpl'}">{$LNG.tech.{$elementID}}
                                                    : {$RessAmount|number}</a>{/foreach}</li>
                                        </ul>
                                    </div>
                                    <div class="card-footer">
                                        {if $Element.buyable}
                                            <form action="game.php?page=officier" method="post" class="build_form">
                                                <input type="hidden" name="id" value="{$ID}">
                                                <button type="submit"
                                                        class="build_submit btn btn-primary">{$LNG.of_recruit}</button>
                                            </form>
                                        {elseif $Element.level >= $Element.maxLevel}
                                            <span class="buy-full">{$LNG.of_deck_complete}</span>
                                        {else}
                                            <button type="submit"
                                                    class="disabled build_submit btn btn-primary">{$LNG.of_recruit}</button>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>
            {/if}
        </div>
    </div>
{/block}
{block name="script"}
    <script src="scripts/game/officier.js"></script>
{/block}
