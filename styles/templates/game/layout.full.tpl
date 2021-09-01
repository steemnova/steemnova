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
<div class="toast-container position-absolute top-3 end-0 p-3" id="toastContainer">
    <div role="alert" aria-live="assertive" aria-atomic="true" class="d-none toast" data-bs-autohide="true" id="toastNotify">
        <div class="toast-header d-none">
            <strong class="me-auto toast-title"></strong>
        </div>
        <div class="toast-body">
        </div>
    </div>
</div>
    <footer>
        {include file="main.footer.tpl" nocache}
    </footer>

</body>
</html>