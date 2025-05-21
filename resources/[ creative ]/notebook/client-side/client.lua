--------------------------------
-- [ CONEXAO ] --
--------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("notebook",src)
vSERVER = Tunnel.getInterface("notebook")



-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vehicleData(vehicle)
	local vehBoost = {
		boost = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveForce"),
		fuelmix = GetVehicleHandlingFloat(vehicle,"CHandlingData","fDriveInertia"),
		braking = GetVehicleHandlingFloat(vehicle,"CHandlingData","fBrakeBiasFront"),
		drivetrain = GetVehicleHandlingFloat(vehicle,"CHandlingData","fDriveBiasFront"),
		brakeforce = GetVehicleHandlingFloat(vehicle,"CHandlingData","fBrakeForce")
	}

	return vehBoost
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVEDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function saveData(vehicle,data)
	if vSERVER.Perm() then 
		SetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveForce",10.0)
		SetVehicleHandlingFloat(vehicle,"CHandlingData","nInitialDriveGears",6)
	else
		SetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveForce",data["boost"] * 1.0)
	end
	SetVehicleHandlingFloat(vehicle,"CHandlingData","fDriveInertia",data["fuelmix"] * 1.0)
	SetVehicleHandlingFloat(vehicle,"CHandlingData","fBrakeForce",data["brakeforce"] * 1.0)
	SetVehicleHandlingFloat(vehicle,"CHandlingData","fBrakeBiasFront",data["braking"] * 1.0)
	--SetVehicleHandlingFloat(vehicle,"CHandlingData","fBrakeForce",8.0)
	SetVehicleHandlingFloat(vehicle,"CHandlingData","fDriveBiasFront",data["drivetrain"] * 1.0)
	SetVehicleHandlingFloat(vehicle,"CHandlingData","fHandBrakeForce",0.75)
	SetVehicleEnginePowerMultiplier(vehicle,data["gearchange"] * 1.0)
end




-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEMENU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("togglemenu",function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("save",function(data)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		if GetPedInVehicleSeat(vehicle,-1) == ped then
			TriggerEvent("Notify","verde","Modificações aplicadas.",5000)
			saveData(vehicle,data)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTEBOOK:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("notebook:openSystem")
AddEventHandler("notebook:openSystem",function()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		if GetPedInVehicleSeat(vehicle,-1) == ped then
			SetNuiFocus(true,true)
			SendNUIMessage({ type = "togglemenu", state = true, data = vehicleData(vehicle) })
		end
	end
end)