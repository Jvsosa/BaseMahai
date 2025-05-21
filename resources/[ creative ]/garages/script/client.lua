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
Tunnel.bindInterface("garages",cRP)
vSERVER = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local searchBlip = nil
local spawnSelected = {}
local vehHotwired = false
local anim = "machinic_loop_mechandplayer"
local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"

------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function vehicleMods(veh,vehCustom)
	if vehCustom then
		SetVehicleModKit(veh,0)

		if vehCustom["wheeltype"] ~= nil then
			SetVehicleWheelType(veh,vehCustom["wheeltype"])
		end

		if vehCustom["mods"] then
			for i = 0,16 do
				if vehCustom["mods"][tostring(i)] ~= nil then
					SetVehicleMod(veh,i,vehCustom["mods"][tostring(i)])
				end
			end

			for i = 17,22 do
				if vehCustom["mods"][tostring(i)] ~= nil then
					ToggleVehicleMod(veh,i,vehCustom["mods"][tostring(i)])
				end
			end

			for i = 23,24 do
				if vehCustom["mods"][tostring(i)] ~= nil then
					if vehCustom["var"] == nil then
						vehCustom["var"] = {}
						vehCustom["var"][tostring(i)] = 0
					end

					SetVehicleMod(veh,i,vehCustom["mods"][tostring(i)],vehCustom["var"][tostring(i)])
				end
			end

			for i = 25,48 do
				if vehCustom["mods"][tostring(i)] ~= nil then
					SetVehicleMod(veh,i,vehCustom["mods"][tostring(i)])
				end
			end
		end

		if vehCustom["neon"] ~= nil then
			for i = 0,3 do
				SetVehicleNeonLightEnabled(veh,i,vehCustom["neon"][tostring(i)])
			end
		end

		if vehCustom["extras"] ~= nil then
			for i = 1,12 do
				local onoff = tonumber(vehCustom["extras"][i])
				if onoff == 1 then
					SetVehicleExtra(veh,i,0)
				else
					SetVehicleExtra(veh,i,1)
				end
			end
		end

		if vehCustom["liverys"] ~= nil and vehCustom["liverys"] ~= 24  then
			SetVehicleLivery(veh,vehCustom["liverys"])
		end

		if vehCustom["plateIndex"] ~= nil and vehCustom["plateIndex"] ~= 4 then
			SetVehicleNumberPlateTextIndex(veh,vehCustom["plateIndex"])
		end

		SetVehicleXenonLightsColour(veh,vehCustom["xenonColor"])
		SetVehicleColours(veh,vehCustom["colors"][1],vehCustom["colors"][2])
		SetVehicleExtraColours(veh,vehCustom["extracolors"][1],vehCustom["extracolors"][2])
		SetVehicleNeonLightsColour(veh,vehCustom["lights"][1],vehCustom["lights"][2],vehCustom["lights"][3])
		SetVehicleTyreSmokeColor(veh,vehCustom["smokecolor"][1],vehCustom["smokecolor"][2],vehCustom["smokecolor"][3])

		if vehCustom["tint"] ~= nil then
			SetVehicleWindowTint(veh,vehCustom["tint"])
		end

		if vehCustom["dashColour"] ~= nil then
			SetVehicleInteriorColour(veh,vehCustom["dashColour"])
		end

		if vehCustom["interColour"] ~= nil then
			SetVehicleDashboardColour(veh,vehCustom["interColour"])
			TriggerEvent("nation:applymods",nveh,vehname)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.spawnPosition(openGarage)
	local checkSlot = 0
	local checkPos = nil

	repeat
		checkSlot = checkSlot + 1

		if garageLocates[openGarage][tostring(checkSlot)] ~= nil then
			local _,groundZ = GetGroundZAndNormalFor_3dCoord(garageLocates[openGarage][tostring(checkSlot)][1],garageLocates[openGarage][tostring(checkSlot)][2],garageLocates[openGarage][tostring(checkSlot)][3])
			spawnSelected = { garageLocates[openGarage][tostring(checkSlot)][1],garageLocates[openGarage][tostring(checkSlot)][2],groundZ,garageLocates[openGarage][tostring(checkSlot)][4] }
			checkPos = GetClosestVehicle(spawnSelected[1],spawnSelected[2],spawnSelected[3],2.501,0,71)
		end
	until not DoesEntityExist(checkPos) or garageLocates[openGarage][tostring(checkSlot)] == nil

	if garageLocates[openGarage][tostring(checkSlot)] == nil then
		TriggerEvent("Notify","amarelo","Vagas estão ocupadas.",5000)
		return false
	end

	return spawnSelected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.createVehicle(vehModel,vehNet,vehEngine,vehCustom,vehWindows,vehTyres)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then

			if vehCustom ~= nil then
				local vehMods = json.decode(vehCustom)
				vehicleMods(Vehicle,vehMods)
				TriggerEvent("nation:applymods",nveh,vehname)
			end

			SetVehicleEngineHealth(Vehicle,vehEngine + 0.0)

			if vehWindows then
				local vehWindows = json.decode(vehWindows)
				if vehWindows ~= nil then
					for k,v in pairs(vehWindows) do
						if not v then
							RemoveVehicleWindow(Vehicle,parseInt(k))
						end
					end
				end
			end

			if vehTyres then
				local vehTyres = json.decode(vehTyres)
				if vehTyres ~= nil then
					for k,Burst in pairs(vehTyres) do
						if Burst then
							SetVehicleTyreBurst(Vehicle,parseInt(k),true,1000.0)
						end
					end
				end
			end

			SetModelAsNoLongerNeeded(vehModel)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Delete")
