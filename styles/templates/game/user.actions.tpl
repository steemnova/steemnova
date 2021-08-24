<h3>{$currentPlanet.user.playerrank}</h3>
<div>
{if !$currentPlanet.ownPlanet}
    {if !$currentPlanet.user.isBuddy}
        <a href='#' onclick='return Dialog.Buddy({$currentPlanet.user.id})' title='{$LNG.gl_buddy_request}'><i class='fas fa-user-friends'</a>
    {/if}
        <a href='#' onclick='return Dialog.Playercard({$currentPlanet.user.id});' title='{$LNG.gl_playercard}'><i class='fas fa-user'></i></a>
{/if}
<a class='btn btn-primary' href='?page=statistics&amp;who=1&amp;start={$currentPlanet.user.rank}' title='{$LNG.gl_see_on_stats}'><i class='fas fa-users'></i></a>
</div>