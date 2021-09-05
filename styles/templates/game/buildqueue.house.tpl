<!-- building queue-->
{if !empty($Queue)}
    <div id="buildlist" class="infos1">
        {foreach $Queue as $List}
            {$ID = $List.element}
            <div class="d-flex flex-wrap justify-content-between alert {if $List@first}alert-info{else}alert-secondary{/if}" id="buildqueue-{$List@iteration}" data-name="{$LNG.tech.{$ID}}">
                <span>{$List@iteration}.: {$LNG.tech.{$ID}} {$List.level}{if $List.destroy} {$LNG.bd_dismantle}{else} {$LNG.bd_build}{/if}</span>
                <div id="time" data-time="{$List.time}"></div>
                <span data-time="{$List.endtime}" class="timer d-none d-md-inline-block">{$List.display}</span>

                {if !($isBusy.research && ($ID == 6 || $ID == 31)) && !($isBusy.shipyard && ($ID == 15 || $ID == 21)) && $RoomIsOk && $CanBuildElement && $BuildInfoList[$ID].buyable}
                    <form class="d-inline-block build_form d-none d-md-inline-block" action="game.php?page=buildings" method="post">
                        <input type="hidden" name="cmd" value="insert">
                        <input type="hidden" name="building" value="{$ID}">
                        <button type="submit" class="build_submit onlist btn btn-success">{$LNG.tech.{$ID}} {$List.level+1}{if $List.destroy} {$LNG.bd_dismantle}{else} {$LNG.bd_build}{/if}</button>
                    </form>
                {/if}
                {if $List@iteration == 1}
                    <form action="game.php?page=buildings" method="post" class="build_form">
                        <input type="hidden" name="cmd" value="pay">
                        <input type="hidden" name="listid" value="{$List@iteration}">
                        <button type="submit" class="build_submit onlist btn btn-primary">{sprintf($LNG['pay_finish'],$List.darkmattercost)}</button>
                    </form>
                {/if}
                <form action="game.php?page=buildings" method="post" class="build_form">
                    <input type="hidden" name="cmd" value="{if $List@iteration == 1}cancel{else}remove{/if}">
                    <input type="hidden" name="listid" value="{$List@iteration}">
                    <button type="submit" class="build_submit onlist btn btn-danger">{$LNG.bd_cancel}</button>
                </form>
                {if $List@first}
                    <div class="progress w-100 time shadow">
                        {$pct = 100-$List.resttime*100/$List.time}
                        <div data-resttime="{$List.resttime}" data-totaltime="{$List.time}" class="border-1 time-progress progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: {$pct}%;"></div>
                    </div>
                {/if}
            </div>
        {/foreach}
    </div>
{/if}
<!-- /building queue-->