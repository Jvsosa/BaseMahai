


$(document).ready(function(){    
	window.addEventListener("message",function(event){

		$(".inputprocurar").on("keyup", function () {
            let search = $(this).val().toLowerCase();
            $(".nome-carro").filter(function () {
              $(this).closest(".item").toggle($(this).text().toLowerCase().indexOf(search) > -1)
            });	
		});

		switch(event.data.action){
			case "showMenu":
                $("#pagina-carro").fadeOut(0);
                $('#pagina-bau').fadeOut(0)
				veh()
				$("body").fadeIn(800);

			break;
            case "hideMenu":
				$("body").fadeOut();		
			break;
		}
	});

	document.addEventListener("keydown",function(event) {
		if (event.key == "Escape"){
			$("body").fadeOut();	
			$.post("http://garages/close");
		}
	})

});


function veh(){
    $.post("http://garages/vehList",JSON.stringify({}),(data) => {
		let vehs = data.vehs.sort((a,b) => (b.bau > a.bau) ? 1: -1);
		$('.overflow-carros').empty()
		vehs.forEach((key,value) => {
			
			$('.overflow-carros').prepend(`

				<div class="item" onclick="vercarro(this)" data-link_imgs="http://localhost/cars" data-carro="${key.name}" data-model="${key.model}" data-plate="${key.plate}" data-engine="${key.engine}" data-body="${key.body}" data-fuel="${key.fuel}">
					<div class="nome-carro">${key.name}</div>
					<img class="img-carro" src="http://localhost/cars/${key.model}.png" alt="">
				</div>


			`)
			
		});
    });
}


function vercarro(data){
    
    var motor = new ldBar(".carBar",
    {
        "value": 100,
        "fill-background-extrude": 0,
        "fill": 'blue',
        "fill-dir": 'btt',
        "type": 'fill',
        "min": 1,
        "max": 100,
        }
    );
    
    var lataria = new ldBar(".latariaBar",
        {
            "value": 100,
            "fill-background-extrude": 0,
            "fill": 'blue',
            "fill-dir": 'btt',
            "type": 'fill',
            "min": 1,
            "max": 100,
        }
    );
    
    var gas = new ldBar(".fuelBar",
        {
            "value": 100,
            "fill-background-extrude": 0,
            "fill": 'blue',
            "fill-dir": 'btt',
            "type": 'fill',
            "min": 1,
            "max": 100,
        }
    );

    $('.nome-carro-lado').html(data.dataset.carro)
    $('#placa').html(data.dataset.plate)

    $('.nome-carro-lado2').html(data.dataset.carro)
    $('#placa2').html(data.dataset.plate)

    motor.set(data.dataset.engine)
    lataria.set(data.dataset.body)
    gas.set(data.dataset.fuel)

	$(".img-carro-lado").attr(`src`,data.dataset.link_imgs + "/" + data.dataset.model + ".png");
    $('#pagina-bau').hide(0)

    $('#pagina-carro').fadeIn(700)

    motor.set(data.dataset.engine)
    lataria.set(data.dataset.body)
    gas.set(data.dataset.fuel)

    $.post("http://garages/vercarro",JSON.stringify({
		model : data.dataset.model,
        plate : data.dataset.plate,
	}), (data) =>{ 
		if(data.retorno == 'done') {
			
		} 
	});
}

function reqBau(){
    $.post("http://garages/reqbau",JSON.stringify({
	}), (data) =>{ 
		if(data.retorno == 'done') {
            $("#pagina-carro").fadeOut(0);
            $('.box-itens').empty()
            bau()
            $('#pagina-bau').fadeIn(700)
		} 
	});
}
function bau(){
    $.post("http://garages/bauCarro",JSON.stringify({}),(data) => {
        let bau = data.bau.sort((a,b) => (b.bau > a.bau) ? 1: -1);
        $('.box-itens').empty()
       
        bau.forEach((key,value) => {
            
			const maxDurability = 86400 * key.days;
			const newDurability = (maxDurability - key.durability) / maxDurability;
			var actualPercent = newDurability * 100;

			if (actualPercent <= 1)
				actualPercent = 1;

            $('.box-itens').prepend(`

                <div class="item-inv">
                    <div class="item-inv-nome">${key.name}</div>
                    <img class="item-img" src="nui://inventory/web-side/images/${key.index}.png" alt="">
                    <div class="item-inv-qtd">${key.amount}x</div>
                    <div class="durability">
                        <div class="durability2" style="width: ${actualPercent == 1 ? "100":actualPercent}%; background: ${actualPercent == 1 ? "#fc5858":colorPicker(actualPercent)};"></div>
                    </div>
                </div>


                `)
			
            });
        });
    }

function retirarCarro(){
    $.post("http://garages/retirarcarro");
}

function trocarPlaca(){
    $("body").fadeOut();	
	$.post("http://garages/close");;
    $.post("http://garages/trocarPlaca");
}


function fecharNui(){
	$("body").fadeOut();	
	$.post("http://garages/close");;
}

function guardarCarro(){
    $.post("http://garages/guardarCarro");
}

const colorPicker = (percent) => {
	var colorPercent = "#2e6e4c";

	if (percent >= 100)
		colorPercent = "rgba(255,255,255,0)";

	if (percent >= 51 && percent <= 75)
		colorPercent = "#fcc458";

	if (percent >= 26 && percent <= 50)
		colorPercent = "#fc8a58";

	if (percent <= 25)
		colorPercent = "#fc5858";

	return colorPercent;
}