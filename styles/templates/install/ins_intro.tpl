{include file="ins_header.tpl"}
<div class="card">
    <div class="card-header">
        <h2>{$LNG.intro_welcome}</h2>
        <div id="lang" align="right">{$LNG.intro_lang}:&nbsp;
            <select id="lang" name="lang"
                    onchange="document.location = '?lang='+$(this).val();">{html_options options=$Selector selected=$lang}</select>
        </div>
    </div>
    <div class="card-body">
        <p class="card-text">{$LNG.intro_text}</p>

    </div>
    <div class="card-footer">
        <a class="btn btn-primary float-end" href="index.php?mode=install&amp;step=2">{$LNG.continue}</a>
    </div>
</div>

{if $canUpgrade}
    <div class="card">
        <div class="card-header">
            <h2>{$LNG.intro_upgrade_head}</h2>
        </div>
        <div class="card-body">
            <p>{$LNG.intro_upgrade_text}</p>

        </div>
        <div class="card-footer">
            <a class="btn btn-primary float-end" href="index.php?mode=upgrade">{$LNG.continueUpgrade}</a>
        </div>
    </div>
{/if}
{include file="ins_footer.tpl"}
