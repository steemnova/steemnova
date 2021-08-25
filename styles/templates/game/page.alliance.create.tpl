{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
    <form action="game.php?page=alliance&amp;mode=create&amp;action=send" method="POST">
        <div class="col">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">{$LNG.al_make_alliance}</h2>
                </div>
                <div class="card-body">
                    <div class="mb-2">
                        <label for="id_atag" class="form-label">{$LNG.al_make_ally_tag_required}</label>
                        <input type="text" name="atag" size="8" maxlength="8" value="" id="id_atag"
                               class="form-control">
                    </div>
                    <div class="mb-2">
                        <label class="form-label" id="id_aname">{$LNG.al_make_ally_name_required}</label>
                        <input type="text" name="aname" size="20" maxlength="30" value="" id="id_aname"
                               class="form-control">
                    </div>
                </div>
                <div class="card-footer">
                    <input type="submit" value="{$LNG.al_make_submit}" class="btn btn-primary">
                </div>
            </div>
        </div>
    </form>
{/block}