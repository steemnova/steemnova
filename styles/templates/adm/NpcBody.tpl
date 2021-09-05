{include file="overall_header.tpl"}
<form method="post">
<div>
    Create <input class="form-control" name="numPlanets" type="number" value="10" /> Planets with <input type="number" name="numCuneros" value="100" /> Cuneros and the following deff:
    <ul>
    {foreach $deffList as $deff}
        <li><input type="number" name="deff_{$deff}" value="0" /> {$LNG.tech.$deff}</li>
    {/foreach}
    </ul>
    <br />
    Pirate user id: <input type="number" name="pirateId" value="2"/><br />
    Universe id: <input type="number" name="universeId" value="1" /><br />
    Mines are: <select name="typeMines" class="form-control"><option value="0">small</option><option value="1">medium (Level 10)</option><option value="2">high (level 20)</option></select>
    <button class="btn btn-primary" type="submit">Create!</button>
</div>
</form>
{include file="overall_footer.tpl"}
