_RegisterCommand = RegisterCommand
function RegisterCommand(command, callback)
    _RegisterCommand(command, function(...)
        if not LocalPlayer.state.inLateGame and not LocalPlayer.state.inPvp then
            return callback(...)
        end
    end)
end

_IsControlJustPressed = IsControlJustPressed
function IsControlJustPressed(...)
    if LocalPlayer.state.inLateGame and LocalPlayer.state.inPvp then
        return false
    else
        return _IsControlJustPressed(...)
    end
end

local initLocates = {
	{ 2578.11,-294.98,93.4,263.63 }
}



Citizen.CreateThread(function()
	for k,v in pairs(initLocates) do
		exports["target"]:AddCircleZone("TowDriver:"..k,vector3(v[1],v[2],v[3]),1.0,{
			name = "TowDriver:"..k,
			heading = 3374176
		},{
			shop = k,
			distance = 1.5,
			options = {

				{
					event = "garages:Impound",
					label = "Apreendidos",
					tunnel = "shop"
				}
			}
		})
	end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP TUNNELS - CORREÇÃO PARA NOCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION - CORRIGIR INTERFACE
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("admin",cRP)  -- ✅ Client se registra como "admin"
vSERVER = Tunnel.getInterface("admin")  -- ✅ Client acessa server

Citizen.CreateThread(function()
    Citizen.Wait(2000)  
    print("^2[ADMIN-CLIENT]^7 Sistema inicializado!")
end)
function cRP.getPosition()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
	return x,y,z
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not IsPedInAnyVehicle(PlayerPedId()) then
			if IsControlJustPressed(0,47) then
				TriggerServerEvent("player:carryPlayeradm")
			end
			if IsControlJustPressed(0,74) then
				TriggerServerEvent("player:carryPlayeradm")
			end
		end
	end
end)

local batata = false

cRP.bololo = function()
    while true do
        ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.25)
        Wait(12000)
        local coords = GetEntityForwardVector(PlayerPedId())
        SetPedToRagdollWithFall(PlayerPedId(),10000,10000,0,coords[1],coords[2],coords[3],10.0,0.0,0.0,0.0,0.0,0.0,0.0)
    end
end

cRP.derrubar = function()

    local coords = GetEntityForwardVector(PlayerPedId())
    SetPedToRagdollWithFall(PlayerPedId(),10000,10000,0,coords[1],coords[2],coords[3],10.0,0.0,0.0,0.0,0.0,0.0,0.0)
end


-- RegisterCommand("reinventory",function(source,args,rawCommand)
	
--         LocalPlayer["state"]["Buttons"] = false
-- 		LocalPlayer["state"]["Cancel"] = false
-- 	    LocalPlayer["state"]["Commands"] = false
--         LocalPlayer["state"]["Handcuff"] = false
-- end)

