{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
    {$countRank = count($availableRanks)}
    <form action="game.php?page=alliance&amp;mode=admin&amp;action=permissionsSend" method="post">
        <input type="hidden" value="1" name="send">
        <div class="col">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">{$LNG.al_configura_ranks}</h2>
                </div>
                <div class="card-body">
                    <button id="create_new_alliance_rank" class="btn btn-success">{$LNG.al_add_rank}</button>

                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>{$LNG.al_dlte}</th>
                            <th>{$LNG.al_rank_name}</th>
                            {foreach $availableRanks as $rankName}
                                <th title="{$LNG.al_rank_desc[$rankName]}"><img src="styles/resource/images/alliance/{$rankName}.png" alt="{$LNG.al_rank_desc[$rankName]}" width="16"
                                         height="16"></th>
                            {/foreach}
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $rankList as $rowId => $rankRow}
                            <tr>
                                <td>
                                    <a href="game.php?page=alliance&amp;mode=admin&amp;action=permissionsSend&amp;deleteRank={$rowId}"><img
                                                src="styles/resource/images/alliance/CLOSE.png" alt="" width="16"
                                                height="16"></a></td>
                                <td><input type="text" name="rank[{$rowId}][rankName]" value="{$rankRow.rankName}">
                                </td>
                                {foreach $availableRanks as $rankId => $rankName}
                                    <td><input type="checkbox" name="rank[{$rowId}][{$rankId}]"
                                               value="1"{if $rankRow[$rankName]} checked{/if}{if !$ownRights[$rankName]} disabled{/if}>
                                    </td>
                                {/foreach}
                            </tr>
                            {foreachelse}
                            <tr>
                                <td colspan="{$countRank + 2}">{$LNG.al_no_ranks_defined}</td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
                <div class="card-footer">
                    <input type="submit" value="{$LNG.al_save}" class="btn btn-primary">
                    <a class="btn btn-secondary" href="game.php?page=alliance&amp;mode=admin">{$LNG.al_back}</a>
                </div>
            </div>
        </div>
    </form>
    <div id="new_alliance_rank" title="{$LNG.al_create_new_rank}" style="display:none;">
        <form action="game.php?page=alliance&amp;mode=admin&amp;action=permissionsSend" method="post">
            <table>
                <tr>
                    <td><label for="rankName">{$LNG.al_rank_name}</label></td>
                    <td><input type="text" name="newrank[rankName]" size="20" maxlength="32" id="rankName"
                               required>
                    </td>
                </tr>
                <tr>
                    <th colspan="{$countRank + 2}">&nbsp;</th>
                </tr>
                {foreach $availableRanks as $rankId => $rankName}
                    <tr>
                        <td><img src="styles/resource/images/alliance/{$rankName}.png" alt="{$rankName}"
                                 width="16"
                                 height="16">&nbsp;<label
                                    for="rank_{$rankId}">{$LNG.al_rank_desc[$rankName]}</label>
                        </td>
                        <td><input type="checkbox" name="newrank[{$rankId}]" value="1" id="rank_{$rankId}"
                                   title="{$LNG.al_rank_desc[$rankName]}"></td>
                    </tr>
                {/foreach}
                <tr>
                    <td colspan="{$countRank + 2}"><input type="submit" class="btn btn-primary" value="{$LNG.al_create}"></td>
                </tr>
            </table>
        </form>
    </div>
{/block}