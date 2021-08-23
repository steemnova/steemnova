{include file="ins_header.tpl"}

<div class="card">
	<div class="card-header">
		<h2></h2>
	</div>
	<div class="card-body">
		{if $class == 'noerror'}
		<p class="alert alert-success">{$message}</p>
		{else}
			<p class="alert alert-danger">{$message}</p>
		{/if}
	</div>
	<div class="card-footer">
		{if $class == 'noerror'}
			<a class="btn btn-primary float-end" href="index.php?mode=install&step=5">{$LNG.continue}</a>
		{else}
			{nocache}<a class="btn btn-warning float-begin" href="index.php?mode=install&step=3&amp;host={$host}&amp;port={$port}&amp;user={$user}&amp;dbname={$dbname}&amp;prefix={$prefix}">{/nocache}{$LNG.back}</a>
		{/if}
	</div>
</div>

{include file="ins_footer.tpl"}