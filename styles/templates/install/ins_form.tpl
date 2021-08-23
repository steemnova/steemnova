{include file="ins_header.tpl"}

<div class="card">
    <form action="index.php?mode=install&step=4" method="post">
        <div class="card-header">
            <h2>{$LNG.step1_head}</h2>
        </div>
        <div class="card-body">
            <p class="card-text">{$LNG.step1_desc}</p>

            <input type="hidden" name="post" value="1">
            <table class="table table-striped">
                <tr>
                    <td class="transparent left"><p>{$LNG.step1_mysql_server}</p></td>
                    <td class="transparent"><input type="text" name="host"
                                                   value="{$smarty.get.host|escape:'htmlall'|default:$host}" size="30">
                    </td>
                </tr>
                <tr>
                    <td class="transparent left"><p>{$LNG.step1_mysql_port}</p></td>
                    <td class="transparent"><input type="text" name="port"
                                                   value="{$smarty.get.port|escape:'htmlall'|default:'3306'}" size="30">
                    </td>
                </tr>
                <tr>
                    <td class="transparent left"><p>{$LNG.step1_mysql_dbuser}</p></td>
                    <td class="transparent"><input type="text" name="user"
                                                   value="{$smarty.get.user|escape:'htmlall'|default:$user}" size="30">
                    </td>
                </tr>
                <tr>
                    <td class="transparent left"><p>{$LNG.step1_mysql_dbpass}</p></td>
                    <td class="transparent"><input type="password" name="passwort" value="{$user}" size="30"></td>
                </tr>
                <tr>
                    <td class="transparent left"><p>{$LNG.step1_mysql_dbname}</p></td>
                    <td class="transparent"><input type="text" name="dbname"
                                                   value="{$smarty.get.dbname|escape:'htmlall'|default:$dbname}"
                                                   size="30"></td>
                </tr>
                <tr>
                    <td class="transparent left"><p>{$LNG.step1_mysql_prefix}</p></td>
                    <td class="transparent"><input type="text" name="prefix"
                                                   value="{$smarty.get.prefix|escape:'htmlall'|default:'uni1_'}"
                                                   size="30"></td>
                </tr>
            </table>
        </div>
        <div class="card-footer">
            <input type="submit" class="btn btn-primary float-end" value="{$LNG.continue}" />
        </div>
    </form>
</div>
{include file="ins_footer.tpl"}