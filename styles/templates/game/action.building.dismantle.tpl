<h4>{$LNG.bd_price_for_destroy} {$LNG.tech.{$ID}} {$Element.level}</h4>

<ul class='list-group'>
    {foreach $Element.destroyResources as $ResType => $ResCount}
        <li class='list-group-item'>{$LNG.tech.{$ResType}}: {$ResCount|number}</li>
    {/foreach}
    <li class='list-group-item'>{$LNG.bd_destroy_time}: {$Element.destroyTime|time}</li>
</ul>
<form action='game.php?page=buildings' method='post' class='build_form'>
    <input type='hidden' name='cmd' value='destroy'>
    <input type='hidden' name='building' value='{$ID}'>
    <button type='submit' class='build_submit onlist btn btn-danger'>{$LNG.bd_dismantle}</button>
</form>
{* End Destruction Popup *}