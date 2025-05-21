--------------------------------------------------
---- CINEMATIC CAM FOR FIVEM MADE BY KIMINAZE ----
--------------------------------------------------

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
src = {}
Tunnel.bindInterface(GetCurrentResourceName(),src)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

src.perm = function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"cam") or vRP.hasPermission(user_id,"Admin") then
			return true
		end
	end
end

--------------------------------------------------
---------------------- EVENTS --------------------
--------------------------------------------------

RegisterServerEvent('CinematicCam:requestPermissions')
AddEventHandler('CinematicCam:requestPermissions', function()
	local isWhitelisted = false

	-- \/ -- permission check here (set "isWhitelisted") -- \/ --


	
	-- /\ -- permission check here (set "isWhitelisted") -- /\ --

	TriggerClientEvent('CinematicCam:receivePermissions', source, isWhitelisted)
end)
