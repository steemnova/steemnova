<h4>{if $currentPlanet.user.avatar_url}<img class='img-avatar-layer' src='{$currentPlanet.user.avatar_url}'>{/if} {$currentPlanet.user.username}</h4>
{if $currentPlanet.user.playerrank == 1}
        <h6>{$LNG.player_top}</h6>
{elseif $currentPlanet.user.playerrank > 0}
        <h6>{$LNG.tkb_platz}: {$currentPlanet.user.playerrank}</h6>
{/if}
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