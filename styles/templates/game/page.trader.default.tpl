{block name="title" prepend}{$LNG.lm_trader}{/block}
{block name="content"}
    <div class="card">
        <div class="card-header">
            <h2 class="card-title">{$LNG.tr_call_trader}</h2>
        </div>
        <div class="card-body">
            {if $requiredDarkMatter}
                <div class="alert alert-info">{$requiredDarkMatter}</div>
            {/if}
            <p class="card-text">{$LNG.tr_call_trader_who_buys}</p>
            <div id="traderContainer" class="centerContainer">
                <div class="outer">
                    <div class="inner">
                        {foreach $charge as $resourceID => $chageData}
                            <div class="trader_col">
                                {if !$requiredDarkMatter}
                                    <form action="game.php?page=trader" method="post">
                                    <input type="hidden" name="mode" value="trade">
                                    <input type="hidden" name="resource" value="{$resourceID}">
                                    <input type="image" id="trader_metal"
                                           src="{$dpath}images/{$resource.$resourceID}.gif"
                                           title="{$LNG.tech.$resourceID}" height="32" width="52">
                                    <label for="trader_metal">{$LNG.tech.$resourceID}</label>
                                    </form>
                                {else}<img src="{$dpath}images/{$resource.$resourceID}.gif"
                                           title="{$LNG.tech.$resourceID}" height="32" width="52">{$LNG.tech.$resourceID}{/if}
                            </div>
                        {/foreach}
                    </div>
                </div>
            </div>
            <p>{$tr_cost_dm_trader}</p>
            <p>{$LNG.tr_exchange_quota}: {$charge.901.903}/{$charge.902.903}/{$charge.903.903}</p>
        </div>
    </div>
{/block}