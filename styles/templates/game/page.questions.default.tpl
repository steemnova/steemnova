{block name="title" prepend}{$LNG.lm_faq}{/block}
{block name="content"}
    <div class="col">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">{$LNG.faq_overview}</h2>
            </div>
            <div class="card-body">
                {foreach $LNG.questions as $categoryID => $categoryRow}<h2>{$categoryRow.category}</h2>
                    <ul class="list-group">
                        {foreach $categoryRow as $questionID => $questionRow}
                            {if is_numeric($questionID)}
                                <li class="list-group-item">
                                    <a href="game.php?page=questions&amp;mode=single&amp;categoryID={$categoryID}&amp;questionID={$questionID}">{$questionRow.title}</a>
                                </li>
                            {/if}
                        {/foreach}
                    </ul>
                {/foreach}

            </div>
        </div>
    </div>
{/block}



{*{foreach $LNG.questions as $categoryID => $categoryRow}
<tr>
    <th>{$categoryRow.category}</th>
</tr>
{foreach $categoryRow as $questionID => $questionRow}
{if is_numeric($questionID)}
<tr>
    <th>{$questionRow.title}</th>
</tr>
<tr>
    <td class="left">
    {$questionRow.body}
</tr>
{/if}
{/foreach}
{/foreach}*}