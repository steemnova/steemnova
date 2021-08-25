{block name="title" prepend}{$LNG.ti_create_head} - {$LNG.lm_support}{/block}
{block name="content"}
    <form action="game.php?page=ticket&mode=send" method="post" id="form">
        <input type="hidden" name="id" value="0">
        <div class="col">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">{$LNG.ti_create_head}</h2>
                </div>
                <div class="card-body">
                    <p class="card-text">{$LNG.ti_create_info}</p>
                    <table class="table">
                        <tr>
                            <td style="width:30%"><label for="category" class="form-label">{$LNG.ti_category}</label></td>
                            <td style="width:70%"><select id="category" name="category" class="form-control">{html_options options=$categoryList}</select>
                            </td>
                        </tr>
                        <tr>
                            <td><label for="subject" class="form-label">{$LNG.ti_subject}</label></td>
                            <td><input class="form-control validate[required]" type="text" id="subject" name="subject" size="40"
                                       maxlength="255"></td>
                        </tr>
                        <tr>
                            <td><label for="message" class="form-label">{$LNG.ti_message}</label></td>
                            <td><textarea class="validate[required] form-control" id="message" name="message" rows="60" cols="8"
                                          style="height:100px;"></textarea></td>
                        </tr>
                        <tr>
                            <td colspan="2"><input class="btn btn-primary" type="submit" value="{$LNG.ti_submit}"></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
{/block}
{block name="script" append}
    <script>
        $(document).ready(function () {
            $("#form").validationEngine('attach');
        });
    </script>
{/block}