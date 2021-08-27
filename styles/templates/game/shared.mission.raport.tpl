{block name="title" prepend}{$pageTitle}{/block}
{block name="content"}
<div class="card">
    <div class="card-header">
        <h3>
            <small class="card-subtitle float-end">{$Raport.time}</small>
            {if $Raport.mode == 1}{$LNG.sys_destruc_title}{else}{$LNG.sys_attack_title}{/if}
        </h3>
    </div>
    <div class="card-body">

    {if isset($Info)}
        <table>
            <tr>
                <td 
                    style="width:40%;font-size:22px;font-weight:bold;padding:10px 0 30px;color:{if $Raport.result == "a"}lime{elseif $Raport.result == "r"}red{else}white{/if}">{$Info.0}</td>
                <td  style="font-size:22px;font-weight:bold;padding:10px 0 30px;">VS</td>
                <td 
                    style="width:40%;font-size:22px;font-weight:bold;padding:10px 0 30px;color:{if $Raport.result == "r"}lime{elseif $Raport.result == "a"}red{else}white{/if}">{$Info.1}</td>
            </tr>
        </table>
    {/if}
    {foreach $Raport.rounds as $Round => $RoundInfo}
        {foreach $RoundInfo.attacker as $Player}
            {$PlayerInfo = $Raport.players[$Player.userID]}
            <h4>{$LNG.sys_attack_attacker_pos} {$PlayerInfo.name} {if isset($Info)}([XX:XX:XX]){else}([{$PlayerInfo.koords[0]}:{$PlayerInfo.koords[1]}:{$PlayerInfo.koords[2]}]{if isset($PlayerInfo.koords[3])} ({$LNG["type_planet_short_{$PlayerInfo.koords[3]}"]}){/if}){/if}</h4>
            <br>
            {$LNG.sys_ship_weapon} {$PlayerInfo.tech[0]}% - {$LNG.sys_ship_shield} {$PlayerInfo.tech[1]}% - {$LNG.sys_ship_armour} {$PlayerInfo.tech[2]}%
            {include "shared.shiptable.part.tpl"}
        {/foreach}

        {foreach $RoundInfo.defender as $Player}
            {$PlayerInfo = $Raport.players[$Player.userID]}
            <h4>{$LNG.sys_attack_defender_pos} {$PlayerInfo.name} {if isset($Info)}([XX:XX:XX]){else}([{$PlayerInfo.koords[0]}:{$PlayerInfo.koords[1]}:{$PlayerInfo.koords[2]}]{if isset($PlayerInfo.koords[3])} ({$LNG.type_planet_short[$PlayerInfo.koords[3]]}){/if}){/if}</h4>
            <br>
            {$LNG.sys_ship_weapon} {$PlayerInfo.tech[0]}%
            - {$LNG.sys_ship_shield} {$PlayerInfo.tech[1]}%
            - {$LNG.sys_ship_armour} {$PlayerInfo.tech[2]}%
            {include "shared.shiptable.part.tpl"}

        {/foreach}

        {if !$RoundInfo@last}
            {$LNG.fleet_attack_1} {$RoundInfo.info[0]|number} {$LNG.fleet_attack_2} {$RoundInfo.info[3]|number} {$LNG.damage}
            <br/>
            {$LNG.fleet_defs_1} {$RoundInfo.info[2]|number} {$LNG.fleet_defs_2} {$RoundInfo.info[1]|number} {$LNG.damage}
        {/if}
        <hr/>
    {/foreach}

    {if $Raport.result == "a"}
        <div class="alert alert-danger">{$LNG.sys_attacker_won}</div>
        <div class="alert alert-info">{$LNG.sys_stealed_ressources} {foreach $Raport.steal as $elementID => $amount}{$amount|number} {$LNG.tech.$elementID}{if ($amount@index + 2) == count($Raport.steal)} {$LNG.sys_and} {elseif !$amount@last}, {/if}{/foreach}</div>
    {elseif $Raport.result == "r"}
        <div class="alert alert-success">{$LNG.sys_defender_won}</div>
    {else}
        <div class="alert alert-info">{$LNG.sys_both_won}</div>
    {/if}
    <div class="alert alert-info">
        {$LNG.sys_attacker_lostunits} {$Raport['units'][0]|number} {$LNG.sys_units}<br/>
        {$LNG.sys_defender_lostunits} {$Raport['units'][1]|number} {$LNG.sys_units}<br/>
        {$LNG.debree_field_1} {foreach $Raport.debris as $elementID => $amount}{$amount|number} {$LNG.tech.$elementID}{if ($amount@index + 2) == count($Raport.debris)} {$LNG.sys_and} {elseif !$amount@last}, {/if}{/foreach}{$LNG.debree_field_2}
    </div>
    {if $Raport.mode == 1}
        {* Destruction *}
        {if $Raport.moon.moonDestroySuccess == -1}
            {* Attack not win *}
            <div class="alert alert-danger">{$LNG.sys_destruc_stop}</div>
        {else}
            {* Attack win *}
            <div class="alert alert-info">{sprintf($LNG.sys_destruc_lune, "{$Raport.moon.moonDestroyChance}")}
                {$LNG.sys_destruc_mess1}
                {if $Raport.moon.moonDestroySuccess == 1}
                    {* Destroy success *}
                    {$LNG.sys_destruc_reussi}
                {elseif $Raport.moon.moonDestroySuccess == 0}
                    {* Destroy failed *}
                    {$LNG.sys_destruc_null}
                {/if}
                <br>
                {sprintf($LNG.sys_destruc_rip, "{$Raport.moon.fleetDestroyChance}")}
                {if $Raport.moon.fleetDestroySuccess == 1}
                    {* Fleet destroyed *}
                    <br>
                    {$LNG.sys_destruc_echec}
                {/if}
            </div>
        {/if}
    {else}
        {* Normal Attack *}
        <div class="alert alert-info">
            {$LNG.sys_moonproba} {$Raport.moon.moonChance} %
            <br>
            {if !empty($Raport.moon.moonName)}
                {if isset($Info)}
                    {* Moon created (HoF Mode) *}
                    {sprintf($LNG.sys_moonbuilt, "{$Raport.moon.moonName}", "XX", "XX", "XX")}
                {else}
                    {* Moon created *}
                    {sprintf($LNG.sys_moonbuilt, "{$Raport.moon.moonName}", "{$Raport.koords[0]}", "{$Raport.koords[1]}", "{$Raport.koords[2]}")}
                {/if}
            {/if}
        </div>
    {/if}

    {$Raport.additionalInfo}

    </div>
</div>
        {/block}
