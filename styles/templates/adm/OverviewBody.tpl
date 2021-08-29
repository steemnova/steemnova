{include file="overall_header.tpl"}
<h1>{$LNG.ow_title}</h1>
{foreach item=Message from=$Messages}
    <div class="alert alert-info">{$Message}</div>
{/foreach}

<h2>{$LNG.ow_overview}</h2>
<p>{$LNG.ow_welcome_text}</p>
<a class="float-end btn btn-primary" href="https://github.com/bastiedotorg/quest-of-galaxy/" target="_blank">Project Homepage</a>

<h3>{$LNG.ow_updates}</h3>
<div id="feed"></div>

<hr/>
<h3>{$LNG.ow_credits}</h3>
<h4>{$LNG.ow_proyect_leader}: <a target="_blank" href="https://github.com/bastiedotorg">Bastian</a></h4>

<h4>Original {$LNG.ow_proyect_leader}: <a target="_blank" href="https://github.com/jkroepke">Jan</a></h4>
<table>
    <tr>
        <td><p>&nbsp;</p>
            <h3>{$LNG.ow_translator}</h3></td>
    </tr>
    <tr>
        <td>
            <table>
                <tr>
                    <td>
                        <img src="styles/resource/images/login/flags/us.png" alt="(english)">
                    </td>
                    <td>
                        QwataKayean
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="styles/resource/images/login/flags/pt.png" alt="(portuguese)">
                    </td>
                    <td>
                        QwataKayean
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="styles/resource/images/login/flags/fr.png" alt="(french)">
                    </td>
                    <td>
                        <a href="https://github.com/BigTwoProduction" target="_blank">BigTwoProduction</a>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="styles/resource/images/login/flags/ru.png" alt="(russian)">
                    </td>
                    <td>
                        InquisitorEA
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="styles/resource/images/login/flags/es.png" alt="(spanish)">
                    </td>
                    <td>
                        Orion
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="styles/resource/images/login/flags/tr.png" alt="(turkish)">
                    </td>
                    <td>
                        romansmac
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table>
    <tr>
        <td><p>&nbsp;</p>
            <h3>{$LNG.ow_special_thanks}</h3></td>
    </tr>
    <tr>
        <td>
            <table>
                <tr>
                    <td><a href="https://github.com/Hilarious001"
                                                    target="_blank">Hilarious001</a></td>
                    <td>Ralf M.</td>
                    <td>InquisitorEA</td>
                </tr>
                <tr>
                    <td>lucky</td>
                    <td>Metusalem</td>
                    <td>Meikel</td>
                </tr>
                <tr>
                    <td>Phil</td>
                    <td>Schnippi</td>
                    <td>Vobi</td>
                </tr>
                <tr>
                    <td>Sycrog</td>
                    <td>Raito</td>
                    <td>Chlorel</td>
                </tr>
                <tr>
                    <td>e-Zobar</td>
                    <td>Flousedid</td>
                    <td>jstar</td>
                </tr>
                <tr>
                    <td>scrippi</td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<script type="text/javascript" src="http://www.google.com/jsapi"></script>
<script type="text/javascript">
    google.load("feeds", "1");
    google.setOnLoadCallback(initialize);

    function initialize() {
        var feedControl = new google.feeds.FeedControl();
        feedControl.addFeed("https://github.com/jkroepke/2Moons/commits/master.atom", "");
        //feedControl.addFeed("http://code.google.com/feeds/p/2moons/svnchanges/basic", "");
        feedControl.draw(document.getElementById("feed"));
        //var feedControl = new google.feeds.FeedControl();
        //feedControl.addFeed("https://www.facebook.com/feeds/page.php?id=129282307106646&format=rss20", "");
        //feedControl.draw(document.getElementById("news"));
    }
</script>

{include file="overall_footer.tpl"}