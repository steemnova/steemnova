{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
    <div class="col">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">{$al_users_list}</h2>
            </div>
            <div class="card-body">

                <table id="memberList" class="tablesorter table table-striped">
                    <thead>
                    <tr>
                        <th>{$LNG.al_num}</th>
                        <th>{$LNG.al_member}</th>
                        <th>{$LNG.al_message}</th>
                        <th>{$LNG.al_position}</th>
                        <th>{$LNG.al_points}</th>
                        <th>{$LNG.al_coords}</th>
                        <th>{$LNG.al_member_since}</th>
                        <th>{$LNG.al_estate}</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $memberList as $userID => $memberListRow}
                        <tr>
                            <td>{$memberListRow@iteration}</td>
                            <td><a href="#"
                                   onclick="return Dialog.Playercard({$userID}, '{$memberListRow.username}');">{$memberListRow.username}</a> {if !empty($memberListRow.class)}{foreach $memberListRow.class as $class}{if !$class@first}&nbsp;{/if}
                                    <span
                                    class="galaxy-short-{$class} galaxy-short">{$ShortStatus.$class}</span>{/foreach}{/if}
                            </td>
                            <td><a href="#" onclick="return Dialog.PM({$userID});"><img src="{$dpath}img/m.gif"
                                                                                        border="0"
                                                                                        title="{$LNG.write_message}"></a>
                            </td>
                            <td>{$memberListRow.rankName}</td>
                            <td class="points" data-points="{$memberListRow.points}">{$memberListRow.points}</td>
                            <td>
                                <a href="game.php?page=galaxy&amp;galaxy={$memberListRow.galaxy}&amp;system={$memberListRow.system}"
                                   data-postion="{$memberListRow.galaxy}:{$memberListRow.system}:{$memberListRow.planet}">[{$memberListRow.galaxy}
                                    :{$memberListRow.system}:{$memberListRow.planet}]</a></td>
                            <td>{$memberListRow.register_time}</td>
                            <td>{if $rights.ONLINESTATE}{if $memberListRow.onlinetime < 4}<span
                                        style="color:darkgreen">{$LNG.al_memberlist_on}</span>{elseif $memberListRow.onlinetime <= 15}
                                    <span style="color:orange">{$memberListRow.onlinetime} {$LNG.al_memberlist_min}</span>{else}
                                    <span style="color:red">{$LNG.al_memberlist_off}</span>{/if}{else}-{/if}</td>
                        </tr>
                    {/foreach}
                    </tbody>
                    <tr>
                        <th colspan="8"><a href="game.php?page=alliance">{$LNG.al_back}</a></th>
                    </tr>
                </table>
            </div>
        </div>
    </div>
{/block}
{block name="script" append}
    <script src="scripts/base/jquery.tablesorter.js"></script>
    <script>$(function () {
            $.tablesorter.addParser({
                id: 'status',
                is: function (s) {
                    // return false so this parser is not auto detected
                    return false;
                },
                format: function (s) {
                    if (s == "{$LNG.al_memberlist_on}")
                        return 0;
                    if (s == "{$LNG.al_memberlist_off}")
                        return 999;
                    // format your data for normalization
                    var lNumber = parseFloat(s.replace(/[^0-9]/, ''));
                    return lNumber;
                },
                // set type, either numeric or text
                type: 'numeric'
            });
            {literal}
            $("#memberList").tablesorter({
                headers: {
                    0: {sorter: false},
                    3: {sorter: false},
                    7: {sorter: "status"}
                },
                debug: false
            });
            {/literal}
            var elements = document.getElementsByClassName('points');
            for (var i = 0, l = elements.length; i < l; i++) {
                elements[i].innerHTML = number_format(elements[i].innerHTML);
            }

        });</script>
{/block}
