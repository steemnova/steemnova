{block name="title" prepend}{$LNG.lm_faq}{/block}
{block name="content"}
    <div class="col">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">{$questionRow.title}</h2>
            </div>
            <div class="card-body">
                {$questionRow.body}
            </div>
            <div class="card-footer">
                <a class="btn btn-secondary" href="game.php?page=questions">{$LNG.al_back}</a>
            </div>
        </div>
    </div>
{/block}