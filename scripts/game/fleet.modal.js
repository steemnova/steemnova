let fleetModal = document.getElementById("fleetTable");
fleetModal.addEventListener('show.bs.modal',function(event) {
    fleetModal.querySelector("input#planetId").value=event.relatedTarget.dataset.planet;
    fleetModal.querySelector("#fleetTableView").href=event.relatedTarget.dataset.href;
})

function computeFleetPower() {
    let totalAttack = 0;
    let totalShields = 0;
    document.querySelectorAll(".fleet-data").forEach(function(item) {
        if(item.value) {
            totalAttack += item.value * item.dataset.attack;
            totalShields += item.value * item.dataset.shields;
        }
    });
    document.getElementById("totalAttack").innerHTML = shortly_number(totalAttack);
    document.getElementById("totalShields").innerHTML = shortly_number(totalShields);
}

function maxShip(id) {
    if (document.getElementsByName(id)[0]) {
        var amount = document.getElementById(id + "_value").innerHTML;
        document.getElementsByName(id)[0].value = amount.replace(/\./g, "");
    }
    computeFleetPower();
}

function noShip(id) {
    if (document.getElementsByName(id)[0]) {
        document.getElementsByName(id)[0].value = 0;
    }
    computeFleetPower();
}

