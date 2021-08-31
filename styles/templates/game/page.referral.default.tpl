{block name="title" prepend}{$LNG.lm_cuneros}{/block}
{block name="content"}

<div class="row row-cols-1 row-cols-md-1 row-cols-xl-1 g-2 build-gutter">
    <div class="col">
        {if $ref_active}
        <div class="card">
            <div class="card-header"><h3 class="card-title">{$LNG.ref_header}</h3></div>
            <div class="card-body">
                <div class="alert alert-info">
                    <strong>{$LNG.ref_link}: </strong> {$SELF_URL}index.php?ref={$userid}<br />
                    {sprintf($LNG.ref_earning_info, $config_ref_factor)}
                </div>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>{$LNG.ref_table_name}</th>
                        <th>{$LNG.ref_table_onlinedate}</th>
                        <th>{$LNG.ref_table_regdate}</th>
                        <th>{$LNG.ref_table_amount}</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $userdata as $data}
                        <tr>
                            <td>{$data.username}</td>
                            <td>{date($LNG.php_tdformat,$data.onlinetime)}</td>
                            <td>{date($LNG.php_tdformat,$data.register_time)}</td>
                            <td>{$data.ref_coins}</td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
        {else}
            <div class="alert alert-info">{$LNG.ref_module_inactive}</div>
        {/if}
    </div>
</div>
{/block}