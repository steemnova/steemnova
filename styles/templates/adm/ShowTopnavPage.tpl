<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="{$lang}" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="{$lang}" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="{$lang}" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="{$lang}" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="{$lang}" class="no-js"> <!--<![endif]-->
<head>
	<title>{$title}</title>
	{if !empty($goto)}
		<meta http-equiv="refresh" content="{$gotoinsec};URL={$goto}">
	{/if}
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link href="./styles/resource/bootstrap/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">

	<link rel="stylesheet" type="text/css" href="./styles/resource/css/base/boilerplate.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="./styles/resource/css/ingame/main.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="./styles/resource/css/admin/main.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="./styles/resource/css/base/jquery.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="./styles/resource/css/base/jquery.fancybox.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="./styles/resource/css/base/validationEngine.jquery.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="./styles/theme/qog/formate.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="styles/resource/css/login/icon-font/style.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="styles/resource/css/login/steemconnect_button.css?v={$REV}">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600" type="text/css">
	<link rel="shortcut icon" href="./favicon.ico" type="image/x-icon">
	<script type="text/javascript">
		var ServerTimezoneOffset = {$Offset};
		var serverTime 	= new Date({$date.0}, {$date.1 - 1}, {$date.2}, {$date.3}, {$date.4}, {$date.5});
		var xsize 	= screen.width;
		var ysize 	= screen.height;
		var breite	= 720;
		var hoehe	= 300;
		var xpos	= (xsize-breite) / 2;
		var ypos	= (ysize-hoehe) / 2;
		var Ready		= "{$LNG.ready}";
		var Skin		= "{$dpath}";
		var Lang		= "{$lang}";
		var head_info	= "{$LNG.fcm_info}";
		var days 		= {$LNG.week_day|json|default:'[]'}
		var months 		= {$LNG.months|json|default:'[]'} ;
		var tdformat	= "{$LNG.js_tdformat}";
		function openEdit(id, type) {
			var editlist = window.open("?page=qeditor&edit="+type+"&id="+id, "edit", "scrollbars=yes,statusbar=no,toolbar=no,location=no,directories=no,resizable=no,menubar=no,width=850,height=600,screenX="+((xsize-600)/2)+",screenY="+((ysize-850)/2)+",top="+((ysize-600)/2)+",left="+((xsize-850)/2));
			editlist.focus();
		}
	</script>
	<script type="text/javascript" src="./scripts/base/jquery.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/base/jquery.ui.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/base/jquery.cookie.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/base/jquery.fancybox.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/base/jquery.validationEngine.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/l18n/validationEngine/jquery.validationEngine-{$lang}.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/base/tooltip.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/game/base.js?v={$REV}"></script>
	{foreach item=scriptname from=$scripts}
		<script type="text/javascript" src="./scripts/game/{$scriptname}.js?v={$REV}"></script>
	{/foreach}
	<script type="text/javascript">
		$(function() {
			{$execscript}
		});
	</script>
</head>
<body id="{$smarty.get.page|htmlspecialchars|default:'overview'}" class="{$bodyclass}">
<div id="tooltip" class="tip"></div>
<h1 class="text-white">{$adm_cp_title}</h1>
<div class="float-end">
{if $authlevel == $smarty.const.AUTH_ADM}
<select id="universe">
{html_options options=$AvailableUnis selected=$UNI}
</select>
{/if}
<a href="admin.php?page=overview" target="Hauptframe" class="topn">&nbsp;{$adm_cp_index}&nbsp;</a>
{if $authlevel == $smarty.const.AUTH_ADM}
<a href="?page=universe&amp;sid={$sid}" target="Hauptframe" class="topn">&nbsp;{$mu_universe}&nbsp;</a>
<a href="?page=rights&amp;mode=rights&amp;sid={$sid}" target="Hauptframe" class="topn">&nbsp;{$mu_moderation_page}&nbsp;</a>
<a href="?page=rights&amp;mode=users&amp;sid={$sid}" target="Hauptframe" class="topn">&nbsp;{$ad_authlevel_title}&nbsp;</a>
{/if}
{if $id == 1}
<a href="?page=reset&amp;sid={$sid}" target="Hauptframe" class="topn">&nbsp;{$re_reset_universe}&nbsp;</a>
{/if}
<a href="javascript:top.location.href='game.php';" target="_top" class="out">&nbsp;{$adm_cp_logout}&nbsp;</a>
</div>
<script>
$(function() {
	$('#universe').on('change', function(e) {
		parent.frames['Hauptframe'].location.href = parent.frames['Hauptframe'].location.href+'&uni='+$(this).val();
		parent.frames['rightFrame'].location.reload();
	});
});
</script>
{if isset($smarty.get.reload)}
	{if $smarty.get.reload == 't'}
		<script type="text/javascript">
			parent.topFrame.document.location.reload();
		</script>
	{elseif $smarty.get.reload == 'l'}
		<script type="text/javascript">
			parent.rightFrame.document.location.reload();
		</script>
	{elseif $smarty.get.reload == 'r'}
		<script type="text/javascript">
			top.document.location.reload();
		</script>
	{/if}
{/if}
</body>
</html>