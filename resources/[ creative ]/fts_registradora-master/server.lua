local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

ftsC = {}
Tunnel.bindInterface("fts_registradora", ftsC)

local roubando = false
local segundos = 0



tempos = {}
CreateThread(function()
    while true do
        Wait(1000)
        for k, v in pairs(tempos) do 
            if v > 0 then 
                tempos[k] = v - 1 
            end 
        end
    end
end)

ftsC.CheckItem = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        
        return true

    end
end

function ftsC.CheckRoubo(id,x,y,z,h)
    local source = source
    local user_id = vRP.getUserId(source)
    local Notificar = math.random(100,100)
    if user_id then
        local policeResult = vRP.numPermission("Police")
        
        if #policeResult >= 3 then  
            if roubando == false then
                if tempos[id] == 0 or not tempos[id] then
                    tempos[id] = math.random(1200,1500)
                    segundos = 15
                    roubando = true
                    if Notificar >= 70 then
                        TriggerClientEvent("Notify", source, "azul","Roube o máximo que puder, soubemos que policiais foram notificados!!!.",5000)
                    end
                    AlertarPMs(x,y,z,source)
                    Roubo(segundos,h)
                    return true
                else
                    TriggerClientEvent("Notify",source,"azul","Esta caixa registradora já foi roubada, aguarde " ..tempos[id].. " segundos para rouba-lo novamente.",5000)
                end
            else
                TriggerClientEvent("Notify",source,"azul","já tem um roubo em andamento!",5000)
            end
        else
            TriggerClientEvent("Notify",source,"vermelho","Não tem policiais suficientes em PTR, minimo 2",5000)
        end
    end
end

function AlertarPMs(x,y,z,source)
    local policeResult = vRP.getUsersByPermission("Police")
     for k,v in ipairs(policeResult) do
        local player = vRP.getUserSource(v)
        if player and player ~= source then
            async(function()
                TriggerClientEvent("fts:AdicionarCDS",player,x,y,z)
                TriggerClientEvent("Notify",player,"azul","Houve um roubo em uma loja e o alarme foi ativado, vá até o local!",5000)
            end)
        end
	end
end

function Roubo(segundos,h)

    local source = source
    local user_id = vRP.getUserId(source)

    SetEntityHeading(source,h)
    vRPclient.playAnim(source, false,{"oddjobs@shop_robbery@rob_till", "loop"}, true)
    TriggerClientEvent("cancelando",source,true)

    local dinheiro_total = 0

    while segundos > 0 do
        Wait(2000)
        local dinheiro_novo = math.random(160,220)
        dinheiro_total = dinheiro_total + dinheiro_novo
        vRP.giveInventoryItem(user_id,"dollars2",dinheiro_novo)
        segundos = segundos -1
    end

    local identity = vRP.userIdentity(user_id)
    PerformHttpRequest("https://discord.com/api/webhooks/1119244700814159932/MSedwYGn5UpDTgQPsVBXXLAl4vC8qqJq_mmZkk-XqYgMYhj5vEkTWVQ3p4Ne0uE0B_Ar", function(err, text, headers) end, 'POST', json.encode({
        embeds = {
            {     
                title = "**Roubo Concluido**",
                fields = {
                    { 
                        name = "📝 Author:", 
                        value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                    },
                    { 
                        name = "💸 Criou:", 
                        value = ""..parseFormat(dinheiro_total).."x Dinheiro Sujo"
                    },
                }, 
                footer = { 
                    text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                    icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                },
                thumbnail = { 
                    url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                },
                color = 3092790
            }
        }
    }), { ['Content-Type'] = 'application/json' })


    roubando = false
    vRPclient.stopAnim(source, false)
    TriggerClientEvent("cancelando",source,false)
end