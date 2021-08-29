<h3>{$currentPlanet.user.playerrank}</h3>
<div class='list-group'>
{if !$currentPlanet.ownPlanet}
    {if !$currentPlanet.user.isBuddy}
        <a href='#' onclick='return Dialog.Buddy({$currentPlanet.user.id})' title='{$LNG.gl_buddy_request}' class='list-group-item'><i class='fas fa-user-friends'></i> {$LNG.gl_buddy_request}</a>
    {/if}
        <a href='#' onclick='return Dialog.Playercard({$currentPlanet.user.id});' title='{$LNG.gl_playercard}' class='list-group-item'><i class='fas fa-user'></i> {$LNG.gl_playercard}</a>
        <a href='#' class='list-group-item' onclick='return Dialog.PM({$currentPlanet.user.id})'><i class='fas fa-envelope'></i> {$LNG.write_message}</a>
{/if}
<a class='list-group-item' href='?page=statistics&amp;who=1&amp;start={$currentPlanet.user.rank}' title='{$LNG.gl_see_on_stats}'><i class='fas fa-users'></i> {$LNG.gl_see_on_stats}</a>
</div>