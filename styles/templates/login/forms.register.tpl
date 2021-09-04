<form id="registerForm" method="post" action="index.php?page=register"
      data-action="index.php?page=register">
    <input type="hidden" value="send" name="mode">
    <input type="hidden" value="{$externalAuth.account}" name="externalAuth[account]">
    <input type="hidden" value="{$externalAuth.method}" name="externalAuth[method]">
    <input type="hidden" value="{$referralData.id}" name="referralID">
    <div class="row">
        <div class="col">
            <label class="form-label" for="universe">{$LNG.universe}</label>
        </div>
        <div class="col">
            <select name="uni" id="universe"
                    class="changeAction form-control">{html_options options=$universeSelect selected=$UNI}</select>
            {if !empty($error.uni)}<span class="error errorUni"></span>{/if}
        </div>
    </div>
    {if !empty($externalAuth.account)}
        {if $facebookEnable}
            <div class="row">
                <div class="col">
                    <label>{$LNG.registerFacebookAccount}</label>
                    <span class="text fbname">{$accountName}</span>
                </div>
                <div class="col">
                </div>
            </div>
        {/if}
    {elseif empty($referralData.id)}
        {if $facebookEnable}
            <div class="row">
                <div class="col">
                    <label>{$LNG.registerFacebookAccount}</label>
                </div>
                <div class="col">
                    <a href="#" data-href="index.php?page=externalAuth&method=facebook"
                       class="fb_login"><img src="styles/resource/images/facebook/fb-connect-large.png"
                                             alt=""></a>
                </div>
            </div>
        {/if}
    {/if}
    <div class="row">
        <div class="col">
            <label class="form-label" for="username">{$LNG.registerUsername}</label>
        </div>
        <div class="col">
            <input type="text" class="form-control input" name="username" id="username" maxlenght="32">
            {if !empty($error.username)}<span class="error errorUsername"></span>{/if}
            <span class="form-text">{$LNG.registerUsernameDesc}</span>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <label class="form-label" for="password">{$LNG.registerPassword}</label>
        </div>
        <div class="col">
            <input type="password" class="input form-control" name="password" id="password">
            {if !empty($error.password)}<span class=" error errorPassword"></span>{/if}
            <span class="inputDesc form-text">{$registerPasswordDesc}</span>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <label for="passwordReplay">{$LNG.registerPasswordReplay}</label>
        </div>
        <div class="col">
            <input type="password" class="input form-control" name="passwordReplay" id="passwordReplay">
            {if !empty($error.passwordReplay)}<span class=" error errorPasswordReplay"></span>{/if}
            <span class="inputDesc form-text ">{$LNG.registerPasswordReplayDesc}</span>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <label for="email" class="form-label">{$LNG.registerEmail}</label>
        </div>
        <div class="col">
            <input type="email" class="input form-control" name="email" id="email">
            {if !empty($error.email)}<span class=" error errorEmail"></span>{/if}
            <span class="form-text inputDesc">{$LNG.registerEmailDesc}</span>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <label for="emailReplay" class="form-label">{$LNG.registerEmailReplay}</label>
        </div>
        <div class="col">
            <input type="email" class="input form-control" name="emailReplay" id="emailReplay">
            {if !empty($error.emailReplay)}<span class="error errorEmailReplay"></span>{/if}
            <span class="inputDesc">{$LNG.registerEmailReplayDesc}</span>
        </div>
    </div>
    {if count($languages) > 1}
        <div class="row">
            <div class="col">
                <label for="language" class="form-label">{$LNG.registerLanguage}</label>
            </div>
            <div class="col">
                <select name="lang" class=" form-control"
                        id="language">{html_options options=$languages selected=$lang}</select>
                {if !empty($error.language)}<span class="error errorLanguage"></span>{/if}
                <div class="clear"></div>
            </div>
        </div>
    {/if}
    {if !empty($referralData.name)}
        <div class="row">
            <div class="col">
                <label for="language" class="form-label">{$LNG.registerReferral}</label>
            </div>
            <div class="col">
                <span class="form-text">{$referralData.name}</span>
                {if !empty($error.language)}<span class="error errorLanguage"></span>{/if}
                <div class="clear"></div>
            </div>
        </div>
    {/if}
    {if $recaptchaEnable}
        <div class="row">
            <div class="col">
                <label class="form-label">{$LNG.registerCaptcha}</label>
                <!--<span class="inputDesc">{$LNG.registerCaptchaDesc}</span>-->
            </div>
            <div class="col">
                <div class="g-recaptcha" data-sitekey="{$recaptchaPublicKey}"></div>
            </div>
        </div>
    {/if}
    <div class="row">
        <div class="col">
            <label for="rules" class="form-label">{$LNG.registerRules}</label>
        </div>
        <div class="col">
            <input type="checkbox" class="form-check" name="rules" id="rules"
                   value="1">
            {if !empty($error.rules)}<span class="error errorRules"></span>{/if}
            <span class="form-text">{$registerRulesDesc}</span>
        </div>
    </div>
    <input type="submit" class="submitButton btn btn-primary"
           value="{$LNG.buttonRegister}">

</form>
