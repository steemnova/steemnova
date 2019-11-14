<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="{$lang}" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="{$lang}" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="{$lang}" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="{$lang}" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="{$lang}" class="no-js"> <!--<![endif]-->
<head>
	<title>{block name="title"} - {$uni_name} - {$game_name}{/block}</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	{if !empty($goto)}
	<meta http-equiv="refresh" content="{$gotoinsec};URL={$goto}">
	{/if}
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="./styles/resource/css/base/boilerplate.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="./styles/resource/css/ingame/main.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="./styles/resource/css/base/jquery.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="./styles/resource/css/base/jquery.fancybox.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="./styles/resource/css/base/validationEngine.jquery.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="{$dpath}formate.css?v={$REV}">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.12/css/all.css">
	<link rel="shortcut icon" href="./favicon.ico" type="image/x-icon">
	<script type="text/javascript">
	var ServerTimezoneOffset = {$Offset};
	var serverTime 	= new Date({$date.0}, {$date.1 - 1}, {$date.2}, {$date.3}, {$date.4}, {$date.5});
	var startTime	= serverTime.getTime();
	var localTime 	= serverTime;
	var localTS 	= startTime;
	var Gamename	= document.title;
	var Ready		= "{$LNG.ready}";
	var Skin		= "{$dpath}";
	var Lang		= "{$lang}";
	var head_info	= "{$LNG.fcm_info}";
	var auth		= {$authlevel|default:'0'};
	var days 		= {$LNG.week_day|json|default:'[]'} 
	var months 		= {$LNG.months|json|default:'[]'} ;
	var tdformat	= "{$LNG.js_tdformat}";
	var queryString	= "{$queryString|escape:'javascript'}";
	var isPlayerCardActive	= "{$isPlayerCardActive|json}";

	setInterval(function() {
		serverTime.setSeconds(serverTime.getSeconds()+1);
	}, 1000);
	</script>
	<script type="text/javascript" src="./scripts/base/jquery.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/base/jquery.ui.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/base/jquery.cookie.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/base/jquery.fancybox.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/base/jquery.validationEngine.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/l18n/validationEngine/jquery.validationEngine-{$lang}.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/base/tooltip.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/game/base.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/base/steem.min.js"></script>
	{foreach item=scriptname from=$scripts}
	<script type="text/javascript" src="./scripts/game/{$scriptname}.js?v={$REV}"></script>
	{/foreach}
	{block name="script"}
  <script>
   $(function(){
            $("#btn1").on('click',function() {
                $(".infoso").hide();
                $(".infos").show();
$("#btn2, #btn3").removeClass("selected");
	
$(this).addClass("selected");
            }); 
        });
 $(function(){
            $("#btn2").on('click',function() {
                $(".infos").toggle();
                $(".infoso").show();
$("#btn1, #btn3").removeClass("selected");
	
$(this).addClass("selected");
            }); 
        });
 $(function(){
            $("#btn3").on('click',function() {
                $(".infos").show();
                $(".infoso").show();
$("#btn2, #btn1").removeClass("selected");
	
$(this).addClass("selected");
            }); 
        });

 $(function(){
            $("#lab1").on('click',function() {
                $(".infos").hide();
                $("#t108, #t113, #t114, #t123, #t124").show();
$("#lab2, #lab3, #lab4, #lab5").removeClass("selected");
	
$(this).addClass("selected");
            }); 
        });
 $(function(){
            $("#lab2").on('click',function() {
                $(".infos").hide();
                $("#t109, #t106, #t110, #t111, #t120, #t121, #t122, #t199").show();
$("#lab1, #lab3, #lab4, #lab5").removeClass("selected");
	
$(this).addClass("selected");
            }); 
        });
 $(function(){
            $("#lab3").on('click',function() {
                $(".infos").hide();
                $("#t114, #t115, #t117, #t118").show();
$("#lab2, #lab1, #lab4, #lab5").removeClass("selected");
	
$(this).addClass("selected");
            }); 
        });
 $(function(){
            $("#lab4").on('click',function() {
                $(".infos").hide();
                $("#t131, #t132, #t133").show();
$("#lab2, #lab1, #lab3, #lab5").removeClass("selected");
	
$(this).addClass("selected");
            }); 
        });
 $(function(){
            $("#lab5").on('click',function() {
                $(".infos").show();
                
$("#lab2, #lab1, #lab4, #lab3").removeClass("selected");
	
$(this).addClass("selected");
            }); 
        });

$(function(){
            $("#0h").on('click',function() {
                for(i=1;i<=99;i++)
                $("#h"+i).hide();
$("#0s").show();
$("#0h").hide();
                
            }); 
        });

      $(function(){
            $("#0s").on('click',function() {
                for(i=1;i<=99;i++)
                $("#h"+i).show();
$("#0h").show();
$("#0s").hide();
                
            }); 
        });

  $(function(){
            $("#100h").on('click',function() {
for(i=101;i<=199;i++)
                $("#h"+i).hide();
$("#100s").show();
$("#100h").hide();
                
            }); 
        });

  $(function(){
            $("#100s").on('click',function() {
for(i=101;i<=199;i++)
                $("#h"+i).show();
$("#100h").show();
$("#100s").hide();
                
            }); 
        });

  $(function(){

            $("#200h").on('click',function() {
for(i=201;i<=299;i++)
                $("#h"+i).hide();
$("#200s").show();
$("#200h").hide();
                
            }); 
        });
 $(function(){

            $("#200s").on('click',function() {
for(i=201;i<=299;i++)
                $("#h"+i).show();
$("#200s").hide();
$("#200h").show();
                
            }); 
        });
  $(function(){

            $("#400h").on('click',function() {
for(i=401;i<=499;i++)
                $("#h"+i).hide();
$("#400s").show();
$("#400h").hide();
                
            }); 
        });
 $(function(){

            $("#400s").on('click',function() {
for(i=401;i<=499;i++)
                $("#h"+i).show();
$("#400s").hide();
$("#400h").show();
                
            }); 
        });
  $(function(){

            $("#500h").on('click',function() {
for(i=501;i<=599;i++)
                $("#h"+i).hide();
$("#500s").show();
$("#500h").hide();
                
            }); 
        });
 $(function(){

            $("#500s").on('click',function() {
for(i=501;i<=599;i++)
                $("#h"+i).show();
$("#500s").hide();
$("#500h").show();
                
            }); 
        });
  $(function(){

            $("#600h").on('click',function() {
for(i=601;i<=699;i++)
                $("#h"+i).hide();
$("#600s").show();
$("#600h").hide();
                
            }); 
        });
 $(function(){

            $("#600s").on('click',function() {
for(i=601;i<=699;i++)
                $("#h"+i).show();
$("#600s").hide();
$("#600h").show();
                
            }); 
        }); 

    </script>
{/block}
	<script type="text/javascript">
	$(window).scroll(function(){
		// affix
		windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
		lastScroll = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop;
		
		// menu
		elementHeight = document.getElementsByTagName("menu")[0].getElementsByClassName("fixed")[0].clientHeight;
		element = document.getElementsByTagName("menu")[0].getElementsByClassName("fixed")[0];
		if (elementHeight > windowHeight - 100){
			a = 100 - lastScroll;
			b = windowHeight - elementHeight;
			scrollTo = Math.max(a, b);
			element.style.top = scrollTo + 'px';
		}
	});
	$(function() {
		{$execscript}
	});
	</script>
</head>
<body id="{$smarty.get.page|htmlspecialchars|default:'overview'}" class="{$bodyclass}">
	<div id="tooltip" class="tip"></div>