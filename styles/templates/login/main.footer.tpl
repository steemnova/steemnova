<footer>
</footer>
</div>

<div id="dialog" style="display:none;"></div>
<!-- Cookie Banner -->
<div class="nk-cookie-banner alert alert-dark text-center mb-0" role="alert">
	{$LNG.cookie_info}
	<a href="?page=disclaimer">{$LNG.learn_more}</a>
	<button type="button" class="btn btn-primary btn-sm ms-3" onclick="window.nk_hideCookieBanner()">
		I Got It
	</button>
</div>
<!-- End of Cookie Banner -->

<script>
	/* Javascript to show and hide cookie banner using localstroage */
	/* Shows the Cookie banner */
	function showCookieBanner(){
		let cookieBanner = document.getElementsByClassName("nk-cookie-banner")[0];
		cookieBanner.style.display = "block";
	}
	/* Hides the Cookie banner and saves the value to localstorage */
	function hideCookieBanner(){
		localStorage.setItem("qog_isCookieAccepted", "yes");
		let cookieBanner = document.getElementsByClassName("nk-cookie-banner")[0];
		cookieBanner.style.display = "none";
	}
	/* Checks the localstorage and shows Cookie banner based on it. */
	function initializeCookieBanner(){
		let isCookieAccepted = localStorage.getItem("qog_isCookieAccepted");
		if(isCookieAccepted === null)
		{
			localStorage.clear();
			localStorage.setItem("qog_isCookieAccepted", "no");
			showCookieBanner();
		}
		if(isCookieAccepted === "no"){
			showCookieBanner();
		}
	}
	// Assigning values to window object

	window.nk_hideCookieBanner = hideCookieBanner;
	initializeCookieBanner();
	var LoginConfig = {
    'isMultiUniverse': {$isMultiUniverse|json},
	'unisWildcast': {$unisWildcast|json},
	'referralEnable' : {$referralEnable|json},
	'basePath' : {$basepath|json}
};
</script>
{if $analyticsEnable}
<script type="text/javascript" src="http://www.google-analytics.com/ga.js"></script>
<script type="text/javascript">
try{
var pageTracker = _gat._getTracker("{$analyticsUID}");
pageTracker._trackPageview();
} catch(err) {}
initializeCookieBanner();>
</script>
{/if}
</body>
</html>