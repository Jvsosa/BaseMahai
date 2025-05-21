
var cargo_player_acessando = "nada"
var filtar_por = "id"

$(document).ready(function(){
	window.addEventListener("message",function(event){

		switch(event.data.action){
			case "showMenu":
				$(".f7request").hide(0);
				$(".status").hide(0);
				var item = event.data

				$("#emp").html(item.empregoAtual);

				
				$(".block").css("background-image",`linear-gradient(to bottom, rgba(15, 15, 15, 0.2), rgba(15, 15, 15, 0.2)),url(${item.imagem_emprego})`);

				$("#nome").html(item.nome);
				$("#passaporte").html(item.passaporte);
	
				
				$("#exp").html(item.exp + '/150');
				$("#carteira").html(item.carteira + ' $');
				$("#banco").html(item.banco + ' $');
				$(".img-aparecer").attr(`src`,item.imagem);

				$("#seulevel").html(item.level);

				$("#ganho").html('0 $');
				$("#level2").html(item.level);
				$("#exp2").html(item.exp + '/150');
				$("#todosblips").html('1/' + item.todosblips);

				$("#salario").html(item.valorMin + '/' + item.valorMax + ' $');
				$("#expm").html(item.expMin + '/' + item.expMax + ' XP');
				$("#levelnes").html(item.levelnes);

				$(".container-fora").show();
				$("body").fadeIn(800);
			break;

			case "hideMenu":
				$(".status").hide(0);
				$(".f7request").hide(0);
				$("body").fadeIn(800);	
				$(".container-fora").hide();
			break;

			case "atualizar":
				var item = event.data

				$("#ganho").html(item.dinheiroGanho + ' $');
				$("#level2").html(item.level);
				$("#exp2").html(item.exp + '/150');
				$("#todosblips").html(item.distino + '/' + item.todosblips);
			break;

			case "f7":
				$(".container-fora").fadeOut(0);
				$(".f7request").show(0);
				$(".status").show(0);
				$("body").fadeIn(1000);
			break;

			case "f7fechar":
				$(".container-fora").hide(0);
				$(".f7request").hide(0);
				$(".status").hide(0);
				$("body").hide(0);
			break;

		}
		
	});

	document.onkeyup = function(data) {
		if (data.which == 27){
			$.post("http://wnEmpregos/close");
		}else if(data.key == "Enter"){
			if($("#chat-input").val() != "" && $("#chat-input").val() != " " ){
				enviarChat()
			}
		}
	};
});

function closeNui(){
	$.post("http://wnEmpregos/close");
}


function iniciar(data){
	$.post("http://wnEmpregos/close");
	$.post("http://wnEmpregos/iniciar",JSON.stringify({
	
	}), (data) =>{ 
		if(data.retorno == 'done') {
			$.post("http://wnEmpregos/close");
		} 
	});
};