var selectShop = "selectShop";
var selectType = "Buy";
/* --------------------------------------------------- */
$(document).ready(function(){
	window.addEventListener("message",function(event){
		switch(event.data.action){
			case "showNUI":
				selectShop = event.data.name;
				selectType = event.data.type;
				$("body").show(500);
				requestShop();
			break;

			case "hideNUI":
				$("body").hide(0);
				$(".ui-tooltip").hide();
			break;

			case "requestShop":
				requestShop();
			break;
		}
	});

	document.onkeyup = data => {
		if (data["key"] === "Escape"){
			$.post("http://shops/close");
			$(".invRight").html("");
			$(".invLeft").html("");
		}
	}
});
/* --------------------------------------------------- */
const updateDrag = () => {
	$(".populated").draggable({
		helper: "clone"
	});

	$('.empty').droppable({
		hoverClass: 'hoverControl',
		drop: function(event,ui){
			if(ui.draggable.parent()[0] == undefined) return;

			const shiftPressed = event.shiftKey;
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;
			const tInv = $(this).parent()[0].className;

			itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };
			const target = $(this).data('slot');

			if (itemData.key === undefined || target === undefined) return;

			let amount = $(".amount").val();
			if (shiftPressed) amount = ui.draggable.data('amount');

			if (tInv === "invLeft"){
				if (origin === "invLeft"){
					$.post("http://shops/populateSlot",JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt(amount)
					}))

					$(".amount").val("");
				} else if (origin === "invRight"){
					$.post("http://shops/functionShops",JSON.stringify({
						shop: selectShop,
						item: itemData.key,
						slot: target,
						amount: parseInt(amount)
					}));

					$(".amount").val("");
				}
			} else if (tInv === "invRight"){
				if (origin === "invLeft" && selectType === "Sell"){
					$.post("http://shops/functionShops",JSON.stringify({
						shop: selectShop,
						item: itemData.key,
						slot: itemData.slot,
						amount: parseInt(amount)
					}));

					$(".amount").val("");
				}
			}
		}
	});

	$('.populated').droppable({
		hoverClass: 'hoverControl',
		drop: function(event,ui){
			if(ui.draggable.parent()[0] == undefined) return;

			const shiftPressed = event.shiftKey;
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;
			const tInv = $(this).parent()[0].className;
			
			itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };
			const target = $(this).data('slot');

			if (itemData.key === undefined || target === undefined) return;

			let amount = $(".amount").val();
			if (shiftPressed) amount = ui.draggable.data('amount');


			if (tInv === "invLeft" ){
				if (origin === "invLeft"){
					$.post("http://shops/updateSlot",JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt(amount)
					}));

					$(".amount").val("");
				} else if (origin === "invRight"){
					$.post("http://shops/functionShops",JSON.stringify({
						shop: selectShop,
						item: itemData.key,
						slot: target,
						amount: parseInt(amount)
					}));

					$(".amount").val("");
				}
			} else if (tInv === "invRight"){
				if (origin === "invLeft" && selectType === "Sell"){
					$.post("http://shops/functionShops",JSON.stringify({
						shop: selectShop,
						item: itemData.key,
						slot: itemData.slot,
						amount: parseInt(amount)
					}));

					$(".amount").val("");
				}
			}
		}
	});

	$(".populated").tooltip({
		create: function(event,ui){
			var max = $(this).attr("data-max");
			var type = $(this).attr("data-type");
			var name = $(this).attr("data-name-key");
			var description = $(this).attr("data-description");

			$(this).tooltip({
				content: `<item>${name}</item>${description !== "undefined" ? "<br><description>"+description+"</description>":""}<br><legenda>Tipo: <r>${type}</r> <s>|</s> Máximo: <r>${max !== "undefined" ? max:"S/L"}</r></legenda>`,
				position: { my: "center top+10", at: "center bottom", collision: "flipfit" },
				show: { duration: 10 },
				hide: { duration: 10 }
			});
		}
	});
}
/* --------------------------------------------------- */
const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--){
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}


