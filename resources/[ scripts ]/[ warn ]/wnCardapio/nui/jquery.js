$(document).ready(function(){
	window.addEventListener("message",function(event){

		switch(event.data.action){
			case "showMenu":

				var item = event.data
				$(".itens-c").hide();
				$(".itens-c2").fadeIn(700);

				$("body").fadeIn(800);

			break;

			case "hideMenu":
				$("body").fadeOut();		
			break;
		}
		
	});

	document.onkeyup = function(data) {
		if (data.which == 27){
			$.post("http://wnCardapio/close");
		}
	};
});

function closeNui(){
	$.post("http://wnCardapio/close");
}

function Sfechar(){
	$("#pagina-viewcar").hide();
	$("#pagina-lista").hide();
	$("#Pagina-Inicio").hide();
}

function trocarPagina(tipo){

	if(tipo == 'combos'){
		$(".itens-c").hide();
		$(".itens-c2").fadeIn(700);
	}

	if(tipo == 'comidas'){
		$(".itens-c2").hide();
		$('.itens-c').empty()
		listCardapio('Comidas')
		$(".itens-c").fadeIn(700);
	}

	if(tipo == 'Bebidas'){
		$(".itens-c2").hide();
		$('.itens-c').empty()
		listCardapio('Bebidas')
		$(".itens-c").fadeIn(700);
	}

}

function listCardapio(tipo){
	$("#categoriaid").html(tipo);
    $.post("http://wnCardapio/consultCardapio",JSON.stringify({lista : tipo}),(data) => {
		let consultCarros = data.consultCarros.sort((a,b) => (b.nome > a.nome) ? 1: -1);
		$('.itens-c').empty()
		consultCarros.forEach((key,value) => {

	
				$('.itens-c').prepend(`

				<div class="item">
					<img src="http://localhost/itens/${key.index}.png" alt="">
					<div class="nome-item">${key.nome}</div>
					<div class="preco-item">${key.valor} $</div>
				</div>

			
			`)
	
		});
    });
}
