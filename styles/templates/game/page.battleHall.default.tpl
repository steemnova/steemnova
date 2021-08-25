{block name="title" prepend}{$LNG.lm_topkb}{/block}
{block name="content"}
    <div class="col-12 col-md-6 col-lg-8 col-xl-6">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">{$LNG.tkb_top}</h2>
            </div>
            <div class="card-body">
                <p class="card-text">{$LNG.tkb_gratz}</p>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>{$LNG.tkb_platz}</th>
                        <th>{$LNG.tkb_owners}</th>
                        <th>{$LNG.tkb_datum}</th>
                        <th>{$LNG.tkb_units}</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $TopKBList as $row}
                        <tr>
                            <td>{$row@iteration}</td>
                            <td><a href="game.php?page=raport&amp;mode=battlehall&amp;raport={$row.rid}"
                                   target="_blank">
                                    {if $row.result == "a"}
                                        <span style="color:#00FF00">{$row.attacker}</span>
                                        VS
                                        <span style="color:#FF0000">{$row.defender}</span>
                                    {elseif $row.result == "r"}
                                        <span style="color:#FF0000">{$row.attacker}</span>
                                        VS
                                        <span style="color:#00FF00">{$row.defender}</span>
                                    {else}
                                        {$row.attacker} VS {$row.defender}
                                    {/if}
                                </a></td>
                            <td>{$row.date}</td>
                            <td>{$row.units|number}</td>
                        </tr>
                    {/foreach}
                    <tr>
                        <td colspan="4">{$LNG.tkb_legende}<span style="color:darkgreen">{$LNG.tkb_gewinner}</span><span
                                    style="color:darkred">{$LNG.tkb_verlierer}</span></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
{/block}