AddEventHandler("garages:Delete",function(Vehicle)
	if Vehicle == nil or Vehicle == "" then
		Vehicle = vRP.nearVehicle(15)
	end

	if IsEntityAVehicle(Vehicle) then
		local Tyres = {}
		local Doors = {}
		local Windows = {}

		for i = 0,5 do
			Doors[i] = IsVehicleDoorDamaged(Vehicle,i)
		end

		for i = 0,5 do
			Windows[i] = IsVehicleWindowIntact(Vehicle,i)
		end

		for i = 0,7 do
			local Status = false

			if GetTyreHealth(Vehicle,i) ~= 1000.0 then
				Status = true
			end

			Tyres[i] = Status
		end

		vSERVER.tryDelete(VehToNet(Vehicle),GetVehicleEngineHealth(Vehicle),GetVehicleBodyHealth(Vehicle),GetVehicleFuelLevel(Vehicle),Doors,Windows,Tyres,GetVehicleNumberPlateText(Vehicle))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHBLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchBlip(vehCoords)
	if DoesBlipExist(searchBlip) then
		RemoveBlip(searchBlip)
		searchBlip = nil
	end

	searchBlip = AddBlipForCoord(vehCoords["x"],vehCoords["y"],vehCoords["z"])
	SetBlipSprite(searchBlip,225)
	SetBlipColour(searchBlip,2)
	SetBlipScale(searchBlip,0.6)
	SetBlipAsShortRange(searchBlip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Veículo")
	EndTextCommandSetBlipName(searchBlip)

	SetTimeout(30000,function()
		RemoveBlip(searchBlip)
		searchBlip = nil
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTANIMHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startAnimHotwired()
	vehHotwired = true

	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(1)
	end

	TaskPlayAnim(PlayerPedId(),animDict,anim,3.0,3.0,-1,49,5.0,0,0,0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPANIMHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.stopAnimHotwired(vehicle)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(1)
	end

	vehHotwired = false
	StopAnimTask(PlayerPedId(),animDict,anim,2.0)

	if vehicle ~= nil then
		local netVeh = VehToNet(vehicle)

		SetNetworkIdCanMigrate(netVeh,true)

		SetEntityAsMissionEntity(vehicle,true,false)
		SetVehicleHasBeenOwnedByPlayer(vehicle,true)
		SetVehicleNeedsToBeHotwired(vehicle,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateHotwired(status)
	vehHotwired = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOPHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsUsing(ped)
			local platext = GetVehicleNumberPlateText(vehicle)
			if GetPedInVehicleSeat(vehicle,-1) == ped and not GlobalState["vehPlates"][platext] then
				SetVehicleEngineOn(vehicle,false,true,true)
				DisablePlayerFiring(ped,true)
				timeDistance = 1
			end

			if vehHotwired and vehicle then
				DisableControlAction(1,75,true)
				DisableControlAction(1,20,true)
				timeDistance = 1
			end
		end

		Citizen.Wait(timeDistance)
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:UPDATELOCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:updateLocs")
AddEventHandler("garages:updateLocs",function(homeName,homeInfos)
	garageLocates[homeName] = homeInfos
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:UPDATEREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:updateRemove")
AddEventHandler("garages:updateRemove",function(homeName,homeInfos)
	if garageLocates[homeName] then
		garageLocates[homeName] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:ALLLOCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:allLocs")
AddEventHandler("garages:allLocs",function(garageTable)
	for k,v in pairs(garageTable) do
		garageLocates[k] = v
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Impound")
AddEventHandler("garages:Impound",function()
	if not menuOpen then
		local Impound = vSERVER.Impound()
		if parseInt(#Impound) > 0 then
			for k,v in pairs(Impound) do
				exports["dynamic"]:AddButton(v["name"],"Clique para iniciar a liberação.","garages:Impound",v["model"],false,true)
			end

			exports["dynamic"]:openMenu()
		else
			TriggerEvent("Notify","amarelo","Não possui veículos apreendidos.",5000)
		end
	end
end)

local GaragemSelecionada = "nil"

---------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(garageLocates) do
				local distance = #(coords - vector3(v["x"],v["y"],v["z"]))
				if distance <= 50 then
					timeDistance = 1

					if not HasStreamedTextureDictLoaded("blip3d") then
						RequestStreamedTextureDict("blip3d", true)
						while not HasStreamedTextureDictLoaded("blip3d") do
							Wait(1)
						end
						else
						DrawMarker(9, v["x"],v["y"],v["z"],0,0,0,90.0,0.0,0,0.6,0.6,0,255, 255, 255, 255,false, true, 1, false, "blip3d", "blip-garagem", false)
					end

					-- DrawMarker(36, v["x"],v["y"],v["z"]-0.6,0,0,0,0,0,0,0.2,0.2,0.3,  255, 255,255,100 ,false,0,0,1)
					-- DrawMarker(27, v["x"],v["y"],v["z"]-0.7,0,0,0,0,0,0,0.4,0.4,0.5, 255, 255,255,100 ,false,0,0,1)
					-- DrawMarker(1, v["x"],v["y"],v["z"]-1,0,0,0,0,0,0,0.4,0.4,0.4, 93, 144,245,100 ,false,0,0,1)
					if IsControlJustPressed(1,38) and distance <= 1.0 and MumbleIsConnected() then
						local Vehicles = vSERVER.Vehicles(k)
						if Vehicles then
							GaragemSelecionada = k
							SetNuiFocus(true,true)
							SetCursorLocation(0.5, 0.5)
							StartScreenEffect("MenuMGSelectionIn", 0, true)
							SendNUIMessage({ action = "showMenu" }) 
						end
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)

RegisterNUICallback("vehList",function(data,cb)
	vSERVER.returnVeh()
	local vehs = vSERVER.Vehicles(GaragemSelecionada)
	if vehs then
		cb({ vehs = vehs })
	end
end)

RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	StopScreenEffect("MenuMGSelectionIn")
end)

local carrover = "nil"
local placacarro = "nil"

RegisterNUICallback("vercarro",function(data,cb)
	carrover = data.model
	placacarro = data.plate
	cb({retorno = 'done'})
end)

RegisterNUICallback("reqbau",function(data,cb)
	vSERVER.checkBau(carrover,placacarro) 
	cb({retorno = 'done'})

end)

RegisterNUICallback("trocarPlaca",function(data,cb)
	if vSERVER.trocarPlaca(carrover) then
		cb({retorno = 'done'})
	end
end)

RegisterNUICallback("bauCarro",function(data,cb)
	vSERVER.returnBau()
	local bau = vSERVER.checkBau(carrover,placacarro)
	if bau then
		cb({ bau = bau })
	end
end)


RegisterNUICallback("guardarCarro",function(data,cb)
	TriggerEvent("garages:Delete")
end)

RegisterNUICallback("retirarcarro",function(data,cb)
	TriggerServerEvent("garages:Spawn",""..carrover.."-"..GaragemSelecionada.."")
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	StopScreenEffect("MenuMGSelectionIn")
end)