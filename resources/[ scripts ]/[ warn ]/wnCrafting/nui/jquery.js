
var cargo_player_acessando = "nada"
var filtar_por = "id"

$(document).ready(function(){
	window.addEventListener("message",function(event){

		$("#procurarpormembro").on("keyup", function () {
			if(filtar_por == "id"){
				let search = $(this).val().toLowerCase();
				$(".i-t-1-text").filter(function () {
				  $(this).closest("#item-contratado").toggle($(this).text().toLowerCase().indexOf(search) > -1)
				});	
			} else if(filtar_por == "nome") {
				let search = $(this).val().toLowerCase();
				$(".nome-ct").filter(function () {
				  $(this).closest("#item-contratado").toggle($(this).text().toLowerCase().indexOf(search) > -1)
				});	
			}
		});

		switch(event.data.action){
			case "showMenu":
				$(".kdsakkda").hide(0);
				var item = event.data
				$("#craftdsa").html(item.k);
				listCrafts()
				$("body").fadeIn(800);

			break;

			case "attsegundos":
				var item = event.data
				$("#segundoskd").html(item.criando);
			break;

	
			

			case "hideMenu":
				$("body").fadeOut();		
			break;
		}
		
	});

	document.onkeyup = function(data) {
		if (data.which == 27){
			$.post("http://wnCrafting/close");
		}else if(data.key == "Enter"){
			if($("#chat-input").val() != "" && $("#chat-input").val() != " " ){
				enviarChat()
			}
		}
	};
});

function closeNui(){
	$.post("http://wnCrafting/close");
}

function listCrafts(){
    $.post("http://wnCrafting/CraftLista",JSON.stringify({}),(data) => {
		let consultCrafts = data.consultCrafts.sort((a,b) => (a.k > b.k) ? 1: -1);
		$('.itens-craft').empty()
		consultCrafts.forEach((key,value) => {

			

			if (key.status == "liberado"){

				$('.itens-craft').prepend(`

				<div class="item_disponivel" onclick="VerCraft(this)" data-item2="${key.item2}" data-tempo="${key.tempo}" data-quantidade="${key.quantidade}" data-item="${key.item}" data-img="${key.img}">
					<img src="nui://inventory/web-side/images/${key.img}.png" alt="">
					<div class="nomeitem">${key.item}</div>
				</div>

				`)
			} else {
				$('.itens-craft').prepend(`

					<div class="item_disponivel">
						<img src="nui://inventory/web-side/images/${key.img}.png" alt="">
						<div class="nomeitem2">BLOQUEADO</div>
					</div>

				`)
			}
			
		});
    });
}

function VerCraft(data){
	$(".imglocaltempo").attr(`src`,"nui://inventory/web-side/images/" + data.dataset.img + ".png");
	$(".nomeitemtempo").html(data.dataset.quantidade + "x " + data.dataset.item);
	$(".tempocraft").html(data.dataset.tempo);
	$.post("http://wnCrafting/VerCraft",JSON.stringify({
		item : data.dataset.item2,
	}), (data) =>{ 
		if(data.retorno == 'done') {
			ListRequesitos()
			$(".kdsakkda").fadeIn(800);
		} 
	});
};

function ListRequesitos(){
    $.post("http://wnCrafting/itensnecessarios",JSON.stringify({}),(data) => {
		let itensnecessarios = data.itensnecessarios.sort((a,b) => (b.item > a.item) ? 1: -1);
		$('.itensnecessarios').empty()
		itensnecessarios.forEach((key,value) => {
			$('.itensnecessarios').prepend(`

				<div class="item_necesario">
					<img class="img_item_necessario" src="nui://inventory/web-side/images/${key.img}.png" alt="">
					<div class="item_quantidade">${key.qtd}x</div>
				</div>

			`)
		});
    });
}

function CriarItem(data){
	$(".proibiralterarCraft").fadeIn(100);
	let qtd = $("#quantidadets").val();
	$.post("http://wnCrafting/CriarItem",JSON.stringify({
		qtd:qtd,
	}), (data) =>{ 
		if(data.retorno == 'done') {
			$(".kdsakkda").fadeOut(800);
			$(".proibiralterarCraft").fadeOut(800);
		} 
	});
};