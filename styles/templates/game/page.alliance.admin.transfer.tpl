{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
    <form action="game.php?page=alliance&amp;mode=admin&amp;action=transfer" method="post">
        <div class="col">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">{$LNG.al_transfer_alliance}</h2>
                </div>
                <div class="card-body">


                    <table class="table519">
                        <tr>
                            <td>{$LNG.al_transfer_to}:</td>
                            <td>{html_options name=newleader options=$transferUserList}</td>
                            <td><input type="submit" value="{$LNG.al_transfer_submit}"></td>
                        </tr>
                        <tr>
                            <th colspan="3"><a href="game.php?page=alliance&amp;mode=admin">{$LNG.al_back}</a></th>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
{/block}