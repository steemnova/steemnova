{block name="title" prepend}{$LNG.lm_messages}{/block}
{block name="content"}
    <div class="row">
        <div class="col-12 mb-2">
            <div class="card">
                <div class="card-header">
                    {$LNG.mg_overview}
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-horizontal">
                        {foreach $CategoryList as $CategoryID => $CategoryRow}
                            <li class="list-group-item p-2 small">
                                <a href="game.php?page=messages&category={$CategoryID}" title="{$LNG.mg_type.{$CategoryID}}">{$LNG.short_mg_type.{$CategoryID}}</a>
                                <span class="badge bg-primary rounded-pill" id="unread_{$CategoryID}">{$CategoryRow.unread} / {$CategoryRow.total}</span>

                            </li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    {$LNG.mg_message_title}
                </div>
                <div class="card-body">
                    <form action="game.php?page=messages" method="post">
                        <input type="hidden" name="mode" value="action">
                        <input type="hidden" name="ajax" value="1">
                        <input type="hidden" name="messcat" value="{$MessID}">
                        <input type="hidden" name="side" value="{$page}">
                        <select name="actionTop">
                            <option value="readmarked">{$LNG.mg_read_marked}</option>
                            <option value="readtypeall">{$LNG.mg_read_type_all}</option>
                            <option value="readall">{$LNG.mg_read_all}</option>
                            <option value="deletemarked">{$LNG.mg_delete_marked}</option>
                            <option value="deleteunmarked">{$LNG.mg_delete_unmarked}</option>
                            <option value="deletetypeall">{$LNG.mg_delete_type_all}</option>
                            <option value="deleteall">{$LNG.mg_delete_all}</option>
                        </select>
                        <input value="{$LNG.mg_confirm}" type="submit" name="submitTop">

                        <table id="messagestable" class="table table-striped">
                            <tr>
                                <td>{$LNG.mg_action}</td>
                                <td>{$LNG.mg_date}</td>
                                <td>{if $MessID != 999}{$LNG.mg_from}{else}{$LNG.mg_to}{/if}</td>
                                <td>{$LNG.mg_subject}</td>
                            </tr>
                            {foreach $MessageList as $Message}
                                <tr id="message_{$Message.id}"
                                    class="message_{$Message.id} message_head{if $MessID != 999 && $Message.unread == 1} mes_unread{/if}">
                                    <td rowspan="2">
                                        {if $MessID != 999}<input name="messageID[{$Message.id}]" value="1"
                                                                  type="checkbox">{/if}
                                    </td>
                                    <td>{$Message.time}</td>
                                    <td>{$Message.from}</td>
                                    <td>{$Message.subject}
                                        {if $Message.type == 1 && $MessID != 999}
                                            <a href="#"
                                               onclick="return Dialog.PM({$Message.sender}, Message.CreateAnswer('{$Message.subject}'));"
                                               title="{$LNG.mg_answer_to} {strip_tags($Message.from)}"><img
                                                        src="{$dpath}img/m.gif" border="0"></a>
                                        {/if}
                                        {if $MessID != 999}<a href="#"
                                                              onclick="Message.delMessage({$Message.id});return false;">
                                            <img
                                                    src="{$dpath}img/deletemsg.png"></a>{/if}
                                    </td>
                                </tr>
                                <tr class="message_{$Message.id} messages_body{if $MessID != 999 && $Message.unread == 1} mes_unread{/if}">
                                    <td colspan="3" class="left">
                                        {$Message.text}
                                    </td>
                                </tr>
                            {/foreach}
                            <tr style="height: 20px;">
                                <td class="right" colspan="4">{$LNG.mg_page}: {if $page != 1}<a
                                        href="game.php?page=messages&category={$MessID}&side=1">
                                            &laquo;</a>&nbsp;{/if}{if $page > 5}..&nbsp;{/if}{for $site=1 to $maxPage}<a
                                        href="game.php?page=messages&category={$MessID}&side={$site}">{if $site == $page}
                                            <b>
                                            [{$site}
                                            ]&nbsp;</b>{elseif ($site > $page-5 && $site < $page+5)}[{$site}]&nbsp;{/if}
                                        </a>{/for}{if $page < $maxPage-4}..&nbsp;{/if}{if $page != $maxPage}&nbsp;<a
                                            href="game.php?page=messages&category={$MessID}&side={$maxPage}">
                                            &raquo;</a>{/if}</td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
{/block}
