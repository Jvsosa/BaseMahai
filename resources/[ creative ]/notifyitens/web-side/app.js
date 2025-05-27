$(document).ready(function(){
    window.addEventListener("message", function(event){
        // Mapeie os modos para as classes CSS
        var itemClass;
        switch (event.data.mode) {
            case 'guardou':
                itemClass = 'guardou';
                break;
            case 'equipou':
                itemClass = 'equipou';
                break;
            default:
                itemClass = 'outro'; // Classe padrão para outros modos
                break;
        }

        var html = `
        <div class="item ${itemClass}" id="${event.data.mode}" style="background-color: rgba(0, 0, 0, 0.8);">
            <div class="item-mode">${event.data.mode}</div>
            <img src="//inventory/web-side/images//${event.data.item}.png">
            
            <div class="info-item">
                <div class="nameItem">${event.data.name}</div>
                <div class="itemRecive">${event.data.mode === 'recebeu' ? `+${event.data.amount}` : `-${event.data.amount}`}</div>
            </div>
        </div>`;

        $(html).css({ opacity: 0 }).appendTo("#notifyitens").animate({ opacity: 1 }, 800).delay(3000).fadeOut(500);
    });
});
