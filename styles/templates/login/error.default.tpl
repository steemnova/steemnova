{block name="title" prepend}{$LNG.fcm_info}{/block}
{block name="content"}
	<div class="card">
		<div class="card-body">
			<p class="alert alert-warning">{$message}</p>
			{if !empty($redirectButtons)}<p>{foreach $redirectButtons as $button}<a class="btn btn-primary" href="{$button.url}">{$button.label}</a>{/foreach}</p>{/if}
		</div>
	</div>
{/block}