RegisterCommand("rs",function(source,args,rawCommand)
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsUsing(ped)
        local vehClass = GetVehicleClass(vehicle)
        print(vehClass)
    
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PLAYERCARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local playerCarry = false
RegisterNetEvent("player:playerCarrypm2")
AddEventHandler("player:playerCarrypm2",function(entity,mode)
	if playerCarry then
		DetachEntity(PlayerPedId(),false,false)
		playerCarry = false
	else
		if mode == "handcuff" then
			AttachEntityToEntity(PlayerPedId(),GetPlayerPed(GetPlayerFromServerId(entity)),11816,0.0,0.5,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		else
			AttachEntityToEntity(PlayerPedId(),GetPlayerPed(GetPlayerFromServerId(entity)),11816,0.6,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		end

		playerCarry = true
	end
end)

local playerCarry = false
RegisterNetEvent("player:playerCarryadm2")
AddEventHandler("player:playerCarryadm2",function(entity,mode)
	if playerCarry then
		DetachEntity(PlayerPedId(),false,false)
		playerCarry = false
	else
		if mode == "handcuff" then
			AttachEntityToEntity(PlayerPedId(),GetPlayerPed(GetPlayerFromServerId(entity)),4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		else
			AttachEntityToEntity(PlayerPedId(),GetPlayerPed(GetPlayerFromServerId(entity)),4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		end

		playerCarry = true
	end
end)


-- local cooldownEntrar_praca = 0

-- Citizen.CreateThread(function()
-- 	while true do
-- 		if cooldownEntrar_praca > 0 then
-- 			cooldownEntrar_praca = cooldownEntrar_praca - 1
-- 		end
-- 		Citizen.Wait(1000)
-- 	end
-- end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		local timeDistance = 999
-- 		timeDistance = 1
-- 		local ped = PlayerPedId()
--         if IsPedShooting(ped) and cooldownEntrar_praca <= 0 then
--             timeDistance = 1
--             cooldownEntrar_praca = 120
--         end
-- 		Citizen.Wait(timeDistance)
-- 	end
-- end)



-- Citizen.CreateThread(function()
-- 	while true do
-- 		local msec = 400
-- 		if cooldownEntrar_praca then
--             local ped = PlayerPedId()
--             local x,y,z = table.unpack(GetEntityCoords(ped))
--             local bowz,cdz = GetGroundZFor_3dCoord(175.32,-974.82,46.37)
--             local distance = GetDistanceBetweenCoords(176.52,-970.49,cdz,x,y,z,true)
--             if distance <= 70 then
--                 msec = 3
--                 DrawMarker(27, 181.86,-967.29,31.36-0.6,0,0,0,0,0,0,0.2,0.2,0.3,  255, 255,255,100 ,false,0,0,1)
--                 SetEntityCoordsNoOffset(ped,151.28,-1003.78,29.281,1,0,0)
--             end
-- 		end
-- 		Wait(msec)
-- 	end
-- end)



RegisterNetEvent("vcolorv")
AddEventHandler("vcolorv",function(veh,r,g,b)
    if IsEntityAVehicle(veh) then
        SetVehicleCustomPrimaryColour(veh,r,g,b)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTWAY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.teleportWay()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		ped = GetVehiclePedIsUsing(ped)
    end

	local waypointBlip = GetFirstBlipInfoId(8)
	local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09,waypointBlip,Citizen.ResultAsVector()))

	local ground
	local groundFound = false
	local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0 }

	for i,height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(ped,x,y,height,1,0,0)

		RequestCollisionAtCoord(x,y,z)
		while not HasCollisionLoadedAroundEntity(ped) do
			Citizen.Wait(1)
		end

		Citizen.Wait(20)

		ground,z = GetGroundZFor_3dCoord(x,y,height)
		if ground then
			z = z + 1.0
			groundFound = true
			break;
		end
	end

	if not groundFound then
		z = 1200
		GiveDelayedWeaponToPed(ped,0xFBAB5776,1,0)
	end

	RequestCollisionAtCoord(x,y,z)
	while not HasCollisionLoadedAroundEntity(ped) do
		Citizen.Wait(1)
	end

	SetEntityCoordsNoOffset(ped,x,y,z,1,0,0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTWAY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.teleportLimbo()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local _,xCoords = GetNthClosestVehicleNode(coords["x"],coords["y"],coords["z"],1,0,0,0)

	SetEntityCoordsNoOffset(ped,xCoords["x"],xCoords["y"],xCoords["z"] + 1,1,0,0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:vehicleTuning")
AddEventHandler("admin:vehicleTuning",function()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)

		SetVehicleModKit(vehicle,0)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11)-1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12)-1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13)-1,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15)-1,false)
        SetVehicleModColor_1(vehicle,0,0,2)
		ToggleVehicleMod(vehicle,18,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function noClip()
    if not noclip then
        noclip = true
        local ped = PlayerPedId()
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetEntityVisible(ped, false, false)
        SetEntityCollision(ped, false, false)
        
        Citizen.CreateThread(function()
            while noclip do
                Citizen.Wait(5) 
                
                local ped = PlayerPedId()
                local x, y, z = table.unpack(GetEntityCoords(ped))
                local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(ped)
                local pitch = GetGameplayCamRelativePitch()
                local dx = -math.sin(math.rad(heading))
                local dy = math.cos(math.rad(heading))
                local dz = math.sin(math.rad(pitch))
                local speed = noclip_speed

                if IsControlPressed(0, 21) then speed = speed * 2 end -- SHIFT
                if IsControlPressed(0, 19) then speed = speed * 0.5 end -- ALT
                
                if IsControlPressed(0, 32) then -- W
                    x = x + dx * speed
                    y = y + dy * speed
                    z = z + dz * speed
                end
                if IsControlPressed(0, 8) then -- S
                    x = x - dx * speed
                    y = y - dy * speed
                    z = z - dz * speed
                end
                if IsControlPressed(0, 34) then -- A
                    x = x + dy * speed
                    y = y - dx * speed
                end
                if IsControlPressed(0, 9) then -- D
                    x = x - dy * speed
                    y = y + dx * speed
                end
                if IsControlPressed(0, 22) then z = z + speed end -- SPACE
                if IsControlPressed(0, 36) then z = z - speed end -- CTRL
                
                if IsControlJustPressed(0, 168) then
                    local visible = IsEntityVisible(ped)
                    SetEntityVisible(ped, not visible, false)
                end
                
                SetEntityCoordsNoOffset(ped, x, y, z, true, true, true)
            end
        end)
    else
        noclip = false
        local ped = PlayerPedId()
        
        FreezeEntityPosition(ped, false)
        SetEntityInvincible(ped, false)
        SetEntityVisible(ped, true, false)
        SetEntityCollision(ped, true, true)
    end
end

function cRP.noClip()
    noClip()
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- [ DEBUG ]  WolfZeraWZR
-----------------------------------------------------------------------------------------------------------------------------------------
local dickheaddebug = false


local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

RegisterNetEvent("ToggleDebug")
AddEventHandler("ToggleDebug",function()
	dickheaddebug = not dickheaddebug
    if dickheaddebug then
        TriggerEvent('chatMessage',"DEBUG",{255,70,50},"ON")
        debugon()
    else
        TriggerEvent('chatMessage',"DEBUG",{255,70,50},"OFF")
    end
end)

local inFreeze = false

function GetVehicle()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstVehicle()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
	    	else
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
	    	end
        end
        success, ped = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return rped
end

function GetObject()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstObject()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if distance < 10.0 then
            distanceFrom = distance
            rped = ped
            --FreezeEntityPosition(ped, inFreeze)
	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
	    	else
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
	    	end
        end
        success, ped = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    return rped
end

function getNPC()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped

	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) .. " IN CONTACT" )
	    	else
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) )
	    	end

            FreezeEntityPosition(ped, inFreeze)
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

