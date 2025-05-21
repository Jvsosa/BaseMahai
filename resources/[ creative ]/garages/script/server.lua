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
Tunnel.bindInterface("garages",cRP)
vPLAYER = Tunnel.getInterface("player")
vCLIENT = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local vehSpawn = {}
local vehSignal = {}
local searchTimers = {}
GlobalState["vehPlates"] = {}
local cooldownSpawn = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVERVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.serverVehicle(model,x,y,z,heading,vehPlate,nitroFuel,vehDoors,vehBody)
	local spawnVehicle = 0
	local spawnVehicle = 0
	local mHash = GetHashKey(model)
	local myVeh = CreateVehicle(mHash,x,y,z,heading,true,true)

	while not DoesEntityExist(myVeh) and spawnVehicle <= 1000 do
		spawnVehicle = spawnVehicle + 1
		Citizen.Wait(100)
	end

	if DoesEntityExist(myVeh) then
		if vehPlate ~= nil then
			SetVehicleNumberPlateText(myVeh,vehPlate)
		else
			vehPlate = vRP.generatePlate()
			SetVehicleNumberPlateText(myVeh,vehPlate)
		end

		SetVehicleBodyHealth(myVeh,vehBody + 0.0)

		if vehDoors then
			local vehDoors = json.decode(vehDoors)
			if vehDoors ~= nil then
				for k,v in pairs(vehDoors) do
					if v then
						SetVehicleDoorBroken(myVeh,parseInt(k),true)
					end
				end
			end
		end

		local netVeh = NetworkGetNetworkIdFromEntity(myVeh)

		if model ~= "wheelchair" then
			local idNetwork = NetworkGetEntityFromNetworkId(netVeh)
			SetVehicleDoorsLocked(idNetwork,2)

			local Nitro = GlobalState["Nitro"]
			Nitro[vehPlate] = nitroFuel or 0
			GlobalState["Nitro"] = Nitro
		end

		return true,netVeh,mHash,myVeh
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SIGNALREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("signalRemove")
AddEventHandler("signalRemove",function(vehPlate)
	vehSignal[vehPlate] = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEREVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plateReveryone")
AddEventHandler("plateReveryone",function(vehPlate)
	if GlobalState["vehPlates"][vehPlate] then
		local vehPlates = GlobalState["vehPlates"]
		vehPlates[vehPlate] = nil
		GlobalState["vehPlates"] = vehPlates
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEEVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plateEveryone")
AddEventHandler("plateEveryone",function(vehPlate)
	local vehPlates = GlobalState["vehPlates"]
	vehPlates[vehPlate] = true
	GlobalState["vehPlates"] = vehPlates
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("platePlayers")
AddEventHandler("platePlayers",function(vehPlate,user_id)
	local userPlate = vRP.userPlate(vehPlate)
	if not userPlate then
		local vehPlates = GlobalState["vehPlates"]
		vehPlates[vehPlate] = user_id
		GlobalState["vehPlates"] = vehPlates
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plateRobberys")
AddEventHandler("plateRobberys",function(vehPlate,vehName)
	if vehPlate ~= nil and vehName ~= nil then
		local source = source
		local user_id = vRP.getUserId(source)
		if user_id then
			if GlobalState["vehPlates"][vehPlate] ~= user_id then
				local vehPlates = GlobalState["vehPlates"]
				vehPlates[vehPlate] = user_id
				GlobalState["vehPlates"] = vehPlates
			end

			vRP.generateItem(user_id,"vehkey-"..vehPlate,1,true,false)

			if math.random(100) >= 50 then
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)

				local policeResult = vRP.numPermission("Police")
				for k,v in pairs(policeResult) do
					async(function()
		
						TriggerClientEvent("NotifyPush",v,{ code = 31, imagem = "lockpick", title = "Roubo de Veículo", criminal = "Um roubo a "..vehicleName(vehName).." - "..vehPlate.." foi denunciado, va ate o local e efetue a prisao.", x = coords["x"], y = coords["y"], z = coords["z"], vehicle = vehicleName(vehName).." - "..vehPlate, time = os.date("%H:%M"), blipColor = 44 })
					end)
				end
			end
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Impound()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myVehicle = {}
		local vehicle = vRP.query("vehicles/getVehicles",{ user_id = user_id })

		for k,v in ipairs(vehicle) do
			if v["arrest"] >= os.time() then
				table.insert(myVehicle,{ ["model"] = vehicle[k]["vehicle"], ["name"] = vehicleName(vehicle[k]["vehicle"]) })
			end
		end

		return myVehicle
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Impound")
AddEventHandler("garages:Impound",function(vehName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehPrice = vehiclePrice(vehName)
		TriggerClientEvent("dynamic:closeSystem",source)

		if vRP.request(source,"A liberação do veículo tem o custo de <b>$"..parseFormat(vehPrice * 0.10).."</b> dólares, deseja prosseguir com a liberação do mesmo?","Sim","Não") then
			if vRP.paymentFull(user_id,vehPrice * 0.10) then
				vRP.execute("vehicles/paymentArrest",{ user_id = user_id, vehicle = vehName })
				TriggerClientEvent("Notify",source,"verde","Veículo liberado.",5000)
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COOLDOWN DO SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if cooldownSpawn == 1 then
			Citizen.Wait(3000)
			cooldownSpawn = 0
		end
		Citizen.Wait(500)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Spawn")
AddEventHandler("garages:Spawn",function(Table)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local splitName = splitString(Table,"-")
		local garageName = splitName[2]
		local vehName = splitName[1]

		local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = vehName })
		if vehicle[1] == nil then
			vRP.execute("vehicles/addVehicles",{ user_id = user_id, vehicle = vehName, plate = vRP.generatePlate(), work = "true" })
			TriggerClientEvent("Notify",source,"verde","Veículo adicionado em sua lista de veículos.",5000)
		else
			local vehPlates = GlobalState["vehPlates"]
			local vehPlate = vehicle[1]["plate"]

			if vehSpawn[vehPlate] then
				if vehSignal[vehPlate] == nil then
					if searchTimers[user_id] == nil then
						searchTimers[user_id] = os.time()
					end

					if os.time() >= parseInt(searchTimers[user_id]) then
						searchTimers[user_id] = os.time() + 60

						local vehNet = vehSpawn[vehPlate][3]
						local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
						if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 2 then
							vCLIENT.searchBlip(source,GetEntityCoords(idNetwork))
							TriggerClientEvent("",source,"amarelo","Rastreador do veículo foi ativado por <b>30 segundos</b>, lembrando que se o mesmo estiver em movimento a localização pode ser imprecisa.",10000)
						else
							if vehSpawn[vehPlate] then
								vehSpawn[vehPlate] = nil
							end

							if vehPlates[vehPlate] then
								vehPlates[vehPlate] = nil
								GlobalState["vehPlates"] = vehPlates
							end

							TriggerClientEvent("",source,"","A seguradora efetuou o resgate do seu veículo e o mesmo já se encontra disponível para retirada.",5000)
						end
					else
						TriggerClientEvent("",source,"amarelo","Rastreador só pode ser ativado a cada <b>60 segundos</b>.",5000)
					end
				else
					TriggerClientEvent("",source,"amarelo","Rastreador está desativado.",5000)
				end
			else
				if vehicle[1]["tax"] <= os.time() and vehicle[1]["tax"] ~= "true" then
					TriggerClientEvent("Notify",source,"amarelo","Taxa do veículo atrasada, efetue o pagamento<br>através do sistema da concessionária.",5000)
				elseif vehicle[1]["arrest"] >= os.time() then
					TriggerClientEvent("Notify",source,"amarelo","Veículo apreendido, dirija-se até o <b>Impound</b> e efetue o pagamento da liberação do mesmo.",5000)
				else
					if vehicle[1]["rental"] ~= 0 then
						if vehicle[1]["rental"] <= os.time() then
							TriggerClientEvent("Notify",source,"amarelo","Validade do veículo expirou, efetue a renovação do mesmo.",5000)
							return
						end
					end

					local Coords = vCLIENT.spawnPosition(source,garageName)
					if Coords then
						local vehMods = nil
						local custom = vRP.query("entitydata/getData",{ dkey = "custom:"..user_id..":"..vehName })
						if parseInt(#custom) > 0 then
							vehMods = custom[1]["dvalue"]
						end

						if garageLocates[garageName][""] then
							if vRP.userPremium(user_id) then
								Citizen.Wait(600)
								if cooldownSpawn == 0 then
									cooldownSpawn = 1
									TriggerClientEvent("dynamic:closeSystem",source)
									local netExist,netVeh,mHash = cRP.serverVehicle(vehName,Coords[1],Coords[2],Coords[3],Coords[4],vehPlate,vehicle[1]["nitro"],vehicle[1]["doors"],vehicle[1]["body"])

									if netExist then
										vCLIENT.createVehicle(-1,mHash,netVeh,vehicle[1]["engine"],vehMods,vehicle[1]["windows"],vehicle[1]["tyres"])
										TriggerEvent("engine:tryFuel",vehPlate,vehicle[1]["fuel"])
										vehSpawn[vehPlate] = { user_id,vehName,netVeh }

										vehPlates[vehPlate] = user_id
										GlobalState["vehPlates"] = vehPlates
									end
								else
									TriggerClientEvent("Notify",source,"vermelho","Aguarde um Pouco",5000)
								end
							else
								local vehPrice = vehiclePrice(vehName)
								if vRP.request(source,"Desejar retirar seu veículo?") then
									if vRP.getBank(user_id) >= parseInt(vehPrice * 0.00) then
										Citizen.Wait(600)
										if cooldownSpawn == 0 then
											cooldownSpawn = 1
											TriggerClientEvent("dynamic:closeSystem",source)
											local netExist,netVeh,mHash = cRP.serverVehicle(vehName,Coords[1],Coords[2],Coords[3],Coords[4],vehPlate,vehicle[1]["nitro"],vehicle[1]["doors"],vehicle[1]["body"])

											if netExist then
												vCLIENT.createVehicle(-1,mHash,netVeh,vehicle[1]["engine"],vehMods,vehicle[1]["windows"],vehicle[1]["tyres"])
												TriggerEvent("engine:tryFuel",vehPlate,vehicle[1]["fuel"])
												vehSpawn[vehPlate] = { user_id,vehName,netVeh }

												vehPlates[vehPlate] = user_id
												GlobalState["vehPlates"] = vehPlates
											end
										else
											TriggerClientEvent("Notify",source,"vermelho","Aguarde um Pouco",5000)
										end
									else
										TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
									end
								end
							end
						else
							Citizen.Wait(600)
							if cooldownSpawn == 0 then
								cooldownSpawn = 1
								TriggerClientEvent("dynamic:closeSystem",source)
								local netExist,netVeh,mHash = cRP.serverVehicle(vehName,Coords[1],Coords[2],Coords[3],Coords[4],vehPlate,vehicle[1]["nitro"],vehicle[1]["doors"],vehicle[1]["body"])

								if netExist then
									if mHash == -276744698 then
										vCLIENT.createVehicle(-1,mHash,netVeh,1000000,vehMods,vehicle[1]["windows"],vehicle[1]["tyres"])
									else
										vCLIENT.createVehicle(-1,mHash,netVeh,vehicle[1]["engine"],vehMods,vehicle[1]["windows"],vehicle[1]["tyres"])
									end
									TriggerEvent("engine:tryFuel",vehPlate,vehicle[1]["fuel"])
									vehSpawn[vehPlate] = { user_id,vehName,netVeh }

									vehPlates[vehPlate] = user_id
									GlobalState["vehPlates"] = vehPlates
								end
							else
								TriggerClientEvent("Notify",source,"vermelho","Aguarde um Pouco",5000)
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("car",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)
			local vehPlate = "VEH"..math.random(10000,99999)
			local netExist,netVeh,mHash,myVeh = cRP.serverVehicle(args[1],coords["x"],coords["y"],coords["z"],heading,vehPlate,200,nil,1000)

			if not netExist then
				return
			end

			vCLIENT.createVehicle(-1,mHash,netVeh,1000,nil,false,false)
			vehSpawn[vehPlate] = { user_id,vehName,netVeh }
			TriggerEvent("engine:tryFuel",vehPlate,100)
			SetPedIntoVehicle(ped,myVeh,-1)

			local vehPlates = GlobalState["vehPlates"]
			vehPlates[vehPlate] = user_id
			GlobalState["vehPlates"] = vehPlates
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dv",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			TriggerClientEvent("garages:Delete",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:VEHICLEKEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:vehicleKey")
AddEventHandler("garages:vehicleKey",function(entity)
	local source = source
	local vehPlate = entity[1]
	local user_id = vRP.getUserId(source)
	if user_id then
		if GlobalState["vehPlates"][vehPlate] == user_id then
			vRP.generateItem(user_id,"vehkey-"..vehPlate,1,true,false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:LOCKVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:lockVehicle")
AddEventHandler("garages:lockVehicle",function(vehNet,vehPlate)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if GlobalState["vehPlates"][vehPlate] == user_id then
			TriggerEvent("garages:keyVehicle",source,vehNet)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:KEYVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:keyVehicle")
AddEventHandler("garages:keyVehicle",function(source,vehNet)
	local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
	local doorStatus = GetVehicleDoorLockStatus(idNetwork)

	if parseInt(doorStatus) <= 1 then
		TriggerClientEvent("Notify",source,"locked","Veículo trancado.",5000)
		TriggerClientEvent("sounds:source",source,"locked",0.4)
		SetVehicleDoorsLocked(idNetwork,2)
	else
		TriggerClientEvent("Notify",source,"unlocked","Veículo destrancado.",5000)
		TriggerClientEvent("sounds:source",source,"unlocked",0.4)
		SetVehicleDoorsLocked(idNetwork,1)
	end

	if not vRPC.inVehicle(source) then
		vRPC.playAnim(source,true,{"anim@mp_player_intmenu@key_fob@","fob_click"},false)
		Citizen.Wait(400)
		vRPC.stopAnim(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.tryDelete(vehNet,vehEngine,vehBody,vehFuel,vehDoors,vehWindows,vehTyres,vehPlate)
	if vehSpawn[vehPlate] then
		local user_id = vehSpawn[vehPlate][1]
		local vehName = vehSpawn[vehPlate][2]

		if parseInt(vehEngine) <= 100 then
			vehEngine = 100
		end

		if parseInt(vehBody) <= 100 then
			vehBody = 100
		end

		if parseInt(vehFuel) >= 100 then
			vehFuel = 100
		end

		if parseInt(vehFuel) <= 0 then
			vehFuel = 0
		end

		local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = vehName })
		if vehicle[1] ~= nil then
			vRP.execute("vehicles/updateVehicles",{ user_id = user_id, vehicle = vehName, nitro = GlobalState["Nitro"][vehPlate] or 0, engine = parseInt(vehEngine), body = parseInt(vehBody), fuel = parseInt(vehFuel), doors = json.encode(vehDoors), windows = json.encode(vehWindows), tyres = json.encode(vehTyres) })
		end
	end

	TriggerEvent("garages:deleteVehicle",vehNet,vehPlate)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETEVEHICLEADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:deleteVehicleAdmin")
AddEventHandler("garages:deleteVehicleAdmin",function(entity)
	TriggerEvent("garages:deleteVehicle",entity[1],entity[2])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:deleteVehicle")
AddEventHandler("garages:deleteVehicle",function(vehNet,vehPlate)
	if GlobalState["vehPlates"][vehPlate] then
		local vehPlates = GlobalState["vehPlates"]
		vehPlates[vehPlate] = nil
		GlobalState["vehPlates"] = vehPlates
	end

	if GlobalState["Nitro"][vehPlate] then
		local Nitro = GlobalState["Nitro"]
		Nitro[vehPlate] = nil
		GlobalState["Nitro"] = Nitro
	end

	if vehSignal[vehPlate] then
		vehSignal[vehPlate] = nil
	end

	if vehSpawn[vehPlate] then
		vehSpawn[vehPlate] = nil
	end

	local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 2 then
		if GetVehicleNumberPlateText(idNetwork) == vehPlate then
			DeleteEntity(idNetwork)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:UPDATEGARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:updateGarages")
AddEventHandler("garages:updateGarages",function(homeName,homeInfos)
	garageLocates[homeName] = { ["name"] = homeName, ["payment"] = false }

	-- CONFIG
	local configFile = LoadResourceFile("logsystem","garageConfig.json")
	local configTable = json.decode(configFile)
	configTable[homeName] = { ["name"] = homeName, ["payment"] = false }
	SaveResourceFile("logsystem","garageConfig.json",json.encode(configTable),-1)

	-- LOCATES
	local locatesFile = LoadResourceFile("logsystem","garageLocates.json")
	local locatesTable = json.decode(locatesFile)
	locatesTable[homeName] = homeInfos
	SaveResourceFile("logsystem","garageLocates.json",json.encode(locatesTable),-1)

	TriggerClientEvent("garages:updateLocs",-1,homeName,homeInfos)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:REMOVEGARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:removeGarages")
AddEventHandler("garages:removeGarages",function(homeName)
	if garageLocates[homeName] then
		garageLocates[homeName] = nil

		local configFile = LoadResourceFile("logsystem","garageConfig.json")
		local configTable = json.decode(configFile)
		if configTable[homeName] then
			configTable[homeName] = nil
			SaveResourceFile("logsystem","garageConfig.json",json.encode(configTable),-1)
		end

		local locatesFile = LoadResourceFile("logsystem","garageLocates.json")
		local locatesTable = json.decode(locatesFile)
		if locatesTable[homeName] then
			locatesTable[homeName] = nil
			SaveResourceFile("logsystem","garageLocates.json",json.encode(locatesTable),-1)
		end

		TriggerClientEvent("garages:updateRemove",-1,homeName)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNCFUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local configFile = LoadResourceFile("logsystem","garageConfig.json")
	local configTable = json.decode(configFile)

	for k,v in pairs(configTable) do
		garageLocates[k] = v
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	local locatesFile = LoadResourceFile("logsystem","garageLocates.json")
	local locatesTable = json.decode(locatesFile)

	TriggerClientEvent("garages:allLocs",source,locatesTable)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if searchTimers[user_id] then
		searchTimers[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHSIGNAL
-----------------------------------------------------------------------------------------------------------------------------------------
exports("vehSignal",function(vehPlate)
	return vehSignal[vehPlate]
end)















-------------
-- Gamboz
-------------

cRP.Vehicles = function(Garage)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and not exports["hud"]:Wanted(user_id) then
		local hasFines, total = exports.bank:hasFines(user_id)
		if parseInt(total) > 0 then
			TriggerClientEvent("Notify",source,"vermelho","Multas pendentes encontradas.",3000)
			return false
		end

		local garageName = garageLocates[Garage]["name"]
		if string.sub(garageName,0,5) == "Homes" then
			local consult = vRP.query("propertys/userPermissions",{ name = garageName, user_id = user_id })
			if consult[1] == nil then
				return false
			else
				local ownerConsult = vRP.query("propertys/userOwnermissions",{ name = garageName })
				if ownerConsult[1] then
					if ownerConsult[1]["tax"] <= os.time() then
						TriggerClientEvent("Notify",source,"amarelo","Taxa da propriedade atrasada.",10000)
						return false
					end
				end
			end
		end

		if garageLocates[Garage]["perm"] then
			if not vRP.hasGroup(user_id,garageLocates[Garage]["perm"]) then
				return false
			end
		end

		local Vehicle = {}
		if workGarages[garageName] then
			for k,v in pairs(workGarages[garageName]) do
				table.insert(Vehicle,{ ["model"] = v, ["name"] = vehicleName(v), plate = garageName, engine = 100,body = 100,fuel = 100 })
			end
		else
			local vehicle = vRP.query("vehicles/getVehicles",{ user_id = user_id })
			for k,v in ipairs(vehicle) do
				if v["work"] == "false" then
					if vehicleName(vehicle[k]["vehicle"]) ~= nil then
						table.insert(Vehicle,{ link_imgs = link_imgs, ["model"] = vehicle[k]["vehicle"], ["name"] = vehicleName(vehicle[k]["vehicle"]), plate = vehicle[k]["plate"], engine = vehicle[k]["engine"]/10,body = vehicle[k]["body"]/10,fuel = vehicle[k]["fuel"] })
					else
						print("^7[^1!^7] Carro com nome invalido: ^1"..vehicle[k]["vehicle"].."^7")
					end
				end
			end
		end

		return Vehicle
	end

	return false
end

cRP.returnVeh = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return Vehicle
    end
end

local vehChest = {}

cRP.checkBau = function(carro,placacarro)
	local source = source
    local user_id = vRP.getUserId(source)
	itensBaus = {}
	if user_id then
		local vehName = carro
		local userPlate = placacarro
		local result = vRP.getSrvdata("vehChest:"..user_id..":"..carro)
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
			table.insert(itensBaus,{ amount = parseInt(v["amount"]),name = itemName(v["item"]),peso = itemWeight(v["item"]),index = itemIndex(v["item"]),max = itemMaxAmount(v["item"]),type = itemType(v["item"]),desc = itemDescription(v["item"]),v = v["item"],k = k, days = v["days"], durability = v["durability"]})
		end

		return itensBaus
	end
end

cRP.returnBau = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return itensBaus
    end
end

cRP.trocarPlaca = function(carro)
	local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
		local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = carro })
		if vehicle[1] then
			local qtditem = vRP.getInventoryItemAmount(user_id,"premiumplate")
			if qtditem[1] >= 1 then
				TriggerClientEvent("Notify",source,"amarelo","Deve ser tudo em minusculas.",5000)

				local vehPlate = vRP.prompt(source,"Placa:","")
				if vehPlate == "" or string.upper(vehPlate) == "CREATIVE" then
					return
				end

				local namePlate = string.sub(vehPlate,1,8)
				local plateCheck = sanitizeString(namePlate,"abcdefghijklmnopqrstuvwxyz0123456789",true)
				if string.len(plateCheck) ~= 8 then
					TriggerClientEvent("Notify",source,"amarelo","O nome de definição para a placa deve conter 8 caracteres.",5000)
					return
				else
					if vRP.userPlate(namePlate) then
						TriggerClientEvent("Notify",source,"vermelho","A placa escolhida já está sendo registrada em outro veículo.",5000)
						return
					else
						if vRP.tryGetInventoryItem(user_id,"premiumplate",1) then
							vRP.execute("vehicles/plateVehiclesUpdate",{ user_id = user_id, vehicle = carro, plate = string.upper(namePlate) })
							TriggerClientEvent("Notify",source,"verde","Placa atualizada.",5000)
							return true
						end
					end
				end
			else
				TriggerClientEvent("Notify",source,"vermelho","Voce nao possui <b>"..itemName("premiumplate").."</b> na mochila.",5000)
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Modelo de veículo não encontrado.",5000)
		end
	end
end