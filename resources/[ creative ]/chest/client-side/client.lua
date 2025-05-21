-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local chestOpen = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTINFOS
-----------------------------------------------------------------------------------------------------------------------------------------
local chestInfos = {
	["1"] = {
		{
			event = "chest:openSystem",
			label = "Abrir",
			tunnel = "shop"
		},{
			event = "chest:upgradeSystem",
			label = "Aumentar",
			tunnel = "shop"
		}
	},
	["2"] = {
		{
			event = "chest:openSystem",
			label = "Bandeja",
			tunnel = "shop"
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	for k,v in pairs(cfg.chestCoords) do
		exports["target"]:AddCircleZone("Chest:"..k,vector3(v.cds[1], v.cds[2], v.cds[3]),0.8,{
			name = "Chest:"..k,
			heading = 3374176,
			useZ = true
		},{
			shop = k,
			distance = 1.5,
			options = chestInfos[v.tipo]
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler("chest:openSystem",function(shopId)
	
	if vSERVER.checkIntPermissions(cfg.chestCoords[shopId].perms) and MumbleIsConnected() then
		SetNuiFocus(true,true)
		chestOpen = shopId
		SendNUIMessage({ action = "showMenu" })
	end
end)

AddEventHandler("chest:openHelicrash",function(shopId)
	SetNuiFocus(true,true)
	chestOpen = shopId
	SendNUIMessage({ action = "showMenu" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPGRADESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("chest:upgradeSystem",function(shopId)
	if MumbleIsConnected() then
		vSERVER.upgradeSystem(shopId)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function()
	SendNUIMessage({ action = "hideMenu" })
	SetNuiFocus(false,false)
	chestOpen = ""
	TriggerServerEvent("closeChest")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data)
	if MumbleIsConnected() then
		vSERVER.takeItem(data["item"],data["slot"],data["amount"],data["target"],chestOpen)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data)
	if MumbleIsConnected() then
		vSERVER.storeItem(data["item"],data["slot"],data["amount"],data["target"],chestOpen)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateChest",function(data)
	if MumbleIsConnected() then
		vSERVER.updateChest(data["slot"],data["target"],data["amount"],chestOpen)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestChest",function(data,cb)
	local myInventory,myChest,invPeso,invMaxpeso,chestPeso,chestMaxpeso,sloltsTotal,chestName = vSERVER.openChest(chestOpen)
	if myInventory then
		
		cb({ myInventory = myInventory, myChest = myChest, invPeso = invPeso, invMaxpeso = invMaxpeso, chestPeso = chestPeso, chestMaxpeso = chestMaxpeso, sloltsTotal = sloltsTotal, chestName = chestName })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Update")
AddEventHandler("chest:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPDATEWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:UpdateWeight")
AddEventHandler("chest:UpdateWeight",function(invPeso,invMaxpeso,chestPeso,chestMaxpeso)
	SendNUIMessage({ action = "updateWeight", invPeso = invPeso, invMaxpeso = invMaxpeso, chestPeso = chestPeso, chestMaxpeso = chestMaxpeso })
end)