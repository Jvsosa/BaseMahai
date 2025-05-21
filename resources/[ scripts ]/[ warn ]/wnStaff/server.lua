--------------------------------
-- [ CONEXAO ] --
--------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()
src = {}
Tunnel.bindInterface("wnStaff",src)
vCLIENT = Tunnel.getInterface("wnStaff")
Config = module(GetCurrentResourceName(), "cfg/config")
Function = module(GetCurrentResourceName(), "cfg/functions")

vPLAYER = Tunnel.getInterface("player")

vRP._prepare("warn/infosTeleports", "SELECT * FROM wnStaff_teleportes WHERE user_id = @user_id") 
vRP._prepare("warn/insertTeleports", "INSERT INTO wnStaff_teleportes(user_id,id,nome,coords) VALUES(@user_id,@id,@nome,@coords)") 
vRP._prepare("warn/deleteTeleport","DELETE FROM wnStaff_teleportes WHERE id = @id")

--------------------------------
-- [ VARIAVEIS ] --
--------------------------------

local logsTables = {}
local freeze = false
local banner_player = "https://cdn.discordapp.com/attachments/1094973674437750834/1101028283056926734/maui.png"

--------------------------------
-- [ SQL ] --
--------------------------------

vRP._prepare("wnStaff/jesterInstagram", "SELECT * FROM smartphone_instagram WHERE user_id = @user_id")

vRP._prepare("warn/wnStaff_teleportes", [[
    CREATE TABLE IF NOT EXISTS wnStaff_teleportes(
        user_id INTEGER,
        id longtext,
        nome longtext,
        coords longtext
    )
]])

Citizen.CreateThread(function()
    vRP.execute("warn/wnStaff_teleportes")
end)

--------------------------------
-- [ VER PERMISSAO ] --
--------------------------------

src.Check_Permissao = function()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id,"Admin")
end

src.ReturnNames = function()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
    if user_id then
        local infos = vRP.execute("wnInventory/jesterInstagram", {user_id = parseInt(user_id)})
        if infos[1] then
            return identity.name,identity.name2,infos[1].avatarURL
        else
            return identity.name,identity.name2,"https://cdn.discordapp.com/attachments/452891038349262849/959382742624260136/unknown.png"
        end
     end
end

--------------------------------
-- [ TELEPORT ] --
--------------------------------

src.consultTeleportes = function()
    local source = source
    local user_id = vRP.getUserId(source)
    teleportTables = {}
    if user_id then
        local SQL = vRP.query("warn/infosTeleports", {user_id = user_id})
        if SQL[1] then
            for k,v in pairs(SQL) do
                table.insert(teleportTables,{id = v.id,nome = v.nome, coord = json.decode(v.coords) })
            end
        end
    end
end

src.consultList = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return teleportTables
    end
end

src.addTeleport = function(returnNome)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,Config.Perms.teleport) then
            if returnNome ~= "" then 
                returnCord = GetEntityCoords(GetPlayerPed(source))
                local aleatorio = math.random(1,99999)
                vRP.execute("warn/insertTeleports", { user_id = user_id, id = aleatorio, nome = returnNome, coords = json.encode(returnCord)})
                return true
            else
                TriggerClientEvent("Notify",source,"azul","Voce precisa inserir um <b>Nome</b>.",10000)
            end
        else
            TriggerClientEvent("Notify",source,"vermelho","Voce nao tem <b>Permissao</b>.",10000)
        end
    end
end

src.delTeleport = function(returnId,returnNome)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.execute("warn/deleteTeleport", { id = returnId })
        return true
    end
end

--------------------------------
-- [ Consult Players ] --
--------------------------------

src.consultControle = function()
    local source = source
    local user_id = vRP.getUserId(source)
    ControleTables = {}
    local players = vRP.userList()
    if user_id then
        for k,v in pairs(players) do
            local identity = vRP.userIdentity(k)
            local infos = vRP.query("wnStaff/jesterInstagram", {user_id = parseInt(k)})
            if k ~= 884 then
                if infos[1] then
                    table.insert(ControleTables,{user_id = k, nome = identity.name.." ".. identity.name2, foto = infos[1].avatarURL })
                else
                    table.insert(ControleTables,{user_id = k, nome = identity.name.." ".. identity.name2, foto = "https://cdn.discordapp.com/attachments/452891038349262849/959382742624260136/unknown.png" })
                end
            end
        end
    end
end

src.consultControleList = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return ControleTables
    end
end

hasGroup = function()
    local source = source
    local user_id = vRP.getUserId(source)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		if dataTable["perm"] then
			for k,v in pairs(dataTable["perm"]) do
			end
		end
	end
end

src.SetIdentidade = function(passaporte)
    local source = source
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.userSource(parseInt(passaporte))
    if nplayer then
        local banco = vRP.getBank(parseInt(passaporte))
        local carteira = vRP.getInventoryItemAmount(parseInt(passaporte),"dollars")
        local identity = vRP.userIdentity(parseInt(passaporte))
        local groupv = 0
        local emprego = hasGroup()
        local groupvip = 0
        local vip = 0
        local coins = vRP.userGemstone(identity.steam)
        local infos = vRP.query("wnStaff/jesterInstagram", {user_id = parseInt(passaporte)})
        if infos[1] then
            return parseFormat(carteira[1]),parseFormat(banco),identity.name,identity.name2,identity.steam,identity.phone,bloodTypes(identity.blood),emprego,vip,parseFormat(coins),infos[1].avatarURL,banner_player
        else
            return parseFormat(carteira[1]),parseFormat(banco),identity.name,identity.name2,identity.steam,identity.phone,bloodTypes(identity.blood),emprego,vip,parseFormat(coins),"https://cdn.discordapp.com/attachments/452891038349262849/959382742624260136/unknown.png",banner_player
        end
    end
