{block name="title" prepend}{$LNG.lm_trader}{/block}
{block name="content"}
    <div class="col-12 col-xl-6">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">{$LNG.tr_call_trader}</h2>
            </div>
            <div class="card-body">
                {if $requiredDarkMatter}
                    <div class="alert alert-danger">{$requiredDarkMatter}</div>
                {/if}
                <p class="alert alert-info">{$tr_cost_dm_trader}</p>

                <p class="card-text">{$LNG.tr_sell_ressources}</p>
                <div id="traderContainer" class="centerContainer">
                    {foreach $charge as $resourceID => $chageData}
                        <div class="trader_col btn-group">
                                <form action="game.php?page=trader" method="post">
                                    <input type="hidden" name="mode" value="trade">
                                    <input type="hidden" name="resource" value="{$resourceID}">
                                    <button type="submit" class="{if $requiredDarkMatter}disabled{/if} btn btn-primary" id="trader_{$resource.$resourceID}"
                                            title="{$LNG.tech.$resourceID}">
                                        <img src="{$dpath}images/{$resource.$resourceID}.gif"
                                             height="32" width="52"><br />
                                        {$LNG.tech.$resourceID}<br />
                                        <small>{$LNG.tr_quota_exchange}:<br /></small>
                                        {if $resourceID != 903}<small>{$charge.$resourceID.903} {$LNG.tech.$resourceID} = {$charge.903.903} {$LNG.tech.903}</small><br />{/if}
                                        {if $resourceID != 902}<small>{$charge.$resourceID.902} {$LNG.tech.$resourceID} = {$charge.902.902} {$LNG.tech.902}</small><br />{/if}
                                        {if $resourceID != 901}<small>{$charge.$resourceID.901} {$LNG.tech.$resourceID} = {$charge.901.901} {$LNG.tech.901}</small>{/if}
                                    </button>
                                </form>
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
{/block}