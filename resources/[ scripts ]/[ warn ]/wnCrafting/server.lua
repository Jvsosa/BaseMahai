--------------------------------
-- [ CONEXAO ] --
--------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("wnCrafting",src)
vCLIENT = Tunnel.getInterface("wnCrafting")
Config = module(GetCurrentResourceName(), "cfg/config")


src.checkPermission = function(perm)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if perm ~= "none" then
            return vRP.hasPermission(user_id,perm)
        else
            return true
        end
    end
end

--------------------------------
-- [ VER CRAFT ] --
--------------------------------

vRP._prepare("verificarUpgrades","SELECT * FROM groups_empresas WHERE empresa = @empresa")

src.consultCrafts = function(mesadecraft)
    local source = source
    local user_id = vRP.getUserId(source)
   
    ListaCrafts = {}
    if user_id then
        local verify = vRP.query("verificarUpgrades", {empresa = mesadecraft})
        if verify then
            for k,v in pairs(Config.Craft[mesadecraft].crafts) do
                if v.upgrade then
                    if verify[1].upgradeCraft >= v.upgrade then
                        table.insert(ListaCrafts,{k = k, item = itemName(k), img = itemIndex(k), item2 = k, tempo = v.tempo, quantidade = v.quantidade, status = "liberado" })
                    else
                        table.insert(ListaCrafts,{k = k, item = itemName(k), img = itemIndex(k), item2 = k, tempo = v.tempo, quantidade = v.quantidade, status = "block" })    
                    end
                else
           
                    table.insert(ListaCrafts,{k = k, item = itemName(k), img = itemIndex(k), item2 = k, tempo = v.tempo, quantidade = v.quantidade, status = "liberado" })
                end
            end
        else
            table.insert(ListaCrafts,{k = k, item = itemName(k), img = itemIndex(k), item2 = k, tempo = v.tempo, quantidade = v.quantidade, status = "liberado" })
        end
    end
end

src.consultCraftsList = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return ListaCrafts
    end
end

--------------------------------
-- [ VER CRAFT ] --
--------------------------------

src.consultReq = function(mesadecraft,itemver)
    local source = source
    local user_id = vRP.getUserId(source)
    ListaCrafts2 = {}
    if user_id then
        for k,v in pairs(Config.Craft[mesadecraft].crafts[itemver].requires) do
            if v.item == "dinheiro" then
                table.insert(ListaCrafts2,{item = v.item, img = "dinheiro", item2 = v.item, qtd = v.amount })
            else
                table.insert(ListaCrafts2,{item = itemName(v.item), img = itemIndex(v.item), item2 = v.item, qtd = v.amount })
            end
        end
    end
end

src.consultReqList = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return ListaCrafts2
    end
end

src.CriarItem = function(mesadecraft,itemver,qtd)
    local source = source
    local user_id = vRP.getUserId(source)
    local Passport = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)

    if parseInt(qtd) == nil then
        qtd = 1
    end


    if parseInt(qtd) >= 1 then
        print("^7[^1Tentativa^7] Player: ^3"..user_id.."^7, Item: ^3"..itemName(itemver).."^7, Mesa: ^3"..mesadecraft.."^7")
        --print("^7[^6!^7] Passaporte ^6"..user_id.." tentou craftar "..itemName(itemver).."^7 na mesa ^6"..mesadecraft.."^7")
    
        for Index,v in pairs(Config.Craft[mesadecraft].crafts[itemver].requires) do
            local consultItem = vRP.getInventoryItemAmount(Passport,v.item)
            if parseInt(consultItem[1]) < parseInt(v.amount * qtd) then
                return
            end
        end
    
        for Index,v in pairs(Config.Craft[mesadecraft].crafts[itemver].requires) do
            local consultItem = vRP.getInventoryItemAmount(Passport,Index)
            vRP.removeInventoryItem(Passport,v.item,parseInt(v.amount * qtd),true)
        end
    
        if Config.Craft[mesadecraft].crafts[itemver].anim then
            vRPclient.playAnim(source,true,{{Config.Craft[mesadecraft].crafts[itemver].anim[1],Config.Craft[mesadecraft].crafts[itemver].anim[2]}},false)
            TriggerClientEvent('cancelando',source,true)
        end
    
        print("^7[^1!^7] Produzindo ^3"..qtd.."x "..itemName(itemver).."^7 na mesa ^3"..mesadecraft.."^7")
        TriggerClientEvent("Progress",source,Config.Craft[mesadecraft].crafts[itemver].tempo * 1000 * qtd,"Criando..")
        Wait(Config.Craft[mesadecraft].crafts[itemver].tempo * 1000 * qtd)
        vRPclient.stopAnim(source,false)
    
    
        vRP.generateItem(user_id,itemver,Config.Craft[mesadecraft].crafts[itemver].quantidade * qtd,true)
    
        if Config.Craft[mesadecraft].crafts[itemver].anim then
            TriggerClientEvent('cancelando',source,false)
        end
    
        if Config.Craft[mesadecraft].log then
            
            PerformHttpRequest(Config.Craft[mesadecraft].log, function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
                        title = "**Craft "..mesadecraft.."**",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
                            { 
                                name = "📦 Criou:", 
                                value = ""..parseFormat(Config.Craft[mesadecraft].crafts[itemver].quantidade * qtd).."x "..itemName(itemver)..""
                            },
                        }, 
                        footer = { 
                            text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                            icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                        },
                        image = { 
                            url = "http://localhost/itens/"..itemIndex(itemver)..".png",
                        },
                        thumbnail = { 
                            url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                        },
                        color = 3092790
                    }
                }
            }), { ['Content-Type'] = 'application/json' })
        end

        if Config.Craft[mesadecraft].log2 then
            PerformHttpRequest(Config.Craft[mesadecraft].log2, function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
                        title = "**Craft "..mesadecraft.."**",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
                            { 
                                name = "📦 Criou:", 
                                value = ""..parseFormat(Config.Craft[mesadecraft].crafts[itemver].quantidade * qtd).."x "..itemName(itemver)..""
                            },
                        }, 
                        footer = { 
                            text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                            icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                        },
                        image = { 
                            url = "http://localhost/itens/"..itemIndex(itemver)..".png",
                        },
                        thumbnail = { 
                            url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                        },
                        color = 3092790
                    }
                }
            }), { ['Content-Type'] = 'application/json' })
        end

    end
    
    return true
end
