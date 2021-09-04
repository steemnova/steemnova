var resttime	= 0;
var time		= 0;
var endtime		= 0;
var interval	= 0;
var buildname	= "";

function Buildlist() {
	var rest	= resttime - (serverTime.getTime() - startTime) / 1000;
	if (rest <= 0) {
		$('#time').text(Ready);
		$('#command').remove();
		document.title	= Ready + ' - ' + Gamename;
		window.setTimeout(function() {
			window.location.href = 'game.php?page=buildings';
		}, 1000);
		return;
	} else {
		window.setTimeout(Buildlist, 1000);
	}
	document.title = GetRestTimeFormat(rest) + ' - ' + buildname + ' - ' + Gamename;
	
	$('#time').text(GetRestTimeFormat(rest));
}
function initProgress() {
	document.querySelectorAll(".time-progress").forEach(function(item) {
		item.dataset.starttime = new Date().getTime() / 1000;
	})

}
function updateProgress() {
	document.querySelectorAll(".time-progress").forEach(function(item) {
		let percentage = Math.max(1, 100 - 100*(item.dataset.resttime-(new Date().getTime() / 1000 - item.dataset.starttime)) / item.dataset.totaltime);
		item.style.width = `${percentage}%`;
	});
	window.setTimeout(updateProgress, 1000);
}

$(document).ready(function() {
	time		= $('#time').data('time');
	resttime	= $('.time-progress').data('resttime');
	endtime		= $('.timer:first').data('time');
	buildname	= $('.buildlist > table > tbody > tr > td:first').text().replace(/[0-9]+\.:/, '').trim();
    window.setTimeout(Buildlist, 1000);

	initProgress();
	updateProgress();
	Buildlist();
});