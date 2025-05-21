-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("shops",cRP)
vSERVER = Tunnel.getInterface("shops")

local BancadaOn = false

cRP.StatusBancada = function(status)
	BancadaOn = status
end

Citizen.CreateThread(function()
    while true do
        local msec = 400
        if not emservico then
            local ped = PlayerPedId()
                local x,y,z = table.unpack(GetEntityCoords(ped))
                local distance = #(GetEntityCoords(ped) - vec3(-583.2,-1060.35,22.34))
                if distance <= 20 and BancadaOn then
                    msec = 3

                    if not HasStreamedTextureDictLoaded("blip3d") then
                        RequestStreamedTextureDict("blip3d", true)
                        while not HasStreamedTextureDictLoaded("blip3d") do
                            Wait(1)
                        end
                        else
                        DrawMarker(9, -583.2,-1060.35,22.34,0,0,0,90.0,0.0,0,0.6,0.6,0,255, 255, 255, 255,false, true, 1, false, "blip3d", "catcafe", false)
                    end

                    if distance <= 1.2 then
                        msec = 3
                        if IsControlJustPressed(0,38) then
							SetNuiFocus(true,true)
							SendNUIMessage({ action = "showNUI", name = "Cafe", type = 1 })
                        end
                    end
                end
        end
        Wait(msec)
    end
end)

