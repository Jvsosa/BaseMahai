-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("player",cRP)
vCLIENT = Tunnel.getInterface("player")
vSKINSHOP = Tunnel.getInterface("skinshop")

function cRP.getPermissao(toogle)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Admin") then
        return true
    else
        return false
    end
end

local discordLinks = {
	["rename"] = "https://discord.com/api/webhooks/1103940423862456350/kpZ7j_I8X07TSPSWNRhlftMZDxWP_zcyS0GHLypOUgKdV4rFmHnO4AT39NECnNkCrBLv"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORDLOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("discordLogs")
AddEventHandler("discordLogs",function(webhook,message,color)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(discordLinks[webhook], function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("me",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		local message = string.sub(rawCommand:sub(4),1,100)

		local activePlayers = vRPC.activePlayers(source)
		for _,v in ipairs(activePlayers) do
			async(function()
				TriggerClientEvent("showme:pressMe",v,source,message,10)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("upgradeStress")
AddEventHandler("upgradeStress",function(number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.upgradeStress(user_id,number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("downgradeStress")
AddEventHandler("downgradeStress",function(number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.downgradeStress(user_id,number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:KICKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:kickSystem")
AddEventHandler("player:kickSystem",function(message)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasGroup(user_id,"Admin") then
			vRP.kick(user_id,message)
		end
	end
end)

---------------------------------------------------------------
-- /FPS
--------------------------------------------------------------
RegisterCommand("fps",function(source,args)
    if args[1] == "on" then
        SetTimecycleModifier("cinema")
        TriggerEvent("Notify","sucesso","Sucesso","Boost de fps ligado!")
    elseif args[1] == "off" then
        SetTimecycleModifier("default")
        TriggerEvent("Notify","sucesso","Sucesso","Boost de fps desligado!")
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- E
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e",function(source,args,rawCommand)
		local user_id = vRP.getUserId(source)
		if user_id and vRP.getHealth(source) > 101 then
			if args[2] == "friend" then
				local otherPlayer = vRPC.nearestPlayer(source)
				if otherPlayer then
					if vRP.getHealth(otherPlayer) > 101 and not vCLIENT.getHandcuff(otherPlayer) then
						local identity = vRP.userIdentity(user_id)
						if vRP.request(otherPlayer,"Pedido de <b>"..identity["name"].."</b> da animação <b>"..args[1].."</b>?") then
							TriggerClientEvent("emotes",otherPlayer,args[1])
							TriggerClientEvent("emotes",source,args[1])
						end
					end
				end
			else
				TriggerClientEvent("emotes",source,args[1])
			end
		end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Pagar Multas
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-- E2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e2",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and vRP.getHealth(source) > 101 then
			local otherPlayer = vRPC.nearestPlayer(source)
			if otherPlayer then
				if vRP.hasGroup(user_id,"Paramedic") or vRP.hasGroup(user_id,"Admin") then
					TriggerClientEvent("emotes",otherPlayer,args[1])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Doors")
AddEventHandler("player:Doors",function(number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vehNet = vRPC.vehList(source,5)
		if vehicle then
			local activePlayers = vRPC.activePlayers(source)
			for _,v in ipairs(activePlayers) do
				async(function()
					TriggerClientEvent("player:syncDoors",v,vehNet,number)
				end)
			end
		end
	end
end)


cRP.checkperm = function()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"wecolor")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECEIVESALARY
-----------------------------------------------------------------------------------------------------------------------------------------

local Salario = {
	{ title = "Vip Silver",cargo = "vipsilver", valor = 1300 },
	{ title = "Vip Gold",cargo = "vipgold", valor = 2000 },
	{ title = "Vip Platinum",cargo = "vipplatinum", valor = 2500 },
	{ title = "Vip Diamond",cargo = "vipdiamond", valor = 3500 },
	{ title = "Vip Advanced",cargo = "vipadvanced", valor = 5000 },
	{ title = "Vip Kids",cargo = "vipkids", valor = 2500 },
	{ title = "Vip Maui",cargo = "vipmaui", valor = 8000 },
	{ title = "Policia",cargo = "Police", valor = 3000 },
	{ title = "Paramédico",cargo = "Paramedic", valor = 2000 },
	{ title = "Juridico",cargo = "Juridico", valor = 11000 },
	{ title = "Café",cargo = "Cafe", valor = 2000 },
	{ title = "Noruega",cargo = "Noruega", valor = 2500 },
	{ title = "Streamer",cargo = "Streamer", valor = 2500 },
	{ title = "Municao",cargo = "Municao2", valor = 2000 },
	{ title = "Desmanche",cargo = "Desmanche", valor = 2000 },
	{ title = "Farol",cargo = "Farol", valor = 2000 },
	{ title = "Escola",cargo = "Escola", valor = 2000 },
	{ title = "Runway",cargo = "runway", valor = 5000 },
	{ title = "Flamingo",cargo = "Flamingo", valor = 3000 },
	{ title = "Fbi",cargo = "Fbi", valor = 11000 },
}

cRP.receiveSalary = function()
	local source = source
	local user_id = vRP.getUserId(source)
	for k,v in pairs(Salario) do
		if vRP.hasPermission(user_id,v.cargo) then
			local identity = vRP.userIdentity(user_id)
			local banco_antigo = vRP.getBank(user_id)
			vRP.addBank(user_id,parseInt(v.valor),"Private")
			TriggerClientEvent("Notify",source,"azul","Salário de "..v.title.." no valor de <b>$"..v.valor.."</b> recebido.",5000)
			local banco_novo = vRP.getBank(user_id)
			PerformHttpRequest("https://discord.com/api/webhooks/1121085159333187686/awtf3ouPy95eLPPZDHl91LoP11vnszL8wPldMQFc0HnV1fSDZV7RdEZvEmkRZ0k1viQC", function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
                        title = "**Salario "..v.title.."**",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
                            { 
                                name = "💋 Recebeu:", 
                                    value = ""..v.valor.." $" 
                            },
							{ 
                                name = "💰 Conta Bancaria:", 
                                    value = "Valor Antigo: "..banco_antigo.." $ / Valor Novo: "..banco_novo.." $" 
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

			Wait(5000)
		end
	end
end

local UniqueShoes = {}
RegisterServerEvent("player:checkShoes")
AddEventHandler("player:checkShoes",function(Entity)
	local source = source
	local Passport = vRP.getUserId(source)
	if Passport then
		
		if not UniqueShoes[Entity] then
			UniqueShoes[Entity] = os.time()
		end

		if os.time() >= UniqueShoes[Entity] then
			if vSKINSHOP.checkShoes(Entity) then
				vRP.generateItem(Passport,"WEAPON_SHOES",2,true)
				UniqueShoes[Entity] = os.time() + 300
			end
		end

	end
end)
------

-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("911",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and args[1] and vRP.getHealth(source) > 101 then
			if vRP.hasGroup(user_id,"Police") then
				local department = "Police"
				local identity = vRP.userIdentity(user_id)
				local policeResult = vRP.numPermission("Police")
				for k,v in pairs(policeResult) do
					print("Chat da Policia "..k.." "..v.."")
					print(rawCommand:sub(4))
					async(function()
						--TriggerClientEvent("chatME",source,"^2911^3"..department.."^9"..identity["name"].."^0"..rawCommand:sub(4))
						TriggerClientEvent("chatME",v,"^2911^3"..department.."^9"..identity["name"].."^0"..rawCommand:sub(4))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 112
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("112",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and args[1] and vRP.getHealth(source) > 101 then
			if vRP.hasGroup(user_id,"Paramedic") then
				local identity = vRP.userIdentity(user_id)
				local paramedicResult = vRP.numPermission("Paramedic")
				for k,v in pairs(paramedicResult) do
					async(function()
						TriggerClientEvent("chatME",source,"^4112^9"..identity["name"].." "..identity["name2"].."^0"..rawCommand:sub(4))
						TriggerClientEvent("chatME",v,"^4112^9"..identity["name"].." "..identity["name2"].."^0"..rawCommand:sub(4))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.shotsFired()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)
		local policeResult = vRP.numPermission("Police")

		for k,v in pairs(policeResult) do
			async(function()
				TriggerClientEvent("NotifyPush",v,{ code = 10, imagem = "tiro", title = "Confronto em andamento", criminal = "Foi realizado disparos de arma de foto, verifique o local.",  x = coords["x"], y = coords["y"], z = coords["z"], blipColor = 6, time = os.date("%H:%M") })
			end)
		end

		local identity = vRP.userIdentity(user_id)
		PerformHttpRequest("https://discord.com/api/webhooks/1121085329751937026/CcpK7kFR6qHAvAY_EIOGllFXw-cS06tmFijlXJjq6XGP_uRqTyX9VqkZ7TnZdQLQpQ5d", function(err, text, headers) end, 'POST', json.encode({
		embeds = {
			{     
				title = "**Disparos de arma de fogo**",
				fields = {
					{ 
						name = "📝 Author:", 
						value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
					},

					{ 
						name = "🌐 Coordenada do Player:", 
							value = ""..coords["x"]..","..coords["y"]..","..coords["z"].." \n \n " 
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


-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CARRYPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
local playerCarry = {}
RegisterServerEvent("player:carryPlayer")
AddEventHandler("player:carryPlayer",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRPC.inVehicle(source) then
			if playerCarry[user_id] then
				TriggerClientEvent("player:playerCarry",playerCarry[user_id],source)
				TriggerClientEvent("player:Commands",playerCarry[user_id],false)
				playerCarry[user_id] = nil
			else
				local otherPlayer = vRPC.nearestPlayer(source)
				if otherPlayer then
					playerCarry[user_id] = otherPlayer

					TriggerClientEvent("player:playerCarry",playerCarry[user_id],source)
					TriggerClientEvent("player:Commands",playerCarry[user_id],true)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if playerCarry[user_id] then
		TriggerClientEvent("player:Commands",playerCarry[user_id],false)
		playerCarry[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:WINSFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:winsFunctions")
AddEventHandler("player:winsFunctions",function(mode)
	local source = source
	local vehicle,vehNet = vRPC.vehSitting(source)
	if vehicle then
		local activePlayers = vRPC.activePlayers(source)
		for _,v in ipairs(activePlayers) do
			async(function()
				TriggerClientEvent("player:syncWins",v,vehNet,mode)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CVFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:cvFunctions")
AddEventHandler("player:cvFunctions",function(mode)
	local source = source
	local distance = 1.1

	if mode == "rv" then
		distance = 10.0
	end

	local otherPlayer = vRPC.nearestPlayer(source,distance)
	if otherPlayer then
		local user_id = vRP.getUserId(source)
		local nuser_id = vRP.getUserId(otherPlayer)
		local consultItem = vRP.getInventoryItemAmount(user_id,"rope")
		if vRP.hasGroup(user_id,"Police") or vRP.hasGroup(user_id,"Paramedic") or consultItem[1] >= 1 then
			local vehicle,vehNet = vRPC.vehList(source,5)
			if vehicle then
				local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
				local doorStatus = GetVehicleDoorLockStatus(idNetwork)
			
				if parseInt(doorStatus) <= 1 then
					if mode == "rv" then
						vCLIENT.removeVehicle(otherPlayer)

						local identity = vRP.userIdentity(user_id)
						local identity2 = vRP.userIdentity(nuser_id)
						local x,y,z = vCLIENT.getPosition(source)
						local x2,y2,z2 = vCLIENT.getPosition(otherPlayer)
						PerformHttpRequest("https://discord.com/api/webhooks/1121086914510991420/hBle9_rwSnFtBpp4fjI4Q1g7l6GuPfm-yqXdAxy0e56ImD_KtjEmmRhDCgHUAkG5xuD-", function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{     
								title = "**Removeu do Carro**",
								fields = {
									{ 
										name = "📝 Author:", 
										value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
									},
		
									{ 
										name = "📝 Player:", 
										value = " "..identity2["name"].." "..identity2["name2"].." **#" ..nuser_id.."**",
									},
		
									{ 
										name = "🌐 Coordenada do Staff:", 
										value = ""..x..","..y..","..z.." \n \n " 
									},
		
									{ 
										name = "🌐 Coordenada do Player:", 
										value = ""..x2..","..y2..","..z2.." \n \n " 
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

					elseif mode == "cv" then
						vCLIENT.putVehicle(otherPlayer,vehNet)

						local identity = vRP.userIdentity(user_id)
						local identity2 = vRP.userIdentity(nuser_id)
						local x,y,z = vCLIENT.getPosition(source)
						local x2,y2,z2 = vCLIENT.getPosition(otherPlayer)
						PerformHttpRequest("https://discord.com/api/webhooks/1121086605965410374/CUxFieRFRkKRlfNWuLRXCiZFEcXQkUdNs9fPNYy-YOubF2lRjwNLZVnXcuHn8maS5fcF", function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{     
								title = "**Removeu do Carro**",
								fields = {
									{ 
										name = "📝 Author:", 
										value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
									},
		
									{ 
										name = "📝 Player:", 
										value = " "..identity2["name"].." "..identity2["name2"].." **#" ..nuser_id.."**",
									},
		
									{ 
										name = "🌐 Coordenada do Staff:", 
										value = ""..x..","..y..","..z.." \n \n " 
									},
		
									{ 
										name = "🌐 Coordenada do Player:", 
										value = ""..x2..","..y2..","..z2.." \n \n " 
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
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local preset = {
	["1"] = {
		["mp_m_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 87, texture = 12, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 25, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 169, texture = 13, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 16, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 146, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 6, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		},
		["mp_f_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 136, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 11, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 169, texture = 13, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 24, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 32, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 141, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 14, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		}
	},
	["2"] = {
		["mp_m_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 33, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 25, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 16, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 146, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 6, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		},
		["mp_f_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 32, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 11, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 24, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 32, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 141, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 14, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		}
	},
	["3"] = {
		["mp_m_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 33, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 25, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 16, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 146, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 6, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		},
		["mp_f_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 32, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 11, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 24, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 32, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 141, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 14, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		}
	},
	["4"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 87, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 25, texture = 3, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 35, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 16, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 146, texture = 3, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 6, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		},
		["mp_f_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 136, texture = 4, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 11, texture = 3, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 36, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 32, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 141, texture = 4, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 14, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		}
	},
	["5"] = {
		["mp_m_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 33, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 15, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 146, texture = 4, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 6, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		},
		["mp_f_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 32, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 24, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 32, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 141, texture = 3, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 14, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		}
	},
	["6"] = {
		["mp_m_freemode_01"] = {
				["hat"] = { item = 150, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 92, texture = 4, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 25, texture = 4, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 169, texture = 16, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 129, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 139, texture = 5, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 112, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 18, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 25, texture = 4, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		},
		["mp_f_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 32, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 24, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 32, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 141, texture = 3, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 14, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		}
	},
	["7"] = {
		["mp_m_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 26, texture = 6, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 169, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 15, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 16, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 146, texture = 6, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 125, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 125, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		},
		["mp_f_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 32, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 24, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 32, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 141, texture = 3, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 14, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		}
	},
	["8"] = {   ----PARAMEDICO
		["mp_m_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 20, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 7, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 96, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 32, texture = 7, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 126, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 79, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		},
		["mp_f_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 23, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 7, texture = 3, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 101, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 58, texture = 7, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 96, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 91, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		}
	},
	["9"] = {   ---ENFERME
		["mp_m_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 20, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 7, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 96, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 32, texture = 7, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 126, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 79, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		},
		["mp_f_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 0, texture = 6, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 1, texture = 14, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 101, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 224, texture = 24, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 96, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		}
	},
	["11"] = {   ---PARAME
		["mp_m_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 20, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 7, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 96, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 32, texture = 7, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 126, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 79, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		},
		["mp_f_freemode_01"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 99, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 1, texture = 10, defaultItem = 1, defaultTexture = 0 },
				["tshirt"] = { item = 101, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso"] = { item = 257, texture = 7, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 10, texture = 4, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 101, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
		}
	},
	["10"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 94, texture = 2 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 67, texture = 2 },
			["tshirt"] = { item = 15, texture = 0 },
			["torso"] = { item = 243, texture = 2 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 86, texture = 1 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 97, texture = 2 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 70, texture = 2 },
			["tshirt"] = { item = 15, texture = 0 },
			["torso"] = { item = 251, texture = 2 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 88, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["11"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 }, --chapeu
			["pants"] = { item = 80, texture = 0 },  --calca
			["vest"] = { item = 15, texture = 0 }, --colete
			["bracelet"] = { item = -1, texture = 0 }, --pulseira
			["backpack"] = { item = 0, texture = 0 }, --mochila
			["decals"] = { item = 0, texture = 0 }, --adesivos
			["mask"] = { item = 0, texture = 0 }, --mascara
			["shoes"] = { item = 40, texture = 0 }, --sapatos
			["tshirt"] = { item = 15, texture = 0 }, --camisa
			["torso"] = { item = 307, texture = 0 }, --jaqueta
			["accessory"] = { item = 23, texture = 0 }, --acessorios
			["watch"] = { item = -1, texture = 0 }, --relogio 
			["arms"] = { item = 156, texture = 2 }, --maos
			["glass"] = { item = 0, texture = 0 }, --oculos
			["ear"] = { item = -1, texture = 0 } --brinco
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 126, texture = 0 },
			["vest"] = { item = 13, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 24, texture = 0 },
			["tshirt"] = { item = 14, texture = 0 },
			["torso"] = { item = 339, texture = 0 },
			["accessory"] = { item = 45, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 117, texture = 9 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }	
		}
	},
	["12"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 }, --chapeu
			["pants"] = { item = 180, texture = 0 },  --calca
			["vest"] = { item = 19, texture = 0 }, --colete
			["bracelet"] = { item = -1, texture = 0 }, --pulseira
			["backpack"] = { item = 0, texture = 0 }, --mochila
			["decals"] = { item = 0, texture = 0 }, --adesivos
			["mask"] = { item = 0, texture = 0 }, --mascara
			["shoes"] = { item = 40, texture = 0 }, --sapatos
			["tshirt"] = { item = 15, texture = 0 }, --camisa
			["torso"] = { item = 179, texture = 3 }, --jaqueta
			["accessory"] = { item = 23, texture = 0 }, --acessorios
			["watch"] = { item = -1, texture = 0 }, --relogio 
			["arms"] = { item = 156, texture = 2 }, --maos
			["glass"] = { item = 0, texture = 0 }, --oculos
			["ear"] = { item = -1, texture = 0 } --brinco
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 126, texture = 21 },
			["vest"] = { item = -1, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 24, texture = 0 },
			["tshirt"] = { item = 31, texture = 0 },
			["torso"] = { item = 26, texture = 3 },
			["accessory"] = { item = 45, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 111, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }	
		}
	},
	["13"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = 19, texture = 0 }, --chapeu
			["pants"] = { item = 83, texture = 0 },  --calca
			["vest"] = { item = 0, texture = 0 }, --colete
			["bracelet"] = { item = -1, texture = 0 }, --pulseira
			["backpack"] = { item = 0, texture = 0 }, --mochila
			["decals"] = { item = 0, texture = 0 }, --adesivos
			["mask"] = { item = 0, texture = 0 }, --mascara
			["shoes"] = { item = 69, texture = 0 }, --sapatos
			["tshirt"] = { item = 131, texture = 0 }, --camisa
			["torso"] = { item = 195, texture = 1 }, --jaqueta
			["accessory"] = { item = 64, texture = 0 }, --acessorios
			["watch"] = { item = -1, texture = 0 }, --relogio 
			["arms"] = { item = 135, texture = 2 }, --maos
			["glass"] = { item = 0, texture = 0 }, --oculos
			["ear"] = { item = -1, texture = 0 } --brinco
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 87, texture = 0 },
			["vest"] = { item = -1, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 24, texture = 0 },
			["tshirt"] = { item = 33, texture = 0 },
			["torso"] = { item = 208, texture = 1 },
			["accessory"] = { item = 45, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 111, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["14"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 }, --chapeu
			["pants"] = { item = 4, texture = 1 },  --calca
			["vest"] = { item = 33, texture = 0 }, --colete
			["bracelet"] = { item = -1, texture = 0 }, --pulseira
			["backpack"] = { item = 0, texture = 0 }, --mochila
			["decals"] = { item = 0, texture = 0 }, --adesivos
			["mask"] = { item = 0, texture = 0 }, --mascara
			["shoes"] = { item = 20, texture = 1 }, --sapatos
			["tshirt"] = { item = 18, texture = 0 }, --camisa
			["torso"] = { item = 0, texture = 13 }, --jaqueta
			["accessory"] = { item = 23, texture = 0 }, --acessorios
			["watch"] = { item = -1, texture = 0 }, --relogio 
			["arms"] = { item = 198, texture = 2 }, --maos
			["glass"] = { item = 0, texture = 0 }, --oculos
			["ear"] = { item = -1, texture = 0 } --brinco
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 }, --chapeu
			["pants"] = { item = 73, texture = 5 },  --calca
			["vest"] = { item = 13, texture = 0 }, --colete
			["bracelet"] = { item = -1, texture = 0 }, --pulseira
			["backpack"] = { item = 0, texture = 0 }, --mochila
			["decals"] = { item = 0, texture = 0 }, --adesivos
			["mask"] = { item = 0, texture = 0 }, --mascara
			["shoes"] = { item = 24, texture = 0 }, --sapatos
			["tshirt"] = { item = 9, texture = 0 }, --camisa
			["torso"] = { item = 335, texture = 1 }, --jaqueta
			["accessory"] = { item = 45, texture = 0 }, --acessorios
			["watch"] = { item = -1, texture = 0 }, --relogio 
			["arms"] = { item = 198, texture = 2 }, --maos
			["glass"] = { item = 0, texture = 0 }, --oculos
			["ear"] = { item = -1, texture = 0 } --brinco				
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESETFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:presetFunctions")
AddEventHandler("player:presetFunctions",function(number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Emergency") then
			local model = vRP.modelPlayer(source)

			if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
				TriggerClientEvent("updateRoupas",source,preset[number][model])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function()
	local source = source
	local otherPlayer = vRPC.nearestPlayer(source)
	if otherPlayer then
		TriggerClientEvent("player:checkTrunk",otherPlayer)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT - REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
local removeFit = {
	["homem"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mulher"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESETFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------

vRP.prepare("novaRoupa/search","SELECT * FROM entitydata WHERE dkey = @dkey")
vRP.prepare("novaRoupa/new","INSERT INTO entitydata(dkey,dvalue) VALUES(@dkey,@dvalue)")
vRP.prepare("novaRoupa/newupdate", "UPDATE entitydata SET dvalue = @dvalue WHERE dkey = @dkey") 

RegisterServerEvent("player:outfitFunctions")
AddEventHandler("player:outfitFunctions",function(mode)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and not exports["hud"]:Repose(user_id) and not exports["hud"]:Wanted(user_id) then
		if mode == "aplicar" then
			local result = vRP.getSrvdata("saveClothes:"..user_id)
			if result["pants"] ~= nil then
				TriggerClientEvent("updateRoupas",source,result)
				TriggerClientEvent("Notify",source,"verde","Roupas aplicadas.",3000)
			else
				TriggerClientEvent("Notify",source,"amarelo","Roupas não encontradas.",3000)
			end
		elseif mode == "preaplicar" then
			if vRP.userPremium(user_id) then
				local result = vRP.getSrvdata("premClothes:"..user_id)
				if result["pants"] ~= nil then
					
					TriggerClientEvent("updateRoupas",source,result)
					
					TriggerClientEvent("Notify",source,"verde","Roupas aplicadas.",3000)
				else
					TriggerClientEvent("Notify",source,"amarelo","Roupas não encontradas.",3000)
				end
			end
		elseif mode == "salvar" then
			local checkBackpack = vSKINSHOP.checkBackpack(source)
			if not checkBackpack then
				local custom = vSKINSHOP.getCustomization(source)
				if custom then
				--	vRP.setSrvdata("saveClothes:"..user_id,custom)
					if not vRP.query("novaRoupa/search",{dkey = 'saveClothes:'..user_id})[1] then
						vRP.execute("novaRoupa/new", {dkey = 'saveClothes:'..user_id,dvalue = json.encode(custom)})
						TriggerClientEvent("Notify",source,"verde","Roupas salvas.",3000)
					else
						vRP.execute("novaRoupa/newupdate", {dkey = 'saveClothes:'..user_id,dvalue = json.encode(custom)})
						TriggerClientEvent("Notify",source,"verde","Roupas atualizadas.",3000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Remova do corpo o acessório item.",5000)
			end
		elseif mode == "presalvar" then
			local checkBackpack = vSKINSHOP.checkBackpack(source)
			if not checkBackpack then
				local custom = vSKINSHOP.getCustomization(source)
				if custom then

					if not vRP.query("novaRoupa/search",{dkey = 'premClothes:'..user_id})[1] then
						vRP.execute("novaRoupa/new", {dkey = 'premClothes:'..user_id,dvalue = json.encode(custom)})
						TriggerClientEvent("Notify",source,"verde","Roupas salvas.",3000)
					else
						vRP.execute("novaRoupa/newupdate", {dkey = 'premClothes:'..user_id,dvalue = json.encode(custom)})
						TriggerClientEvent("Notify",source,"verde","Roupas atualizadas.",3000)
					end
					-- vRP.execute("novaRoupa/new", {dkey = 'premClothes:'..user_id,dvalue = json.encode(custom)})
				--	vRP.setSrvdata("premClothes:"..user_id,custom)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Remova do corpo o acessório item.",5000)
			end
		elseif mode == "remover" then
			local model = vRP.modelPlayer(source)
			if model == "mp_m_freemode_01" then
				TriggerClientEvent("updateRoupas",source,removeFit["homem"])
			elseif model == "mp_f_freemode_01" then
				TriggerClientEvent("updateRoupas",source,removeFit["mulher"])
			end
		else
			TriggerClientEvent("skinshop:set"..mode,source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand("add",function(source,args,rawCommand)
-- 	if exports["chat"]:statusChat(source) then
-- 		local user_id = vRP.getUserId(source)
-- 		if user_id and args[1] and parseInt(args[2]) > 0 then
-- 			local Group = args[1]
-- 			local nuser_id = parseInt(args[2])

-- 			local identity = vRP.userIdentity(nuser_id)
-- 			if identity then
-- 				if vRP.hasPermission(user_id,"set"..Group) then
-- 					vRP.cleanPermission(nuser_id)
-- 					vRP.setPermission(nuser_id,Group)
-- 					TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..nuser_id.."</b> adicionado.",5000)
-- 				end
-- 			end
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand("rem",function(source,args,rawCommand)
-- 	if exports["chat"]:statusChat(source) then
-- 		local user_id = vRP.getUserId(source)
-- 		if user_id and args[1] and parseInt(args[2]) > 0 then
-- 			local Group = args[1]
-- 			local nuser_id = parseInt(args[2])

-- 			local identity = vRP.userIdentity(nuser_id)
-- 			if identity then
-- 				if vRP.hasPermission(user_id,"set"..Group) then
-- 					vRP.cleanPermission(nuser_id)
-- 					TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..nuser_id.."</b> removido.",5000)
-- 				end
-- 			end
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATHLOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:deathLogs")
AddEventHandler("player:deathLogs",function(nSource)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and source ~= nSource then
		local nuser_id = vRP.getUserId(nSource)
		if nuser_id then

				local identity = vRP.userIdentity(user_id)
				local identity2 = vRP.userIdentity(nuser_id)
				local x,y,z = vCLIENT.getPosition(source)
				local x2,y2,z2 = vCLIENT.getPosition(nSource)
				PerformHttpRequest("https://discord.com/api/webhooks/1121087159919722619/-K683gyU6sjLmgI3MhUMMUYZgvFN2tejD9w5F7NJiWZ5cjOcQ75Fmh1Z5Ip_lz9fesNX", function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{     
						title = "**Matou**",
						fields = {
							{ 
								name = "📝 Author:", 
								value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
							},

							{ 
								name = "📝 Player:", 
								value = " "..identity2["name"].." "..identity2["name2"].." **#" ..nuser_id.."**",
							},

							{ 
								name = "🌐 Coordenada do Staff:", 
								value = ""..x..","..y..","..z.." \n \n " 
							},

							{ 
								name = "🌐 Coordenada do Player:", 
								value = ""..x2..","..y2..","..z2.." \n \n " 
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
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORDLINKS
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORDLOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("discordLogs")
AddEventHandler("discordLogs",function(webhook,message,color)
	if webhook ~= nil and webhook ~= "" then
		return true
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKESBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.bikesBackpack()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local amountWeight = 10
		local myWeight = vRP.getWeight(user_id)

		if parseInt(myWeight) < 45 then
			amountWeight = 15
		elseif parseInt(myWeight) >= 45 and parseInt(myWeight) <= 79 then
			amountWeight = 10
		elseif parseInt(myWeight) >= 80 and parseInt(myWeight) <= 95 then
			amountWeight = 5
		elseif parseInt(myWeight) >= 100 and parseInt(myWeight) <= 148 then
			amountWeight = 2
		elseif parseInt(myWeight) >= 150 then
			amountWeight = 1
		end

		vRP.setWeight(user_id,amountWeight)
	end
end
