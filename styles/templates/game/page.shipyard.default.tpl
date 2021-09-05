{block name="title" prepend}{if $mode == "defense"}{$LNG.lm_defenses}{else}{$LNG.lm_shipshard}{/if}{/block}
{block name="content"}
    {if !$NotBuilding}
        <div class="alert alert-info">{$LNG.bd_building_shipyard}</div>{/if}
    {if !empty($BuildList)} <!-- fleet training list -->
        <div class="bg-light mb-2 p-2 rounded">
            <form action="game.php?page=shipyard&amp;mode={$mode}" method="post">
                <input type="hidden" name="action" value="delete">
                <div class="row">
                    <div class="col">
                        <select name="auftr[]" id="auftr" onchange="this.form.myText.setAttribute('size', this.value);"
                                multiple class="shipl form-control">
                            <option>&nbsp;</option>
                        </select>
                    </div>
                    <div class="col">
                        <div class="alert alert-warning">{$LNG.bd_cancel_warning}</div>
                    </div>
                    <div class="col">
                        <input type="submit" value="{$LNG.bd_cancel_send}" class="btn btn-danger"/><br/><span
                                class="btn btn-primary" id="timeleft"></span>
                    </div>
                </div>
            </form>
        </div>
    {/if}
    <div>
        <div class="planeto bg-light rounded mb-2">
            <a class="btn btn-toggle btn-primary" data-bs-toggle="collapse"
               data-bs-target=".civil">{$LNG.sy_toggle_civil}</a>
            |
            <a class="btn btn-toggle btn-primary" data-bs-toggle="collapse"
               data-bs-target=".military">{$LNG.sy_toggle_military}</a>
            |
            <a class="btn btn-toggle btn-primary" data-bs-toggle="collapse"
               data-bs-target=".ship">{$LNG.build_toggle_all}</a>
        </div>
    </div>
    <div class="row row-cols-1 row-cols-md-4 g-4 build-gutter">
        {foreach $elementList as $ID => $Element}
            <div class="col collapse show ship {if $ID|in_array:[202, 203, 209, 208, 212, 216, 217, 218, 219, 220]}civil{else}military{/if}"
                 id="s{$ID}">
                <form action="game.php?page=shipyard&amp;mode={$mode}" method="post" id="s{$ID}">
                    <div class="card">
                        <div class="card-header">
                            <h3 onclick="return Dialog.info({$ID})">{$Element.available|number}x
                                <small>{$LNG.tech.{$ID}}</small></h3>
                        </div>
                        <a href="#" onclick="return Dialog.info({$ID})">
                            <img src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}" class="card-img-top mt-2 rounded shadow">
                        </a>
                        <div class="card-body">
                            <!-- missing ress -->
                            {if !$Element.buyable}
                                <ul class="list-group">
                                    <li class="list-group-item">{$LNG.bd_remaining}</li>
                                    {foreach $Element.costOverflow as $ResType => $ResCount}
                                        {if $ResCount > 0}
                                            <li class="list-group-item" onclick="return Dialog.info({$ResType});"
                                                data-bs-toggle="tooltip" data-bs-placement="top"
                                                title="{$LNG.tech.{$ResType}}: {$LNG.shortDescription.$ResType}">{$LNG.tech.{$ResType}}</a>
                                                : <span style="font-weight:700">{$ResCount|number}</span></li>
                                        {/if}
                                    {/foreach}
                                </ul>
                            {/if}
                            {$LNG.bd_next_level_cost}<br/>

                            <ul class="list-group">
                                {foreach $Element.costResources as $RessID => $RessAmount}
                                    <li class="list-group-item" onclick="return Dialog.info({$RessID});"
                                        data-bs-toggle="tooltip"
                                        title="{$LNG.tech.{$RessID}}: {$LNG.shortDescription.$RessID}">{$LNG.tech.{$RessID}}</a>
                                        <strong><span
                                                    style="color:{if $Element.costOverflow[$RessID] == 0}darkgreen{else}darkred{/if}">{$RessAmount|number}</span></strong>
                                    </li>
                                {/foreach}
                                {if !empty($Element.infoEnergy)}
                                    <li class="list-group-item">{$Element.infoEnergy}</li>
                                {/if}
                                <li class="list-group-item">{$LNG.fgf_time}: {$Element.elementTime|time}</li>
                                {if $ID==212}
                                    <li class="list-group-item list-group-item-success">
                                    +{$SolarEnergy} {$LNG.tech.911}</li>{/if}
                        </div>
                        <div class="card-footer">
                            {if $Element.AlreadyBuild}<span
                                    style="color:red">{$LNG.bd_protection_shield_only_one}</span>{elseif $NotBuilding && $Element.buyable}
                                <input type="number" class="form-control" name="fmenge[{$ID}]" id="input_{$ID}" size="3"
                                       maxlength="{$maxlength}" value="0"
                                       tabindex="{$smarty.foreach.FleetList.iteration}">
                                <input type="button" class="btn btn-secondary" value="{$LNG.bd_max_ships}"
                                       onclick="$('#input_{$ID}').val('{$Element.maxBuildable}')">
                                <input class="b btn btn-primary" type="submit" value="{$LNG.bd_build_ships}">
                            {/if}
                        </div>
                    </div>
                </form>
            </div>
        {/foreach}
    </div>
{/block}
{block name="script" append}
    <script type="text/javascript">
        data = {$BuildList|json};
        bd_operating = '{$LNG.bd_operating}';
        bd_available = '{$LNG.bd_available}';
    </script>
    {if !empty($BuildList)}
        <script src="scripts/base/bcmath.js"></script>
        <script src="scripts/game/shipyard.js"></script>
        <script type="text/javascript">
            $(function () {
                ShipyardInit();
            });

        </script>
    {/if}


{/block}
