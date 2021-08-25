{block name="title" prepend}{$LNG.siteTitleBattleHall}{/block}
{block name="content"}
    <div class="col">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title"><h2>{$LNG.siteTitleBattleHall}</h2>
            </div>
            <div class="card-body">

                {if $isMultiUniverse}<p>
                    {html_options options=$universeSelect selected=$UNI class="changeUni" id="universe" name="universe"}
                    </p>{/if}
                <table class="table table-striped">
                    <tr>
                        <th >{$LNG.tkb_platz}</th>
                        <th >{$LNG.tkb_owners}</th>
                        <th >{$LNG.tkb_datum}</th>
                        <th >{$LNG.tkb_units}</th>
                    </tr>
                    {foreach $hallList as $hallRow}
                        <tr>
                            <td>{$hallRow@iteration}</td>
                            <td>
                                {if $hallRow.result == "a"}
                                    <span >{$hallRow.attacker}</span>
                                    <span ><b> VS </b></span>
                                    <span >{$hallRow.defender}</span>
                                {elseif $hallRow.result == "r"}
                                    <span >{$hallRow.attacker}</span>
                                    <span ><b> VS </b></span>
                                    <span >{$hallRow.defender}</span>
                                {else}
                                    {$hallRow.attacker}
                                    <b> VS </b>
                                    {$hallRow.defender}
                                {/if}
                            </td>
                            <td>{$hallRow.time}</td>
                            <td>{$hallRow.units|number}</td>
                        </tr>
                    {/foreach}
                    <tr>
                        <td colspan="4"><p>{$LNG.tkb_legende}<span >{$LNG.tkb_gewinner}</span><span
                                        >{$LNG.tkb_verlierer}</span></p></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
{/block}