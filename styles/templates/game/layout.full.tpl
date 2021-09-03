{include file="main.header.tpl" bodyclass="full"}

            {include file="main.topnav.tpl"}

            {include file="main.navigation.tpl"}

    <div class="container">
        <div class="bg-light rounded w-100 mb-2 p-2 nav d-md-none shadow">
            <li class="nav-item"><a class="mt-2 nav-link link-dark rounded" href="game.php?page=overview"><i class="fas fa-home fs-2"></i></a></li>
            {if isModuleAvailable($smarty.const.MODULE_BUILDING)}<li class="nav-item"><a class="mt-2 nav-link link-dark rounded" href="game.php?page=galaxy"><i class="fas fa-sun fs-2"></i></a></li>{/if}
                {if isModuleAvailable($smarty.const.MODULE_BUILDING)}<li class="nav-item"><a class="mt-2 nav-link link-dark rounded" href="game.php?page=buildings" title="{$LNG.lm_buildings}"><i class="fs-2 fas fa-hammer"></i></a></li>{/if}
                {if isModuleAvailable($smarty.const.MODULE_SHIPYARD_FLEET)}<li class="nav-item"><a class="mt-2 nav-link link-dark rounded" href="game.php?page=shipyard&amp;mode=fleet" title="{$LNG.lm_shipshard}"><i class="fs-2 fas fa-space-shuttle"></i></a></li>{/if}
                {if isModuleAvailable($smarty.const.MODULE_SHIPYARD_DEFENSIVE)}<li class="nav-item"><a class="mt-2 nav-link link-dark rounded" href="game.php?page=shipyard&amp;mode=defense" title="{$LNG.lm_defenses}"><i class="fs-2 fas fa-shield-alt"></i></a></li>{/if}
                {if isModuleAvailable($smarty.const.MODULE_RESEARCH)}<li class="nav-item"><a class="mt-2 nav-link link-dark rounded" href="game.php?page=research" title="{$LNG.lm_research}"><i class="fs-2 fas fa-flask"></i></a></li>{/if}
        </div>
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
        {include "messages.partial.tpl"}


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