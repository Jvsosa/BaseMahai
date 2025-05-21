$(document).ready(function(){
	window.addEventListener("message",function(event){
		switch(event.data.action){
			case "showMenu":
				$(".f7request").hide(0);
				$(".container-fora").fadeIn(0);
				$("body").fadeIn(1000);
				listaItens();
			break;

			case "hideMenu":
				$(".f7request").hide(0);
				$("body").fadeOut(500);
				$(".container-fora").fadeOut(0);

			break;

			case "f7":
				$(".container-fora").fadeOut(0);
				$(".f7request").show(0);
				$("body").fadeIn(1000);
			break;

			case "f7fechar":
				$(".container-fora").hide(0);
				$(".f7request").hide(0);
				$("body").hide(0);
			break;

		}
		
	});


	document.onkeyup = function(data) {
		if (data.which == 27){
			$.post("http://wnRoutes/shopClose");
		}
	};
});


const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}

const listaItens = () => {
	$.post("http://wnRoutes/itensList",JSON.stringify({}),(data) => {
		let i = 0;

		const nameList = data.playersregistrados.sort((a,b) => (a.index > b.index) ? 1: -1);
		$('.box-baixa').empty()
		$('.box-baixa').html(`
			${nameList.map((item) => (`
			<div class="item" data-index-key="${item.index}" item="${item.item2}">
				<div class="imagem-item"><img src="${item.ipurl}/${item.img}.png" alt=""></div>
				<div class="nome-item">${item.item}</div>
				<div class="pegar-rota">Iniciar</div>
			</div>

			`)).join('')}
		`);
	});
}

$(document).on("click",".pegar-rota",function(){
	let $el = $('.item:hover');
	if($el){
		$.post("http://wnRoutes/iniciarrota",JSON.stringify({
			item: $el.attr('item'),
		}));
	}
});

// $(document).on("click","#b-aco", function() {
// 	$.post("http://wnRoutes/aco");
// });

// $(document).on("click","#b-polvora", function() {
// 	$.post("http://wnRoutes/polvora");
// });

// $(document).on("click","#p-pente-pistola", function() {
// 	$.post("http://wnRoutes/pentepistola");
// });
// $(document).on("click","#p-pente-smg", function() {
// 	$.post("http://wnRoutes/pentesmg");
// });

// $(document).on("click","#p-pente-rifle", function() {
// 	$.post("http://wnRoutes/penterifle");
// });