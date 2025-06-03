$(document).ready(function(){
    window.addEventListener("message",function(event){
        switch(event["data"]["action"]){
            case "showMenu":
                $("#nomeperso").html(event.data.nome);
                $("#cargoperso").html(event.data.cargo);
                updateCargos(event.data.cargo); // Atualiza os cargos dinamicamente
                $("#vipPlayer").html(event.data.vip);
                $("#bancoPlayer").html(event.data.banco + " $");
                $("#telefonePlayer").html(event.data.celular);
                $("#idadePlayer").html(event.data.sangue);
                $("#perolasPlayer").html(event.data.gemas);
                $("#warningsPlayer").html(event.data.warnings);
                $("#passaporteslds").html(event.data.user_id);
                $(".imgperso").attr(`src`,`${event.data.imagem}` );

                if (event.data.item_inv == true){
                    $(".identidadePart3").hide();
                    $(".identidadePart2").show();
                } else { 
                    $(".identidadePart2").hide();
                    $(".identidadePart3").show();
                }

                // Carregar hotbar se existir
                if (event.data.hotbar) {
                    loadHotbar(event.data.hotbar);
                }

                updateMochila();
                $("body").show(500);
            break;

            case "hideMenu":
                $("body").hide(500);
                $(".ui-tooltip").hide();
            break;

            case "updateMochila":
                updateMochila();
            break;

            case "updateHotbar":
                if (event.data.hotbar) {
                    loadHotbar(event.data.hotbar);
                }
            break;
        }
    });

    document.onkeyup = data => {
        if (data["key"] === "Escape"){
            $.post("http://inventory/invClose");
            $(".invRight").html("");
            $(".invLeft").html("");
            
            // Limpar hotbar visual (mas manter os dados)
            for (let i = 1; i <= 4; i++) {
                const hotbarSlot = $(`.hotbar-slot[data-slot="${i}"]`);
                hotbarSlot.removeClass('has-item');
                hotbarSlot.html(`<span class="slot-number">${i}</span>`);
                hotbarSlot.removeAttr('title');
            }
        }
    };
});