end

--------------------------------
-- [ Lista de Itens ] --
--------------------------------

src.consultItens = function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
        itemlist = {}
        for k,v in pairs(returnLista()) do
            if k ~= "dollars" or k ~= "WEAPON_RAYPISTOL" then
                table.insert(itemlist,{ 	
                    item = k,
                    name = v.name, 
                    index = v.index,
                    linkinventario = Config.Imagens_Inventario
                })
            end
        end
	return itemlist
	end
end

src.consultItenstsList = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return itemlist
    end
end

src.pegarItem = function(item_pegar,quantidade)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
    if user_id then
        if vRP.hasPermission(user_id,Config.Perms.pegar_itens) then
            vRP.generateItem(user_id,item_pegar,quantidade,true)
            TriggerClientEvent("Notify",source,"verde","Voce Pegou <b>"..quantidade.."x "..itemName(item_pegar).."</b>.",10000)

            local identity = vRP.userIdentity(user_id)
            PerformHttpRequest("https://discord.com/api/webhooks/1121067148006142056/V54pTaizGm7a8PashnCqyxzuzXUj49MZzJkj3BfvDoArEW8ve0EWrT5DpBszAtKMMCLN", function(err, text, headers) end, 'POST', json.encode({
            embeds = {
                {     
                    title = "**Spawn de Item**",
                    fields = {
                        { 
                            name = "📝 Author:", 
                            value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                        },
                        { 
                            name = "📦 Item:", 
                            value = "" ..quantidade.."x "..itemName(item_pegar).." ",
                        },
                    }, 
                    footer = { 
                        text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                        icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                    },
                    image = { 
                        url = ""..Config.Imagens_InventarioXamp..""..itemIndex(item_pegar)..".png",
                    },
                    thumbnail = { 
                        url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                    },
                    color = 3092790
                }
            }
        }), { ['Content-Type'] = 'application/json' })

            return true
        else
            TriggerClientEvent("Notify", source, "vermelho", "Voce nao tem <b>Permissao</b>",10000)
        end
    end
end

--------------------------------
-- [ Lista de Carros ] --
--------------------------------

src.consultGaragemTotal = function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		garagemList = {}
        for k,v in pairs(vehicleGlobal()) do
            table.insert(garagemList,{ 	
                carro = k,
                name = vehicleName(k), 
                linkgaragem = Config.Imagens_Garagem
            })
        end
		return garagemList
	end
end

src.consultGaragemListTotal = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return garagemList
    end
end

