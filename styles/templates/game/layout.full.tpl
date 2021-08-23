{include file="main.header.tpl" bodyclass="full"}

            {include file="main.topnav.tpl"}

            {include file="main.navigation.tpl"}

    <div class="container">
        {if $hasAdminAccess}
            <div class="globalWarning">
                {$LNG.admin_access_1} <a id="drop-admin">{$LNG.admin_access_link}</a>{$LNG.admin_access_2}
            </div>
        {/if}
        {if $closed}
            <div class="infobox">{$LNG.ov_closed}</div>
        {elseif $delete}
            <div class="infobox">{$delete}</div>
        {elseif $vacation}
            <div class="infobox">{$LNG.tn_vacation_mode} {$vacation}</div>
        {/if}


        {block name="content"}{/block}
    </div>

    <footer>
        {foreach $cronjobs as $cronjob}<img src="cronjob.php?cronjobID={$cronjob}" alt="">{/foreach}

        {include file="main.footer.tpl" nocache}
    </footer>
</div>

</body>
</html>