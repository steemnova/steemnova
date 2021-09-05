function GetOfficerTime(Element, Time)
{
	if(Time == 0)
		return;
	
	$('#time_'+Element).text(GetRestTimeFormat(Time));
	Time--;
	window.setTimeout("GetOfficerTime("+Element+", "+Time+")", 1000)
}

function openPayment() {
	OpenPopup('pay.php?mode=out', 'payment', 650, 350);
}

function buyOfficer(targetId, cost) {
	const http = new HttpHandler();
	http.post('game.php?page=officier&ajax=1', {"id": targetId}, function(data) {
		NotifyBox(data.message, data.error? "danger":"success");
		if(!data.error) {
			let curLevel = parseInt(document.querySelector("#currentLevel"+targetId).innerText);
			document.querySelector("#currentLevel"+targetId).innerText = curLevel+1;
			let dm = parseInt(document.querySelector('#current_darkmatter').dataset.real);
			document.querySelector('#current_darkmatter').dataset.real = dm - Number(cost);
			document.querySelector('#current_darkmatter').innerHTML = shortly_number(document.querySelector('#current_darkmatter').dataset.real);
		}
	})
}