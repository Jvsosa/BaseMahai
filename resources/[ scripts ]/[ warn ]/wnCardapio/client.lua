--------------------------------
-- [ CONEXAO ] --
--------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("wnCardapio",src)
vSERVER = Tunnel.getInterface("wnCardapio")

local ConceNumber = 0
local CarroSelect = "null"
local myveh = {}

-- Citizen.CreateThread(function()
--     while true do
--         local t = 1000
--         local ped = PlayerPedId()
--         local x, y, z = table.unpack(GetEntityCoords(ped))
--         for k, v in pairs(Config.Bar) do
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


RegisterNetEvent('wnCardapio:Abrir')
AddEventHandler('wnCardapio:Abrir',function()
    local t = 1000
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
    for k,v in pairs(Config.Bar) do
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

RegisterNetEvent('wnCardapio2:Abrir')
AddEventHandler('wnCardapio2:Abrir',function()
    ConceNumber = 1
    SetNuiFocus(true,true)
    SetCursorLocation(0.5, 0.5)
    StartScreenEffect("MenuMGSelectionIn", 0, true)
    SendNUIMessage({ action = "showMenu" })
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	for k,v in pairs(Config.Bar) do
		exports["target"]:AddCircleZone("Cardapio:"..k,vec3(v.blip['x'],v.blip['y'],v.blip['z']),0.75,{
			name = "Cardapio:"..k,
			heading = 3374176
		},{
			distance = 3.0,
			options = {
				{
					event = "wnCardapio:Abrir",
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

RegisterNUICallback("consultCardapio",function(data,cb,imgperfil)
	vSERVER.consultCarros(ConceNumber,data.lista)
	local consultCarros = vSERVER.consultCarrosList()
	if consultCarros then
		cb({ consultCarros = consultCarros })
	end
end)
