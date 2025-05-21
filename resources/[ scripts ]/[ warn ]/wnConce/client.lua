--------------------------------
-- [ CONEXAO ] --
--------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("wnConce",src)
vSERVER = Tunnel.getInterface("wnConce")

local ConceNumber = 0
local CarroSelect = "null"
local myveh = {}

-- Citizen.CreateThread(function()
--     while true do
--         local t = 1000
--         local ped = PlayerPedId()
--         local x, y, z = table.unpack(GetEntityCoords(ped))
--         for k, v in pairs(Config.Conce) do
--             if Vdist(x, y, z, v.blip['x'],v.blip['y'],v.blip['z']) <= 5.5 then
--                 t = 5
--                 DrawMarker(21, v.blip['x'],v.blip['y'],v.blip['z'] - 0.6, 0, 0, 0, 0.0, 0, 0, 0.4, 0.4, 0.3, 50, 200, 50, 100, 0, 0, 0, 1)
--                 if IsControlJustPressed(0, 38) then
--                     if vRP.getNearestPlayer(3) == nil then 
--                         if Vdist(x, y, z, v.blip['x'],v.blip['y'],v.blip['z']) <= 1.5 then
--                             SetNuiFocus(true,true)
--                         	CarroSelect = "null"
--                             ConceNumber = k
--                             SetCursorLocation(0.5, 0.5)
--                             StartScreenEffect("MenuMGSelectionIn", 0, true)
--                             SendNUIMessage({ action = "showMenu" })
--                         end
--                     else
--                         TriggerEvent("Notify","negado","Você está muito próximo de alguém! Afaste-se para abrir o baú!")
--                     end
--                 end
--             end
--         end

--         Citizen.Wait(t)
--     end
-- end)


RegisterNetEvent('wnConce:Abrir')
AddEventHandler('wnConce:Abrir',function()
    local t = 1000
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
    for k,v in pairs(Config.Conce) do
        if Vdist(x, y, z, v.blip['x'],v.blip['y'],v.blip['z']) <= 5.5 then
            local nome_player,imagem_player = vSERVER.return_nome()
			CarroSelect = "null"
            ConceNumber = k
            SetNuiFocus(true,true)
            SetCursorLocation(0.5, 0.5)
            StartScreenEffect("MenuMGSelectionIn", 0, true)
            SendNUIMessage({ action = "showMenu", nome_player = nome_player, imagem_player = imagem_player })
        end
    end
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	for k,v in pairs(Config.Conce) do
		exports["target"]:AddCircleZone("Conce:"..k,vec3(v.blip['x'],v.blip['y'],v.blip['z']),0.75,{
			name = "Conce:"..k,
			heading = 3374176
		},{
			distance = 3.0,
			options = {
				{
					event = "wnConce:Abrir",
					label = "Abrir",
					tunnel = "client"
				}
			}
		})
	end
end)

RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	StopScreenEffect("MenuMGSelectionIn")
	nui_open = false
end)

RegisterNUICallback("consultCarrosList",function(data,cb,imgperfil)
	vSERVER.consultCarros(ConceNumber,data.lista)
	local consultCarros = vSERVER.consultCarrosList()
	if consultCarros then
		cb({ consultCarros = consultCarros })
	end
end)

RegisterNUICallback("verCarros",function(data,cb,imgperfil)
	CarroSelect = data.carro
    local quantidadePortas = GetNumberOfVehicleDoors(data.carro)
    local x,y,z = table.unpack(GetEntityCoords(ped,false))
    local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
	cb({retorno = 'done', quantidadePortas = quantidadePortas , street = street})
end)

