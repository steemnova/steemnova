{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
    <div class="row row-cols-1 row-cols-md-2 row-cols-xl-2 g-2 build-gutter">
    <div class="col">
        <form action="game.php?page=alliance&amp;mode=search" method="post">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">{$LNG.al_find_alliances}</h2>
                </div>
                <div class="card-body">
                    <label for="id_searchtext" class="form-label">{$LNG.al_find_text}</label>
                    <input type="text" name="searchtext" value="{$searchText}" class="form-control" id="id_searchtext">
                </div>
                <div class="card-footer">
                    <input type="submit" value="{$LNG.al_find_submit}" class="btn btn-primary">
                </div>
            </div>
        </form>
    </div>
    {if !empty($searchList)}
        <div class="col">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">{$LNG.al_find_alliances}</h2>
                </div>
                <div class="card-body">

                    <table class="table table-striped">
                        <tr>
                            <th>{$LNG.al_ally_info_tag}</th>
                            <th>{$LNG.al_ally_info_name}</th>
                            <th>{$LNG.al_ally_info_members}</th>
                        </tr>
                        {foreach $searchList as $seachRow}
                            <tr>
                                <td>
                                    <a href="game.php?page=alliance&amp;mode=apply&amp;id={$seachRow.id}">{$seachRow.tag}</a>
                                </td>
                                <td>
                                    <a href="game.php?page=alliance&amp;mode=apply&amp;id={$seachRow.id}">{$seachRow.name}</a>
                                </td>
                                <td>
                                    <a href="game.php?page=alliance&amp;mode=apply&amp;id={$seachRow.id}">{$seachRow.members}</a>
                                </td>
                            </tr>
                            {foreachelse}
                            <tr>
                                <td colspan="3">{$LNG.al_find_no_alliances}</td>
                            </tr>
                        {/foreach}
                    </table>
                </div>
            </div>
        </div>
    {/if}
{/block}