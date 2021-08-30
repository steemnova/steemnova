{include file="main.header.tpl" bodyclass="full"}

            {include file="main.topnav.tpl"}

            {include file="main.navigation.tpl"}

    <div class="container">
        {if $hasAdminAccess}
            <div class="globalWarning alert alert-danger">
                {$LNG.admin_access_1} <a id="drop-admin">{$LNG.admin_access_link}</a>{$LNG.admin_access_2}
            </div>
        {/if}
        {if $closed}
            <div class="alert alert-warning">{$LNG.ov_closed}</div>
        {elseif $delete}
            <div class="alert alert-danger">{$delete}</div>
        {elseif $vacation}
            <div class="alert alert-warning">{$LNG.tn_vacation_mode} {$vacation}</div>
        {/if}


        {block name="content"}{/block}
    </div>

    <footer>
        {include file="main.footer.tpl" nocache}
    </footer>
</div>

</body>
</html>