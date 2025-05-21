-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("chest",cRP)


local chestPlayer = {}

vRP.prepare("chest/createTables", [[	
	CREATE TABLE IF NOT EXISTS chest (
	id int(11) NOT NULL AUTO_INCREMENT,
	org longtext,
	value int(11) DEFAULT 0,
	PRIMARY KEY (id))
]])


vRP.prepare("chest/upgradeChest", "UPDATE chest SET value = value + 100 WHERE org = @org ")

vRP.prepare("chest/consultValue","SELECT * FROM chest WHERE org = @org")
vRP.prepare("chest/addChest","INSERT INTO chest (org,value) VALUES(@org,3000) ")
vRP.prepare("chest/consultTables","SHOW TABLES LIKE 'chest'")

CreateThread(function()
    if vRP.query("chest/consultTables")[1] == nil then
        vRP.execute("chest/createTables")
        print('[+] ^7chest^0 - BANCO DE DADOS INSTALADO COM SUCESSO!')
    else
        print('[+] ^7chest^0 - O BANCO DE DADOS ESTA CONFIGURADO!')
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
-- function cRP.checkIntPermissions(chestName)
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		if chestName == "trayShot" or chestName == "trayDesserts" or chestName == "trayPops" or chestName == "trayPizza" then
-- 			return true
-- 		end

-- 		local consultChest = vRP.query("chests/getChests",{ name = chestName })
-- 		if consultChest[1] then
-- 			if (vRP.hasGroup(user_id,consultChest[1]["perm"]) and not exports["hud"]:Wanted(user_id)) or vRP.hasGroup(user_id,"Police") then
-- 				return true
-- 			end
-- 		end
-- 	end

-- 	return false
-- end


checkPermissionTable = function(user_id,table)
	for k,v in pairs(table) do
		if vRP.hasPermission(user_id,v) then
			return true
		end
	end
end

vRP._prepare("getUsuario_chest", "SELECT * FROM groups_perfil WHERE user_id = @user_id") 
function cRP.checkIntPermissions(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		
		if chestName == "Bandeja1" then
		
			return true
		end

		local splitName = splitString(chestName, "-")

		if string.find(chestName, "Lider") then 
		
			local GetJogador = vRP.query("getUsuario_chest", {user_id = user_id})
	

			if splitName[1] == "ClubAnitta" then
				splitName[1] = "Bar"
			end


			if vRP.hasGroup(user_id,splitName[1]) and GetJogador[1].cargo == "Lider" or GetJogador[1].cargo == "Gerente" then
				return true
			end

		elseif string.find(chestName, "Comando Geral") then 
			local GetJogador = vRP.query("getUsuario_chest", {user_id = user_id})
			if vRP.hasGroup(user_id,splitName[1]) and GetJogador[1].cargo == "Comando Geral" then
				return true
			end
		else
			if (vRP.hasGroup(user_id,chestName)) then
				return true
			end
		end
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.upgradeSystem(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.request(source,"Aumentar <b>100Kg</b> por <b>$"..parseFormat(50000).."</b> dólares?","Comprar") then
			if vRP.paymentFull(user_id,50000) then
				print("[Chest] - ","^7O Bau da org "..chestName.." foi atualizado em 100kg ^0")
				vRP.execute("chest/upgradeChest",{ org = chestName })
				TriggerClientEvent("Notify",source,"verde","Compra concluída.",3000)
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.openChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myInventory = {}
		local inventory = vRP.userInventory(user_id)

		local sloltsTotal = 100
		if chestName == "Bandeja1" or chestName == "Bandeja2" then
			sloltsTotal = 5
		elseif chestName == "Police" or chestName == "Police-Comandante" or chestName == "Fbi" or chestName == "Police2" or chestName == "Mecanico" or chestName == "Mecanico-Lider" or chestName == "Cafe" then
			sloltsTotal = 800
		else
			sloltsTotal = 100
		end

		for k,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["type"] = itemType(v["item"])
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

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

			myInventory[k] = v
		end

		local myChest = {}
	
		local result = vRP.getSrvdata("stackChest:"..chestName)
		for k,v in pairs(result) do
	
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["type"] = itemType(v["item"])
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = k
		

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

			myChest[k] = v
		end

		local chestQuery = vRP.query("chest/consultValue",{org = chestName})[1]
		local chestValue = 0
		if not chestQuery then
			vRP.execute("chest/addChest",{org = chestName})
			chestValue = 3000
			chestPlayer[user_id] = 3000
		else
			chestValue = chestQuery["value"]
			chestPlayer[user_id] = chestQuery["value"]
		end

		return myInventory,myChest,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),chestValue,parseInt(sloltsTotal),chestName
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
local noStore = {
	["cheese"] = true,
	["foodburger"] = true,
	["foodjuice"] = true,
	["foodbox"] = true,
	["octopus"] = true,
	["shrimp"] = true,
	["carp"] = true,
	["codfish"] = true,
	["catfish"] = true,
	["goldenfish"] = true,
	["horsefish"] = true,
	["tilapia"] = true,
	["pacu"] = true,
	["pirarucu"] = true,
	["tambaqui"] = true,
	["energetic"] = true,
	--["milkbottle"] = true,
	["water"] = true,
	["coffee"] = true,
	["cola"] = true,
	["tacos"] = true,
	["fries"] = true,
	["soda"] = true,
	["apple"] = true,
	["coffee2"] = true,
	["grape"] = true,
	["banana"] = true,
	["passion"] = true,
	["tomato"] = true,
	["mushroom"] = true,
	["orangejuice"] = true,
	["tangejuice"] = true,
	["grapejuice"] = true,
	["strawberryjuice"] = true,
	["bananajuice"] = true,
	["passionjuice"] = true,
	["bread"] = true,
	["ketchup"] = true,
	["cannedsoup"] = true,
	["canofbeans"] = true,
	["meat"] = true,
	["fishfillet"] = true,
	["marshmallow"] = true,
	["cookedfishfillet"] = true,
	["cookedmeat"] = true,
	["hamburger"] = true,
	["hamburger2"] = true,
	["pizza"] = true,
	["pizza2"] = true,
	["hotdog"] = true,
	["donut"] = true,
	["chocolate"] = true,
	["sandwich"] = true,
	["absolut"] = true,
	["chandon"] = true,
	["dewars"] = true,
	["hennessy"] = true,
	["nigirizushi"] = true,
	["sushi"] = true,
	["cupcake"] = true,
	["milkshake"] = true,
	["cappuccino"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeItem(nameItem,slot,amount,target,chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if chestName ~= "trayShot" and chestName ~= "trayDesserts" and chestName ~= "trayPops" and chestName ~= "trayPizza" then
			if noStore[nameItem] then
				TriggerClientEvent("chest:Update",source,"requestChest")
				TriggerClientEvent("Notify",source,"amarelo","Armazenamento proibido.",5000)
				return
			end
		end
		if vRP.storeChest(user_id,"stackChest:"..chestName,amount,chestPlayer[user_id],slot,target) then
			TriggerClientEvent("chest:Update",source,"requestChest")
		else
			local result = vRP.getSrvdata("stackChest:"..chestName)
			TriggerClientEvent("chest:UpdateWeight",source,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),chestPlayer[user_id])
			local identity = vRP.userIdentity(user_id)
			PerformHttpRequest(cfg.chestCoords[chestName].log, function(err, text, headers) end, 'POST', json.encode({
                embeds = {
                    {     
						title = "**Guardou "..chestName.."**",
                        fields = {
                            { 
                                name = "📝 Author:", 
                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                            },
							{ 
								name = "🍖 Item:", 
								value = ""..parseFormat(amount).."x "..itemName(nameItem)..""
                            },
                        }, 
                        footer = { 
                            text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                            icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                        },
                        image = { 
                            url = "http://localhost/itens/"..itemIndex(nameItem)..".png",
                        },
                        thumbnail = { 
                            url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                        },
                        color = 5763719
                    }
                }
            }), { ['Content-Type'] = 'application/json' })

			if cfg.chestCoords[chestName].log2 then
				PerformHttpRequest(cfg.chestCoords[chestName].log2, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{     
							title = "**Guardou "..chestName.."**",
							fields = {
								{ 
									name = "📝 Author:", 
									value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
								},
								{ 
									name = "🍖 Item:", 
									value = ""..parseFormat(amount).."x "..itemName(nameItem)..""
								},
							}, 
							footer = { 
								text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
								icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							image = { 
								url = "http://localhost/itens/"..itemIndex(nameItem)..".png",
							},
							thumbnail = { 
								url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							color = 5763719
						}
					}
				}), { ['Content-Type'] = 'application/json' })
			end


			TriggerEvent("discordLogs",chestName,"**Passaporte:** "..parseFormat(user_id).."\n**Guardou:** "..parseFormat(amount).."x "..itemName(nameItem).."\n**Horário:** "..os.date("%H:%M:%S"),3042892)
		end
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.takeItem(nameItem,slot,amount,target,chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryChest(user_id,"stackChest:"..chestName,amount,slot,target) then
			TriggerClientEvent("chest:Update",source,"requestChest")
		else
			local result = vRP.getSrvdata("stackChest:"..chestName)
			TriggerClientEvent("chest:UpdateWeight",source,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),chestPlayer[user_id])
			local identity = vRP.userIdentity(user_id)
			PerformHttpRequest(cfg.chestCoords[chestName].log, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{     
						title = "**Retirou "..chestName.."**",
						fields = {
							{ 
								name = "📝 Author:", 
								value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
							},
							{ 
								name = "🍖 Item:", 
								value = ""..parseFormat(amount).."x "..itemName(nameItem)..""
							},
						}, 
						footer = { 
							text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
							icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						image = { 
							url = "http://localhost/itens/"..itemIndex(nameItem)..".png",
						},
						thumbnail = { 
							url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						color = 15548997
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			if cfg.chestCoords[chestName].log2 then
				PerformHttpRequest(cfg.chestCoords[chestName].log2, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{     
							title = "**Retirou "..chestName.."**",
							fields = {
								{ 
									name = "📝 Author:", 
									value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
								},
								{ 
									name = "🍖 Item:", 
									value = ""..parseFormat(amount).."x "..itemName(nameItem)..""
								},
							}, 
							footer = { 
								text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
								icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							image = { 
								url = "http://localhost/itens/"..itemIndex(nameItem)..".png",
							},
							thumbnail = { 
								url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							color = 15548997
						}
					}
				}), { ['Content-Type'] = 'application/json' })
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateChest(slot,target,amount,chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.updateChest(user_id,"stackChest:"..chestName,slot,target,amount) then
			TriggerClientEvent("chest:Update",source,"requestChest")
		end
	end
end

RegisterServerEvent("closeChest")
AddEventHandler("closeChest", function()
	local source = source
	local user_id = vRP.getUserId(source)
	chestPlayer[user_id] = nil
end)