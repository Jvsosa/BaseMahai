--------------------------------
-- [ CONEXAO ] --
--------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("wnPresente",src)
vCLIENT = Tunnel.getInterface("wnPresente")
Config = module(GetCurrentResourceName(), "cfg/config")

src.TirarItem = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.removeInventoryItem(user_id,"caixauwu",1,true) then
        return true
    else
        return false
    end
end

src.ReceberItem = function(numero)
    local source = source
    local user_id = vRP.getUserId(source)
    local random2 = math.random(100)
    local identity = vRP.userIdentity(user_id)
    local chanceNumero = 0
    if parseInt(numero) == 1 then
        chanceNumero = 15
    else
        chanceNumero = 10
    end
    if random2 <= chanceNumero then
        local random = math.random(#Config.Peds[numero])
        vRP.generateItem(user_id,Config.Peds[numero][random].item,1,true)
        PerformHttpRequest("https://discord.com/api/webhooks/1134713330188173385/Xa3TQcDS8RAw-jaAvldPwQFmJ60slwaxx2XHWZHOEavEjTbTsrsBz6Ras5W7lSk_xtDV", function(err, text, headers) end, 'POST', json.encode({
            embeds = {
                {     
                    title = "**Registro de Caixa**",
                    fields = {
                        { 
                            name = "📝 Author:", 
                            value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                        },
                        { 
                            name = "🐱‍👓 Item:", 
                            value = "" ..Config.Peds[numero][random].item.."",
                        },
                        { 
                            name = "🐱 Chance:", 
                            value = "Chance Gerada: "..random2.."",
                        },
                    }, 
                    footer = { 
                        text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                        icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                    },
                    image = { 
                        url = "http://localhost/itens/"..itemIndex(Config.Peds[random].item)..".png",
                    },
                    thumbnail = { 
                        url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                    },
                    color = 7863416
                }
            }
        }), { ['Content-Type'] = 'application/json' })
        return Config.Peds[random].item
    else
        PerformHttpRequest("https://discord.com/api/webhooks/1134713330188173385/Xa3TQcDS8RAw-jaAvldPwQFmJ60slwaxx2XHWZHOEavEjTbTsrsBz6Ras5W7lSk_xtDV", function(err, text, headers) end, 'POST', json.encode({
            embeds = {
                {     
                    title = "**Nao Ganhou**",
                    fields = {
                        { 
                            name = "📝 Author:", 
                            value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                        },
                        { 
                            name = "🐱 Chance:", 
                            value = "Chance Gerada: "..random2.."",
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
        return "Nada"
    end
end

src.GetInfosItem = function(item)
    local source = source
    local user_id = vRP.getUserId(source)
    if item == "Nada" then
        return "Nada"
    else
        return itemName(item),itemIndex(item)
    end
end