{block name="title" prepend}{$LNG.siteTitleIndex}{/block}
{block name="content"}

    <!-- Modal -->
    <div class="modal fade" id="registerModal" tabindex="-1" aria-labelledby="registerModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="registerModalLabel">{$LNG.siteTitleRegister}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    {include "forms.register.tpl"}
                </div>
            </div>
        </div>
    </div>
    <main class="container">
        <div class="row">
            <div class="card col-xl-6 col-12 p-5">
                <div class="c-body">
                    <img class="img-fluid" src="styles/resource/images/header.png"/>
                    <p class="lead">{$descText}</p>
                    <ul id="desc_list">{foreach $gameInformations as $info}
                            <li>{$info}</li>{/foreach}</ul>
                </div>
            </div>

            <div class="col-xl-6 col-12">
                <div class="card">
                    <div class="card-header">
                        <h2>{$LNG.loginHeader}</h2>
                    </div>
                    <div class="card-body">
                        <form id="login" name="login" action="index.php?page=login" data-action="index.php?page=login"
                              method="post">
                            <div class="row">
                                <div class="mb-3">
                                    <select class="form-select changeAction" aria-label="Default universe example"
                                            name="uni" id="universe">
                                        {html_options options=$universeSelect selected=$UNI}
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="exampleFormControlInput1"
                                           class="form-label">{$LNG.loginUsername}</label>
                                    <input type="text" class="form-control" placeholder="{$LNG.loginUsername}"
                                           id="username"
                                           name="username">
                                </div>
                                <div class="mb-3">
                                    <label for="id_password" class="form-label">{$LNG.loginPassword}</label>
                                    <input type="password" class="form-control" id="id_password"
                                           placeholder="{$LNG.loginPassword}" name="password">
                                </div>
                                <div class="mb-3">
                                    {if $verkey["capaktiv"]==1}
                                        <script src='https://www.google.com/recaptcha/api.js'></script>
                                        <script>function onSubmit() {
                                                document.getElementById("login").submit();
                                            } </script>
                                        <input class="g-recaptcha btn btn-primary" data-sitekey="{$verkey["cappublic"]}"
                                               data-callback="onSubmit"
                                               type="submit" value="{$LNG.loginButton}">
                                    {else}
                                        <input type="submit" class="btn btn-primary" value="{$LNG.loginButton}">
                                    {/if}
                                </div>
                            </div>
                        </form>
                        {if $facebookEnable}
                            <a href="#" data-href="index.php?page=externalAuth&method=facebook" class="fb_login"><img
                                        src="styles/resource/images/facebook/fb-connect-large.png" alt=""></a>
                        {/if}
                        <a class="btn btn-primary" href="#" data-bs-toggle="modal" data-bs-target="#registerModal">{$LNG.buttonRegister}</a>
                    </div>
                </div>
            </div>
        </div>
    </main>
{/block}
{block name="script" append}
    <script>{if $code}alert({$code|json});{/if}</script>
{/block}