function canPedBeUsed(ped)
    if ped == nil then
        return false
    end
    if ped == GetPlayerPed(-1) then
        return false
    end
    if not DoesEntityExist(ped) then
        return false
    end
    return true
end

function debugon()
Citizen.CreateThread( function()
    while true do
        Citizen.Wait(1)
        
        if dickheaddebug then
            local pos = GetEntityCoords(GetPlayerPed(-1))

            local forPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 1.0, 0.0)
            local backPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -1.0, 0.0)
            local LPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 1.0, 0.0, 0.0)
            local RPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -1.0, 0.0, 0.0) 

            local forPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 2.0, 0.0)
            local backPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -2.0, 0.0)
            local LPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 2.0, 0.0, 0.0)
            local RPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -2.0, 0.0, 0.0)    

            local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
            local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
            currentStreetName = GetStreetNameFromHashKey(currentStreetHash)

            drawTxtS(0.8, 0.50, 0.4,0.4,0.30, "Heading: " .. GetEntityHeading(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.52, 0.4,0.4,0.30, "Coords: " .. pos, 55, 155, 55, 255)
            drawTxtS(0.8, 0.54, 0.4,0.4,0.30, "Attached Ent: " .. GetEntityAttachedTo(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.56, 0.4,0.4,0.30, "Health: " .. GetEntityHealth(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.58, 0.4,0.4,0.30, "H a G: " .. GetEntityHeightAboveGround(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.60, 0.4,0.4,0.30, "Model: " .. GetEntityModel(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.62, 0.4,0.4,0.30, "Speed: " .. GetEntitySpeed(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.64, 0.4,0.4,0.30, "Frame Time: " .. GetFrameTime(), 55, 155, 55, 255)
            drawTxtS(0.8, 0.66, 0.4,0.4,0.30, "Street: " .. currentStreetName, 55, 155, 55, 255)
            
            
            DrawLine(pos,forPos, 255,0,0,115)
            DrawLine(pos,backPos, 255,0,0,115)

            DrawLine(pos,LPos, 255,255,0,115)
            DrawLine(pos,RPos, 255,255,0,115)

            DrawLine(forPos,forPos2, 255,0,255,115)
            DrawLine(backPos,backPos2, 255,0,255,115)

            DrawLine(LPos,LPos2, 255,255,255,115)
            DrawLine(RPos,RPos2, 255,255,255,115)

            local nearped = getNPC()

            local veh = GetVehicle()

            local nearobj = GetObject()

            if IsControlJustReleased(0, 38) then
                if inFreeze then
                    inFreeze = false
                    TriggerEvent("Notify","amarelo","Freeze ON.",5000)
                else
                    inFreeze = true
                    TriggerEvent("Notify","amarelo","Freeze OFF.",5000)
                end
            end
        else
            Citizen.Wait(5000)
        end
    end
end)
end

Citizen.CreateThread(function()
    while true do
        local msec = 400
        if not emservico then
            local ped = PlayerPedId()
                local x,y,z = table.unpack(GetEntityCoords(ped))
                local distance = #(GetEntityCoords(ped) - vec3(179.61,-990.61,30.09))
                if distance <= 20 then
                    msec = 3

                    if not HasStreamedTextureDictLoaded("blip3d") then
                        RequestStreamedTextureDict("blip3d", true)
                        while not HasStreamedTextureDictLoaded("blip3d") do
                            Wait(1)
                        end
                        else
                        DrawMarker(9, 179.61,-990.61,30.09,0,0,0,90.0,0.0,0,0.6,0.6,0,255, 255, 255, 255,false, true, 1, false, "blip3d", "pvp_blip", false)
                    end

                    if distance <= 1.2 then
                        msec = 3
                        if IsControlJustPressed(0,38) then
                  
                           ExecuteCommand("lategame")
                        end
                    end
                end
        end
        Wait(msec)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxtS(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.25, 0.25)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLOCAR FOGO - COMANDO OWNER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('FOGO')
AddEventHandler('FOGO',function(source)
    local ped = PlayerPedId(-1)
    if not kravinho then
        kravinho = true
        Citizen.Wait(100)
        StartEntityFire(ped);
    else
        kravinho = false
        StopEntityFire(ped);
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTONCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do
-- 		if IsControlJustPressed(1,38) then
-- 			vSERVER.buttonTxt()
-- 		end
-- 		Citizen.Wait(1)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTONMAKERACE
-----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do
-- 		if IsControlJustPressed(1,38) then
-- 			local ped = PlayerPedId()
-- 			local vehicle = GetVehiclePedIsUsing(ped)
-- 			local vehCoords = GetEntityCoords(vehicle)
-- 			local leftCoords = GetOffsetFromEntityInWorldCoords(vehicle,5.0,0.0,0.0)
-- 			local rightCoords = GetOffsetFromEntityInWorldCoords(vehicle,-5.0,0.0,0.0)

-- 			vSERVER.raceCoords(vehCoords,leftCoords,rightCoords)
-- 		end

-- 		Citizen.Wait(1)
-- 	end
-- end)

local blips = {}
RegisterNetEvent('notificacaoavisopd')
AddEventHandler('notificacaoavisopd',function(x,y,z,user_id)
   if not DoesBlipExist(blips[user_id]) then
       blips[user_id] = AddBlipForCoord(x,y,z)
       SetBlipScale(blips[user_id],0.5)
       SetBlipSprite(blips[user_id],161)
       SetBlipColour(blips[user_id],5)
       BeginTextCommandSetBlipName("STRING")
       AddTextComponentString("Atividade criminosa")
       EndTextCommandSetBlipName(blips[user_id])
       SetBlipAsShortRange(blips[user_id],false)
       SetTimeout(5*60000,function()
           if DoesBlipExist(blips[user_id]) then
               RemoveBlip(blips[user_id])
           end
       end)
   end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = false
local verSafe = false

local Safezone = {
	["1"] = {
		["Praca"] = PolyZone:Create({
			vector2(205.79,-1024.9),
			vector2(208.78,-1025.24),
			vector2(211.59,-1023.95),
			vector2(213.45,-1021.75),
			vector2(265.77,-877.37),
			vector2(265.96,-872.18),
			vector2(263.66,-867.45),
			vector2(260.59,-865.25),
			vector2(253.69,-862.65),
			vector2(250.3,-863.26),
			vector2(246.89,-864.0),
			vector2(196.15,-845.44),
			vector2(194.17,-843.28),
			vector2(191.79,-840.11),
			vector2(186.61,-840.59),
			vector2(183.84,-843.67),
			vector2(174.82,-866.8),
			vector2(169.77,-877.06),
			vector2(162.94,-886.97),
			vector2(159.76,-893.61),
			vector2(126.22,-985.71),
			vector2(126.45,-990.34),
			vector2(129.62,-993.36),
			vector2(152.5,-1001.3),
			vector2(155.39,-1006.91),
			vector2(157.51,-1008.65),
			vector2(162.7,-1010.22),
			vector2(169.57,-1007.15),
			vector2(192.45,-1014.76),
			vector2(195.25,-1020.51),
			vector2(198.78,-1022.51)
		},{
			["name"] = "Praca",
			["minZ"] = 0.00,
			["maxZ"] = 150.00
			--debugPoly = true
		}),

		["Pier"] = PolyZone:Create({
			vector2(-1748.21,-1110.43),
			vector2(-1675.66,-1172.74),
			vector2(-1573.42,-1050.75),
			vector2(-1516.5,-983.14),
			vector2(-1576.04,-931.02),
			vector2(-1643.45,-986.36)
		},{
			["name"] = "Pier",
			["minZ"] = 0,
			["maxZ"] = 150.00
			--debugPoly = true
		}),

		["Hospital"] = PolyZone:Create({
			vector2(1096.7,-1457.14),
			vector2(1238.47,-1460.13),
			vector2(1235.36,-1524.97),
			vector2(1152.69,-1630.56),
			vector2(1117.98,-1631.57),
			vector2(1095.57,-1534.78),
			vector2(1096.87,-1456.83),
		},{
			["name"] = "Hospital",
			["minZ"] = 0,
			["maxZ"] = 150
			-- debugPoly = false
		}),
		["Cafe"] = PolyZone:Create({
			vector2(-569.02,-1167.58),
            vector2(-623.18,-1167.4),
            vector2(-623.76,-1013.47),
            vector2(-618.56,-971.77),
            vector2(-557.51,-975.13),
            vector2(-559.55,-1123.78),
            vector2(-569.02,-1167.58),
		},{
			["name"] = "Cafe",
			["minZ"] = 0,
			["maxZ"] = 150
			--debugPoly = true
		}),
		["Spawn"] = PolyZone:Create({
			vector2(-1337.73,-1551.89),
            vector2(-1358.3,-1498.2),
            vector2(-1308.47,-1488.01),
            vector2(-1294.16,-1525.78),
            vector2(-1337.73,-1551.89),
		},{
			["name"] = "Spawn",
			["minZ"] = 0,
			["maxZ"] = 150,
			debugPoly = false
		}),		
		["Mecanica"] = PolyZone:Create({
			vector2(118.71,-2984.41),
            vector2(200.01,-2981.68),
            vector2(198.15,-3081.46),
            vector2(106.21,-3074.37),
            vector2(118.71,-2984.41),
		},{
			["name"] = "Mecanica",
			["minZ"] = 0,
			["maxZ"] = 150,
			debugPoly = false
		}),	
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSAFEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
local PermArma = false
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Index,v in pairs(Safezone) do
			if v["Praca"]:isPointInside(Coords) or v["Pier"]:isPointInside(Coords) or v["Hospital"]:isPointInside(Coords) or v["Cafe"]:isPointInside(Coords) or v["Spawn"]:isPointInside(Coords) or v["Mecanica"]:isPointInside(Coords) then
				if not Active then
					Active = Index
					NetworkSetFriendlyFireOption(false)
					LocalPlayer["state"]:set("SafeZone",true,true)
					--LocalPlayer["state"]["isLafyMuted"] = true
                    SetCurrentPedWeapon(Ped,GetHashKey("WEAPON_UNARMED"),true)
					TriggerEvent('hud:safezone',true)
					if vSERVER.CheckPermSafezone() then
						PermArma = true
					else
						PermArma = false
					end
				end
			else
				if Active then
					Active = false
					NetworkSetFriendlyFireOption(true)
					LocalPlayer["state"]:set("SafeZone",false,true)
					--LocalPlayer["state"]["isLafyMuted"] = false
					TriggerEvent('hud:safezone',false)
				end
			end
		end

		Wait(1000)
	end
end)

CreateThread(function()
	while true do
		local TimeDistance = 999
		if Active and not PermArma then
			TimeDistance = 1
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,68,true)
			DisableControlAction(0,69,true)
			DisableControlAction(0,70,true)
			--DisableControlAction(0,75,true)
			DisableControlAction(0,91,true)
			DisableControlAction(0,92,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,257,true)
			local Ped = PlayerPedId()
			DisablePlayerFiring(Ped,true)

			if GetSelectedPedWeapon(Ped) ~= GetHashKey("WEAPON_BAT") then
				SetCurrentPedWeapon(Ped,GetHashKey("WEAPON_UNARMED"),true)
			end
			
		end

		Wait(TimeDistance)
	end
end)




-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local localPeds = {}
local List = {

	{ -- Rota Alvejante
			Distance = 15,
			Coords = { -320.47,-747.4,28.02,340.16  },
			Model = "CS_GambozBaby",
			anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
		},

		{ -- Rota Alvejante
		Distance = 15,
		Coords = { 127.92,-3053.14,7.04,0.0  },
		Model = "ig_benny",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

	{ -- Rota Alvejante
	Distance = 15,
	Coords = { 148.03,-3018.68,7.11,269.3  },
	Model = "cs_beverly",
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
},

}

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadModel(Hash)
	if IsModelInCdimage(Hash) and IsModelValid(Hash) then
		RequestModel(Hash)
		while not HasModelLoaded(Hash) do
			RequestModel(Hash)
			Wait(1)
		end

		return true
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadAnim(Dict)
	local Time = 1000

	while not HasAnimDictLoaded(Dict) or Time < 0 do
		RequestAnimDict(Dict)
		Time = Time - 1
		Wait(1)
	end

	return true
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADLIST
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Number = 1,#List do
			local Distance = #(Coords - vec3(List[Number]["Coords"][1],List[Number]["Coords"][2],List[Number]["Coords"][3]))
			if Distance <= List[Number]["Distance"] then
				if not localPeds[Number] then
					if LoadModel(List[Number]["Model"]) then
						localPeds[Number] = CreatePed(4,List[Number]["Model"],List[Number]["Coords"][1],List[Number]["Coords"][2],List[Number]["Coords"][3] - 1,List[Number]["Coords"][4],false,false)
						SetPedArmour(localPeds[Number],99)
						SetEntityInvincible(localPeds[Number],true)
						FreezeEntityPosition(localPeds[Number],true)
						SetBlockingOfNonTemporaryEvents(localPeds[Number],true)

						SetModelAsNoLongerNeeded(List[Number]["Model"])

						if List[Number]["Model"] == "s_f_y_casino_01" then
							SetPedDefaultComponentVariation(localPeds[Number])
							SetPedComponentVariation(localPeds[Number],0,3,0,0)
							SetPedComponentVariation(localPeds[Number],1,0,0,0)
							SetPedComponentVariation(localPeds[Number],2,3,0,0)
							SetPedComponentVariation(localPeds[Number],3,0,1,0)
							SetPedComponentVariation(localPeds[Number],4,1,0,0)
							SetPedComponentVariation(localPeds[Number],6,1,0,0)
							SetPedComponentVariation(localPeds[Number],7,1,0,0)
							SetPedComponentVariation(localPeds[Number],8,0,0,0)
							SetPedComponentVariation(localPeds[Number],10,0,0,0)
							SetPedComponentVariation(localPeds[Number],11,0,0,0)
							SetPedPropIndex(localPeds[Number],1,0,0,false)
						end

						if List[Number]["anim"] ~= nil then
							if LoadAnim(List[Number]["anim"][1]) then
								TaskPlayAnim(localPeds[Number],List[Number]["anim"][1],List[Number]["anim"][2],8.0,8.0,-1,1,0,0,0,0)
							end
						end
					end
				end
			else
				if localPeds[Number] then
					if DoesEntityExist(localPeds[Number]) then
						DeleteEntity(localPeds[Number])
					end

					localPeds[Number] = nil
				end
			end
		end

		Wait(1000)
	end
end)