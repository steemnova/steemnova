let fleetModal = document.getElementById("fleetTable");
fleetModal.addEventListener('show.bs.modal',function(event) {
    fleetModal.querySelector("input#planetId").value=event.relatedTarget.dataset.planet;
    fleetModal.querySelector("#fleetTableView").href=event.relatedTarget.dataset.href;
})