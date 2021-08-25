{block name="title" prepend}{$LNG.lm_research}{/block}
{block name="content"}
    <form action="game.php?page=alliance&amp;mode=cancelApply" method="post">
        <div class="col">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">{$LNG.al_your_request_title}</h2>
                </div>
                <div class="card-body">
                    {$request_text}
                </div>
                <div class="card-footer">
                    <input type="submit" class="btn btn-danger" value="{$LNG.al_cancel_application}">
                </div>
            </div>
        </div>
    </form>
{/block}