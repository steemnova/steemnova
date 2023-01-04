{block name="title" prepend}{$LNG.siteTitleIndex}{/block}
{block name="content"}
<section>
	<h1>{$descHeader}</h1>
	<p class="desc">{$descText}</p>
	<p class="desc"><ul id="desc_list">{foreach $gameInformations as $info}<li>{$info}</li>{/foreach}</ul></p>
	<p><a href="https://busy.org/@steemnova/steemnova-ogame-based-browsergame-for-steemians" target="copy">SteemNova - OGame-based browsergame for Steemians by @steemnova [busy.org]</a>
	</p>
</section>
<section>
	<div class="contentbox">
		
				<h1>{$LNG.loginHeader}</h1>
				<form id="login" name="login" action="index.php?page=login" data-action="index.php?page=login" method="post">
					<div class="row">
						<select name="uni" id="universe" class="changeAction">{html_options options=$universeSelect selected=$UNI}</select>
						<input name="username" id="username" type="text" placeholder="{$LNG.loginUsername}">
						<input name="password" id="password" type="password" placeholder="{$LNG.loginPassword}">
						{if $verkey["capaktiv"]==1}
							<script src='https://www.google.com/recaptcha/api.js'></script>
							<script>function onSubmit() { document.getElementById("login").submit(); } </script>
							<input class="g-recaptcha" data-sitekey="{$verkey["cappublic"]}" data-callback="onSubmit" type="submit" value="{$LNG.loginButton}">
						{else}
							<input type="submit" value="{$LNG.loginButton}">
						{/if}

					</div>
				</form>
				{if $facebookEnable}<a href="#" data-href="index.php?page=externalAuth&method=facebook" class="fb_login"><img src="styles/resource/images/facebook/fb-connect-large.png" alt=""></a>{/if}
								
				<a href="index.php?page=register"><input value="{$LNG.buttonRegister}"></a>
				<!-- <br><span class="small">{$loginInfo}</span> -->
			
	</div>
</section>
<section>
<!-- 	<div class="button-box">
		<div class="button-box-inner">
			<div class="button-important">
				<a href="index.php?page=register">
					<span class="button-left"></span>
					<span class="button-center">{$LNG.buttonRegister}</span>
					<span class="button-right"></span>
				</a>
			</div>
		</div>
	</div>
	<div class="button-box">
		<div class="button-box-inner">
			{if $mailEnable} 
			<div class="button multi">
				<a href="index.php?page=lostPassword">
					<span class="button-left"></span>
					<span class="button-center">{$LNG.buttonLostPassword}</span>
					<span class="button-right"></span>
				</a>
			</div>
			<div class="button multi">
			{else}
			<div class="button">
			{/if}
				<a href="index.php?page=screens">
					<span class="button-left"></span>
					<span class="button-center">{$LNG.buttonScreenshot}</span>
					<span class="button-right"></span>
				</a>
			</div>
		</div>
	</div> -->
</section>
{/block}
{block name="script" append}
<script>{if $code}alert({$code|json});{/if}</script>
{/block}
