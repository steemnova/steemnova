{if !empty($Player.ships)}
    <table class="table table-striped">
        <thead>
        <tr>
            <th>{$LNG.sys_ship_type}</th>
            {foreach $Player.ships as $ShipID => $ShipData}
                <th>{$LNG.shortNames.{$ShipID}}</th>
            {/foreach}
        </tr>
        </thead>
        <tr>
            <th>{$LNG.sys_ship_count}</th>
            {foreach $Player.ships as $ShipID => $ShipData}
                <td>{$ShipData[0]|number}</td>
            {/foreach}
        </tr>
        <tr>
            <th>{$LNG.sys_ship_weapon}</th>
            {foreach $Player.ships as $ShipID => $ShipData}
                <td>{$ShipData[1]|number}</td>
            {/foreach}
        </tr>
        <tr>
            <th>{$LNG.sys_ship_shield}</th>
            {foreach $Player.ships as $ShipID => $ShipData}
                <td>{$ShipData[2]|number}</td>
            {/foreach}
        </tr>
        <tr>
            <th>{$LNG.sys_ship_armour}</th>
            {foreach $Player.ships as $ShipID => $ShipData}
                <td>{$ShipData[3]|number}</td>
            {/foreach}
        </tr>
    </table>
{else}
    <div class="alert alert-danger">{$LNG.sys_destroyed}</div>
{/if}
