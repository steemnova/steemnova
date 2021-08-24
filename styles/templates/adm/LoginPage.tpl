{include file="overall_header.tpl"}

<div id="content">
    <div class="col-12 col-md-6">
        <form action="" method="POST">
            <div class="card mt-2">
                <div class="card-header">
                    <h1 class="card-title">{$LNG.adm_login}</h1>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label class="form-label" for="id_username">{$LNG.adm_username}:</label>
                        <input class="form-control" id="id_username" type="text" value="{$username}" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="id_password">{$LNG.adm_password}:</label>
                        <input class="form-control" id="id_password" type="password" name="admin_pw" />
                    </div>
                    <div><input class="btn btn-primary" type="submit" value="{$LNG.adm_absenden}"></div>
                </div>
            </div>
        </form>
    </div>
</div>
{include file="overall_footer.tpl"}