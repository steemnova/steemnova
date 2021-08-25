{block name="title" prepend}{$LNG.lm_search}{/block}
{block name="content"}
    <div class="col-12 col-md-6 col-lg-8 col-xl-6">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">{$LNG.sh_search_in_the_universe}</h2>
            </div>
            <div class="card-body">
                {html_options options=$modeSelector name="type" id="type" class="form-control"}
                <input class="form-control" type="text" name="searchtext" id="searchtext">
                <input class="btn btn-primary" type="button" value="{$LNG.sh_search}">
            </div>
        </div>
    </div>
{/block}