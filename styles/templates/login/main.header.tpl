<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="{$lang}" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="{$lang}" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="{$lang}" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="{$lang}" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="{$lang}" class="no-js"> <!--<![endif]-->
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="./styles/resource/bootstrap/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">

	<link rel="stylesheet" type="text/css" href="styles/resource/css/login/main.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="styles/resource/css/base/jquery.fancybox.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="styles/resource/css/login/icon-font/style.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="styles/theme/qog/formate.css?v={$REV}">

	<link rel="apple-touch-icon" sizes="180x180" href="./favicons/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="./favicons/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="./favicons/favicon-16x16.png">
	<link rel="manifest" href="./favicons/site.webmanifest">
	<meta name="msapplication-TileColor" content="#da532c">
	<meta name="theme-color" content="#ffffff">
	<link rel="shortcut icon" href="./favicons/favicon.ico" type="image/x-icon">

	<title>{block name="title"} - {$gameName}{/block}</title>
	<meta name="keywords" content="">
	<meta name="description" content="Massively Multiplayer Online Strategy Game (MMOSG). Space Browsergame with competition between Alliances. Free-to-play, win-to-pay style.">
	<!-- open graph protocol -->
	<meta property="og:title" content="Quest of Galaxy">
	<meta property="og:type" content="website">
	<meta property="og:description" content="Massively Multiplayer Online Strategy Game (MMOSG). Space Browsergame with competition between Alliances. Free-to-play, win-to-pay style.">
	<meta property="og:image" content="styles/resource/images/logo.png">
	<script src="./styles/resource/bootstrap/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>

	<!--[if lt IE 9]>
	<script src="scripts/base/html5.js"></script>
	<![endif]-->
	<script src="scripts/base/jquery.js?v={$REV}"></script>
	<script src="scripts/base/jquery.cookie.js?v={$REV}"></script>
	<script src="scripts/base/jquery.fancybox.js?v={$REV}"></script>
	<script src="scripts/login/main.js"></script>
	<script>{if isset($code)}var loginError = {$code|json};{/if}</script>
	{block name="script"}{/block}	
</head>
<body id="{$smarty.get.page|htmlspecialchars|default:'overview'}" class="{$bodyclass}">
	<div id="page">
