</main>
{if $ga_active}
<script type="text/javascript">
	var _gaq = _gaq || [];
	_gaq.push(['_setAccount', '{$ga_key}']);
	_gaq.push(['_trackPageview']);

	(function() {
	var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	})();
</script>
{/if}
<script src="./styles/resource/bootstrap/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>
<script>
	document.querySelectorAll("a").forEach(function(item) {
		item.classList.remove("active");
	});
	let a = document.location.pathname.substring(1)+document.location.search;
	document.querySelectorAll("a[href='"+a+"']").forEach(function(item) {
		item.classList.add("active");
		item.parentElement.parentElement.parentElement.classList.add("show");
	});

</script>
{if $debug == 1}
<script type="text/javascript">
	onerror = handleErr;
</script>
{/if}