{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
    <div class="col">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">{$LNG.al_request_list}</h2>
            </div>
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>{$LNG.al_candidate}</th>
                        <th>{$LNG.al_request_date}</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $applyList as $applyRow}
                        <tr>
                            <td>
                                <a href="game.php?page=alliance&amp;mode=admin&amp;action=detailApply&amp;id={$applyRow.id}">{$applyRow.username}</a>
                            </td>
                            <td>
                                <a href="game.php?page=alliance&amp;mode=admin&amp;action=detailApply&amp;id={$applyRow.id}">{$applyRow.time}</a>
                            </td>
                        </tr>
                        {foreachelse}
                        <tr>
                            <td colspan="2">{$LNG.al_no_requests}</td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
            <div class="card-footer">
                <a class="btn btn-secondary" href="game.php?page=alliance">{$LNG.al_back}</a>
            </div>
        </div>
    </div>
{/block}