Citizen.CreateThread(function()
    while true do
        local msec = 400
            local ped = PlayerPedId()
                local x,y,z = table.unpack(GetEntityCoords(ped))
                local distance = #(GetEntityCoords(ped) - vec3(-622.16,-230.83,38.05))
                if distance <= 20 then
                    msec = 3

                    if not HasStreamedTextureDictLoaded("blip3d") then
                        RequestStreamedTextureDict("blip3d", true)
                        while not HasStreamedTextureDictLoaded("blip3d") do
                            Wait(1)
                        end
                        else
                        DrawMarker(9, -622.16,-230.83,38.05,0,0,0,90.0,0.0,0,0.6,0.6,0,255, 255, 255, 255,false, true, 1, false, "blip3d", "joias", false)
                    end

                    if distance <= 1.2 then
                        msec = 3
                        if IsControlJustPressed(0,38) then
							SetNuiFocus(true,true)
							SendNUIMessage({ action = "showNUI", name = "Joalheria", type = 1 })
                        end
                    end
                end
        Wait(msec)
    end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideNUI" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestShop",function(data,cb)
	local inventoryShop,inventoryUser,invPeso,invMaxpeso,shopSlots = vSERVER.requestShop(data["shop"])
	if inventoryShop then
		cb({ inventoryShop = inventoryShop, inventoryUser = inventoryUser, invPeso = invPeso, invMaxpeso = invMaxpeso, shopSlots = shopSlots })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionShops",function(data)
	if MumbleIsConnected() then
		vSERVER.functionShops(data["shop"],data["item"],data["amount"],data["slot"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("shops:populateSlot",data["item"],data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("shops:updateSlot",data["item"],data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateShops(action)
	SendNUIMessage({ action = action })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local shopList = {
	{ -553.89,-191.45,38.222,"identityStore",false },
	{ -553.3,-192.34,38.22,"identityStore",false },
	{ -544.33,-185.59,52.2,"fidentityStore",false },
	{ 24.9,-1346.8,29.49,"departamentStore",true },
	{ 2556.74,381.24,108.61,"departamentStore",true },
	{ 1164.82,-323.65,69.2,"departamentStore",true },
	{ -706.15,-914.53,19.21,"departamentStore",true },
	{ -47.38,-1758.68,29.42,"departamentStore",true },
	{ 373.1,326.81,103.56,"departamentStore",true },
	{ -3242.75,1000.46,12.82,"departamentStore",true },
	{ 1728.47,6415.46,35.03,"departamentStore",true },
	{ 1960.2,3740.68,32.33,"departamentStore",true },
	{ 2677.8,3280.04,55.23,"departamentStore",true },
	{ 1697.31,4923.49,42.06,"departamentStore",true },
	{ -1819.52,793.48,138.08,"departamentStore",true },
	{ 1391.69,3605.97,34.98,"departamentStore",true },
	{ -2966.41,391.55,15.05,"departamentStore",true },
	{ -3039.54,584.79,7.9,"departamentStore",true },
	{ 1134.33,-983.11,46.4,"departamentStore",true },
	{ 1165.28,2710.77,38.15,"departamentStore",true },
	{ -1486.72,-377.55,40.15,"departamentStore",true },
	{ -1221.45,-907.92,12.32,"departamentStore",true },
	{ 161.2,6641.66,31.69,"departamentStore",true },
	{ -160.62,6320.93,31.58,"departamentStore",true },
	{ 548.7,2670.73,42.16,"departamentStore",true },

	{ -3160.15,7357.69,8.46,"departamentStore",true },
	{ -3043.95,6744.19,6.79,"departamentStore",true },

	{ 2529.43,-339.17,101.89,"arsenallspd",false }, 
	{ -2205.63,3171.93,32.82,"arsenallspd",false },  
	{ 161.19,6642.24,31.69,"departamentStore",true }, -- Loja De Departamentos 21
	{ 291.99,-1272.61,29.52,"departamentStore",true }, -- Loja De Departamentos 22
	{ 1695.26,3760.94,34.69,"ammunationStore",false }, -- Loja De Armas 1
	{ 250.12,-51.56,69.94,"ammunationStore",false },  -- Loja De Armas 2
	{ 840.19,-1032.14,28.19,"ammunationStore",false }, -- Loja De Armas 3
	{ -327.81,6084.3,31.46,"ammunationStore",false }, -- Loja De Armas 4
	{ -660.05,-936.71,21.82,"ammunationStore",false }, -- Loja De Armas 5
	{ -1307.72,-396.02,36.7,"ammunationStore",false }, -- Loja De Armas 6 
	{ -1115.16,2698.94,18.55,"ammunationStore",false }, -- Loja De Armas 7
	{ 2565.72,295.73,108.73,"ammunationStore",false }, -- Loja De Armas 8
	{ -3169.76,1089.16,20.84,"ammunationStore",false }, -- Loja De Armas 9
	{ 22.54,-1105.54,29.79,"ammunationStore",false }, -- Loja De Armas 10
	{ 810.26,-2159.02,29.62,"ammunationStore",false }, -- Loja De Armas 11
	{ -1082.25,-247.52,37.76,"premiumStore",false },
	{ 1524.77,3783.84,34.49,"fishingSell",false },

	{ 153.05,-757.37,45.75,"fbi",false },


	{ 326.52,-1073.92,29.47,"pharmacyStore",false },
	{ -2197.8,3169.9,32.82,"pharmacyStore2",false },
	{ -172.48,6380.96,31.48,"pharmacyStore",false },
	{ 149.74,-3018.77,7.04,"mechanicTools",false },

	{ -1528.44,-401.36,35.62,"eletronicos",false },		
	--{ -1209.46,-1502.79,4.36,"eletronicos",false },	


	{ 1523.69,3782.48,34.51,"fishdepartamentStore",true },

	{ -622.16,-230.83,38.05,"Joalheria",true },

	{ 1136.55,-1555.59,35.03,"lojaHP",true },
	{ 1142.73,-1529.89,35.03,"HospitalShop",true },
	

	--{ -1263.3,-1425.52,4.36,"animalStore",false },
	
	{ -551.38,-190.6,38.22,"imoveisShop",false },
	
	{ -2168.21,3172.12,32.82,"departamentStore",true },

	{ 1087.06,6510.88,21.05,"comprarfruta",false },
	--{ 1189.57,2722.26,38.69,"ilegalshop",false },
	--{ 1184.02,2722.26,38.62,"ilegalshop2",false },
	{ -1400.3,-602.21,30.31,"bebidasbahamas",false },
	{ 96.3,-1272.71,21.1,"vanillabebib",false },
	{ 650.3,2728.34,41.99,"venderfrutas",false },
--	{ -1225.66,-1483.64,4.36,"venderfrutas",false },
--{ -1246.86,-1453.67,4.36,"mcFridge",false },
	--{ -1218.68,-1493.94,4.36,"mcFridge",false },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPINFOS
-----------------------------------------------------------------------------------------------------------------------------------------
local shopInfos = {
	["1"] = {
		{
			event = "shops:openSystem",
			label = "Abrir",
			tunnel = "shop"
		},{
			event = "crafting:ammunationStore",
			label = "Criar",
			tunnel = "shop"
		}
	},
	["2"] = {
		{
			event = "shops:openSystem",
			label = "Abrir",
			tunnel = "shop"
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Informations(shopName)
	if shopName == "ammunationStoreStore" then
		return shopInfos["1"]
	end

	return shopInfos["2"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	for k,v in pairs(shopList) do
		exports["target"]:AddCircleZone("Shops:"..k,vector3(v[1],v[2],v[3]),0.75,{
			name = "Shops:"..k,
			heading = 3374176
		},{
			shop = k,
			distance = 1.75,
			options = Informations(v[4])
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:openSystem",function(shopId)
	if vSERVER.requestPerm(shopList[shopId][4]) and MumbleIsConnected() then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showNUI", name = shopList[shopId][4], type = vSERVER.getShopType(shopList[shopId][4]) })

		if shopList[shopId][5] then
			TriggerEvent("sounds:source","shop",0.5)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:COFFEEMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:coffeeMachine",function()
	if MumbleIsConnected() then
		SendNUIMessage({ action = "showNUI", name = "coffeeMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:SODAMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:sodaMachine",function()
	if MumbleIsConnected() then
		SendNUIMessage({ action = "showNUI", name = "sodaMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DONUTMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:donutMachine",function()
	if MumbleIsConnected() then
		SendNUIMessage({ action = "showNUI", name = "donutMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BURGERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:burgerMachine",function()
	if MumbleIsConnected() then
		SendNUIMessage({ action = "showNUI", name = "burgerMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HOTDOGMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:hotdogMachine",function()
	if MumbleIsConnected() then
		SendNUIMessage({ action = "showNUI", name = "hotdogMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:CHIHUAHUA
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:Chihuahua",function()
	if MumbleIsConnected() then
		SendNUIMessage({ action = "showNUI", name = "Chihuahua", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:WATERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:waterMachine",function()
	if MumbleIsConnected() then
		SendNUIMessage({ action = "showNUI", name = "waterMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:MEDICBAG
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:medicBag",function()
	if vSERVER.requestPerm("pharmacyParamedic") and MumbleIsConnected() then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showNUI", name = "pharmacyParamedic", type = "Buy" })
	end
end)