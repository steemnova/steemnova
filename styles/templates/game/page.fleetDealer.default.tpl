{block name="title" prepend}{$LNG.lm_fleettrader}{/block}
{block name="content"}
    <div class="card">
        <form action="game.php?page=fleetDealer" method="post">

            <div class="card-header">
                <h2 class="card-title">{$LNG.ft_head}</h2>
                <select name="shipID" id="shipID" class="float-end form-control" onchange="updateVars()">
                    {foreach $shipIDs as $shipID}
                        <option value="{$shipID}">{$LNG.tech.$shipID}</option>
                    {/foreach}
                </select>
            </div>
            <input type="hidden" name="mode" value="send">
            <div class="card-body">
                <p class="alert alert-info">{$LNG.fleetDealer_info}</p>
                <img id="img" class="float-end" alt="" data-src="{$dpath}gebaeude/"><br/>
                <p>{$LNG.ft_count}: <input type="text" id="count" name="count" onkeyup="Total();">
                    <button class="btn btn-sm btn-primary" onclick="MaxShips();return false;">{$LNG.ft_max}</button>
                </p>
                <p>{$LNG.tech.901}: <span id="metal" style="font-weight:800;"></span>
                    &bull; {$LNG.tech.902}: <span id="crystal" style="font-weight:800;"></span>
                    &bull; {$LNG.tech.903}: <span id="deuterium" style="font-weight:800;"></span>
                    &bull; {$LNG.tech.921}: <span id="darkmatter" style="font-weight:800;"></span></p>
                <p>{$LNG.ft_total}: {$LNG.tech.901}: <span id="total_metal"
                                                           style="font-weight:800;"></span>
                    &bull; {$LNG.tech.902}: <span id="total_crystal" style="font-weight:800;"></span>
                    &bull; {$LNG.tech.903} <span id="total_deuterium" style="font-weight:800;"></span>
                    &bull; {$LNG.tech.921}: <span id="total_darkmatter" style="font-weight:800;"></span>
                </p>
                <p>{$LNG.ft_charge}: {$Charge}%</p>
            </div>
            <div class="card-footer">
                <input class="btn btn-primary" type="submit" value="{$LNG.ft_absenden}">
            </div>
        </form>
    </div>
{/block}
{block name="script" append}
    <script src="scripts/game/fleettrader.js"></script>
    <script>
        var CostInfo = {$CostInfos|json};
        var Charge = {$Charge};
        $(function () {
            updateVars();
        });
    </script>
{/block}