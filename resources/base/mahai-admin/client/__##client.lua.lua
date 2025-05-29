-----------------------------------------------------------------------------------------------------------------------------------------
-- 🚀 MAHAI CREATIVE - ADMIN CLIENT
-- Versão: 2.0 | Organizado e otimizado
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP TUNNELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

local cRP = {}
Tunnel.bindInterface("admin",cRP)
local vSERVER = Tunnel.getInterface("admin")

-----------------------------------------------------------------------------------------------------------------------------------------
-- OVERRIDES DE COMANDO
-----------------------------------------------------------------------------------------------------------------------------------------
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

-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIALIZAÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    Citizen.Wait(2000)  
    print("^2[ADMIN-CLIENT]^7 Sistema inicializado!")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES ADMIN BÁSICAS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getPosition()
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
    return x,y,z
end

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

-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT WAY
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
-- NOCLIP SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
local noclip = false
local noclip_speed = 1.0

function cRP.noClip()
    noclip = not noclip
    local ped = PlayerPedId()
    
    if noclip then
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetEntityVisible(ped, false, false)
        SetEntityCollision(ped, false, false)
        
        Citizen.CreateThread(function()
            while noclip do
                Citizen.Wait(1)
                
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped)
                local x, y, z = coords.x, coords.y, coords.z
                
                local speed = noclip_speed
                if IsControlPressed(0, 21) then speed = speed * 2 end -- SHIFT
                if IsControlPressed(0, 19) then speed = speed * 0.5 end -- ALT
                
                local cam_rot = GetGameplayCamRot(0)
                local cam_heading = math.rad(cam_rot.z)
                local cam_pitch = math.rad(cam_rot.x)
                
                local forward_x = -math.sin(cam_heading) * math.cos(cam_pitch)
                local forward_y = math.cos(cam_heading) * math.cos(cam_pitch)
                local forward_z = math.sin(cam_pitch)
                
                local right_x = math.cos(cam_heading)
                local right_y = math.sin(cam_heading)
                
                if IsControlPressed(0, 32) then -- W
                    x = x + forward_x * speed
                    y = y + forward_y * speed
                    z = z + forward_z * speed
                end
                if IsControlPressed(0, 8) then -- S
                    x = x - forward_x * speed
                    y = y - forward_y * speed
                    z = z - forward_z * speed
                end
                if IsControlPressed(0, 34) then -- A
                    x = x - right_x * speed
                    y = y - right_y * speed
                end
                if IsControlPressed(0, 9) then -- D
                    x = x + right_x * speed
                    y = y + right_y * speed
                end
                if IsControlPressed(0, 22) then -- SPACE
                    z = z + speed
                end
                if IsControlPressed(0, 36) then -- CTRL
                    z = z - speed
                end
                
                SetEntityCoordsNoOffset(ped, x, y, z, true, true, true)
            end
        end)
    else
        FreezeEntityPosition(ped, false)
        SetEntityInvincible(ped, false)
        SetEntityVisible(ped, true, false)
        SetEntityCollision(ped, true, true)
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CARRY PLAYER SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if not IsPedInAnyVehicle(PlayerPedId()) then
            if IsControlJustPressed(0,47) or IsControlJustPressed(0,74) then
                TriggerServerEvent("player:carryPlayeradm")
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
local dickheaddebug = false
local inFreeze = false

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

function debugon()
    Citizen.CreateThread(function()
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

                getNPC()
                GetVehicle()
                GetObject()

                if IsControlJustReleased(0, 38) then
                    inFreeze = not inFreeze
                    TriggerEvent("Notify","amarelo", inFreeze and "Freeze ON" or "Freeze OFF", 5000)
                end
            else
                Citizen.Wait(5000)
            end
        end
    end)
