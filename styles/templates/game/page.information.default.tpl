{block name="title" prepend}{$LNG.lm_info}{/block}
{block name="content"}
    <h2>{$LNG.tech.$elementID}</h2>
    <p>{$LNG.longDescription.$elementID}</p>
    {if !empty($Bonus)}
        <h3>{$LNG.in_bonus}</h3>
        <p>
        {foreach $Bonus as $BonusName => $elementBouns}{if $elementBouns[0] < 0}-{else}+{/if}{if $elementBouns[1] == 0}{abs($elementBouns[0] * 100)}%{else}{floatval($elementBouns[0])}{/if} {$LNG.bonus.$BonusName}
            <br>
        {/foreach}
        </p>{/if}
    {if !empty($FleetInfo)}
        <div class="d-flex w-100">

        {if !empty($FleetInfo.rapidfire.to)}
            <ul class="list-group flex-grow-1">
            <li class="list-group-item list-group-item-success">{$LNG.strength}</li>
            {foreach $FleetInfo.rapidfire.to as $rapidfireID => $shoots}
                <li class="list-group-item list-group-item-success d-flex justify-content-between align-items-center">{$LNG.in_rf_again} {$LNG.tech.$rapidfireID}: <span class="badge rounded bg-primary">{$shoots|number}%</span></li>
            {/foreach}
            </ul>{/if}
        {if !empty($FleetInfo.rapidfire.from)}
            <ul class="list-group flex-grow-1">
            <li class="list-group-item list-group-item-danger">{$LNG.weakness}</li>
            {foreach $FleetInfo.rapidfire.from as $rapidfireID => $shoots}
                <li class="list-group-item list-group-item-danger d-flex justify-content-between align-items-center">{$LNG.in_rf_from} {$LNG.tech.$rapidfireID}: <span class="badge rounded bg-danger">{$shoots|number}%</span></li>
            {/foreach}
            </ul>{/if}
        </div>
        <hr />
    {/if}

    {if !empty($FleetInfo)}
        {include file="shared.information.shipInfo.tpl"}
        <hr />
    {/if}
    {if !empty($gateData)}
        {include file="shared.information.gate.tpl"}
        <hr />
    {/if}
    {if !empty($MissileList)}
        {include file="shared.information.missiles.tpl"}
        <hr />
    {/if}
    {if !empty($productionTable.production)}
        {include file="shared.information.production.tpl"}
        <hr />
    {/if}
    {if !empty($productionTable.storage)}
        {include file="shared.information.storage.tpl"}
    {/if}
{/block}