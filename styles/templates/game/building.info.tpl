<div class='container row'>
    <div class='col-md-4 col-12'>
        <img src='{$dpath}gebaeude/{$elementID}.{if $elementID >=600 && $elementID <= 699}jpg{else}gif{/if}' class='img-fluid'>
    </div>
    <div class='col-md-8 col-12'>
        <h5>{$LNG.tech.{$elementID}}</h5>
        <p>{$LNG.shortDescription.$elementID}</p>
    </div>
</div>