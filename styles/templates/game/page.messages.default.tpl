{block name="title" prepend}{$LNG.lm_messages}{/block}
{block name="content"}
    <div class="row">
        <div class="col-12 mb-2">
            <div class="card">
                <div class="card-header">
                    {$LNG.mg_overview}
                </div>
                <div class="card-body">
                    <div class="nav nav-fill">
                        {foreach $CategoryList as $CategoryID => $CategoryRow}
                            <a class="btn btn-sm btn-outline-primary" href="game.php?page=messages&category={$CategoryID}"
                                   title="{$LNG.mg_type.{$CategoryID}}">{$LNG.short_mg_type.{$CategoryID}}
                                <span class="badge bg-primary rounded-pill"
                                      id="unread_{$CategoryID}">{$CategoryRow.unread} / {$CategoryRow.total}</span>
                            </a>
                        {/foreach}
                    </div>
                </div>
            </div>
        </div>
        <div class="col-12">
            <form action="game.php?page=messages" method="post">
                <div class="card">
                    <div class="card-header">
                        {$LNG.mg_message_title}
                    </div>
                    <div class="card-body">

                        <input type="hidden" name="mode" value="action">
                        <input type="hidden" name="ajax" value="1">
                        <input type="hidden" name="messcat" value="{$MessID}">
                        <input type="hidden" name="side" value="{$page}">
                        <div class="input-group mb-3">
                            <select name="actionTop" class="form-control">
                                <option value="readmarked">{$LNG.mg_read_marked}</option>
                                <option value="readtypeall">{$LNG.mg_read_type_all}</option>
                                <option value="readall">{$LNG.mg_read_all}</option>
                                <option value="deletemarked">{$LNG.mg_delete_marked}</option>
                                <option value="deleteunmarked">{$LNG.mg_delete_unmarked}</option>
                                <option value="deletetypeall">{$LNG.mg_delete_type_all}</option>
                                <option value="deleteall">{$LNG.mg_delete_all}</option>
                            </select>
                            <input value="{$LNG.mg_confirm}" type="submit" name="submitTop"
                                   class="btn btn-sm btn-primary">
                        </div>
                        <table id="messagestable" class="table table-striped w-100" style="word-break: break-word">
                            <thead>
                            <tr>
                                <th></th>
                                <th>{$LNG.mg_date}</th>
                                <th>{if $MessID != 999}{$LNG.mg_from}{else}{$LNG.mg_to}{/if}</th>
                                <th>{$LNG.mg_subject}</th>
                            </tr>
                            </thead>
                            <tbody>
                            {foreach $MessageList as $Message}
                                <tr id="message_{$Message.id}"
                                    class="message_{$Message.id} message_head{if $MessID != 999 && $Message.unread == 1} mes_unread{/if}">
                                    <td rowspan="2">
                                        {if $MessID != 999}
                                            <input name="messageID[{$Message.id}]" value="1" class="form-check" type="checkbox"><br />
                                            <a href="#" onclick="Message.delMessage({$Message.id});return false;"><i class="fas fa-trash"></i></a>
                                            {if $Message.type == 1}
                                                <a href="#" onclick="return Dialog.PM({$Message.sender}, Message.CreateAnswer('{$Message.subject}'));"
                                                   title="{$LNG.mg_answer_to} {strip_tags($Message.from)}"><i class="fas fa-envelope"></i></a>
                                            {/if}
                                        {/if}
                                    </td>
                                    <td><span class="d-none d-md-inline-block">{$Message.date}</span> {$Message.time}</td>
                                    <td>{$Message.from}</td>
                                    <td>{$Message.subject}</td>
                                </tr>
                                <tr class="message_{$Message.id} messages_body{if $MessID != 999 && $Message.unread == 1} mes_unread{/if}">
                                    <td colspan="3" class="left" style="overflow-y: scroll">
                                        {$Message.text}
                                    </td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination">
                                <li class="page-item"><a class="page-link">{$LNG.mg_page}</a></li>
                                <li class="page-item"><a class="page-link"
                                                         href="game.php?page=messages&category={$MessID}&side=1">&laquo;</a>
                                </li>
                                {for $site=1 to $maxPage}
                                    {if $site >= $page-5 && $site <= $page+5}
                                    <li class="page-item {if $page == $site} active{/if}">
                                        <a class="page-link"
                                           href="game.php?page=messages&category={$MessID}&side={$site}">{$site}</a>
                                    </li>
                                    {/if}
                                {/for}
                                <li class="page-item"><a class="page-link"
                                                         href="game.php?page=messages&category={$MessID}&side={$maxPage}">&raquo;</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </form>
        </div>
    </div>
{/block}
