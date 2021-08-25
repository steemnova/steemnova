{block name="title" prepend}{$LNG.lm_records}{/block}
{block name="content"}
<div class="col-12 col-md-6 col-lg-8 col-xl-6">
    <div class="card">
        <div class="card-header">
            <h2 class="card-title">{$LNG.rec_last_update_on}: {$update}</h2>
        </div>
        <div class="card-body">
            <table class="table-responsive table table-striped">
                <thead>
                <tr>
                    <th>{$LNG.tech.0}</th>
                    <th>{$LNG.rec_players}</th>
                    <th>{$LNG.rec_level}</th>
                </tr>
                </thead>
                <tbody>
                {foreach $buildList as $elementID => $elementRow}
                    <tr>
                        <td><a href='#' onclick='return Dialog.info({$elementID})' class='tooltip'
                               data-tooltip-content="<table><tr><th>{$LNG.tech.{$elementID}}</th></tr><tr><table class='hoverinfo'><tr><td><img src='{$dpath}gebaeude/{$elementID}.{if $elementID >=600 && $elementID <= 699}jpg{else}gif{/if}'></td><td>{$LNG.shortDescription.$elementID}</td></tr></table></tr></table>">{$LNG.tech.{$elementID}}</a>
                        </td>
                        {if !empty($elementRow)}
                            <td>{foreach $elementRow as $user}<a href='#'
                                                                 onclick='return Dialog.Playercard({$user.userID});'>{$user.username}</a>{if !$user@last}
                                        <br>
                                    {/if}{/foreach}</td>
                            <td>{$elementRow[0].level|number}</td>
                        {else}
                            <td>-</td>
                            <td>-</td>
                        {/if}
                    </tr>
                {/foreach}
                <tr>
                    <th>{$LNG.tech.100}</th>
                    <th>{$LNG.rec_players}</th>
                    <th>{$LNG.rec_level}</th>
                </tr>
                {foreach $researchList as $elementID => $elementRow}
                    <tr>
                        <td><a href='#' onclick='return Dialog.info({$elementID})' class='tooltip'
                               data-tooltip-content="<table><tr><th>{$LNG.tech.{$elementID}}</th></tr><tr><table class='hoverinfo'><tr><td><img src='{$dpath}gebaeude/{$elementID}.{if $elementID >=600 && $elementID <= 699}jpg{else}gif{/if}'></td><td>{$LNG.shortDescription.$elementID}</td></tr></table></tr></table>">{$LNG.tech.{$elementID}}</a>
                        </td>
                        {if !empty($elementRow)}
                            <td>{foreach $elementRow as $user}<a href='#'
                                                                 onclick='return Dialog.Playercard({$user.userID});'>{$user.username}</a>{if !$user@last}
                                        <br>
                                    {/if}{/foreach}</td>
                            <td>{$elementRow[0].level|number}</td>
                        {else}
                            <td>-</td>
                            <td>-</td>
                        {/if}
                    </tr>
                {/foreach}
                <tr>
                    <th>{$LNG.tech.200}</th>
                    <th>{$LNG.rec_players}</th>
                    <th>{$LNG.rec_count}</th>
                </tr>
                {foreach $fleetList as $elementID => $elementRow}
                    <tr>
                        <td><a href='#' onclick='return Dialog.info({$elementID})' class='tooltip'
                               data-tooltip-content="<table><tr><th>{$LNG.tech.{$elementID}}</th></tr><tr><table class='hoverinfo'><tr><td><img src='{$dpath}gebaeude/{$elementID}.{if $elementID >=600 && $elementID <= 699}jpg{else}gif{/if}'></td><td>{$LNG.shortDescription.$elementID}</td></tr></table></tr></table>">{$LNG.tech.{$elementID}}</a>
                        </td>
                        {if !empty($elementRow)}
                            <td>{foreach $elementRow as $user}<a href='#'
                                                                 onclick='return Dialog.Playercard({$user.userID});'>{$user.username}</a>{if !$user@last}
                                        <br>
                                    {/if}{/foreach}</td>
                            <td>{$elementRow[0].level|number}</td>
                        {else}
                            <td>-</td>
                            <td>-</td>
                        {/if}
                    </tr>
                {/foreach}
                <tr>
                    <th>{$LNG.tech.400}</th>
                    <th>{$LNG.rec_players}</th>
                    <th>{$LNG.rec_count}</th>
                </tr>
                {foreach $defenseList as $elementID => $elementRow}
                    <tr>
                        <td><a href='#' onclick='return Dialog.info({$elementID})' class='tooltip'
                               data-tooltip-content="<table><tr><th>{$LNG.tech.{$elementID}}</th></tr><tr><table class='hoverinfo'><tr><td><img src='{$dpath}gebaeude/{$elementID}.{if $elementID >=600 && $elementID <= 699}jpg{else}gif{/if}'></td><td>{$LNG.shortDescription.$elementID}</td></tr></table></tr></table>">{$LNG.tech.{$elementID}}</a>
                        </td>
                        {if !empty($elementRow)}
                            <td>{foreach $elementRow as $user}<a href='#'
                                                                 onclick='return Dialog.Playercard({$user.userID});'>{$user.username}</a>{if !$user@last}
                                        <br>
                                    {/if}{/foreach}</td>
                            <td>{$elementRow[0].level|number}</td>
                        {else}
                            <td>-</td>
                            <td>-</td>
                        {/if}
                    </tr>
                {/foreach}
                <tr>
                    <th>{$LNG.tech.600}</th>
                    <th>{$LNG.rec_players}</th>
                    <th>{$LNG.rec_count}</th>
                </tr>
                {foreach $officerList as $elementID => $elementRow}
                    <tr>
                        <td><a href='#' onclick='return Dialog.info({$elementID})' class='tooltip'
                               data-tooltip-content="<table><tr><th>{$LNG.tech.{$elementID}}</th></tr><tr><table class='hoverinfo'><tr><td><img src='{$dpath}gebaeude/{$elementID}.{if $elementID >=600 && $elementID <= 699}jpg{else}gif{/if}'></td><td>{$LNG.shortDescription.$elementID}</td></tr></table></tr></table>">{$LNG.tech.{$elementID}}</a>
                        </td>
                        {if !empty($elementRow)}
                            <td>{foreach $elementRow as $user}<a href='#'
                                                                 onclick='return Dialog.Playercard({$user.userID});'>{$user.username}</a>{if !$user@last}
                                        <br>
                                    {/if}{/foreach}</td>
                            <td>{$elementRow[0].level|number}</td>
                        {else}
                            <td>-</td>
                            <td>-</td>
                        {/if}
                    </tr>
                {/foreach}
                </tbody>

            </table>

        </div>
    </div>
    {/block}
