{block name="title" prepend}
    {$LNG.lm_technology}{/block}

{block name="content"}

{if $messages}
    <div class="alert alert-info"><a href="?page=messages">{$messages}</a></div>
{/if}

<div class="card">
    <ul class="nav nav-tabs px-3" id="myTab" role="tablist">
        {foreach from=$TechTreeList key=$elementID item=$requireList name=techniques}
            {if !is_array($requireList)}
                <li class="nav-item" role="presentation">
                    <button class="nav-link p-3 {if $smarty.foreach.techniques.iteration == 1}active{/if}" id="tab-{$requireList}" data-bs-toggle="tab"
                            data-bs-target="#content-{$requireList}" type="button" role="tab"
                            aria-controls="content-{$requireList}"
                            aria-selected="true">{$LNG.tech.$requireList}</button>
                </li>
            {/if}
        {/foreach}
    </ul>
    <div class="tab-content" id="myTabContent">
        <div><div>
            {foreach from=$TechTreeList key=$ID item=$requireList name=techniques}
            {if !is_array($requireList)}
            </div></div>
        <div class="tab-pane fade {if $smarty.foreach.techniques.iteration == 1}show active{/if}" id="content-{$requireList}" role="tabpanel" aria-labelledby="tab-{$requireList}">
            <div class="row row-cols-1 row-cols-md-2 row-cols-xl-4 g-2 build-gutter">
            {else}
            <div class="col">
                <div class="card">
                    <div class="card-header">
                        <h6 class="card-title" onclick="return Dialog.info({$ID})">{$LNG.tech.{$ID}}
                        </h6>
                    </div>

                    <a href="#" onclick="return Dialog.info({$ID})">
                        <img class="card-img-top"
                             src="{$dpath}gebaeude/{$ID}.{if $ID >=600 && $ID <= 699}jpg{else}gif{/if}"
                             alt="{$LNG.tech.{$ID}}">
                    </a>
                    <div class="card-body">
                        {if $requireList }
                        {$LNG.tt_requirements}
                        <ul class="list-group">
                        {foreach $requireList as $requireID => $NeedLevel}
                        <li onclick="return Dialog.info({$requireID});" class="list-group-item list-group-item-{if $NeedLevel.own < $NeedLevel.count}danger{else}success{/if}">{$LNG.tech.$requireID} ({$LNG.tt_lvl} {$NeedLevel.own}/{$NeedLevel.count})</li>
                        {/foreach}
                        </ul>
                        {/if}
                    </div>

                </div>
            </div>

            {/if}
            {/foreach}
        </div>

        {/block}
