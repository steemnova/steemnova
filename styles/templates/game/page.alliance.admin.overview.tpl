{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
    <div class="col">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">{$LNG.al_manage_alliance}</h2>
            </div>
            <div class="card-body">
                <a class="btn btn-primary"
                   href="game.php?page=alliance&amp;mode=admin&amp;action=permissions">{$LNG.al_manage_ranks}</a>
                <a class="btn btn-primary"
                   href="game.php?page=alliance&amp;mode=admin&amp;action=members">{$LNG.al_manage_members}</a>
                {if $rights.DIPLOMATIC}
                    <a class="btn btn-primary"
                       href="game.php?page=alliance&amp;mode=admin&amp;action=diplomacy">{$LNG.al_manage_diplo}</a>
                {/if}
                <form action="game.php?page=alliance&mode=admin" method="post">
                    <input type="hidden" name="textMode" value="{$textMode}">
                    <input type="hidden" name="send" value="1">
                    <hr/>
                    <h3 class="card-title">{$LNG.al_texts}</h3>

                    <a class="btn btn-secondary"
                       href="game.php?page=alliance&amp;mode=admin&amp;textMode=external">{$LNG.al_outside_text}</a>
                    <a class="btn btn-secondary"
                       href="game.php?page=alliance&amp;mode=admin&amp;textMode=internal">{$LNG.al_inside_text}</a>
                    <a class="btn btn-secondary"
                       href="game.php?page=alliance&amp;mode=admin&amp;textMode=apply">{$LNG.al_request_text}</a>
                    <textarea name="text" id="text" cols="70" rows="15" class="tinymce">{$text}</textarea>

                    <input type="reset" value="{$LNG.al_circular_reset}" class="btn btn-secondary">
                    <input type="submit" value="{$LNG.al_save}" class="btn btn-primary">

                    <hr/>
                    <h3 class="card-title">{$LNG.al_manage_options}</h3>

                    <div class="row">
                        <div class="col"><label class="form-label" for=""></label></div>
                        <div class="col"></div>
                    </div>

                    <div class="row">
                        <div class="col"><label class="form-label" for="id-ally_tag">{$LNG.al_tag}</label></div>
                        <div class="col"><input type="text" name="ally_tag" value="{$ally_tag}" size="8" maxlength="8"
                                                id="id-ally_tag" class="form-control" required></div>
                    </div>

                    <div class="row">
                        <div class="col"><label class="form-label" for="id-ally_name">{$LNG.al_name}</label></div>
                        <div class="col"><input type="text" name="ally_name" value="{$ally_name}" id="id-ally_name"
                                                class="form-control" size="20" maxlength="30" required></div>
                    </div>

                    <div class="row">
                        <div class="col"><label class="form-label"
                                                for="id-owner_range">{$LNG.al_manage_founder_rank}</label></div>
                        <div class="col"><input type="text" name="owner_range" id="id-owner_range" class="form-control"
                                                value="{$ally_owner_range}" size="30"></div>
                    </div>

                    <div class="row">
                        <div class="col"><label class="form-label" for="id-web">{$LNG.al_web_site}</label></div>
                        <div class="col"><input type="text" name="web" id="id-web" class="form-control"
                                                value="{$ally_web}" size="70"></div>
                    </div>

                    <div class="row">
                        <div class="col"><label class="form-label" for="id-image">{$LNG.al_manage_image}</label></div>
                        <div class="col"><input type="text" name="image" value="{$ally_image}" size="70" id="id-image"
                                                class="form-control"></div>
                    </div>
                    <div class="row">
                        <div class="col"><label class="form-label" for="id-stats">{$LNG.al_view_stats}</label></div>
                        <div class="col">{html_options name=stats options=$YesNoSelector selected=$ally_stats_data id="id-stats" class="form-control"}</div>
                    </div>

                    <div class="row">
                        <div class="col"><label class="form-label" for="id-diplo">{$LNG.al_view_diplo}</label></div>
                        <div class="col">{html_options name=diplo options=$YesNoSelector selected=$ally_diplo_data id="id-diplo" class="form-control"}</div>
                    </div>
                    <div class="row">
                        <div class="col"><label class="form-label" for="id-events">{$LNG.al_view_events}</label></div>
                        <div class="col"><select id="id-events" class="form-control" name="events[]"
                                                 size="{$available_events|@count}" multiple>
                                {foreach $available_events as $id => $mission}
                                    {foreach $ally_events as $selected_events}
                                        {if $selected_events == $id}
                                            {assign var=selected value=selected}
                                            {break}
                                        {else}
                                            {assign var=selected value=''}
                                        {/if}
                                    {/foreach}
                                    <option value="{$id}" {$selected}>{$mission}</option>
                                {/foreach}
                            </select></div>
                    </div>

                    <hr/>
                    <h3 class="card-title">{$LNG.al_manage_requests}</h3>
                    <div class="row">
                        <div class="col"><label class="form-label"
                                                for="id-request_notallow">{$LNG.al_manage_requests}</label></div>
                        <div class="col">{html_options name=request_notallow options=$RequestSelector selected=$ally_request_notallow id="id-request_notallow" class="form-control"}</div>
                    </div>

                    <div class="row">
                        <div class="col"><label class="form-label"
                                                for="id-ally_max_members">{$LNG.al_set_max_members}</label></div>
                        <div class="col">{$ally_members} / <input type="number" min="1" name="ally_max_members"
                                                                  value="{$ally_max_members}" size="8"
                                                                  class="form-control" id="id-ally_max_members"></div>
                    </div>

                    <div class="row">
                        <div class="col"><label class="form-label"
                                                for="id-request_min_points">{$LNG.al_manage_request_min_points}</label>
                        </div>
                        <div class="col"><input type="number" min="0" name="request_min_points"
                                                value="{$ally_request_min_points}" size="30" class="form-control"
                                                id="id-request_min_points"></div>
                    </div>
            </div>
            <div class="card-footer">
                <input class="btn btn-secondary" type="reset" value="{$LNG.al_circular_reset}">
                <input class="btn btn-primary" type="submit" value="{$LNG.al_save}">
            </div>
            </form>
            <div class="card-footer">
                {if $AllianceOwner}
                    <form action="game.php?page=alliance&amp;mode=admin&amp;action=close" method="post"><input
                                type="submit" value="{$LNG.al_disolve_alliance}" class="btn btn-danger"
                                onclick="return confirm('{$LNG.al_close_ally}');"></form>

                    <form action="game.php?page=alliance&amp;mode=admin&amp;action=transfer" method="post">
                        <input type="submit" value="{$LNG.al_transfer_alliance}" class="btn btn-warning"></form>
                {/if}
            </div>
        </div>
    </div>

{/block}
{block name="script" append}
    <script type="text/javascript" src="scripts/base/tinymce/tiny_mce_gzip.js"></script>
    <script type="text/javascript">
        $(function () {
            tinyMCE_GZ.init({
                plugins: 'bbcode,fullscreen',
                themes: 'advanced',
                languages: '{$lang}',
                disk_cache: true,
                debug: false
            }, function () {
                tinyMCE.init({
                    language: '{$lang}',
                    script_url: 'scripts/base/tinymce/tiny_mce.js',
                    theme: "advanced",
                    mode: "textareas",
                    plugins: "bbcode,fullscreen",
                    theme_advanced_buttons1: "bold,italic,underline,undo,redo,link,unlink,image,forecolor,styleselect,removeformat,cleanup,code,fullscreen",
                    theme_advanced_buttons2: "",
                    theme_advanced_buttons3: "",
                    theme_advanced_toolbar_location: "bottom",
                    theme_advanced_toolbar_align: "center",
                    theme_advanced_styles: "Code=codeStyle;Quote=quoteStyle",
                    content_css: "{$dpath}formate.css",
                    entity_encoding: "raw",
                    add_unload_trigger: false,
                    remove_linebreaks: false,
                    fullscreen_new_window: false,
                    fullscreen_settings: {
                        theme_advanced_path_location: "top"
                    }
                });
            });
        });
    </script>
{/block}