const updateDrag = () => {
    $(".populated").draggable({
        helper: "clone",
        start: function(event, ui) {
            ui.helper.css("z-index", 9999);
        }
    });

    // Permitir arrastar da hotbar
    $(".hotbar-slot.has-item").draggable({
        helper: "clone",
        revert: "invalid"
    });

    // Hotbar aceita itens do inventário
    $(".hotbar-slot").droppable({
        hoverClass: "hoverControl",
        accept: ".populated",
        drop: function(event, ui) {
            if(ui.draggable.parent()[0] == undefined) return;
            
            const origin = ui.draggable.parent()[0].className;
            if (origin !== "invLeft") return; // Só aceita itens do inventário principal
            
            const hotbarSlot = $(this).data("slot");
            const itemData = {
                key: ui.draggable.data("item-key"),
                slot: ui.draggable.data("slot"),
                name: ui.draggable.data("name-key"),
                amount: ui.draggable.data("amount"),
                index: ui.draggable.find('.img-inv').attr('src').match(/images\/(.+)\.png/)[1],
                peso: ui.draggable.data("peso")
            };
            
            // Verificar se já existe um item neste slot da hotbar
            if ($(this).hasClass('has-item')) {
                // Substituir item existente - devolver o item anterior para o inventário
                const oldItem = hotbarData[hotbarSlot];
                
                // Enviar item antigo de volta para o inventário
                $.post("http://inventory/returnHotbarItem", JSON.stringify({
                    item: oldItem
                }));
            }
            
            // Remover o item do inventário (transformar em slot vazio)
            const originalSlot = ui.draggable.data("slot");
            ui.draggable.replaceWith(`<div class="item empty" data-slot="${originalSlot}"></div>`);
            
            // Atualizar visual da hotbar
            updateHotbarSlot(hotbarSlot, itemData);
            
            // Reativar o drag & drop para o novo slot vazio
            updateDrag();
            
            // Enviar para o backend
            $.post("http://inventory/moveToHotbar", JSON.stringify({
                slot: hotbarSlot,
                item: itemData,
                originalSlot: originalSlot
            }));
            
        }
    });

    $(".empty").droppable({
        hoverClass: "hoverControl",
        accept: ".populated, .hotbar-slot.has-item",
        drop: function(event, ui) {
            // Se for da hotbar
            if (ui.draggable.hasClass("hotbar-slot")) {
                const hotbarSlot = ui.draggable.data("slot");
                const itemData = hotbarData[hotbarSlot];
                const targetSlot = $(this).data("slot");

                // Atualiza visual do inventário
                const item = `
                    <div class="item populated" title="" data-max="${itemData.max || ''}" data-type="${itemData.type || ''}" data-description="${itemData.desc || ''}" data-amount="${itemData.amount}" data-peso="${itemData.peso}" data-item-key="${itemData.key}" data-name-key="${itemData.name}" data-slot="${targetSlot}">
                        <div class="top">
                            <div class="itemWeight">${(itemData.peso * itemData.amount).toFixed(2)}</div>
                            <div class="itemAmount">${formatarNumero(itemData.amount)}x</div>
                        </div>
                        <img class="img-inv" src="images/${itemData.index}.png" alt="" data-max="${itemData.max || ''}" data-type="${itemData.type || ''}" data-description="${itemData.desc || ''}" data-amount="${itemData.amount}" data-peso="${itemData.peso}" data-item-key="${itemData.key}" data-name-key="${itemData.name}" data-slot="${targetSlot}">
                        <div class="nameItem">${itemData.name}</div>
                    </div>`;
                $(this).replaceWith(item);

                // Remove visualmente da hotbar
                updateHotbarSlot(hotbarSlot, null);

                // Atualiza drag & drop
                updateDrag();


                // Notifica o backend para atualizar
                $.post("http://inventory/returnHotbarToInventory", JSON.stringify({
                    slot: hotbarSlot,
                    item: itemData,
                    target: targetSlot
                }));
            } else {
                if(ui.draggable.parent()[0] == undefined) return;

                const shiftPressed = event.shiftKey;
                const origin = ui.draggable.parent()[0].className;
                if (origin === undefined) return;
                const tInv = $(this).parent()[0].className;

                if(origin === "invRight" && tInv === "invRight") return;
                
                itemData = { key: ui.draggable.data("item-key"), slot: ui.draggable.data("slot") };
                const target = $(this).data("slot");

                if (itemData.key === undefined || target === undefined) return;

                let amount = 0;
                let itemAmount = parseInt(ui.draggable.data("amount"));

                if (shiftPressed)
                    amount = itemAmount;
                else if($(".amount").val() == "" | parseInt($(".amount").val()) <= 0)
                    amount = 1;
                else
                    amount = parseInt($(".amount").val());

                if(amount > itemAmount)
                    amount = itemAmount;

                $(".populated, .empty, .use, .send, .deliver").off("draggable droppable");

                let clone1 = ui.draggable.clone();
                let slot2 = $(this).data("slot"); 

                if(amount == itemAmount) {
                    let clone2 = $(this).clone();
                    let slot1 = ui.draggable.data("slot");

                    $(this).replaceWith(clone1);
                    ui.draggable.replaceWith(clone2);
                    
                    $(clone1).data("slot", slot2);
                    $(clone2).data("slot", slot1);
                } else {
                    let newAmountOldItem = itemAmount - amount;
                    let weight = parseFloat(ui.draggable.data("peso"));
                    let newWeightClone1 = (amount*weight).toFixed(2);
                    let newWeightOldItem = (newAmountOldItem*weight).toFixed(2);

                    ui.draggable.data("amount",newAmountOldItem);

                    clone1.data("amount",amount);

                    $(this).replaceWith(clone1);
                    $(clone1).data("slot",slot2);

                    ui.draggable.children(".top").children(".itemAmount").html(formatarNumero(ui.draggable.data("amount")) + "x");
                    ui.draggable.children(".top").children(".itemWeight").html(newWeightOldItem);
                    
                    $(clone1).children(".top").children(".itemAmount").html(formatarNumero(clone1.data("amount")) + "x");
                    $(clone1).children(".top").children(".itemWeight").html(newWeightClone1);
                }

                updateDrag();

                if (origin === "invLeft" && tInv === "invLeft"){
                    $.post("http://inventory/updateSlot",JSON.stringify({
                        item: itemData.key,
                        slot: itemData.slot,
                        target: target,
                        amount: parseInt(amount)
                    }));
                } else if (origin === "invRight" && tInv === "invLeft"){
                    const id = ui.draggable.data("id");
                    $.post("http://inventory/pickupItem",JSON.stringify({
                        id: id,
                        target: target,
                        amount: parseInt(amount)
                    }));
                } else if (origin === "invLeft" && tInv === "invRight"){
                    $.post("http://inventory/dropItem",JSON.stringify({
                        item: itemData.key,
                        slot: itemData.slot,
                        amount: parseInt(amount)
                    }));
                }

                $(".amount").val("");
            }
        }
    });

    $(".populated").droppable({
        hoverClass: "hoverControl",
        drop: function(event,ui){
            if(ui.draggable.parent()[0] == undefined) return;

            const shiftPressed = event.shiftKey;
            const origin = ui.draggable.parent()[0].className;
            if (origin === undefined) return;
            const tInv = $(this).parent()[0].className;

            if(origin === "invRight" && tInv === "invRight") return;

            itemData = { key: ui.draggable.data("item-key"), slot: ui.draggable.data("slot") };
            const target = $(this).data("slot");

            if (itemData.key === undefined || target === undefined) return;

            let amount = 0;
            let itemAmount = parseInt(ui.draggable.data("amount"));

            if (shiftPressed)
                amount = itemAmount;
            else if($(".amount").val() == "" | parseInt($(".amount").val()) <= 0)
                amount = 1;
            else
                amount = parseInt($(".amount").val());

            if(amount > itemAmount)
                amount = itemAmount;

            $(".populated, .empty, .use, .send, .deliver").off("draggable droppable");

            if(ui.draggable.data("item-key") == $(this).data("item-key")){
                let newSlotAmount = amount + parseInt($(this).data("amount"));
                let newSlotWeight = ui.draggable.data("peso") * newSlotAmount;

                $(this).data("amount",newSlotAmount);
                $(this).children(".top").children(".itemAmount").html(formatarNumero(newSlotAmount) + "x");
                $(this).children(".top").children(".itemWeight").html(newSlotWeight.toFixed(2));

                if(amount == itemAmount) {
                    ui.draggable.replaceWith(`<div class="item empty" data-slot="${ui.draggable.data("slot")}"></div>`);
                } else {
                    let newMovedAmount = itemAmount - amount;
                    let newMovedWeight = parseFloat(ui.draggable.data("peso")) * newMovedAmount;

                    ui.draggable.data("amount",newMovedAmount);
                    ui.draggable.children(".top").children(".itemAmount").html(formatarNumero(newMovedAmount) + "x");
                    ui.draggable.children(".top").children(".itemWeight").html(newMovedWeight.toFixed(2));
                }
            } else {
                if (origin === "invRight" && tInv === "invLeft") return;

                let clone1 = ui.draggable.clone();
                let clone2 = $(this).clone();

                let slot1 = ui.draggable.data("slot");
                let slot2 = $(this).data("slot");

                ui.draggable.replaceWith(clone2);
                $(this).replaceWith(clone1);

                $(clone1).data("slot",slot2);
                $(clone2).data("slot",slot1);
            }

            updateDrag();

            if (origin === "invLeft" && tInv === "invLeft") {
                $.post("http://inventory/updateSlot",JSON.stringify({
                    item: itemData.key,
                    slot: itemData.slot,
                    target: target,
                    amount: parseInt(amount)
                }));
            } else if (origin === "invRight" && tInv === "invLeft"){
                const id = ui.draggable.data("id");
                $.post("http://inventory/pickupItem",JSON.stringify({
                    id: id,
                    target: target,
                    amount: parseInt(amount)
                }));
            } else if (origin === "invLeft" && tInv === "invRight"){
                $.post("http://inventory/dropItem",JSON.stringify({
                    item: itemData.key,
                    slot: itemData.slot,
                    amount: parseInt(amount)
                }));
            }

            $(".amount").val("");
        }
    });

    $(".use").droppable({
        hoverClass: "hoverControl",
        drop: function(event,ui){
            if(ui.draggable.parent()[0] == undefined) return;

            const shiftPressed = event.shiftKey;
            const origin = ui.draggable.parent()[0].className;
            if (origin === undefined || origin === "invRight") return;
            itemData = { key: ui.draggable.data("item-key"), slot: ui.draggable.data("slot") };

            if (itemData.key === undefined) return;

            let amount = $(".amount").val();
            if (shiftPressed) amount = ui.draggable.data("amount");

            $.post("http://inventory/useItem",JSON.stringify({
                slot: itemData.slot,
                amount: parseInt(amount)
            }));

            $(".amount").val("");
        }
    });

    $(".send").droppable({
        hoverClass: "hoverControl",
        drop: function(event,ui){
            if(ui.draggable.parent()[0] == undefined) return;

            const shiftPressed = event.shiftKey;
            const origin = ui.draggable.parent()[0].className;
            if (origin === undefined || origin === "invRight") return;
            itemData = { key: ui.draggable.data("item-key"), slot: ui.draggable.data("slot") };

            if (itemData.key === undefined) return;

            let amount = $(".amount").val();
            if (shiftPressed) amount = ui.draggable.data("amount");

            $.post("http://inventory/sendItem",JSON.stringify({
                slot: itemData.slot,
                amount: parseInt(amount)
            }));

            $(".amount").val("");
        }
    });

    $(".lixo").droppable({
        hoverClass: "hoverControl",
        drop: function(event,ui){
            if(ui.draggable.parent()[0] == undefined) return;

            const shiftPressed = event.shiftKey;
            const origin = ui.draggable.parent()[0].className;
            if (origin === undefined || origin === "invRight") return;
            itemData = { key: ui.draggable.data("item-key"), slot: ui.draggable.data("slot") };

            if (itemData.key === undefined) return;

            let amount = $(".amount").val();
            if (shiftPressed) amount = ui.draggable.data("amount");

            $.post("http://inventory/lixoItem",JSON.stringify({
                item: itemData.key,
                slot: itemData.slot,
                amount: parseInt(amount)
            }));

            $(".amount").val("");
        }
    });

    $(".deliver").droppable({
        hoverClass: "hoverControl",
        drop: function(event,ui){
            if(ui.draggable.parent()[0] == undefined) return;

            const shiftPressed = event.shiftKey;
            const origin = ui.draggable.parent()[0].className;
            if (origin === undefined || origin === "invRight") return;
            itemData = { key: ui.draggable.data("item-key"), slot: ui.draggable.data("slot") };

            if (itemData.key === undefined) return;

            let amount = $(".amount").val();
            if (shiftPressed) amount = ui.draggable.data("amount");

            $.post("http://inventory/Deliver",JSON.stringify({
                slot: itemData.slot,
                amount: parseInt(amount)
            }));

            $(".amount").val("");
        }
    });

    $(".populated").on("auxclick", e => {
        if (e["which"] === 3){
            const item = e["target"];
            const shiftPressed = event.shiftKey;
            const origin = $(item).parent()[0].className;
            if (origin === undefined || origin === "invRight") return;

            itemData = { key: $(item).data("item-key"), slot: $(item).data("slot") };

            if (itemData.key === undefined) return;

            let amount = $(".amount").val();
            if (shiftPressed) amount = $(item).data("amount");

            $.post("http://inventory/useItem",JSON.stringify({
                slot: itemData.slot,
                amount: parseInt(amount)
            }));
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

const updateMochila = () => {
	$.post("http://inventory/requestInventory",JSON.stringify({}),(data) => {
		$("#weightTextLeft").html(`${(data["invPeso"]).toFixed(2)} / ${(data["invMaxpeso"]).toFixed(2)}`);

		updateBarValue(data["invPeso"],data["invMaxpeso"])

		$(".invLeft").html("");
		$(".invRight").html("");

		if (data["invMaxpeso"] > 100)
			data["invMaxpeso"] = 100;

		const nameList2 = data["drop"].sort((a,b) => (a["name"] > b["name"]) ? 1:-1);

		for (let x = 1; x <= data["invMaxpeso"]; x++){
			
			const slot = x.toString();
		
			if (data["inventario"][slot] !== undefined){
				
				const v = data["inventario"][slot];
				const maxDurability = 86400 * v["days"];
				const newDurability = (maxDurability - v["durability"]) / maxDurability;
				var actualPercent = parseInt(newDurability * 100);

				if (actualPercent <= 1)
					actualPercent = 1;

				const item = `
				
					<div class="item populated" title="" data-max="${v["max"]}" data-type="${v["type"]}" data-description="${v["desc"]}" data-amount="${v["amount"]}" data-peso="${v["peso"]}" data-item-key="${v["key"]}" data-name-key="${v["name"]}" data-slot="${slot}">
						<div class="top">
							<div class="itemWeight">${(v["peso"] * v["amount"]).toFixed(2)}</div>
							<div class="itemAmount">${formatarNumero(v["amount"])}x</div>
						</div>
						<img class="img-inv" src="images/${v["index"]}.png" alt="" data-max="${v["max"]}" data-type="${v["type"]}" data-description="${v["desc"]}" data-amount="${v["amount"]}" data-peso="${v["peso"]}" data-item-key="${v["key"]}" data-name-key="${v["name"]}" data-slot="${slot}">
						<div class="nameItem">${v["name"]}</div>
						<div class="durability" style="background: ${actualPercent == 1 ? "#fc5858":colorPicker2(actualPercent)};">
							<div class="durability2" style="width: ${actualPercent == 1 ? "100":actualPercent}%; background: ${actualPercent == 1 ? "#fc5858":colorPicker(actualPercent)};"></div>
						</div>
					</div>`;

				$(".invLeft").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invLeft").append(item);
			}
		}

		for (let x = 1; x <= 5; x++){
			const slot = x.toString();

			if (nameList2[x - 1] !== undefined){
				const v = nameList2[x - 1];
				const maxDurability = 86400 * v["days"];
				const newDurability = (maxDurability - v["durability"]) / maxDurability;
				var actualPercent = newDurability * 100;

				if (actualPercent <= 1)
					actualPercent = 1;

				const item = `
				
				<div class="item populated" data-item-key="${v["key"]}" data-id="${v["id"]}" data-amount="${v["amount"]}" data-peso="${v["peso"]}" data-slot="${slot}">
					<div class="top">
						<div class="itemWeight">${(v["peso"] * v["amount"]).toFixed(2)}</div>
						<div class="itemAmount">${formatarNumero(v["amount"])}x</div>
					</div>
					<img class="img-inv" src="images/${v["index"]}.png" alt="" data-item-key="${v["key"]}" data-id="${v["id"]}" data-amount="${v["amount"]}" data-peso="${v["peso"]}" data-slot="${slot}">
					<div class="nameItem">${v["name"]}</div>
					<div class="durability" style="background: ${actualPercent == 1 ? "#fc5858":colorPicker2(actualPercent)};">
						<div class="durability2" style="width: ${actualPercent == 1 ? "100":actualPercent}%; background: ${actualPercent == 1 ? "#fc5858":colorPicker(actualPercent)};"></div>
					</div>
				</div>`;

				$(".invRight").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invRight").append(item);
			}
		}

		updateDrag();
	});
}

let mochilaNivel = 1; // Começa no nível 1
/* ----------CRAFT---------- */
$(document).on("click",".craft",function(e){
	$.post("http://inventory/Craft");
});
/* ----------FORMATARNUMERO---------- */
const formatarNumero = n => {
	var n = n.toString();
	var r = "";
	var x = 0;

	for (var i = n["length"]; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? "." : "");
		x = x == 2 ? 0 : x + 1;
	}

	return r.split("").reverse().join("");
}

function updateBarValue(peso_inv, peso_max){
    let pesoInv = peso_inv
    let maxPeso = peso_max
    let transformInv = (pesoInv * 100) / maxPeso
    
    // Atualiza o texto do peso
    $("#peso-texto").html(`${pesoInv.toFixed(1)} / ${maxPeso.toFixed(1)}`);
    
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
    $('.barra-peso2').css({"width": value + "%"}) // Mude de "height" para "width"
}

// Exemplo para o evento de uso de item
$(document).on("click", ".use, .populated", function(e) {
    // Pegue o nome do item
    const itemName = $(this).data("name-key") || $(this).data("item-key");

    // Se for o backpack, aumenta o nível
    if (itemName === "backpack") {
        if (mochilaNivel < 4) { // Limite de 4 níveis
            mochilaNivel++;
            setMochilaNivel(mochilaNivel);
        }
    }
});

function setMochilaNivel(nivel) {
    $('.mochila-bar').each(function(i){
        if(i < nivel) {
            $(this).addClass('active');
        } else {
            $(this).removeClass('active');
        }
    });
}

// FUNÇÃO PARA ATUALIZAR CARGOS (MÚLTIPLOS)
function updateCargos(cargosData) {
    const cargosContainer = $("#cargo-player");
    cargosContainer.empty(); // Limpa os cargos existentes
    
    if (cargosData && cargosData.trim() !== "") {
        // Dividir os cargos por "/" ou outro separador
        let cargos = cargosData.split('/'); // Ajuste o separador se necessário
        
        // Adiciona cada cargo como um item separado
        cargos.forEach(function(cargo) {
            if (cargo.trim() !== "") {
                cargosContainer.append(`<div class="cargo-item">${cargo.trim()}</div>`);
            }
        });
    } else {
        // Se não tem cargo, mostra mensagem padrão
        cargosContainer.html(`<div class="cargo-item no-cargo">Nenhum cargo</div>`);
    }
}

// Sistema de Hotbar
let hotbarData = {};

// Atualizar slot da hotbar
function updateHotbarSlot(slot, itemData) {
    const hotbarSlot = $(`.hotbar-slot[data-slot="${slot}"]`);
    
    if (itemData) {
        hotbarData[slot] = itemData;
        
        hotbarSlot.addClass('has-item');
        hotbarSlot.html(`
            <span class="slot-number">${slot}</span>
            <img class="hotbar-item-image" src="images/${itemData.index}.png" alt="${itemData.name}">
            <span class="hotbar-item-amount">${itemData.amount}x</span>
        `);
        
        // Adicionar tooltip
        hotbarSlot.attr('title', itemData.name);
    } else {
        delete hotbarData[slot];
        hotbarSlot.removeClass('has-item');
        hotbarSlot.html(`<span class="slot-number">${slot}</span>`);
        hotbarSlot.removeAttr('title');
    }
}

// Função para carregar a hotbar ao abrir o menu
function loadHotbar(hotbarDataReceived) {
    // Limpar hotbar atual
    hotbarData = {};
    for (let i = 1; i <= 4; i++) {
        updateHotbarSlot(i, null);
    }
    
    // Carregar novos dados
    if (hotbarDataReceived) {
        Object.keys(hotbarDataReceived).forEach(slot => {
            if (hotbarDataReceived[slot]) {
                updateHotbarSlot(slot, hotbarDataReceived[slot]);
            }
        });
    }
}

// Limpar slot da hotbar e devolver item para o inventário
function clearHotbarSlot(slot) {
    if (hotbarData[slot]) {
        const item = hotbarData[slot];
        
        // Remover visualmente da hotbar
        updateHotbarSlot(slot, null);
        
        // Enviar para o backend para devolver ao inventário
        $.post("http://inventory/returnHotbarToInventory", JSON.stringify({
            slot: slot,
            item: item
        }));
    }
}

// Adicionar eventos de click direito para remover da hotbar
$(document).on('contextmenu', '.hotbar-slot.has-item', function(e) {
    e.preventDefault();
    const slot = $(this).data('slot');
    clearHotbarSlot(slot);
});

//# sourceMappingURL=inventory.js.map