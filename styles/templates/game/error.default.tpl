{block name="title" prepend}{$LNG.fcm_info}{/block}
{block name="content"}
<div class="card">
	<div class="card-header">
		<h3 class="card-title">{$LNG.fcm_info}</h3>
	</div>
	<div class="card-body">
		<p>{$message}</p>
	</div>
	{if !empty($redirectButtons)}
	<div class="card-footer">
		{foreach $redirectButtons as $button}<a href="{$button.url}" class="btn btn-primary">{$button.label}</a>{/foreach}
	</div>
	{/if}
</div>
{/block}