RegisterNUICallback("testeDrive",function(data,cb)
	local driveIn,vehPlate = vSERVER.startDrive()
	if driveIn then
		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "closeSystem" })

		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		benCoords = { coords["x"],coords["y"],coords["z"] }

		TriggerEvent("races:insertList",true)
		LocalPlayer["state"]["Commands"] = true
		TriggerEvent("Notify","azul","Teste iniciado, para finalizar saia do veículo.",5000)

		Citizen.Wait(1000)

		vehCreate(CarroSelect,vehPlate)

		Citizen.Wait(1000)

		SetPedIntoVehicle(ped,vehDrive,-1)
		benDrive = true
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCREATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vehCreate(vehName,vehPlate)
	local mHash = GetHashKey(vehName)

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Citizen.Wait(1)
	end

	if HasModelLoaded(mHash) then
		vehDrive = CreateVehicle(mHash,-53.9,-1110.5,26.34,68.04,false,false)

		SetEntityInvincible(vehDrive,true)
		SetVehicleNumberPlateText(vehDrive,vehPlate)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if benDrive then
			timeDistance = 1
			DisableControlAction(1,69,false)

			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				Citizen.Wait(1000)

				benDrive = false
				vSERVER.removeDrive()
				TriggerEvent("races:insertList",false)
				LocalPlayer["state"]["Commands"] = false
				SetEntityCoords(ped,benCoords[1],benCoords[2],benCoords[3],1,0,0,0)
				DeleteEntity(vehDrive)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)


function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end


RegisterNUICallback("comprarCarro",function(data,cb)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	StopScreenEffect("MenuMGSelectionIn")
	nui_open = false
	vSERVER.comprarCarro(CarroSelect,data.red,data.green,data.blue)
end)

RegisterNUICallback("alugarcarro",function(data,cb)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	StopScreenEffect("MenuMGSelectionIn")
	nui_open = false
	vSERVER.comprarCarro(CarroSelect,data.red,data.green,data.blue)
end)

RegisterNUICallback("comprarCarro2",function(data,cb)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	StopScreenEffect("MenuMGSelectionIn")
	nui_open = false
	vSERVER.comprarCarroVip(CarroSelect,data.red,data.green,data.blue)
end)


RegisterNUICallback("venderCarro",function(data,cb)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	StopScreenEffect("MenuMGSelectionIn")
	nui_open = false
	vSERVER.venderCarro(data.carro)
end)


src.TesteDrive = function()
	local bhash = CarroSelect
    local playerPed = PlayerPedId()
    local playerpos = GetEntityCoords(playerPed)
    if not testedrive then
        while not HasModelLoaded(bhash) do
            RequestModel(bhash)
            Citizen.Wait(10)
        end
        local ped = PlayerPedId()
        local x,y,z = vRP.getPosition()
		vSERVER.AlterarMundo()
		TriggerEvent("Notify","aviso","Alterando de mundo!",8000)
		Wait(2000)
        veh = CreateVehicle(bhash,Config.Teste_Drive+0.2,0.83,true,false) -- LOCALIDADE TEST DRIVE
        SetPedIntoVehicle(playerPed,veh,-1)
        testedrive = true
        SetVehicleIsStolen(veh,false)
        SetVehicleOnGroundProperly(veh)
        SetEntityInvincible(veh,false)
        SetVehicleDoorsLocked(veh,4)
        SetVehicleDoorsLockedForAllPlayers(veh,4)
        SetVehicleNumberPlateText(veh, "TEST DRIVE") -- PLACA DO VEÍCUILO
        Citizen.InvokeNative(0xAD738C3085FE7E11,veh,true,true)
        SetVehicleDirtLevel(veh,0.0)
        SetVehRadioStation(veh,"OFF")
        SetVehicleEngineOn(GetVehiclePedIsIn(ped,false),true)
        SetModelAsNoLongerNeeded(bhash)
        Wait(Config.Segundos*1000)
		vSERVER.AlterarMundo2()
		TriggerEvent("Notify","aviso","Seu teste drive acabou!",8000)
        DeleteVehicle(veh)
        testedrive = false
        SetEntityCoords(playerPed, playerpos, false, false, false, false)
    end
end