src.pegarCarro = function(carro_pegar,passaporte)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
    if passaporte then
        local identity2 = vRP.userIdentity(parseInt(passaporte))
        if Function['config'].hasPermission(user_id,Config.Perms.pegar_carros) then
            vRP.execute("vehicles/addVehicles",{ user_id = parseInt(passaporte), vehicle = carro_pegar, plate = vRP.generatePlate(), work = tostring(false) })
            TriggerClientEvent("Notify", source, "verde", "Voce setou o <b>"..vehicleName(carro_pegar).."</b> no passaporte: <b>"..identity2.name.." "..identity2.name2.." ["..passaporte.."]</b>.",10000)
            
            local identity2 = vRP.userIdentity(parseInt(passaporte))
            local x,y,z = vCLIENT.getPosition(source)
            PerformHttpRequest("https://discord.com/api/webhooks/1121075613864820767/1_sG0o0_-QzPo8AefzG6tb5tFM_9YgV-pVVUBXTdDUcsXHgAJClf_H97qpOcW0R2wNq4", function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
                        title = "**Setou Carro**",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
                            { 
                                name = "📝 Player:", 
                                value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
                            },

                            { 
                                name = "🚗 Carro:", 
                                value = "" ..vehicleName(carro_pegar).." ",
                            },

                            { 
                                name = "🌐 Coordenada do Staff:", 
                                    value = ""..x..","..y..","..z.." \n \n " 
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

            return true
        else
            TriggerClientEvent("Notify", source, "vermelho", "Voce nao tem <b>Permissao</b>",10000)
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Voce precisa colocar um <b>Passaporte</b>",10000)
    end
end

--------------------------------
-- [ SISTEMA VER OPCOES RAPIDAS ] --
--------------------------------
local Spectate = {}
src.opcoesRapidas = function(passaporte,tipo)
    local source = source
    local user_id = vRP.getUserId(source)
    local id = vRP.userSource(parseInt(passaporte))
    if user_id and parseInt(passaporte) ~= 77 or parseInt(passaporte) ~= 499 or parseInt(passaporte) ~= 7 then
        if id then
            local identity2 = vRP.userIdentity(parseInt(passaporte))
            local x,y,z = vCLIENT.getPosition(source)
            if tipo == "reviver" then
				vRPclient.revivePlayer(id,200)
				TriggerClientEvent("resetBleeding",id)
				TriggerClientEvent("resetDiagnostic",id)
                TriggerClientEvent("Notify",source,"verde","Voce reviveu o <b>"..identity2.name.." ".. identity2.name2.." ["..passaporte.."]</b>.")

              
                    local identity = vRP.userIdentity(user_id)
                    PerformHttpRequest("https://discord.com/api/webhooks/1121066029443989625/XPOi32N0t5D972goe-tbghh-rDzInt1Lafk9p-YN0WFLHG6gUN7bpHD54iHOKmudHEGt", function(err, text, headers) end, 'POST', json.encode({
                    embeds = {
                        {     
                            title = "**Reviveu**",
                            fields = {
                                { 
                                    name = "📝 Author:", 
                                    value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                },
                                { 
                                    name = "📝 Author:", 
                                    value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
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
           

            elseif tipo == "matar" then
                vRPclient.revivePlayer(id,0)
                TriggerClientEvent("Notify",source,"verde","Voce matou o <b>"..identity2.name.." ".. identity2.name2.." ["..passaporte.."]</b>.")

                
                local identity = vRP.userIdentity(user_id)
                PerformHttpRequest("https://discord.com/api/webhooks/1121066029443989625/XPOi32N0t5D972goe-tbghh-rDzInt1Lafk9p-YN0WFLHG6gUN7bpHD54iHOKmudHEGt", function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
                        title = "**Matou**",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
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

            elseif tipo == "colete" then
                vRPclient.setArmour(id,100)
                TriggerClientEvent("Notify",source,"verde","Colete Setado no <b>"..identity2.name.." ".. identity2.name2.." ["..passaporte.."]</b>.")

                local identity = vRP.userIdentity(user_id)
                PerformHttpRequest("https://discord.com/api/webhooks/1121066029443989625/XPOi32N0t5D972goe-tbghh-rDzInt1Lafk9p-YN0WFLHG6gUN7bpHD54iHOKmudHEGt", function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
                        title = "**Deu Colete**",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
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

            elseif tipo == "tpto" then
                local ped = GetPlayerPed(id)
				local coords = GetEntityCoords(ped)
				vRP.teleport(source,coords["x"],coords["y"],coords["z"])
                TriggerClientEvent("Notify",source,"verde","Voce foi ate o <b>"..identity2.name.." ".. identity2.name2.." ["..passaporte.."]</b>.")

                local identity = vRP.userIdentity(user_id)
                PerformHttpRequest("https://discord.com/api/webhooks/1121066029443989625/XPOi32N0t5D972goe-tbghh-rDzInt1Lafk9p-YN0WFLHG6gUN7bpHD54iHOKmudHEGt", function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
                        title = "**Tpto**",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
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

            elseif tipo == "tptome" then
                local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)
				vRP.teleport(id,coords["x"],coords["y"],coords["z"])	
                TriggerClientEvent("Notify",source,"verde","Voce puxou o <b>"..identity2.name.." ".. identity2.name2.." ["..passaporte.."]</b>.")

                local identity = vRP.userIdentity(user_id)
                PerformHttpRequest("https://discord.com/api/webhooks/1121066029443989625/XPOi32N0t5D972goe-tbghh-rDzInt1Lafk9p-YN0WFLHG6gUN7bpHD54iHOKmudHEGt", function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
                        title = "****",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
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

            elseif tipo == "fix" then
                local vehicle,vehNet,vehPlate = vRPclient.vehList(id,10)
                if vehicle then
                    local activePlayers = vRPclient.activePlayers(id)
                    for _,v in ipairs(activePlayers) do
                        async(function()
                            TriggerClientEvent("inventory:repairAdmin",v,vehNet,vehPlate)                    
                        end)
                    end

                    TriggerClientEvent("Notify",source,"verde","Voce deu fix no carro do <b>"..identity2.name.." ".. identity2.name2.." ["..passaporte.."]</b>.")
                    local identity = vRP.userIdentity(user_id)
                    PerformHttpRequest("https://discord.com/api/webhooks/1121066029443989625/XPOi32N0t5D972goe-tbghh-rDzInt1Lafk9p-YN0WFLHG6gUN7bpHD54iHOKmudHEGt", function(err, text, headers) end, 'POST', json.encode({
                    embeds = {
                        {     
                            title = "**Reparou**",
                            fields = {
                                { 
                                    name = "📝 Author:", 
                                    value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                },
                                { 
                                    name = "📝 Author:", 
                                    value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
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

                else
                    TriggerClientEvent("Notify",source,"vermelho","O <b>"..identity2.name.." ".. identity2.name2.." ["..passaporte.."]</b> nao esta perto de um veiculo.")
                end
            elseif tipo == "reset" then
                if vRP.request(user_id,"Você deseja resetar o passaporte: "..passaporte.." ?") then
                    fclient = Tunnel.getInterface("nation_creator")
                    fclient._startCreator(id)
                    TriggerClientEvent("Notify",source,"verde","Voce resetou o personagem <b>"..identity2.name.." ".. identity2.name2.." ["..passaporte.."]</b>.")
                end
            elseif tipo == "algema" then
                if vPLAYER.getHandcuff(id) then
                    vPLAYER.toggleHandcuff(id)
                    TriggerClientEvent("sounds:source",source,"uncuff",0.5)
                    TriggerClientEvent("sounds:source",id,"uncuff",0.5)
                    TriggerClientEvent("Notify",source,"verde","Voce desalgemou o <b>"..identity2.name.." ".. identity2.name2.." ["..passaporte.."]</b>.")

                    local identity = vRP.userIdentity(user_id)
                    PerformHttpRequest("https://discord.com/api/webhooks/1121066029443989625/XPOi32N0t5D972goe-tbghh-rDzInt1Lafk9p-YN0WFLHG6gUN7bpHD54iHOKmudHEGt", function(err, text, headers) end, 'POST', json.encode({
                    embeds = {
                        {     
                            title = "**Desalgemou**",
                            fields = {
                                { 
                                    name = "📝 Author:", 
                                    value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                },
                                { 
                                    name = "📝 Author:", 
                                    value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
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

                else
                    vPLAYER.toggleHandcuff(id)
                    TriggerClientEvent("sounds:source",source,"cuff",0.5)
                    TriggerClientEvent("sounds:source",id,"cuff",0.5)
                    TriggerClientEvent("Notify",source,"verde","Voce algemou o <b>"..identity2.name.." ".. identity2.name2.." ["..passaporte.."]</b>.")

                    local identity = vRP.userIdentity(user_id)
                    PerformHttpRequest("https://discord.com/api/webhooks/1121066029443989625/XPOi32N0t5D972goe-tbghh-rDzInt1Lafk9p-YN0WFLHG6gUN7bpHD54iHOKmudHEGt", function(err, text, headers) end, 'POST', json.encode({
                    embeds = {
                        {     
                            title = "**Algemou**",
                            fields = {
                                { 
                                    name = "📝 Author:", 
                                    value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                },
                                { 
                                    name = "📝 Author:", 
                                    value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
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

                end
            elseif tipo == "ragdoll" then
                TriggerClientEvent('tacklewnstaff:Player',id)
                local identity = vRP.userIdentity(user_id)
                PerformHttpRequest("https://discord.com/api/webhooks/1121066029443989625/XPOi32N0t5D972goe-tbghh-rDzInt1Lafk9p-YN0WFLHG6gUN7bpHD54iHOKmudHEGt", function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
                        title = "**Derrubou**",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
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
            elseif tipo == "fogo" then
                TriggerClientEvent('entity:fire',id)

                local identity = vRP.userIdentity(user_id)
                PerformHttpRequest("https://discord.com/api/webhooks/1121066029443989625/XPOi32N0t5D972goe-tbghh-rDzInt1Lafk9p-YN0WFLHG6gUN7bpHD54iHOKmudHEGt", function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
                        title = "**Tacou Fogo**",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
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

            elseif tipo == "fome" then
                vRP.upgradeThirst(parseInt(passaporte),50)
				vRP.upgradeHunger(parseInt(passaporte),50)
				vRP.downgradeStress(parseInt(passaporte),50)

                local identity = vRP.userIdentity(user_id)
                PerformHttpRequest("https://discord.com/api/webhooks/1121066029443989625/XPOi32N0t5D972goe-tbghh-rDzInt1Lafk9p-YN0WFLHG6gUN7bpHD54iHOKmudHEGt", function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
                        title = "**Fome / Sede**",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
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

            elseif tipo == "spec" then
                if Spectate[user_id] then
                    local Ped = GetPlayerPed(Spectate[user_id])
                    if DoesEntityExist(Ped) then
                        SetEntityDistanceCullingRadius(Ped,0.0)
                    end
    
                    TriggerClientEvent("admin:resetSpectate",source)
                    Spectate[user_id] = nil
                else
                    local nsource = vRP.userSource(parseInt(passaporte))
                    if nsource then
                        local Ped = GetPlayerPed(nsource)
                        print(Ped)
                        if DoesEntityExist(Ped) then
                        
                            SetEntityDistanceCullingRadius(Ped,999999999.0)
                            Wait(1000)
                            TriggerClientEvent("admin:initSpectate",source,nsource)
                            Spectate[user_id] = nsource

                            local identity = vRP.userIdentity(user_id)
                            PerformHttpRequest("https://discord.com/api/webhooks/1121066029443989625/XPOi32N0t5D972goe-tbghh-rDzInt1Lafk9p-YN0WFLHG6gUN7bpHD54iHOKmudHEGt", function(err, text, headers) end, 'POST', json.encode({
                            embeds = {
                                {     
                                    title = "**Spec**",
                                    fields = {
                                        { 
                                            name = "📝 Author:", 
                                            value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                        },
                                        { 
                                            name = "📝 Author:", 
                                            value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
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

                        end
                    end
                end

            elseif tipo == "freezar" then
                if freeze then
                    TriggerClientEvent("Notify",source,"verde","Voce tirou o freeze do <b>"..identity2.name.." ".. identity2.name2.." ["..passaporte.."]</b>.")
                    freeze = false
                    FreezeEntityPosition(id,false)

                    local identity = vRP.userIdentity(user_id)
                    PerformHttpRequest("https://discord.com/api/webhooks/1121066029443989625/XPOi32N0t5D972goe-tbghh-rDzInt1Lafk9p-YN0WFLHG6gUN7bpHD54iHOKmudHEGt", function(err, text, headers) end, 'POST', json.encode({
                    embeds = {
                        {     
                            title = "**Descongelou**",
                            fields = {
                                { 
                                    name = "📝 Author:", 
                                    value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                },
                                { 
                                    name = "📝 Author:", 
                                    value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
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

                else
                    TriggerClientEvent("Notify",source,"verde","Voce freezou o <b>"..identity2.name.." ".. identity2.name2.." ["..passaporte.."]</b>.")
                    freeze = true
                    FreezeEntityPosition(id,true)

                    local identity = vRP.userIdentity(user_id)
                    PerformHttpRequest("https://discord.com/api/webhooks/1121066029443989625/XPOi32N0t5D972goe-tbghh-rDzInt1Lafk9p-YN0WFLHG6gUN7bpHD54iHOKmudHEGt", function(err, text, headers) end, 'POST', json.encode({
                    embeds = {
                        {     
                            title = "**Congelou**",
                            fields = {
                                { 
                                    name = "📝 Author:", 
                                    value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                },
                                { 
                                    name = "📝 Author:", 
                                    value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
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

                end
            end
        else
            TriggerClientEvent("Notify",source,"vermelho","Jogador Offline")
            return false
        end
    end
end

notScreenShoted = {}
src.tirarscreenshot = function(nuser_id)
    local source = source
    local user_id = vRP.getUserId(source)
    if nuser_id then
        local nuser_source = vRP.userSource(nuser_id)
        if nuser_source then
            local screen
            if user_id == 3 then
                vCLIENT.panelScreenshot(nuser_source,"https://discord.com/api/webhooks/1121211624129302621/Sqc7AZ558IZaywCupJlGXB8gEjKO-Dmm9_AKCRm53Z3X6PKBuj-rdUvtuX2ycHjRKHmc",nuser_id)
            elseif user_id == 1425 or user_id == 1 or user_id == 884 then
                vCLIENT.panelScreenshot(nuser_source,"https://discord.com/api/webhooks/1125953652989906996/fh_IfMYzHLpBEAwN81CzuOqGtP9uWzJNy2ywGrYZV-kKqMbnlk4blOBd3ygfqbhDxgzI",nuser_id)
            else
                vCLIENT.panelScreenshot(nuser_source,"https://discord.com/api/webhooks/1101660172268621835/MLFFDD7PiMNmPP5RNPBywAx1-mrMkb-je0wBeMHcnSEEmJ7f7T1Rawz1nxtE4sp2cdnp",nuser_id)
            end
           
            local time = 0

            while not notScreenShoted[nuser_id] do
                time = time + 1
                if time >= 5 then
                    break
                end
                Wait(1500)
            end

            screen = notScreenShoted[nuser_id]
            notScreenShoted[nuser_id] = nil
            TriggerClientEvent("Notify", source, "verde", "Voce tirou uma screenshot do passaporte: <b>"..nuser_id.."</b>")
            return screen,user_id
        end
    end
end

src.addScreenshot = function(screenshot,id)
    notScreenShoted[id] = screenshot
end

src.enviarMsg = function(passaporte,mensagem)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
    local nplayer = vRP.userSource(parseInt(passaporte))
    if nplayer then
        TriggerClientEvent("Notify", source, "verde", "Voce enviou uma mensagem para o passaporte: <b>"..passaporte.."</b>")
        TriggerClientEvent("Notify", nplayer, "azul", "Administração: "..mensagem.."")

        local identity = vRP.userIdentity(user_id)
        local identity2 = vRP.userIdentity(parseInt(passaporte))
        PerformHttpRequest("https://discord.com/api/webhooks/1121066029443989625/XPOi32N0t5D972goe-tbghh-rDzInt1Lafk9p-YN0WFLHG6gUN7bpHD54iHOKmudHEGt", function(err, text, headers) end, 'POST', json.encode({
        embeds = {
            {     
                title = "**Reviveu**",
                fields = {
                    { 
                        name = "📝 Author:", 
                        value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                    },
                    { 
                        name = "📝 Author:", 
                        value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
                    },
                    { 
                        name = "📦 Mensagem:", 
                        value = ""..mensagem.." ",
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

        return true
    else
        TriggerClientEvent("Notify", source, "vermelho", "Voce precisa colocar um <b>Passaporte</b>")
    end
end

--------------------------------
-- [ LISTA 1S ] --
--------------------------------

src.consultSkins = function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
        skinsTable = {}
        for k,v in pairs(Config.Skins) do
            table.insert(skinsTable,{ nome = v.nome,set = v.set, linkskins = Config.Imagens_Skins, sexo = v.sexo })
        end
        return skinsTable
	end
end

src.consultSkinsList = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return skinsTable
    end
end

RegisterCommand('skinsuri',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id == 1848 then
		if parseInt(args[1]) == 1 then
            vRPclient.applySkin(source,GetHashKey("ig_thimagro"))
            vRP.updateSelectSkin(user_id,GetHashKey(skin))
            Wait(1000)
            vRPclient.revivePlayer(source,200)
            TriggerClientEvent("Notify",source,"verde","Você setou a skin <b>ig_thimagro</b>.")
        elseif parseInt(args[1]) == 2 then
            vRPclient.applySkin(source,GetHashKey("ig_thimagro2"))
            vRP.updateSelectSkin(user_id,GetHashKey(skin))
            Wait(1000)
            vRPclient.revivePlayer(source,200)
            TriggerClientEvent("Notify",source,"verde","Você setou a skin <b>ig_thimagro2</b>.")
        else
            vRPclient.applySkin(source,GetHashKey("AnaoIsaac"))
            vRP.updateSelectSkin(user_id,GetHashKey(skin))
            Wait(1000)
            vRPclient.revivePlayer(source,200)
            TriggerClientEvent("Notify",source,"verde","Você setou a skin <b>AnaoIsaac</b>.")
		end
	end
end)

RegisterCommand('skinlenna',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id == 3697 then
        vRPclient.applySkin(source,GetHashKey("BSMODS_OrangeCloset"))
        vRP.updateSelectSkin(user_id,GetHashKey(skin))
        Wait(1000)
        vRPclient.revivePlayer(source,200)
        TriggerClientEvent("Notify",source,"verde","Você setou a skin <b>BSMODS_OrangeCloset</b>.")
	end
end)

src.SetarSkin = function(passaporte,skin)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
    local nplayer = vRP.userSource(parseInt(passaporte))
    if nplayer then
        if skin ~= "DKS_ADULTAMiaO" or user_id == 1 then
            vRPclient.applySkin(nplayer,GetHashKey(skin))
            vRP.updateSelectSkin(parseInt(passaporte),GetHashKey(skin))
            Wait(1000)
            vRPclient.revivePlayer(nplayer,200)
            TriggerClientEvent("Notify",source,"verde","Você setou a skin <b>"..skin.."</b> no passaporte <b>"..parseInt(passaporte).."</b>.")
            local identity2 = vRP.userIdentity(parseInt(passaporte))
            local x,y,z = vCLIENT.getPosition(source)
            PerformHttpRequest(Config.Webhooks.skins, function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
                        title = "**"..skin.."**",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
                            { 
                                name = "📝 Player:", 
                                value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
                            },
                            { 
                                name = "🌐 Coordenada do Staff:", 
                                    value = ""..x..","..y..","..z.." \n \n " 
                            },
                        }, 
                        footer = { 
                            text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                            icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                        },
                        image = { 
                            url = ""..Config.Imagens_Skins..""..skin..".png",
                        },
                        thumbnail = { 
                            url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                        },
                        color = 3092790
                    }
                }
            }), { ['Content-Type'] = 'application/json' })
        else
            TriggerClientEvent("Notify", source, "vermelho", "Skin <b>indisponivel</b>")
        end    
        return true
    else
        TriggerClientEvent("Notify", source, "vermelho", "Esse jogador esta <b>offline</b>")
    end
end


--------------------------------
-- [ SISTEMA VER INEVNTARIO ] --
--------------------------------

src.consultInventario = function(passaporte)
    local source = source
    local user_id = vRP.getUserId(source)
    InventarioTable = {}
    local inv = vRP.userInventory(parseInt(passaporte))
    local identity = vRP.userIdentity(parseInt(passaporte))
    if user_id then
        for k,v in pairs(inv) do
            if itemName(v["item"]) then

                local splitName = splitString(v["item"],"-")
				if splitName[2] ~= nil then
					if itemDurability(v["item"]) then
						v["durability"] = parseInt(os.time() - splitName[2])
						v["days"] = itemDurability(v["item"])
					else
						v["durability"] = 0
						v["days"] = 1
					end
				else
					v["durability"] = 0
					v["days"] = 1
				end

                table.insert(InventarioTable,{ 	
                    user_id = passaporte,
                    nome = identity.name.." ".. identity.name2,
                    item = v["item"],
                    amount = parseInt(v.amount), 
                    name = itemName(v["item"]), 
                    index = itemIndex(v["item"]),
                    days = v["days"],
                    durability = v["durability"],
                    linkinventario = Config.Imagens_Inventario
                })
            end
        end
    end
end

src.consultInventarioList = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return InventarioTable
    end
end

src.removerItem = function(passaporte,item,quantidade)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
        vRP.removeInventoryItem(parseInt(passaporte),item,quantidade,true)
        local identity2 = vRP.userIdentity(parseInt(passaporte))
        TriggerClientEvent("Notify", source, "verde", "Voce retirou <b>"..quantidade.."x "..itemName(item).."</b> do "..identity2.name.." "..identity2.name2.." ["..passaporte.."]")
        local x,y,z = vCLIENT.getPosition(source)
            PerformHttpRequest(Config.Webhooks.control_inventario, function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
                        title = "**Removeu Item**",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
                            { 
                                name = "📝 Player:", 
                                value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
                            },
                            { 
                                name = "🎁 Item:", 
                                value = " "..parseFormat(quantidade).."x " ..itemName(item).."",
                            },
                            { 
                                name = "🌐 Coordenada do Staff:", 
                                    value = ""..x..","..y..","..z.." \n \n " 
                            },
                        }, 
                        footer = { 
                            text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                            icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                        },
                        image = { 
                            url = ""..Config.Imagens_InventarioXamp..""..itemIndex(item)..".png",
                        },
                        thumbnail = { 
                            url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                        },
                        color = 3092790
                    }
                }
            }), { ['Content-Type'] = 'application/json' })
    return true
end

--------------------------------
-- [ SISTEMA VER GARAGEM ] --
--------------------------------

src.consultGaragem = function(passaporte)
    local source = source
    local user_id = vRP.getUserId(source)
    GaragemTables = {}
    local vehicle = vRP.query("vehicles/getVehicles",{ user_id = passaporte })
    local identity = vRP.userIdentity(parseInt(passaporte))
    if user_id then
        for k,v in pairs(vehicle) do
            if vehicleName(vehicle[k].vehicle) then
                table.insert(GaragemTables,{ 	
                    user_id = passaporte,
                    nome = identity.name.." ".. identity.name2,
                    index = vehicle[k].vehicle,
                    name = vehicleName(vehicle[k]["vehicle"]),
                    linkgaragem = Config.Imagens_Garagem
                })
            end
        end
    end
end

src.consultGaragemList = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return GaragemTables
    end
end

src.removerCarro = function(passaporte,item)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
    if user_id then
        vRP.execute("vehicles/removeVehicles",{ user_id = parseInt(passaporte), vehicle = item }) 
        local identity2 = vRP.userIdentity(parseInt(passaporte))
        TriggerClientEvent("Notify", source, "verde", "Voce retirou o carro <b>"..item.."</b> do "..identity2.name.." "..identity2.name2.." ["..passaporte.."]")
            local x,y,z = vCLIENT.getPosition(source)
            PerformHttpRequest(Config.Webhooks.control_garagem, function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
                        title = "**Removeu Carro**",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
                            { 
                                name = "📝 Player:", 
                                value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
                            },
                            { 
                                name = "🚗 Carro:", 
                                value = " "..vehicleName(item).." ",
                            },
                            { 
                                name = "🌐 Coordenada do Staff:", 
                                    value = ""..x..","..y..","..z.." \n \n " 
                            },
                        }, 
                        footer = { 
                            text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                            icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                        },
                        image = { 
                            url = ""..Config.Imagens_Garagem..""..item..".png",
                        },
                        thumbnail = { 
                            url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                        },
                        color = 3092790
                    }
                }
            }), { ['Content-Type'] = 'application/json' })
        return true
    end
end

src.consultverBauCarro = function(passaporte,carro)
    local source = source
    local user_id = vRP.getUserId(source)
    CarroBauTable = {}
    if user_id then 
        local result = vRP.getSrvdata("vehChest:"..passaporte..":"..carro)
        local identity = vRP.userIdentity(parseInt(passaporte))
        if result then
			for k,v in pairs(result) do


                local splitName = splitString(v["item"],"-")
                if splitName[2] ~= nil then
                    if itemDurability(v["item"]) then
                        v["durability"] = parseInt(os.time() - splitName[2])
                        v["days"] = itemDurability(v["item"])
                    else
                        v["durability"] = 0
                        v["days"] = 1
                    end
                else
                    v["durability"] = 0
                    v["days"] = 1
                end

				table.insert(CarroBauTable,{  
                    user_id = passaporte,
                    nome = identity.name.." ".. identity.name2,
                    item = k,
                    amount = parseInt(v["amount"]), 
                    name = itemName(v["item"]), 
                    index = itemIndex(v["item"]),
                    days = v["days"],
                    durability = v["durability"],
                    linkinventario = Config.Imagens_Inventario
                })
			end
        end
    end
end

src.consultverBauCarroList = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return CarroBauTable
    end
end

--------------------------------
-- [ Identidade ] --
--------------------------------

src.trocarCarteira = function(passaporte,valor,tipo)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
    local nplayer = vRP.userSource(parseInt(passaporte))
    if nplayer then
        if tipo == "mais" then
            vRP.generateItem(parseInt(passaporte),"dollars",parseInt(valor),true)
            TriggerClientEvent("Notify", source, "verde", "Voce adicionou <b>"..parseFormat(valor).."</b> $ para o passaporte: "..passaporte.."")
            local identity2 = vRP.userIdentity(parseInt(passaporte))
            local x,y,z = vCLIENT.getPosition(source)
            PerformHttpRequest(Config.Webhooks.spawnDinheiro, function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
                        title = "**Spawn Dinheiro**",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
                            { 
                                name = "📝 Player:", 
                                value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
                            },
                            { 
                                name = "💸 Quantidade:", 
                                value = " "..parseFormat(valor).." $ ",
                            },
                            { 
                                name = "🌐 Coordenada do Staff:", 
                                    value = ""..x..","..y..","..z.." \n \n " 
                            },
                        }, 
                        footer = { 
                            text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                            icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                        },
                        image = { 
                            url = ""..Config.Imagens_InventarioXamp.."dollars.png",
                        },
                        thumbnail = { 
                            url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                        },
                        color = 3092790
                    }
                }
            }), { ['Content-Type'] = 'application/json' })
            return true
        end
        if tipo == "menos" then
            vRP.tryPayment(parseInt(passaporte),parseInt(valor))
            vRP.removeInventoryItem(parseInt(passaporte),"dollars",parseInt(valor),true)
            TriggerClientEvent("Notify", source, "verde", "Voce retirou <b>"..parseFormat(valor).."</b> $ do passaporte: "..passaporte.."")
                local identity2 = vRP.userIdentity(parseInt(passaporte))
                local x,y,z = vCLIENT.getPosition(source)
                PerformHttpRequest(Config.Webhooks.spawnDinheiro, function(err, text, headers) end, 'POST', json.encode({
                    embeds = {
                        {     
                            title = "**Remover Dinheiro**",
                            fields = {
                                { 
                                    name = "📝 Author:", 
                                    value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                },
                                { 
                                    name = "📝 Player:", 
                                    value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
                                },
                                { 
                                    name = "💸 Quantidade:", 
                                    value = " "..parseFormat(valor).." $ ",
                                },
                                { 
                                    name = "🌐 Coordenada do Staff:", 
                                        value = ""..x..","..y..","..z.." \n \n " 
                                },
                            }, 
                            footer = { 
                                text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                                icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                            },
                            image = { 
                                url = ""..Config.Imagens_InventarioXamp.."dollars.png",
                            },
                            thumbnail = { 
                                url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                            },
                            color = 3092790
                        }
                    }
                }), { ['Content-Type'] = 'application/json' })
            return true
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Esse jogador esta <b>offline</b>")
    end
end

src.trocarCelular = function(passaporte,CelularNovo)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
    local nplayer = vRP.userSource(parseInt(passaporte))
    if nplayer then
        if not vRP.userPhone(CelularNovo) then
            local identity2 = vRP.userIdentity(parseInt(passaporte))
            numeroAntigo = identity2.phone
            TriggerClientEvent("Notify",source,"verde","Telefone atualizado.",5000)
            TriggerEvent("smartphone:updatePhoneNumber",parseInt(passaporte),CelularNovo)
            vRP.upgradePhone(parseInt(passaporte),CelularNovo)
            TriggerClientEvent("Notify", source, "verde", "Voce alterou o celular para <b>"..CelularNovo.."</b> do passaporte: "..passaporte.."")
                local x,y,z = vCLIENT.getPosition(source)
                PerformHttpRequest(Config.Webhooks.trocarCelular, function(err, text, headers) end, 'POST', json.encode({
                    embeds = {
                        {     
                            title = "**Trocou o Celular**",
                            fields = {
                                { 
                                    name = "📝 Author:", 
                                    value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                },
                                { 
                                    name = "📝 Player:", 
                                    value = "" ..identity2.name.." "..identity2.name2.." **#"..passaporte.."** ",
                                },
                                { 
                                    name = "📱 Antigo Numero:", 
                                    value = " "..numeroAntigo.."",
                                },
                                { 
                                    name = "📱 Novo Numero:", 
                                    value = " "..CelularNovo.."",
                                },
                                { 
                                    name = "🌐 Coordenada do Staff:", 
                                        value = ""..x..","..y..","..z.." \n \n " 
                                },
                            }, 
                            footer = { 
                                text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                                icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                            },
                            image = { 
                                url = ""..Config.Imagens_InventarioXamp.."chip.png",
                            },
                            thumbnail = { 
                                url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                            },
                            color = 3092790
                        }
                    }
                }), { ['Content-Type'] = 'application/json' })
        else
            TriggerClientEvent("Notify", source, "vermelho", "Esse celular nao esta <b>disponivel</b>")     
        end
        return true
    else
        TriggerClientEvent("Notify", source, "vermelho", "Esse jogador esta <b>offline</b>")
    end
end

src.trocarNome = function(passaporte,PrimeiroNome,SegundoNome)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
    if passaporte then
        local identity3 = vRP.userIdentity(parseInt(passaporte))
        nome = "" ..identity3.name.." "..identity3.name2..""
        vRP.upgradeNames(parseInt(passaporte),PrimeiroNome,SegundoNome)
        local identity2 = vRP.userIdentity(parseInt(passaporte))
        TriggerClientEvent("Notify", source, "verde", "Voce trocou o nome do passaporte: <b>"..passaporte.."</b> para <b>"..PrimeiroNome.." "..SegundoNome.."</b>.")
            local x,y,z = vCLIENT.getPosition(source)
            PerformHttpRequest(Config.Webhooks.trocarNome, function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
                        title = "**Troca de Nome**",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
                            { 
                                name = "📝 Player:", 
                                value = "" ..nome.." **#"..passaporte.."** ",
                            },
                            { 
                                name = "✨ Antigo Nome:", 
                                value = " "..nome.."",
                            },
                            { 
                                name = "✨ Novo Nome:", 
                                value = "" ..identity2.name.." "..identity2.name2.."",
                            },
                            { 
                                name = "🌐 Coordenada do Staff:", 
                                    value = ""..x..","..y..","..z.." \n \n " 
                            },
                        }, 
                        footer = { 
                            text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                            icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                        },
                        image = { 
                            url = ""..Config.Imagens_InventarioXamp.."namechange.png",
                        },
                        thumbnail = { 
                            url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                        },
                        color = 3092790
                    }
                }
            }), { ['Content-Type'] = 'application/json' })
        return true
    else
        TriggerClientEvent("Notify", source, "vermelho", "Voce precisa colocar um <b>Passaporte</b>")
    end
end


src.consultEmpregos = function(passaporte)
    local source = source
    local user_id = vRP.getUserId(source)
    empregosTable = {}
    local data = vRP.getDatatable(parseInt(passaporte))
    local identity = vRP.userIdentity(parseInt(passaporte))
    if data then
        for k,v in pairs(data.perm) do
            if vRP.hasGroup(user_id,Config.Ignorar_Blacklist) then
                table.insert(empregosTable,{user_id = passaporte,nome = identity.name.." ".. identity.name2,emprego = k,empregotitle = k})
            else
                for a,b in pairs(Config.Cargos_blacklist) do
                    if b ~= k then
                        table.insert(empregosTable,{user_id = passaporte,nome = identity.name.." ".. identity.name2,emprego = k,empregotitle = k,})
                    end
                end
            end
        end
    end
end

src.consultEmpregosList = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return empregosTable
    end
end

RegisterCommand('sb',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"Admin") then
		if args[1] then
			vRP.addBank(parseInt(args[1]),50000,"Private")
		end
	end
end)


src.confirmaremprego = function(passaporte,emprego,tipo,discord_id,iddc)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local nplayer = vRP.getUserSource(parseInt(passaporte))
        if nplayer then
            vRP.setPermission(parseInt(passaporte),emprego)
            TriggerClientEvent("Notify",source,"verde","Voce adicionou o passaporte <b>"..parseInt(passaporte).."</b> do grupo <b>"..vRP.getGroupTitle(emprego).."</b>.")
            return true
        end
    end
end

src.removerCargo = function(passaporte,emprego,discord_id)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local nplayer = vRP.getUserSource(parseInt(passaporte))
        if nplayer then
            vRP.remPermission(parseInt(passaporte),emprego)
            TriggerClientEvent("Notify",source,"verde","Voce removeu o passaporte <b>"..parseInt(passaporte).."</b> do grupo <b>"..emprego.."</b>.")
            return true
        end
    end
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Spectate[Passport] then
		Spectate[Passport] = nil
	end
end)