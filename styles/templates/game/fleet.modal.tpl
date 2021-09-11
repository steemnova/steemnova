<div class="modal fade" id="fleetTable">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <input type="hidden" id="planetId" value="0" name="planet-id"/>
                {include "fleet.table.tpl"}
            </div>
            <div class="modal-footer">
                <a class="btn btn-secondary" data-bs-dismiss="modal">{$LNG.btn_abort}</a>
                <a class="btn btn-primary" href="" id="fleetTableView">{$LNG.galaxy_classic_fleets}</a>
                <a class='list-group-item list-group-item-danger' onclick="send_attack_fleet();" href="#"
                   title='{$LNG['type_mission_1']}'><i class='fas fa-horse'></i> {$LNG['type_mission_1']}</a>
            </div>
        </div>
    </div>
</div>
<script src="scripts/game/fleet.modal.js?2"></script>