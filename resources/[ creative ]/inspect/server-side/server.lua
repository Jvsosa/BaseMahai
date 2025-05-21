-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------




local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")


-- _RegisterCommand = RegisterCommand
-- function RegisterCommand(command, callback)
--     _RegisterCommand(command, function(...)
--         if not LocalPlayer.state.inLateGame then
--             return callback(...)
--         end
--     end)
-- end

-- _IsControlJustPressed = IsControlJustPressed
-- function IsControlJustPressed(...)
--     if LocalPlayer.state.inLateGame then
--         return false
--     else
--         return _IsControlJustPressed(...)
--     end
-- end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("inspect",cRP)
vCLIENT = Tunnel.getInterface("inspect")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local openPlayer = {}
local openSource = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:RUNINSPECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:runInspect")
AddEventHandler("police:runInspect",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 then
		TriggerClientEvent("player:playerCarry",entity[1],source,"handcuff")
		TriggerClientEvent("player:Commands",entity[1],true)
		TriggerClientEvent("inventory:Close",entity[1])
		openPlayer[user_id] = vRP.getUserId(entity[1])
		openSource[user_id] = entity[1]
		vCLIENT.openInspect(source)
	end
end)

RegisterServerEvent("player:runInspect")
AddEventHandler("player:runInspect",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 then
			local n_player = vRPC.nearestPlayer(source,2)
			if n_player then
				local n_user_id = vRP.getUserId(n_player)
				if n_user_id then
					local n_source = vRP.userSource(n_user_id)
					if n_source then
						if vRP.getHealth(n_source) > 101 then
							local request = vRP.request(n_source,"Você está sendo revistado, você permite?","sim","nao")
							if request then
								TriggerClientEvent("player:playerCarry",n_source,source,"handcuff")
								TriggerClientEvent("player:Commands",n_source,true)
								TriggerClientEvent("inventory:Close",n_source)
								openPlayer[user_id] = vRP.getUserId(n_source)
								openSource[user_id] = n_source
								vCLIENT.openInspect(source)
							end
						end
					end
				end
		end
	end
end)

-- RegisterCommand("revistar",function(source,args,rawCmd)
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id and vRP.getHealth(source) > 101 then
-- 		local n_player = vRPC.nearestPlayer(source,2)
-- 		print('1')
-- 		if n_player then
-- 			print(2)
-- 			local n_user_id = vRP.getUserId(n_player)
-- 			if n_user_id then
-- 				print(3)
-- 				local n_source = vRP.userSource(n_user_id)
-- 				if n_source then
-- 					print(4)
-- 					if vRP.getHealth(n_source) > 101 then
-- 						print(5)
-- 						local request = vRP.request(n_source,"Você está sendo revistado, você permite?","sim","nao")
-- 						if request then
-- 							print(6)
-- 							TriggerClientEvent("player:playerCarry",n_source,source,"handcuff")
-- 							TriggerClientEvent("player:Commands",n_source,true)
-- 							TriggerClientEvent("inventory:Close",n_source)
-- 							openPlayer[user_id] = vRP.getUserId(n_source)
-- 							openSource[user_id] = n_source
-- 							vCLIENT.openInspect(source)
-- 						end
-- 					else
-- 						TriggerClientEvent("player:playerCarry",n_source,source,"handcuff")
-- 						TriggerClientEvent("player:Commands",n_source,true)
-- 						TriggerClientEvent("inventory:Close",n_source)
-- 						openPlayer[user_id] = vRP.getUserId(n_source)
-- 						openSource[user_id] = n_source
-- 						vCLIENT.openInspect(source)
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.openChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myInventory = {}
		local inventory = vRP.userInventory(user_id)
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
		local inventory = vRP.userInventory(openPlayer[user_id])
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

			myChest[k] = v
		end

		return myInventory,myChest,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.inventoryWeight(openPlayer[user_id]),vRP.getWeight(openPlayer[user_id])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeItem(nameItem,slot,amount,target)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if openSource[user_id] and not vRP.hasPermission(user_id,"Police") then
			if DoesEntityExist(GetPlayerPed(openSource[user_id])) then
				if vRP.checkMaxItens(openPlayer[user_id],nameItem,amount) then
					TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
					TriggerClientEvent("inspect:Update",source,"requestChest")
					return
				end

				if (vRP.inventoryWeight(openPlayer[user_id]) + (itemWeight(nameItem) * parseInt(amount))) <= vRP.getWeight(openPlayer[user_id]) then
					if vRP.tryGetInventoryItem(user_id,nameItem,amount,false,slot) then
						vRP.giveInventoryItem(openPlayer[user_id],nameItem,amount,true,target)
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					TriggerClientEvent("inspect:Update",source,"requestChest")
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.takeItem(nameItem,slot,amount,target)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if openSource[user_id] then
			if DoesEntityExist(GetPlayerPed(openSource[user_id])) then
				if vRP.checkMaxItens(user_id,nameItem,amount) then
					TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
					TriggerClientEvent("inspect:Update",source,"requestChest")
					return
				end

				if (vRP.inventoryWeight(user_id) + (itemWeight(nameItem) * parseInt(amount))) <= vRP.getWeight(user_id) then
					if vRP.tryGetInventoryItem(openPlayer[user_id],nameItem,amount,false,slot) then
						vRP.giveInventoryItem(user_id,nameItem,amount,false,target)
						TriggerClientEvent("inspect:Update",source,"requestChest")

						if nameItem == "dollars" then
							vRP.storePolice(amount)
						end
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					TriggerClientEvent("inspect:Update",source,"requestChest")
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateChest(slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if openSource[user_id] then
			if DoesEntityExist(GetPlayerPed(openSource[user_id])) then
				if vRP.invUpdate(openPlayer[user_id],slot,target,amount) then
					TriggerClientEvent("inspect:Update",source,"requestChest")
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETINSPECT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.resetInspect()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if openSource[user_id] then
			if DoesEntityExist(GetPlayerPed(openSource[user_id])) then
				TriggerClientEvent("player:Commands",openSource[user_id],false)
				TriggerClientEvent("player:playerCarry",openSource[user_id],source)
			end
		end

		if openSource[user_id] then
			openSource[user_id] = nil
		end

		if openPlayer[user_id] then
			openPlayer[user_id] = nil
		end
	end
end