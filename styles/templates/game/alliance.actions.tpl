<table style='width:240px'>
    <tr>
        <th>{$LNG.gl_alliance} {$currentPlanet.alliance.name} {$currentPlanet.alliance.member}</th>
    </tr>
    <td>
        <table>
            <tr>
                <td>
                    <a href='?page=alliance&amp;mode=info&amp;id={$currentPlanet.alliance.id}'>{$LNG.gl_alliance_page}</a>
                </td>
            </tr>
            <tr>
                <td>
                    <a href='?page=statistics&amp;start={$currentPlanet.alliance.rank}&amp;who=2'>{$LNG.gl_see_on_stats}</a>
                </td>
            </tr>{if $currentPlanet.alliance.web}
            <tr>
                <td><a href='{$currentPlanet.alliance.web}' target='allyweb'>{$LNG.gl_alliance_web_page}</td></tr>{/if}
        </table>
    </td>
</table>