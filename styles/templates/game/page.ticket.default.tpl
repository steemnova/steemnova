{block name="title" prepend}{$LNG.lm_support}{/block}
{block name="content"}
    <div class="col-12 col-md-6 col-lg-8 col-xl-6">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">{$LNG.ti_header}</h2>
            </div>
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th style="width:10%">
                        {$LNG.ti_id}</td>
                        <th style="width:45%">
                        {$LNG.ti_subject}</td>
                        <th style="width:15%">
                        {$LNG.ti_answers}</td>
                        <th style="width:15%">
                        {$LNG.ti_date}</td>
                        <th style="width:15%">
                        {$LNG.ti_status}</td>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $ticketList as $TicketID => $TicketInfo}
                        <tr>
                            <td><a href="game.php?page=ticket&amp;mode=view&amp;id={$TicketID}">#{$TicketID}</a></td>
                            <td>
                                <a href="game.php?page=ticket&amp;mode=view&amp;id={$TicketID}">{$TicketInfo.subject}</a>
                            </td>
                            <td>{$TicketInfo.answer - 1}</td>
                            <td>{$TicketInfo.time}</td>
                            <td>{if $TicketInfo.status == 0}<span
                                        style="color:green">{$LNG.ti_status_open}</span>{elseif $TicketInfo.status == 1}
                                    <span style="color:orange">{$LNG.ti_status_answer}</span>{else}<span
                                            style="color:red">{$LNG.ti_status_closed}</span>{/if}</td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
            <div class="card-footer">
                <a class="btn btn-success" href="game.php?page=ticket&amp;mode=create">{$LNG.ti_new}</a>
            </div>
        </div>
    </div>
{/block}