end

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
            local statusText = IsEntityTouchingEntity(GetPlayerPed(-1), ped) and " IN CONTACT" or ""
            DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. statusText)
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
            local statusText = IsEntityTouchingEntity(GetPlayerPed(-1), ped) and " IN CONTACT" or ""
            DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. statusText)
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
            local statusText = IsEntityTouchingEntity(GetPlayerPed(-1), ped) and " IN CONTACT" or ""
            DrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) .. statusText)
            FreezeEntityPosition(ped, inFreeze)
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

function canPedBeUsed(ped)
    return ped and ped ~= GetPlayerPed(-1) and DoesEntityExist(ped)
end

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
-- LATE GAME PVP SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
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
-- IMPOUND SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
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
-- FIRE SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
local kravinho = false

RegisterNetEvent('FOGO')
AddEventHandler('FOGO',function(source)
    local ped = PlayerPedId(-1)
    kravinho = not kravinho
    if kravinho then
        Citizen.Wait(100)
        StartEntityFire(ped)
    else
        StopEntityFire(ped)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFICATION SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
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
-- SAFEZONE SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = false
local PermArma = false

local Safezone = {
    ["1"] = {
        ["Praca"] = PolyZone:Create({
            vector2(205.79,-1024.9), vector2(208.78,-1025.24), vector2(211.59,-1023.95), vector2(213.45,-1021.75),
            vector2(265.77,-877.37), vector2(265.96,-872.18), vector2(263.66,-867.45), vector2(260.59,-865.25),
            vector2(253.69,-862.65), vector2(250.3,-863.26), vector2(246.89,-864.0), vector2(196.15,-845.44),
            vector2(194.17,-843.28), vector2(191.79,-840.11), vector2(186.61,-840.59), vector2(183.84,-843.67),
            vector2(174.82,-866.8), vector2(169.77,-877.06), vector2(162.94,-886.97), vector2(159.76,-893.61),
            vector2(126.22,-985.71), vector2(126.45,-990.34), vector2(129.62,-993.36), vector2(152.5,-1001.3),
            vector2(155.39,-1006.91), vector2(157.51,-1008.65), vector2(162.7,-1010.22), vector2(169.57,-1007.15),
            vector2(192.45,-1014.76), vector2(195.25,-1020.51), vector2(198.78,-1022.51)
        }, { name = "Praca", minZ = 0.00, maxZ = 150.00 }),

        ["Pier"] = PolyZone:Create({
            vector2(-1748.21,-1110.43), vector2(-1675.66,-1172.74), vector2(-1573.42,-1050.75),
            vector2(-1516.5,-983.14), vector2(-1576.04,-931.02), vector2(-1643.45,-986.36)
        }, { name = "Pier", minZ = 0, maxZ = 150.00 }),

        ["Hospital"] = PolyZone:Create({
            vector2(1096.7,-1457.14), vector2(1238.47,-1460.13), vector2(1235.36,-1524.97),
            vector2(1152.69,-1630.56), vector2(1117.98,-1631.57), vector2(1095.57,-1534.78), vector2(1096.87,-1456.83)
        }, { name = "Hospital", minZ = 0, maxZ = 150 }),

        ["Cafe"] = PolyZone:Create({
            vector2(-569.02,-1167.58), vector2(-623.18,-1167.4), vector2(-623.76,-1013.47),
            vector2(-618.56,-971.77), vector2(-557.51,-975.13), vector2(-559.55,-1123.78), vector2(-569.02,-1167.58)
        }, { name = "Cafe", minZ = 0, maxZ = 150 }),

        ["Spawn"] = PolyZone:Create({
            vector2(-1337.73,-1551.89), vector2(-1358.3,-1498.2), vector2(-1308.47,-1488.01),
            vector2(-1294.16,-1525.78), vector2(-1337.73,-1551.89)
        }, { name = "Spawn", minZ = 0, maxZ = 150 }),

        ["Mecanica"] = PolyZone:Create({
            vector2(118.71,-2984.41), vector2(200.01,-2981.68), vector2(198.15,-3081.46),
            vector2(106.21,-3074.37), vector2(118.71,-2984.41)
        }, { name = "Mecanica", minZ = 0, maxZ = 150 })
    }
}

CreateThread(function()
    while true do
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)

        for Index,v in pairs(Safezone) do
            local inSafeZone = v["Praca"]:isPointInside(Coords) or v["Pier"]:isPointInside(Coords) or 
                              v["Hospital"]:isPointInside(Coords) or v["Cafe"]:isPointInside(Coords) or 
                              v["Spawn"]:isPointInside(Coords) or v["Mecanica"]:isPointInside(Coords)
            
            if inSafeZone then
                if not Active then
                    Active = Index
                    NetworkSetFriendlyFireOption(false)
                    LocalPlayer["state"]:set("SafeZone",true,true)
                    SetCurrentPedWeapon(Ped,GetHashKey("WEAPON_UNARMED"),true)
                    TriggerEvent('hud:safezone',true)
                    PermArma = vSERVER.CheckPermSafezone() or false
                end
            else
                if Active then
                    Active = false
                    NetworkSetFriendlyFireOption(true)
                    LocalPlayer["state"]:set("SafeZone",false,true)
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
            local controls = {24,25,68,69,70,91,92,140,142,257}
            for _, control in pairs(controls) do
                DisableControlAction(0, control, true)
            end
            
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
-- NPC SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
local localPeds = {}
local List = {
    { Distance = 15, Coords = { -320.47,-747.4,28.02,340.16 }, Model = "CS_GambozBaby", anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" } },
    { Distance = 15, Coords = { 127.92,-3053.14,7.04,0.0 }, Model = "ig_benny", anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" } },
    { Distance = 15, Coords = { 148.03,-3018.68,7.11,269.3 }, Model = "cs_beverly", anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" } }
}

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

function LoadAnim(Dict)
    local Time = 1000
    while not HasAnimDictLoaded(Dict) or Time < 0 do
        RequestAnimDict(Dict)
        Time = Time - 1
        Wait(1)
    end
    return true
end

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
                            local variations = {{0,3,0,0},{1,0,0,0},{2,3,0,0},{3,0,1,0},{4,1,0,0},{6,1,0,0},{7,1,0,0},{8,0,0,0},{10,0,0,0},{11,0,0,0}}
                            for _, var in pairs(variations) do
                                SetPedComponentVariation(localPeds[Number], var[1], var[2], var[3], var[4])
                            end
                            SetPedPropIndex(localPeds[Number],1,0,0,false)
                        end

                        if List[Number]["anim"] then
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

-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLE ADMIN FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:vehicleTuning")
AddEventHandler("admin:vehicleTuning",function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsUsing(ped)
        SetVehicleModKit(vehicle,0)
        
        local mods = {11,12,13,15}
        for _, mod in pairs(mods) do
            SetVehicleMod(vehicle, mod, GetNumVehicleMods(vehicle,mod)-1, false)
        end
        
        SetVehicleModColor_1(vehicle,0,0,2)
        ToggleVehicleMod(vehicle,18,true)
    end
end)

RegisterNetEvent("admin:fixVehicle")
AddEventHandler("admin:fixVehicle", function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle and vehicle ~= 0 then
        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleUndriveable(vehicle, false)
        SetVehicleEngineOn(vehicle, true, true)
        SetVehicleDirtLevel(vehicle, 0.0)
        TriggerEvent("Notify", "verde", "Veículo reparado com sucesso!", 5000)
    else
        local coords = GetEntityCoords(ped)
        local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        
        if vehicle and vehicle ~= 0 then
            SetVehicleFixed(vehicle)
            SetVehicleDeformationFixed(vehicle)
            SetVehicleUndriveable(vehicle, false)
            SetVehicleEngineOn(vehicle, true, true)
            SetVehicleDirtLevel(vehicle, 0.0)
            TriggerEvent("Notify", "verde", "Veículo próximo reparado!", 5000)
        else
            TriggerEvent("Notify", "vermelho", "Nenhum veículo encontrado por perto.", 5000)
        end
    end
end)