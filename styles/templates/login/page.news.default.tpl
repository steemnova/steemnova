{block name="title" prepend}{$LNG.siteTitleNews}{/block}
{block name="content"}
    <div class="col">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">{$LNG.siteTitleNews}</h2>
            </div>
            <div class="card-body">
                {foreach $newsList as $newsRow}
                    {if !$newsRow@first}
                        <hr>
                    {/if}
                    <div class="info">
                        <h3>{$newsRow.title}</h3>
                        <p>{$newsRow.text}</p>
                    </div>
                    {foreachelse}
                    <h2>{$LNG.news_does_not_exist}</h2>
                {/foreach}
            </div>
        </div>
    </div>
{/block}