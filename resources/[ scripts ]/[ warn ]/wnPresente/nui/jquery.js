
$(document).ready(function(){
	window.addEventListener("message",function(event){

		switch(event.data.action){
			case "showMenu":

				var item = event.data

				$("#nomeitem").html(item.nome);


				if(item.nome == "Nada"){
					$("#nomeitem").html("Voce teve azar..");
					$(".imgpresente").attr(`src`,"");
				}else{
					$("#nomeitem").html(item.nome);
					$(".imgpresente").attr(`src`,"nui://inventory/web-side/images/" + item.index + ".png");
				}

				$("body").fadeIn(800);

			break;

			case "hideMenu":
				$("body").fadeOut();		
			break;
		}
		
	});

	document.onkeyup = function(data) {
		if (data.which == 27){
			$.post("http://wnPresente/close");
		}else if(data.key == "Enter"){
			if($("#chat-input").val() != "" && $("#chat-input").val() != " " ){
				enviarChat()
			}
		}
	};
});

function closeNui(){
	$.post("http://wnPresente/close");
}

