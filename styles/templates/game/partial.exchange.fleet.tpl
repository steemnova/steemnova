<script>
    function checkMarket() {
        if(document.querySelector("#market_radio_0").checked) {
            document.querySelector('#market_info').classList.remove("show");
            document.querySelector('#market_info_ress').classList.add("show");
        } else {
            document.querySelector('#market_info').classList.add("show");
            document.querySelector('#market_info_ress').classList.remove("show");
        }
    }
</script>
<div class="col">
    <div class="card">
        <div class="card-header">
            <h3>{$LNG.fl_exchange}</h3>
        </div>
        <div class="card-body">
            <span>{$LNG.fl_market_type}</span>

            <input type="radio" value="0" class="btn-check" name="markettype"
                   id="market_radio_0" autocomplete="off" checked="checked" onclick="checkMarket();">
            <label class="btn btn-outline-dark"
                   for="market_radio_0">{$LNG.fl_mt_resources}</label>
            <input type="radio" value="1" class="btn-check" name="markettype"
                   id="market_radio_1" autocomplete="off" onclick="checkMarket();">
            <label class="btn btn-outline-dark"
                   for="market_radio_1">{$LNG.fl_mt_fleet}</label>
            <br />
            <div class="alert alert-info collapse fade" id="market_info">{$LNG.fl_mt_fleet_info}</div>
            <div class="alert alert-info collapse fade show" id="market_info_ress">{$LNG.fl_mt_resources_info}</div>

            {$LNG.market_buy_resources}
            <select name="resEx">
                <option value="1">{$LNG.tech.901}</option>
                <option value="2">{$LNG.tech.902}</option>
                <option value="3">{$LNG.tech.903}</option>
            </select>
            <input name="exchange" size="10" type="number">
            <hr/>
            {$LNG.fl_cargo_capacity}: <span id="remainingresources"></span><br />
            <label for="id-visibility" class="form-label">{$LNG.fl_exchange_with}</label>
            <select name="visibility" id="id-visibility">
                <option value="2" selected>{$LNG.fl_visibility_no_enemies}</option>
                <option value="1">{$LNG.fl_visibility_alliance}</option>
                <option value="0">{$LNG.fl_visibility_all}</option>
            </select><br />
        </div>
        <div class="card-footer">
            <input value="{$LNG.fl_continue}" type="submit" class="btn btn-primary float-end"/>
        </div>
    </div>
</div>
