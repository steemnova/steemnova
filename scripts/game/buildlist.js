var resttime	= 0;
var time		= 0;
var endtime		= 0;
var interval	= 0;
var buildname	= "";

function Buildlist() {
	var rest	= resttime - (serverTime.getTime() - startTime) / 1000;
	if (rest <= 0) {
		document.querySelector('#time').innerText = GetRestTimeFormat(Ready);
		document.title	= Ready + ' - ' + Gamename;
		window.setTimeout(function() {
			window.location.href = buildUrl;
		}, 1000);
		return;
	} else {
		window.setTimeout(Buildlist, 1000);
	}
	document.title = GetRestTimeFormat(rest) + ' - ' + buildname + ' - ' + Gamename;
	
	document.querySelector('#time').innerText = GetRestTimeFormat(rest);
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

window.onload = function() {
	time		= document.querySelector('#time').dataset.time;
	resttime	= document.querySelector('.time-progress').dataset.resttime;
	endtime	= document.querySelector('.time-progress').dataset.totaltime
	buildname	= document.querySelector('#buildqueue-1').dataset.name;
    window.setTimeout(Buildlist, 1000);

	initProgress();
	updateProgress();
	Buildlist();
};