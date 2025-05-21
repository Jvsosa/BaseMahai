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
Tunnel.bindInterface("skinshop",cRP)
vSERVER = Tunnel.getInterface("skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = -1
local skinData = {}
local previousSkinData = {}
local customCamLocation = nil
local creatingCharacter = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINDATA
-----------------------------------------------------------------------------------------------------------------------------------------
local skinData = {
	["pants"] = { item = 0, texture = 0 },
	["arms"] = { item = 0, texture = 0 },
	["tshirt"] = { item = 1, texture = 0 },
	["torso"] = { item = 0, texture = 0 },
	["vest"] = { item = 0, texture = 0 },
	["shoes"] = { item = 0, texture = 0 },
	["mask"] = { item = 0, texture = 0 },
	["backpack"] = { item = 0, texture = 0 },
	["hat"] = { item = -1, texture = 0 },
	["glass"] = { item = 0, texture = 0 },
	["ear"] = { item = -1, texture = 0 },
	["watch"] = { item = -1, texture = 0 },
	["bracelet"] = { item = -1, texture = 0 },
	["accessory"] = { item = 0, texture = 0 },
	["decals"] = { item = 0, texture = 0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:apply")
AddEventHandler("skinshop:apply",function(status)
	if status["pants"] ~= nil then
		skinData = status
	end

	resetClothing(skinData)
	vSERVER.updateClothes(skinData)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("updateRoupas")
AddEventHandler("updateRoupas",function(custom)
	skinData = custom
	resetClothing(custom)
	vSERVER.updateClothes(custom)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETATTOO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:updateTattoo")
AddEventHandler("skinshop:updateTattoo",function()
	resetClothing(skinData)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATESHOPS
-----------------------------------------------------------------------------------------------------------------------------------------
local locateShops = {
	--{ 75.40,-1392.92,29.37 },
	--{ -709.40,-153.66,37.41 },
	--{ -163.20,-302.03,39.73 },
	--{ 425.58,-806.23,29.49 },
	--{ -822.34,-1073.49,11.32 },
	--{ -1193.81,-768.49,17.31 },
	--{ -1450.85,-238.15,49.81 },
	--{ 4.90,6512.47,31.87 },
	--{ 1693.95,4822.67,42.06 },
	--{ 126.05,-223.10,54.55 },
	--{ 614.26,2761.91,42.08 },
	--{ 1196.74,2710.21,38.22 },
	--{ -3170.18,1044.54,20.86 },
	--{ -1101.46,2710.57,19.10 },
	--{ 461.85,-999.75,30.68 },
	--{ 461.87,-995.88,30.68 },
	--{ 301.9,-599.55,43.29 },
	--{ 298.54,-598.2,43.29 },
	--{ 1834.73,2571.71,46.02 },
    --{ 621.8,-7.54,76.63 }, -- 1
    --{ 623.25,0.4,76.63 }, -- 2
    --{ 623.87,4.59,76.63 }, -- 3
    --{ 622.61,-3.28,76.63 }, -- 4
	--{ 105.66,-1303.04,28.8 },
	--{ 153.1,-3011.12,7.04 },
	--{ -1124.28,-1442.0,5.22 },
	--{ -439.47,6011.46,36.99 },
	--{ -437.44,6008.93,36.99 },
	--{ 362.35,-1593.34,25.44 },
	--{ -1186.57,-902.82,13.99 },
	--{ 810.28,-761.19,31.26 },
	--{ 387.37,799.76,187.45 },
	--{ -586.76,-1049.98,22.34 },
	--{ 1825.76,3672.3,34.27 },
	--{ 1853.5,3688.55,29.81 },
	--{ -1887.19,2070.57,145.57 },
	{ 1951.38,3766.07,11.11 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
--Citizen.CreateThread(function()
--	local innerTable = {}
--	for k,v in pairs(locateShops) do
--		table.insert(innerTable,{ v[1],v[2],v[3],2,"E","Loja de Roupas","Pressione para abrir" })
--	end
--
--	TriggerEvent("hoverfy:insertTable",innerTable)
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) and not creatingCharacter then
			local coords = GetEntityCoords(ped)

			for k,v in pairs(locateShops) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 2 then
					timeDistance = 1

					if IsControlJustPressed(0,38) and vSERVER.checkShares() then
						customCamLocation = nil

						openMenu({
							{ menu = "character", label = "Roupas", selected = true },
							{ menu = "accessoires", label = "Utilidades", selected = false }
						})
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:OPENSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:openShop")
AddEventHandler("skinshop:openShop",function()
	if not creatingCharacter and vSERVER.checkShares() then
		customCamLocation = nil

		openMenu({
			{ menu = "character", label = "Roupas", selected = true },
			{ menu = "accessoires", label = "Utilidades", selected = false }
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETOUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("resetOutfit",function()
	resetClothing(json.decode(previousSkinData))
	skinData = json.decode(previousSkinData)
	previousSkinData = {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATERIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateRight",function()
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	SetEntityHeading(ped,heading + 30)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATELEFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateLeft",function()
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	SetEntityHeading(ped,heading - 30)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHINGCATEGORYS
-----------------------------------------------------------------------------------------------------------------------------------------
local clothingCategorys = {
	["arms"] = { type = "variation", id = 3 },
	["backpack"] = { type = "variation", id = 5 },
	["tshirt"] = { type = "variation", id = 8 },
	["torso"] = { type = "variation", id = 11 },
	["pants"] = { type = "variation", id = 4 },
	["vest"] = { type = "variation", id = 9 },
	["shoes"] = { type = "variation", id = 6 },
	["mask"] = { type = "variation", id = 1 },
	["hat"] = { type = "prop", id = 0 },
	["glass"] = { type = "prop", id = 1 },
	["ear"] = { type = "prop", id = 2 },
	["watch"] = { type = "prop", id = 6 },
	["bracelet"] = { type = "prop", id = 7 },
	["accessory"] = { type = "variation", id = 7 },
	["decals"] = { type = "variation", id = 10 }
}

RegisterNetEvent("changeClothes")
AddEventHandler("changeClothes",function(index,color,type_clothe)
    local ped = PlayerPedId()
    if GetEntityHealth(ped) > 101 then
        local v = clothingCategorys[type_clothe]
        if v then 
            if index == nil then
                ClearPedTasks(ped)
                SetPedComponentVariation(ped,v.id,0,0,2)
				skinData[type_clothe]["texture"] = 0
				skinData[type_clothe]["item"] = 0
				vSERVER.updateClothes(skinData)
                return
            end
            if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
                ClearPedTasks(ped)
                if v.type == "prop" then
                    SetPedPropIndex(ped,v.id,parseInt(index),parseInt(color),2)
                else
                    SetPedComponentVariation(ped,v.id,parseInt(index),parseInt(color),2)
                end
				skinData[type_clothe]["texture"] = parseInt(color)
				skinData[type_clothe]["item"] = parseInt(index)
				vSERVER.updateClothes(skinData)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMAXVALUES
-----------------------------------------------------------------------------------------------------------------------------------------
function GetMaxValues()
	maxModelValues = {
		["backpack"] = { type = "character", item = 0, texture = 0 },
		["arms"] = { type = "character", item = 0, texture = 0 },
		["tshirt"] = { type = "character", item = 0, texture = 0 },
		["torso"] = { type = "character", item = 0, texture = 0 },
		["pants"] = { type = "character", item = 0, texture = 0 },
		["shoes"] = { type = "character", item = 0, texture = 0 },
		["vest"] = { type = "character", item = 0, texture = 0 },
		["accessory"] = { type = "character", item = 0, texture = 0 },
		["decals"] = { type = "character", item = 0, texture = 0 },
		["mask"] = { type = "accessoires", item = 0, texture = 0 },
		["hat"] = { type = "accessoires", item = 0, texture = 0 },
		["glass"] = { type = "accessoires", item = 0, texture = 0 },
		["ear"] = { type = "accessoires", item = 0, texture = 0 },
		["watch"] = { type = "accessoires", item = 0, texture = 0 },
		["bracelet"] = { type = "accessoires", item = 0, texture = 0 }
	}

	local ped = PlayerPedId()
	for k,v in pairs(clothingCategorys) do
		if v["type"] == "variation" then
			maxModelValues[k]["item"] = GetNumberOfPedDrawableVariations(ped,v["id"]) - 1
			maxModelValues[k]["texture"] = GetNumberOfPedTextureVariations(ped,v["id"],GetPedDrawableVariation(ped,v["id"])) - 1

			if maxModelValues[k]["texture"] <= 0 then
				maxModelValues[k]["texture"] = 0
			end
		end

		if v["type"] == "prop" then
			maxModelValues[k]["item"] = GetNumberOfPedPropDrawableVariations(ped,v["id"]) - 1
			maxModelValues[k]["texture"] = GetNumberOfPedPropTextureVariations(ped,v["id"],GetPedPropIndex(ped,v["id"])) - 1

			if maxModelValues[k]["texture"] <= 0 then
				maxModelValues[k]["texture"] = 0
			end
		end
	end

	SendNUIMessage({ action = "updateMax", maxValues = maxModelValues })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function openMenu(allowedMenus)
	creatingCharacter = true
	previousSkinData = json.encode(skinData)

	GetMaxValues()

	SendNUIMessage({ action = "open", menus = allowedMenus, currentClothing = skinData })

	SetNuiFocus(true,true)
	SetCursorLocation(0.9,0.25)

	enableCam()
	vRP.playAnim(false,{"mp_sleep","bind_pose_180"},true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENABLECAM
-----------------------------------------------------------------------------------------------------------------------------------------
function enableCam()
	local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,2.0,0)
	RenderScriptCams(false,false,0,1,0)
	DestroyCam(cam,false)

	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
		SetCamActive(cam,true)
		RenderScriptCams(true,false,0,true,true)
		SetCamCoord(cam,coords["x"],coords["y"],coords["z"] + 0.5)
		SetCamRot(cam,0.0,0.0,GetEntityHeading(PlayerPedId()) + 180)
	end

	if customCamLocation ~= nil then
		SetCamCoord(cam,customCamLocation["x"],customCamLocation["y"],customCamLocation["z"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATECAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateCam",function(data)
	local ped = PlayerPedId()
	local rotType = data["type"]
	local coords = GetOffsetFromEntityInWorldCoords(ped,0,2.0,0)

	if rotType == "left" then
		SetEntityHeading(ped,GetEntityHeading(ped) - 10)
		SetCamCoord(cam,coords["x"],coords["y"],coords["z"] + 0.5)
		SetCamRot(cam,0.0,0.0,GetEntityHeading(ped) + 180)
	else
		SetEntityHeading(ped,GetEntityHeading(ped) + 10)
		SetCamCoord(cam,coords["x"],coords["y"],coords["z"] + 0.5)
		SetCamRot(cam,0.0,0.0,GetEntityHeading(ped) + 180)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPCAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("setupCam",function(data)
	local value = data["value"]

	if value == 1 then
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,0.75,0)
		SetCamCoord(cam,coords["x"],coords["y"],coords["z"] + 0.6)
	elseif value == 2 then
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,1.0,0)
		SetCamCoord(cam,coords["x"],coords["y"],coords["z"] + 0.2)
	elseif value == 3 then
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,1.0,0)
		SetCamCoord(cam,coords["x"],coords["y"],coords["z"] - 0.5)
	else
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,2.0,0)
		SetCamCoord(cam,coords["x"],coords["y"],coords["z"] + 0.5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSEMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function closeMenu()
	SendNUIMessage({ action = "close" })
	RenderScriptCams(false,true,250,1,0)
	DestroyCam(cam,false)
	vRP.stopAnim()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETCLOTHING
-----------------------------------------------------------------------------------------------------------------------------------------
function resetClothing(data)
	local ped = PlayerPedId()

	if data["backpack"] == nil then
		data["backpack"] = {}
		data["backpack"]["item"] = 0
		data["backpack"]["texture"] = 0
	end

	SetPedComponentVariation(ped,4,data["pants"]["item"],data["pants"]["texture"],1)
	SetPedComponentVariation(ped,3,data["arms"]["item"],data["arms"]["texture"],1)
	SetPedComponentVariation(ped,5,data["backpack"]["item"],data["backpack"]["texture"],1)
	SetPedComponentVariation(ped,8,data["tshirt"]["item"],data["tshirt"]["texture"],1)
	SetPedComponentVariation(ped,9,data["vest"]["item"],data["vest"]["texture"],1)
	SetPedComponentVariation(ped,11,data["torso"]["item"],data["torso"]["texture"],1)
	SetPedComponentVariation(ped,6,data["shoes"]["item"],data["shoes"]["texture"],1)
	SetPedComponentVariation(ped,1,data["mask"]["item"],data["mask"]["texture"],1)
	SetPedComponentVariation(ped,10,data["decals"]["item"],data["decals"]["texture"],1)
	SetPedComponentVariation(ped,7,data["accessory"]["item"],data["accessory"]["texture"],1)

	if data["hat"]["item"] ~= -1 and data["hat"]["item"] ~= 0 then
		SetPedPropIndex(ped,0,data["hat"]["item"],data["hat"]["texture"],1)
	else
		ClearPedProp(ped,0)
	end

	if data["glass"]["item"] ~= -1 and data["glass"]["item"] ~= 0 then
		SetPedPropIndex(ped,1,data["glass"]["item"],data["glass"]["texture"],1)
	else
		ClearPedProp(ped,1)
	end

	if data["ear"]["item"] ~= -1 and data["ear"]["item"] ~= 0 then
		SetPedPropIndex(ped,2,data["ear"]["item"],data["ear"]["texture"],1)
	else
		ClearPedProp(ped,2)
	end

	if data["watch"]["item"] ~= -1 and data["watch"]["item"] ~= 0 then
		SetPedPropIndex(ped,6,data["watch"]["item"],data["watch"]["texture"],1)
	else
		ClearPedProp(ped,6)
	end

	if data["bracelet"]["item"] ~= -1 and data["bracelet"]["item"] ~= 0 then
		SetPedPropIndex(ped,7,data["bracelet"]["item"],data["bracelet"]["texture"],1)
	else
		ClearPedProp(ped,7)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function()
	RenderScriptCams(false,true,250,1,0)
	creatingCharacter = false
	SetNuiFocus(false,false)
	DestroyCam(cam,false)
	vRP.stopAnim()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkin",function(data)
	ChangeVariation(data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKINONINPUT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkinOnInput",function(data)
	ChangeVariation(data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGEVARIATION
-----------------------------------------------------------------------------------------------------------------------------------------
function ChangeVariation(data)
	local ped = PlayerPedId()
	local types = data["type"]
	local item = data["articleNumber"]
	local category = data["clothingType"]

	if category == "pants" then
		if types == "item" then
			SetPedComponentVariation(ped,4,item,0,1)
			skinData["pants"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(ped,4,GetPedDrawableVariation(ped,4),item,1)
			skinData["pants"]["texture"] = item
		end
	elseif category == "arms" then
		if types == "item" then
			SetPedComponentVariation(ped,3,item,0,1)
			skinData["arms"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(ped,3,GetPedDrawableVariation(ped,3),item,1)
			skinData["arms"]["texture"] = item
		end
	elseif category == "tshirt" then
		if types == "item" then
			SetPedComponentVariation(ped,8,item,0,1)
			skinData["tshirt"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(ped,8,GetPedDrawableVariation(ped,8),item,1)
			skinData["tshirt"]["texture"] = item
		end
	elseif category == "vest" then
		if types == "item" then
			SetPedComponentVariation(ped,9,item,0,1)
			skinData["vest"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(ped,9,skinData["vest"]["item"],item,1)
			skinData["vest"]["texture"] = item
		end
	elseif category == "decals" then
		if types == "item" then
			SetPedComponentVariation(ped,10,item,0,1)
			skinData["decals"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(ped,10,skinData["decals"]["item"],item,1)
			skinData["decals"]["texture"] = item
		end
	elseif category == "accessory" then
		if types == "item" then
			SetPedComponentVariation(ped,7,item,0,1)
			skinData["accessory"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(ped,7,skinData["accessory"]["item"],item,1)
			skinData["accessory"]["texture"] = item
		end
	elseif category == "torso" then
		if types == "item" then
			SetPedComponentVariation(ped,11,item,0,1)
			skinData["torso"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(ped,11,GetPedDrawableVariation(ped,11),item,1)
			skinData["torso"]["texture"] = item
		end
	elseif category == "shoes" then
		if types == "item" then
			SetPedComponentVariation(ped,6,item,0,1)
			skinData["shoes"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(ped,6,GetPedDrawableVariation(ped,6),item,1)
			skinData["shoes"]["texture"] = item
		end
	elseif category == "mask" then
		if types == "item" then
			SetPedComponentVariation(ped,1,item,0,1)
			skinData["mask"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(ped,1,GetPedDrawableVariation(ped,1),item,1)
			skinData["mask"]["texture"] = item
		end
	elseif category == "hat" then
		if types == "item" then
			if item ~= -1 then
				SetPedPropIndex(ped,0,item,skinData["hat"]["texture"],1)
			else
				ClearPedProp(ped,0)
			end

			skinData["hat"]["item"] = item
		elseif types == "texture" then
			SetPedPropIndex(ped,0,skinData["hat"]["item"],item,1)
			skinData["hat"]["texture"] = item
		end
	elseif category == "glass" then
		if types == "item" then
			if item ~= -1 then
				SetPedPropIndex(ped,1,item,skinData["glass"]["texture"],1)
				skinData["glass"]["item"] = item
			else
				ClearPedProp(ped,1)
			end
		elseif types == "texture" then
			SetPedPropIndex(ped,1,skinData["glass"]["item"],item,1)
			skinData["glass"]["texture"] = item
		end
	elseif category == "ear" then
		if types == "item" then
			if item ~= -1 then
				SetPedPropIndex(ped,2,item,skinData["ear"]["texture"],1)
			else
				ClearPedProp(ped,2)
			end

			skinData["ear"]["item"] = item
		elseif types == "texture" then
			SetPedPropIndex(ped,2,skinData["ear"]["item"],item,1)
			skinData["ear"]["texture"] = item
		end
	elseif category == "watch" then
		if types == "item" then
			if item ~= -1 then
				SetPedPropIndex(ped,6,item,skinData["watch"]["texture"],1)
			else
				ClearPedProp(ped,6)
			end

			skinData["watch"]["item"] = item
		elseif types == "texture" then
			SetPedPropIndex(ped,6,skinData["watch"]["item"],item,1)
			skinData["watch"]["texture"] = item
		end
	elseif category == "bracelet" then
		if types == "item" then
			if item ~= -1 then
				SetPedPropIndex(ped,7,item,skinData["bracelet"]["texture"],1)
			else
				ClearPedProp(ped,7)
			end

			skinData["bracelet"]["item"] = item
		elseif types == "texture" then
			SetPedPropIndex(ped,7,skinData["bracelet"]["item"],item,1)
			skinData["bracelet"]["texture"] = item
		end
	end

	GetMaxValues()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVECLOTHING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("saveClothing",function()
	vSERVER.updateClothes(skinData)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMASK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setMask")
AddEventHandler("skinshop:setMask",function()
	local ped = PlayerPedId()
	
	if GetPedDrawableVariation(ped,1) == skinData["mask"]["item"] then
		SetPedComponentVariation(ped,1,0,0,1)
	else
		SetPedComponentVariation(ped,1,skinData["mask"]["item"],skinData["mask"]["texture"],1)
	end
	
	vRP.removeObjects()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setHat")
AddEventHandler("skinshop:setHat",function()
	local ped = PlayerPedId()

	if GetPedPropIndex(ped,0) == skinData["hat"]["item"] then
		ClearPedProp(ped,0)
	else
		SetPedPropIndex(ped,0,skinData["hat"]["item"],skinData["hat"]["texture"],1)
	end

	vRP.removeObjects()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETGLASSES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setGlasses")
AddEventHandler("skinshop:setGlasses",function()
	local ped = PlayerPedId()

	if GetPedPropIndex(ped,1) == skinData["glass"]["item"] then
		ClearPedProp(ped,1)
	else
		SetPedPropIndex(ped,1,skinData["glass"]["item"],skinData["glass"]["texture"],1)
	end

	vRP.removeObjects()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETARMS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setArms")
AddEventHandler("skinshop:setArms",function()
	local ped = PlayerPedId()

	if GetPedDrawableVariation(ped,3) == skinData["arms"]["item"] then
		SetPedComponentVariation(ped,3,15,0,1)
	else
		SetPedComponentVariation(ped,3,skinData["arms"]["item"],skinData["arms"]["texture"],1)
	end

	vRP.removeObjects()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setShoes")
AddEventHandler("skinshop:setShoes",function()
	local ped = PlayerPedId()

	if GetPedDrawableVariation(ped,6) == skinData["shoes"]["item"] then
		SetPedComponentVariation(ped,6,5,0,1)
	else
		SetPedComponentVariation(ped,6,skinData["shoes"]["item"],skinData["shoes"]["texture"],1)
	end

	vRP.removeObjects()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPANTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setPants")
AddEventHandler("skinshop:setPants",function()
	local ped = PlayerPedId()

	if GetPedDrawableVariation(ped,4) == skinData["pants"]["item"] then
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,4,14,0,1)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,4,15,0,1)
		end
	else
		SetPedComponentVariation(ped,4,skinData["pants"]["item"],skinData["pants"]["texture"],1)
	end

	vRP.removeObjects()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSHIRT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setShirt")
AddEventHandler("skinshop:setShirt",function()
	local ped = PlayerPedId()

	if GetPedDrawableVariation(ped,8) == skinData["tshirt"]["item"] then
		SetPedComponentVariation(ped,8,15,0,1)
		SetPedComponentVariation(ped,3,15,0,1)
	else
		SetPedComponentVariation(ped,8,skinData["tshirt"]["item"],skinData["tshirt"]["texture"],1)
	end

	vRP.removeObjects()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETJACKET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setJacket")
AddEventHandler("skinshop:setJacket",function()
	local ped = PlayerPedId()

	if GetPedDrawableVariation(ped,11) == skinData["torso"]["item"] then
		SetPedComponentVariation(ped,11,15,0,1)
		SetPedComponentVariation(ped,3,15,0,1)
	else
		SetPedComponentVariation(ped,11,skinData["torso"]["item"],skinData["torso"]["texture"],1)
	end

	vRP.removeObjects()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETVEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setVest")
AddEventHandler("skinshop:setVest",function()
	local ped = PlayerPedId()

	if GetPedDrawableVariation(ped,9) == skinData["vest"]["item"] then
		SetPedComponentVariation(ped,9,0,0,1)
	else
		SetPedComponentVariation(ped,9,skinData["vest"]["item"],skinData["vest"]["texture"],1)
	end

	vRP.removeObjects()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:toggleBackpack")
AddEventHandler("skinshop:toggleBackpack",function(numBack)
	if skinData["backpack"]["item"] == parseInt(numBack) then
		skinData["backpack"]["item"] = 0
		skinData["backpack"]["texture"] = 0
	else
		skinData["backpack"]["texture"] = 0
		skinData["backpack"]["item"] = parseInt(numBack)
	end

	SetPedComponentVariation(PlayerPedId(),5,skinData["backpack"]["item"],skinData["backpack"]["texture"],1)

	vSERVER.updateClothes(skinData)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:removeBackpack")
AddEventHandler("skinshop:removeBackpack",function(numBack)
	if skinData["backpack"]["item"] == parseInt(numBack) then
		skinData["backpack"]["item"] = 0
		skinData["backpack"]["texture"] = 0
		SetPedComponentVariation(PlayerPedId(),5,0,0,1)

		vSERVER.updateClothes(skinData)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getCustomization()
	return skinData
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkBackpack()
	if skinData["backpack"]["item"] >= 100 then
		return skinData["backpack"]["item"]
	end

	return false
end

function cRP.checkShoes()
	
	local Number = 34
	local Ped = PlayerPedId()
	if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
		Number = 35
	end

	if skinData["shoes"]["item"] ~= Number then
	
		skinData["shoes"]["item"] = Number
		skinData["shoes"]["texture"] = 0
		SetPedComponentVariation(Ped,6,skinData["shoes"]["item"],skinData["shoes"]["texture"],1)

		return true
	end

	return false
end