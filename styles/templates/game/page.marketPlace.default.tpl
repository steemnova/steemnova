{block name="title" prepend}{$LNG.lm_marketplace}{/block}
{block name="content"}
    <div class="card">
        <div class="card-header">
            <h2 class="card-title">{$LNG.market_info_header}</h2>
        </div>
        <div class="card-body">
            <p class="card-text">{$LNG.market_info_description}</p>

            <label for="shipT" class="form-label">{$LNG.market_ship_as_first}</label>
            <select id="shipT" class="form-control">
                <option value="1">{$LNG.tech[202]}</option>
                <option value="2" selected>{$LNG.tech[203]}</option>
            </select>


            <ul class="nav nav-tabs px-3" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link p-3 active" id="tab-resource" data-bs-toggle="tab"
                       data-bs-target="#content-resource" role="tab" href="#"
                       aria-controls="content-resource"
                       aria-selected="true">{$LNG.market_resource}</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link p-3" id="tab-fleet" data-bs-toggle="tab"
                       data-bs-target="#content-fleet" href="#" role="tab"
                       aria-controls="content-fleet"
                       aria-selected="false">{$LNG.market_fleet}</a>
                </li>
            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="content-resource" role="tabpanel"
                     aria-labelledby="tab-resource">

                    <!--<table style="width:50%">
                        <tr class="ratio">
                            <td>Reference ratio:</td>
                            <td>
                                <input type="number" name="ratio-metal" value="4" style="width: 30%"/>:<input type="number" name="ratio-cristal" value="2" style="width: 30%"/>:<input type="number"name="ratio-deuterium" value="1" style="width: 30%"/>
                            </td>
                        </tr>
                    </table>-->

                    {include "partial.resource.market.tpl"}
                </div>
                <div class="tab-pane fade" id="content-fleet" role="tabpanel"
                     aria-labelledby="tab-fleet">

                    {include "partial.fleet.market.tpl"}

                </div>
            </div>
        </div>
    </div>
    {if $message}
        <div class="alert alert-info"><h4>{$LNG.fcm_info}</h4>
            {$message}
        </div>
    {/if}
{/block}
{block name="script" append}
    <script src="scripts/base/jquery.tablesorter.js"></script>
    <script>
        /*
    function reloadMarketBox() {
        var cl = $("#resourceMBtn").attr("class");
        var resB = $("#resourceMarketBox");
        if(cl !=null && cl.indexOf("selected") != -1)
            resB.attr("style","display: inline");
        else
            resB.attr("style","display: none");

        cl = $("#fleetMBtn").attr("class");
        var fleetB = $("#fleetMarketBox");
        if(cl !=null && cl.indexOf("selected") != -1)
            fleetB.attr("style","display: inline");
        else
            fleetB.attr("style","display: none");
    }

    $(function() {
    // Set the default
    reloadMarketBox();
    //
    $("#resourceMBtn, #fleetMBtn").on("click", function(){
        $(".marketOption").removeClass("selected");
        $(this).addClass("selected");
        reloadMarketBox();
    });*/

        $("#tradeList").tablesorter({
            headers: {},
            debug: false
        });

        $("#tradeFleetList").tablesorter({
            headers: {},
            debug: false
        });

        $('#shipT').on('change', function (e) {
            var optionSelected = $("option:selected", this);
            var valueSelected = this.value;
            if (valueSelected == 1) {
                $('.HC').hide();
                $('.LC').show();
            }
            if (valueSelected == 2) {
                $('.LC').hide();
                $('.HC').show();
            }
        });

        $('#shipT').trigger("change");

        $(".market_form").submit(function () {
            var c = confirm("{$LNG.market_confirm_are_you_sure}");
            if (c) {
                $(this).append('<input type="hidden" name="shipType" value="' + $("#shipT").val() + '">')
            }
            return c;
        });
        })
        ;</script>
{/block}
