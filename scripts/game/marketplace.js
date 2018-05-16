
//-------------------
function calculateRatios(){
	/*
	 * Thanks to zb0oj for idea and a part of source code!
	 */
	var referenceRatios = {
			'metal': $('input[name=ratio-metal]').val(),
			'cristal': $('input[name=ratio-cristal]').val(),
			'deuterium': $('input[name=ratio-deuterium]').val()
	};
	$('table#tradeList tbody tr').not('.no-background.no-border.center').each(function() {
			var tradeOffer = $(this);
			var offer = {
				'metal': parseInt(tradeOffer.find('.resource_metal').html().replace(/\./g,'')),
				'cristal': parseInt(tradeOffer.find('.resource_crystal').html().replace(/\./g,'')),
				'deuterium': parseInt(tradeOffer.find('.resource_deuterium').html().replace(/\./g,'')),
				'getReference': function() {
					return this.metal / referenceRatios.metal + this.cristal / referenceRatios.cristal + this.deuterium / referenceRatios.deuterium;
				}
			};

			var cost = {
				'isMetal': (tradeOffer.find('.wanted-resource-1').length > 0),
				'isCristal': (tradeOffer.find('.wanted-resource-2').length > 0),
				'isDeuterium': (tradeOffer.find('.wanted-resource-3').length > 0),
				'wantedAmount': parseInt(tradeOffer.find('.wanted-resource-amount').html().replace(/\./g,'')),
				'getReference': function() {
					if(this.isMetal) return this.wantedAmount / referenceRatios.metal;
					if(this.isCristal) return this.wantedAmount / referenceRatios.cristal;
					if(this.isDeuterium) return this.wantedAmount / referenceRatios.deuterium;
				}
			};
			var ratio =  offer.getReference() / cost.getReference();
			tradeOffer.find('.total_value').text(offer.getReference().toFixed(0));
			var n = tradeOffer.find('.ratio').text(ratio.toFixed(2));
			if(ratio < 1) {
				n.css({'color': '#F00'});
			} else {
				n.css({'color': '#0F0'});
			}
		});
}


$(document).ready(function() {
	$("a#addResourceOfferButton, a#addFleetOfferButton").fancybox({
		padding: 0,
		wrapCSS: 'market_dialog',
	});
	$("#resourceMBtn, #fleetMBtn").on("click", function(){
		$(".marketOption").removeClass("selected");
		$(this).addClass("selected");
		reloadMarketBox();
	});

	console.log(window.location.hash);
	if(window.location.hash == "#fleetmarket") {
		$("#fleetMBtn").trigger("click");
	} else {
		$("#resourceMBtn").trigger("click");
	}

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
			if(valueSelected == 1) {
				$('.HC').hide();
				$('.LC').show();
			}
			if(valueSelected == 2) {
				$('.LC').hide();
				$('.HC').show();
			}
	});

	$('#shipT').trigger("change");

	$('input[name=ratio-metal], input[name=ratio-crystal], input[name=ratio-deuterium]').change(function(e){
		calculateRatios();
	});
	calculateRatios();
});

function reloadMarketBox() {
	var cl = $("#resourceMBtn").attr("class");
	var resB = $("#resourceMarketBox");
	if(cl !=null && cl.indexOf("selected") != -1){
		resB.attr("style","display: inline");
		window.location.hash = "#resourcemarket";
	}else
		resB.attr("style","display: none");

	cl = $("#fleetMBtn").attr("class");
	var fleetB = $("#fleetMarketBox");
	if(cl !=null && cl.indexOf("selected") != -1) {
		fleetB.attr("style","display: inline");
		window.location.hash = "#fleetmarket";
	}
	else
		fleetB.attr("style","display: none");
}
