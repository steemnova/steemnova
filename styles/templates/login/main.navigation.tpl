<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Quest of Galaxy</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <ul class="navbar-nav me-auto mb-2 mb-md-0">
                <li class="nav-item"><a class="nav-link" href="index.php">{$LNG.menu_index}</a></li>
                <li class="nav-item"><a class="nav-link" href="index.php?page=board" target="board">{$LNG.forum}</a></li>
                <li class="nav-item"><a class="nav-link" href="index.php?page=news">{$LNG.menu_news}</a></li>
                <li class="nav-item"><a class="nav-link" href="index.php?page=rules">{$LNG.menu_rules}</a></li>
                <li class="nav-item"><a class="nav-link" href="index.php?page=battleHall">{$LNG.menu_battlehall}</a></li>
                <li class="nav-item"><a class="nav-link" href="index.php?page=banList">{$LNG.menu_banlist}</a></li>
                <li class="nav-item"><a class="nav-link" href="index.php?page=disclamer">{$LNG.menu_disclamer}</a></li>
            </ul>
            <ul class="navbar-nav me-auto mb-2 mb-md-0">
                {if count($languages) > 1}
                    <ul id="language">
                        {foreach $languages as $langKey => $langName}
                            <li class="nav-item"><a class="nav-link" href="?lang={$langKey}" rel="alternate" hreflang="{$langKey}" title="{$langName}"><span class="flags {$langKey}">{$langName}</span></a></li>
                        {/foreach}
                    </ul>
                {/if}
            </ul>
        </div>
    </div>
</nav>
