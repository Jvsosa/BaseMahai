Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local blips = false
local menuOpen = false
local inService = false

local rotainiciada = false

vSERVER = Tunnel.getInterface(GetCurrentResourceName())

RegisterNetEvent('wnRoutes:Abrir')
AddEventHandler('wnRoutes:Abrir',function()
    local t = 1000
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
    for k,v in pairs(Config.Rotas) do
        if Vdist(x, y, z, v.blip_iniciar['x'],v.blip_iniciar['y'],v.blip_iniciar['z']) <= 5.5 then
            if vSERVER.checkPermission(v.permissao) and not rotainiciada then
                if k == "mecanicokid" then
                   
                end
                SetNuiFocus(true,true)
                vSERVER.Lista_Itens(k)
                SetCursorLocation(0.5, 0.5)
                StartScreenEffect("MenuMGSelectionIn", 0, true)
                SendNUIMessage({ action = "showMenu" })
            else
                TriggerEvent("Notify","negado","Você não tem acesso a essa rota!")
            end
        end
    end
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	for k,v in pairs(Config.Rotas) do
        if k == "mecanicokid" then
            exports["target"]:AddCircleZone("Routes:"..k,vec3(v.blip_iniciar['x'],v.blip_iniciar['y'],v.blip_iniciar['z']),0.50,{
                name = "Routes:"..k,
                heading = 3374176
            },{
                distance = 3.0,
                options = {
                    {
                        event = "wnRoutes:Abrir",
                        label = "Abrir",
                        tunnel = "client"
                    }
                }
            })
        else
            exports["target"]:AddCircleZone("Routes:"..k,vec3(v.blip_iniciar['x'],v.blip_iniciar['y'],v.blip_iniciar['z']),0.75,{
                name = "Routes:"..k,
                heading = 3374176
            },{
                distance = 3.0,
                options = {
                    {
                        event = "wnRoutes:Abrir",
                        label = "Abrir",
                        tunnel = "client"
                    }
                }
            })
        end
	end
end)

RegisterNUICallback("shopClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
    StopScreenEffect("MenuMGSelectionIn")
	menuOpen = false
end)

RegisterNUICallback("itensList",function(data,cb,imgperfil)
	local playersregistrados = vSERVER.PlayersContratadosList()
	if playersregistrados then
		cb({ playersregistrados = playersregistrados})
	end
end)

pontos_total = 0

RegisterNUICallback("iniciarrota",function(data)	
	local ped = PlayerPedId()
    rotainiciada = true
	SetNuiFocus(false,false)
    StopScreenEffect("MenuMGSelectionIn")
	SendNUIMessage({ action = "hideMenu" })
    Wait(1000)
    SendNUIMessage({ action = "f7" })
	menuOpen = false
	for k,v in pairs(Config.Rotas) do
		local distance = #(GetEntityCoords(PlayerPedId()) - vector3(v.blip_iniciar['x'],v.blip_iniciar['y'],v.blip_iniciar['z']))
		if distance <= 3 then
            inService = true
            pontos_total = #v.locs
            IniciarRotas(data.item,v.locs,v.permissao,k)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local timings = 1000
		if inService then
			timings = 5
			if IsControlJustPressed(0,168) then
                inService = false
                inJob = false
				RemoveBlip(blips)
                Wait(1000)
                rotainiciada = false
                SendNUIMessage({ action = "f7fechar" })
			end
		end
		Citizen.Wait(timings)
	end
end)

function CriandoBlip(locs,selecionado)
    blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
    SetBlipSprite(blips,11)
    SetBlipColour(blips,6)
    SetBlipScale(blips,0.6)
    SetBlipAsShortRange(blips,false)
    SetBlipRoute(blips,true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Rota")
    EndTextCommandSetBlipName(blips)
end

function IniciarRotas(item,andress,perm,rank)
    local random = 1
    CriandoBlip(andress,random)
    while true do
        local sleep = 1000
        if inService then
            local ped = PlayerPedId()
            local distance = #(GetEntityCoords(ped) - vector3(andress[random].x,andress[random].y,andress[random].z))
       
            if distance <= 5.0 then
                sleep = 2
                DrawMarker(42, andress[random].x,andress[random].y,andress[random].z-0.6,0,0,0,0,0,0,0.2,0.2,0.3,  255, 255,255,100 ,false,0,0,1)
                DrawMarker(27, andress[random].x,andress[random].y,andress[random].z-0.7,0,0,0,0,0,0,0.4,0.4,0.5, 255, 255,255,100 ,false,0,0,1)
                DrawMarker(1, andress[random].x,andress[random].y,andress[random].z-1,0,0,0,0,0,0,0.4,0.4,0.4, 255, 79, 79,100 ,false,0,0,1)
                if distance <= 1.5 and IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then
                    if vSERVER.checkPayment(item,rank) then
        
      

                        if random == pontos_total then
                            random = 1
                            RemoveBlip(blips)
                            CriandoBlip(andress,random)
                        else
                            random = random + 1
                            RemoveBlip(blips)
                            CriandoBlip(andress,random)
            
                        end
                        vRP.playAnim(true,{"pickup_object","pickup_low"},true)
                        Wait(1500)
                        vRP.stopAnim(false)
         
                    end
                end
            end
        end
        Wait(sleep)
        if not inService then
            break
        end
    end
end