const requestShop = () => {
	$.post("http://shops/requestShop",JSON.stringify({ shop: selectShop }),(data) => {


		updateBarValue(data.invPeso,data.invMaxpeso * 100)

		$("#weightTextLeft1").html(`${(data["invPeso"]).toFixed(2)}   /   ${(data["invMaxpeso"]).toFixed(2)}`);

		$(".invLeft").html("");
		$(".invRight").html("");

		if (data["invMaxpeso"] > 100)
			data["invMaxpeso"] = 100;

		for (let x = 1; x <= data["invMaxpeso"]; x++){
			const slot = x.toString();

			if (data.inventoryUser[slot] !== undefined){
				const v = data["inventoryUser"][slot];
				const maxDurability = 86400 * v["days"];
				const newDurability = (maxDurability - v["durability"]) / maxDurability;
				var actualPercent = newDurability * 100;

				if (actualPercent <= 1)
					actualPercent = 1;

				const item = `
				
				
				<div class="item populated" title="" data-max="${v["max"]}" data-type="${v["type"]}" data-description="${v["desc"]}" data-amount="${v["amount"]}" data-peso="${v["peso"]}" data-item-key="${v["key"]}" data-name-key="${v["name"]}" data-slot="${slot}">
				<div class="top">
					<div class="itemWeight">${(v["peso"] * v["amount"]).toFixed(2)}</div>
					<div class="itemAmount">${formatarNumero(v["amount"])}x</div>
				</div>
				<img class="img-inv" src="nui://inventory/web-side/images/${v["index"]}.png" alt="">
				<div class="nameItem">${v["name"]}</div>
				<div class="durability" style="background: ${actualPercent == 1 ? "#fc5858":colorPicker2(actualPercent)};">
					<div class="durability2" style="width: ${actualPercent == 1 ? "100":actualPercent}%; background: ${actualPercent == 1 ? "#fc5858":colorPicker(actualPercent)};"></div>
				</div>
			</div>
				
		`;

				$(".invLeft").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invLeft").append(item);
			}
		}

		const nameList2 = data.inventoryShop.sort((a,b) => (a.name > b.name) ? 1: -1);

		for (let x = 1; x <= 50; x++){
			const slot = x.toString();

			if (nameList2[x-1] !== undefined){
				const v = nameList2[x - 1];

				const item = `
				
				
				<div class="item populated" title="" data-max="${v["max"]}" data-type="${v["type"]}" data-description="${v["desc"]}" data-item-key="${v["key"]}" data-name-key="${v["name"]}" data-price="${v["price"]}" data-peso="${v["peso"]}" data-slot="${slot}">
					<div class="top">
					<div class="itemWeight">${(v["peso"]).toFixed(2)}</div>
						<div class="itemAmount">$${formatarNumero(v["price"])}</div>
					</div>
					<img class="img-inv" src="nui://inventory/web-side/images/${v["index"]}.png" alt="">
					<div class="nameItem">${v["name"]}</div>
					
				</div>
				
			`;

				$(".invRight").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invRight").append(item);
			}
		}
		updateDrag();
	});
}

function somenteNumeros(e){
	var charCode = e.charCode ? e.charCode : e.keyCode;
	if (charCode != 8 && charCode != 9){
		var max = 9;
		var num = $(".amount").val();

		if ((charCode < 48 || charCode > 57)||(num.length >= max)){
			return false;
		}
	}
}


function updateBarValue(peso_inv,peso_max){
	let pesoInv = peso_inv
	let maxPeso = peso_max
	let transformInv = (pesoInv * 100) / maxPeso
	updateColor(transformInv)
}

function updateColor(valor){
	let value = valor;
	if (value >= 100){
		value = 100
	}
	if(value <= 30){
		$('.barra-peso2').css({"background-color": "#12b42d"})
	} else if(value > 30 && value < 70) {
		$('.barra-peso2').css({"background-color": "#faad39"})
	} else if(value > 70) {
		$('.barra-peso2').css({"background-color": "#ff4e4e"})
	}
	$('.barra-peso2').css({"height": value + "%"})
}

function updateBarValue2(peso_inv,peso_max){
	let pesoInv = peso_inv
	let maxPeso = peso_max
	let transformInv = (pesoInv * 100) / maxPeso
	updateColor2(transformInv)
}

function updateColor2(valor){
	let value = valor;
	if (value >= 100){
		value = 100
	}
	if(value <= 30){
		$('.barra-peso4').css({"background-color": "#12b42d"})
	} else if(value > 30 && value < 70) {
		$('.barra-peso4').css({"background-color": "#faad39"})
	} else if(value > 70) {
		$('.barra-peso4').css({"background-color": "#ff4e4e"})
	}
	$('.barra-peso4').css({"height": value + "%"})
}

const colorPicker = (percent) => {
	var colorPercent = "#43e943";

	if (percent >= 100)
		colorPercent = "rgba(255,255,255,0)";

	if (percent >= 51 && percent <= 75)
		colorPercent = "#43e943";

	if (percent >= 26 && percent <= 50)
		colorPercent = "#e9b543";

	if (percent <= 25)
		colorPercent = "#fd2e09";

	return colorPercent;
}

const colorPicker2 = (percent) => {
	var colorPercent = "rgba(15,15,15,0.8)";

	if (percent >= 100)
		colorPercent = "rgba(255,255,255,0)";

	if (percent >= 51 && percent <= 75)
		colorPercent = "rgba(15,15,15,0.8)";

	if (percent >= 26 && percent <= 50)
		colorPercent = "rgba(15,15,15,0.8)";

	if (percent <= 25)
		colorPercent = "rgba(15,15,15,0.8)";

	return colorPercent;
}