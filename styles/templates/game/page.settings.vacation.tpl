{block name="title" prepend}{$LNG.lm_options}{/block}
{block name="content"}
	<div class="col">
		<div class="card">
			<form action="game.php?page=settings&amp;mode=send" method="post">
<div class="card-header">
	<h2 class="card-title">{$LNG.lm_options}</h2>
</div>
				<div class="card-body">
					<div class="alert alert-info">{$LNG.op_vacation_mode_active_message} {$vacationUntil}</div>
					<div class="row mb-2">
						<div class="col"><label for="id-vacation" class="form-label">{$LNG.op_end_vacation_mode}</label></div>
						<div class="col"><input name="vacation" id="id_vacation" type="checkbox" value="1" {if !$canVacationDisbaled}disabled{/if}></div>
					</div>
					<div class="row mb-2">
						<div class="col"><label for="id-delete" class="form-label">{$LNG.op_dlte_account}</label><div class="alert alert-warning">{$LNG.op_dlte_account_descrip}</div></div>
						<div class="col"><input name="delete" class="form-check" id="id-delete" type="checkbox" value="1" {if $delete > 0}checked="checked"{/if}></div>
					</div>
				</div>
				<div class="card-footer">
					<input class="btn btn-primary" type="submit" value="{$LNG.op_save_changes}">
				</div>
			</form>

		</div>

	</div>
{/block}