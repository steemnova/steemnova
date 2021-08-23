{include file="ins_header.tpl"}
<div class="card">
    <form action="index.php?mode=install&step=8" method="post">

        <div class="card-header">
            <h2>{$LNG.step4_head}</h2>
        </div>
        <div class="card-body">
            <p class="card-text">{$LNG.step4_desc}</p>
            <div class="mb-3">
                <label for="id_username" class="form-label">{$LNG.step4_admin_name}</label>
                <input type="text" class="form-control" name="username" id="id_username"
                       aria-describedby="usernameHelp">
                <div id="usernameHelp" class="form-text">{$LNG.step4_admin_name_desc}</div>
            </div>
            <div class="mb-3">
                <label for="exampleInputPassword1" class="form-label">{$LNG.step4_admin_pass}</label>
                <input type="password" name="password" value="{$password}" class="form-control"
                       id="exampleInputPassword1" aria-describedby="passwordHelp">
                <div id="passwordHelp" class="form-text">{$LNG.step4_admin_pass_desc}</div>
            </div>

            <div class="mb-3">
                <label for="id_email" class="form-label">{$LNG.step4_admin_mail}</label>
                <input type="email" class="form-control" name="email" id="id_email" aria-describedby="">
            </div>
        </div>
        <div class="card-footer">
            <button type="submit" class="btn btn-primary float-end">{$LNG.continue}</button>
        </div>
    </form>
</div>

{include file="ins_footer.tpl"}