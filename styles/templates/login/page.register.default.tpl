{block name="title" prepend}{$LNG.siteTitleRegister}{/block}
{block name="content"}
    <div class="col-12 col-md-6">
        <div class="card">
            <div class="card-header"><h2 class="card-title">{$LNG.siteTitleRegister}</h2></div>
            <div class="card-body">
                {include "forms.register.tpl"}
            </div>
        </div>
    </div>
{/block}
{block name="script" append}
    <link rel="stylesheet" type="text/css" href="styles/resource/css/login/register.css?v={$REV}">
    {if $recaptchaEnable}
        <script type="text/javascript" src="https://www.google.com/recaptcha/api.js?hl={$lang}"></script>
    {/if}
    <script type="text/javascript" src="scripts/login/register.js"></script>
{/block}