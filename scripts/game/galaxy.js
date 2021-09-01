function send_fleet(missionID, planetID, galaxy=null, system=null, planet=null) {
	let targetUrl = planetID !== null ? `game.php?page=fleetAjax&ajax=1&mission=${missionID}&planetID=${planetID}` : `game.php?page=fleetAjax&ajax=1&mission=${missionID}&galaxy=${galaxy}&system=${system}&planet=${planet}`
	$.getJSON(targetUrl, function(data)
	{
		$('#slots').text(data.slots);
		if(typeof data.ships !== "undefined")
		{
			$.each(data.ships, function(elementID, value) {
				$('#elementID'+elementID).text(number_format(value));
			});
		}

		NotifyBox(data.message, data.code === 600 ? "success" : "danger");
	});
}

function send_attack_fleet() {
	let missionID = 1;
	let planetID = document.getElementById("planetId").value;
	let fleetData = [];
	document.querySelectorAll(".fleet-data").forEach(function(item) {
		fleetData["fleet_" + item.dataset.type] = item.value;
	});

	window.http.post(`game.php?page=fleetAjax&ajax=1&mission=${missionID}&planetID=${planetID}`, fleetData, function(data) {
		NotifyBox(data.message, data.code === 600 ? "success" : "danger");
	}, null, false);
}

function galaxy_submit(value) {
	$('#auto').attr('name', value);
	$('#galaxy_form').submit();
}