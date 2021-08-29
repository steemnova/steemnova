{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
    <div class="row row-cols-1 row-cols-md-2 row-cols-xl-2 g-2 build-gutter">

        <div class="col">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">{$LNG.al_diplo_head}</h2>
                </div>
                <div class="card-body">
                    <p class="card-text">{$LNG.al_diplo_info}</p>

                    {foreach $diploList.0 as $diploMode => $diploAlliances}
                        <hr/>
                        <h3>{$LNG.al_diplo_level.$diploMode}</h3>
                        <ul class="list-group">
                            {foreach $diploAlliances as $diploID => $diploName}
                                <li class="list-group-item">{$diploName} <a
                                            href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacyDelete&amp;id={$diploID}"
                                            onclick="return confirm('{$LNG.al_diplo_confirm_delete}');"><i
                                                class="fas fa-trash-alt"></i></a>
                                </li>
                                {foreachelse}
                                <li class="list-group-item">{$LNG.al_diplo_no_entry}</li>
                            {/foreach}
                        </ul>
                        <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacyCreate&amp;diploMode={$diploMode}"
                           onclick="return Dialog.open(this.href, 650, 300);"
                           class="btn btn-success">{$LNG.al_diplo_create}</a>
                    {/foreach}
                </div>
            </div>
        </div>
        <div class="col">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">{$LNG.al_diplo_request}</h2>
                </div>
                <div class="card-body">
                    <h3 class="card-title">{$LNG.al_diplo_accept}</h3>
                    {if array_filter($diploList.1)}

                        {foreach $diploList.1 as $diploMode => $diploAlliances}
                            {if !empty($diploAlliances)}
                                <ul class="list-group">
                                    <li class="list-group-item">{$LNG.al_diplo_level.$diploMode}</li>
                                    {foreach $diploAlliances as $diploID => $diploName}
                                        <li class="list-group-item">{$diploName}
                                            <a class="btn btn-success btn-sm"
                                               href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacyAccept&amp;id={$diploID}"
                                               onclick="return confirm('{$LNG.al_diplo_accept_yes_confirm}');">
                                                <i class="fas fa-check"></i></a>
                                            <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacyDelete&amp;id={$diploID}"
                                               onclick="return confirm('{$LNG.al_diplo_accept_no_confirm}');"
                                               class="btn btn-danger">
                                                <i class="fas fa-trash-alt"></i></a>
                                        </li>
                                    {/foreach}
                                </ul>
                            {/if}
                        {/foreach}
                    {else}
                        {$LNG.al_diplo_no_accept}
                    {/if}
                    <hr />
                    <h3 class="card-title">{$LNG.al_diplo_accept_send}</h3>
                    {if array_filter($diploList.2)}

                        {foreach $diploList.2 as $diploMode => $diploAlliances}
                            {if !empty($diploAlliances)}
                                <ul class="list-group">
                                    <li class="list-group-item">{$LNG.al_diplo_level.$diploMode}</li>
                                    {foreach $diploAlliances as $diploID => $diploName}
                                        <li class="list-group-item">{$diploName}
                                            <a href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacyDelete&amp;id={$diploID}"
                                               onclick="return confirm('{$LNG.al_diplo_accept_no_confirm}');"
                                               class="btn btn-danger">
                                                <i class="fas fa-trash-alt"></i></a>
                                        </li>
                                    {/foreach}
                                </ul>
                            {/if}
                        {/foreach}
                    {else}
                        {$LNG.al_diplo_no_accept}
                    {/if}

                </div>
            </div>
        </div>
    </div>
{/block}