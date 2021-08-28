<table class='table table-striped'>
    <tr>
        <th colspan='2'>{$LNG.fl_info_detail}</th>
    </tr>
    {foreach $FlyingFleetRow.FleetList as $shipID => $shipCount}
    <tr>
        <td>{$LNG.tech.{$shipID}}:</td>
        <td>{$shipCount}</td>
    </tr>
    {/foreach}
</table>