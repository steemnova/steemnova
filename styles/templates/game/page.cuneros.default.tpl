{block name="title" prepend}{$LNG.lm_cuneros}{/block}
{block name="content"}
    <script>
        function show_otp() {
            let url = 'https://www.cuneros.de/otp/{$project_id}/';
            window.open(url, "Cuneros OTP", "width=750,height=900,status=yes,scrollbars=yes,resizable=yes").focus();
        }
    </script>
    {if $return_message}
        <div class="alert alert-info">{$return_message}</div>
    {/if}
    <div class="row row-cols-1 row-cols-md-2 row-cols-xl-2 g-2 build-gutter">
        <div class="col">
            <div class="card">
                <form class="" method="post">
                    <input type="hidden" name="mode" value="payin">
                    <div class="card-header"><h2 class="card-title">{$LNG.lm_cuneros}</h2></div>
                    <div class="card-body">
                        <p class="card-text">{$info_data}</p>
                        <p class="card-text">{$LNG.cuneros_description}</p>
                        <div class="row">
                            <div class="col">
                                <label for="id-amount">{$LNG.cuneros_amount}</label>
                            </div>
                            <div class="col">
                                <input type="number" min="100" name="amount" id="id-amount" value="100"
                                       class="form-control"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label for="id-username">{$LNG.cuneros_username}</label>
                            </div>
                            <div class="col">
                                <input type="text" name="username" id="id-username" class="form-control"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label for="id-password">{$LNG.cuneros_otp}</label>
                            </div>
                            <div class="col">
                                <input type="text" name="password" id="id-password" class="form-control"/>
                                <a class="btn btn-success" onclick="show_otp()">{$LNG.cuneros_generate_otp}</a>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <input type="submit" value="{$LNG.cuneros_upload}" class="btn btn-primary"/>

                    </div>
                </form>
            </div>
        </div>
        <div class="col">
            <form class="" method="post">
                <input type="hidden" name="mode" value="payout">
                <div class="card">
                    <div class="card-header"><h2 class="card-title">{$LNG.cuneros_payout}</h2></div>
                    <div class="card-body">{sprintf($LNG.cuneros_account_info,$user_coins)}
                        <div class="row">
                            <div class="col">
                                <label for="id-amount">{$LNG.cuneros_amount}</label>
                            </div>
                            <div class="col">
                                <input type="number" min="100" name="amount" id="id-amount" value="100"
                                       class="form-control"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label for="id-username">{$LNG.cuneros_username}</label>
                            </div>
                            <div class="col">
                                <input type="text" name="username" id="id-username" class="form-control"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label for="id-password">{$LNG.cuneros_otp}</label>
                            </div>
                            <div class="col">
                                <input type="text" name="password" id="id-password" class="form-control"/>
                                <a class="btn btn-success" onclick="show_otp()">{$LNG.cuneros_generate_otp}</a>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <input type="submit" value="{$LNG.cuneros_payout}" class="btn btn-primary"/>
                    </div>
                </div>
            </form>
        </div>
        <div class="col">
            <form class="" method="post">
                <input type="hidden" name="mode" value="exchange">
                <div class="card">
                    <div class="card-header"><h2 class="card-title">{$LNG.cuneros_exchange}</h2></div>
                    <div class="card-body">{sprintf($LNG.cuneros_account_exchange,$user_coins)}
                        <div class="row">
                            <div class="col">
                                <label for="id-amount">{$LNG.cuneros_amount}</label>
                            </div>

                            <div class="col">
                                <input type="number" min="1" name="amount" id="id-amount" value="{$user_coins}"
                                       class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <input type="submit" value="{$LNG.cuneros_exchange}" class="btn btn-primary"/>
                    </div>
                </div>
            </form>
        </div>
    </div>
{/block}