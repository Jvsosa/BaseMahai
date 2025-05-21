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
Tunnel.bindInterface("drugs",cRP)
vCLIENT = Tunnel.getInterface("drugs")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local amount = {}
local hasList = {}
local lastTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemList = {
	{ item = "lean", priceMin = 750, priceMax = 850, randMin = 4, randMax = 6 },
	{ item = "ecstasy", priceMin = 750, priceMax = 850, randMin = 4, randMax = 6 },
	{ item = "cocaine", priceMin = 750, priceMax = 850, randMin = 4, randMax = 6 },
	{ item = "lsd", priceMin = 750, priceMax = 850, randMin = 4, randMax = 6 },
	{ item = "meth", priceMin = 750, priceMax = 850, randMin = 4, randMax = 6 },
	{ item = "joint", priceMin = 750, priceMax = 850, randMin = 4, randMax = 6 },
	{ item = "oxy", priceMin = 750, priceMax = 850, randMin = 4, randMax = 6 },
	{ item = "heroine", priceMin = 750, priceMax = 850, randMin = 4, randMax = 6 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
--function cRP.checkPermission()
--	local source = source
--	local user_id = vRP.getUserId(source)
--	if user_id then
	--	if vRP.hasGroup(user_id,"Drugs") then
--			TriggerClientEvent("Notify",source,"aviso","Sistema indisponível.",5000)
--			return false
	--	end
--	end

--	return true
--end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkAmount()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(itemList) do
			local rand = math.random(v["randMin"],v["randMax"])
			local consultItem = vRP.getInventoryItemAmount(user_id,v["item"])
			if consultItem[1] >= parseInt(rand) then
				amount[user_id] = { v["item"],rand,math.random(v["priceMin"],v["priceMax"]) }

				if math.random(100) >= 65 then
					local ped = GetPlayerPed(source)
					local coords = GetEntityCoords(ped)

					local policeResult = vRP.numPermission("Police")
					for k,v in pairs(policeResult) do
						async(function()
						--	TriggerClientEvent("NotifyPush",source,{ code = "QRU", imagem = "trafico", title = "Venda de Drogas", criminal = "Teve uma denuncia de venda de drogas, verifique o local.", x = -75.82, y = -817.02, z = 326.18, time = os.date("%H:%M"), blipColor = 5 })
							TriggerClientEvent("NotifyPush",v,{ code = "QRU", imagem = "trafico", title = "Venda de Drogas", criminal = "Teve uma denuncia de venda de drogas, verifique o local.", x = -75.82, x = coords["x"], y = coords["y"], z = coords["z"], time = os.date("%H:%M"), blipColor = 5 })
						end)
					end

					local identity = vRP.userIdentity(user_id)
					PerformHttpRequest("https://discord.com/api/webhooks/1121091129228668929/Cr7iUhEBhzyypXQ1APfVv2oly9m2fIggxC8sjunES7SsnIkNIwOIfYyDaDq4guxVxZ0w", function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{     
							title = "**Foi Denunciado**",
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

				return true
			end
		end

		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,amount[user_id][1],amount[user_id][2],true) then
			vRP.upgradeStress(user_id,2)
			TriggerClientEvent("player:applyGsr",source)
			local value = amount[user_id][3] * amount[user_id][2]

			vRP.generateItem(user_id,"dollars2",parseInt(value),true)

			local identity = vRP.userIdentity(user_id)
			PerformHttpRequest("https://discord.com/api/webhooks/1121091129228668929/Cr7iUhEBhzyypXQ1APfVv2oly9m2fIggxC8sjunES7SsnIkNIwOIfYyDaDq4guxVxZ0w", function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{     
					title = "**Vendeu Droga**",
					fields = {
						{ 
							name = "📝 Author:", 
							value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
						},
						{ 
							name = "💸 Ganhou:", 
								value = ""..parseInt(value).."\n\n" 
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


			if math.random(100) >= 65 then
				if vRP.tryGetInventoryItem(user_id,"oxy",1,true) then
					vRP.generateItem(user_id,"dollars2",math.random(125,175),true)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
local robberys = {
	{ item = "notepad", min = 1, max = 5 },
	{ item = "mouse", min = 1, max = 1 },
	{ item = "silverring", min = 1, max = 1 },
	{ item = "goldring", min = 1, max = 1 },
	{ item = "watch", min = 1, max = 2 },
	{ item = "ominitrix", min = 1, max = 1 },
	{ item = "bracelet", min = 1, max = 1 },
	{ item = "spray01", min = 1, max = 2 },
	{ item = "spray02", min = 1, max = 2 },
	{ item = "spray03", min = 1, max = 2 },
	{ item = "spray04", min = 1, max = 2 },
	{ item = "dices", min = 1, max = 2 },
	{ item = "dish", min = 1, max = 3 },
	{ item = "sneakers", min = 1, max = 2 },
	{ item = "rimel", min = 1, max = 3 },
	{ item = "blender", min = 1, max = 1 },
	{ item = "switch", min = 1, max = 3 },
	{ item = "brush", min = 1, max = 2 },
	{ item = "domino", min = 1, max = 3 },
	{ item = "floppy", min = 1, max = 4 },
	{ item = "deck", min = 1, max = 2 },
	{ item = "pliers", min = 1, max = 2 },
	{ item = "slipper", min = 1, max = 1 },
	{ item = "soap", min = 1, max = 1 },
	{ item = "dollars2", min = 425, max = 525 },
	{ item = "card01", min = 1, max = 1 },
	{ item = "card02", min = 1, max = 1 },
	{ item = "card03", min = 1, max = 1 },
	{ item = "card04", min = 1, max = 1 },
	{ item = "card05", min = 1, max = 1 }
}

function cRP.paymentRobbery()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local rand = math.random(#robberys)
		local value = math.random(robberys[rand]["min"],robberys[rand]["max"])

		vRP.generateItem(user_id,robberys[rand]["item"],value,true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSERTPEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.insertPedlist(pedId,callPolice,sellDrugs)
	hasList[pedId] = true
	TriggerClientEvent("drugs:insertList",-1,pedId)

	if GetGameTimer() >= lastTimers then
		lastTimers = GetGameTimer() + (30 * 60000)
		TriggerClientEvent("drugs:clearList",-1)
	end

	if callPolice then
		if math.random(100) >= 50 then
			local source = source
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			local textNotify = "Venda de Drogas"
			local textCriminal = "Teve uma denuncia de venda de drogas, verifique o local."
			local textImagem = "trafico"

			if not sellDrugs then
				textNotify = "Roubo de Pertences"
				textCriminal = "Acabou de acontecer um roubo de pertences, prenda o suspeito."
				textImagem = "pertences"
			end

			local policeResult = vRP.numPermission("Police")
			for k,v in pairs(policeResult) do
				async(function()
					TriggerClientEvent("NotifyPush",v,{ code = "QRU", imagem = textImagem, criminal = textCriminal, title = textNotify, x = coords["x"], y = coords["y"], z = coords["z"], time = os.date("%H:%M"), blipColor = 5 })
				end)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("drugs:updateList",source,hasList)
end)