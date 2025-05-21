--------------------------------
-- [ CONEXAO ] --
--------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("wnCrafting",src)
vSERVER = Tunnel.getInterface("wnCrafting")

--------------------------------
-- [ VARIAVEL ] --
--------------------------------

local nui_open = false
local mesadecraft = "Nenhuma"
local itemver = "Nenhuma"

--------------------------------
-- [ COMANDOS ] --
--------------------------------

RegisterNetEvent('wnCrafting:Abrir')
AddEventHandler('wnCrafting:Abrir',function()
    local t = 1000
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
    for k,v in pairs(Config.Craft) do
        if Vdist(x, y, z, v.blip['x'],v.blip['y'],v.blip['z']) <= 5.5 then
            if vSERVER.checkPermission(v.permissao) then
				itemver = "Nenhuma"
				mesadecraft = k
                SetNuiFocus(true,true)
                SetCursorLocation(0.5, 0.5)
                StartScreenEffect("MenuMGSelectionIn", 0, true)
                SendNUIMessage({ action = "showMenu", k = k })
            else
                TriggerEvent("Notify","negado","Você não tem acesso a essa mesa!")
            end
        end
    end
end)

RegisterNetEvent('crafting:fuelShop')
AddEventHandler('crafting:fuelShop',function()
    local t = 1000
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
	SetNuiFocus(true,true)
	SetCursorLocation(0.5, 0.5)
	StartScreenEffect("MenuMGSelectionIn", 0, true)
	mesadecraft = "Combustivel"
    SendNUIMessage({ action = "showMenu", k = "Combustivel" })
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	for k,v in pairs(Config.Craft) do
		exports["target"]:AddCircleZone("Craft:"..k,vec3(v.blip['x'],v.blip['y'],v.blip['z']),0.75,{
			name = "Craft:"..k,
			heading = 3374176
		},{
			distance = 3.0,
			options = {
				{
					event = "wnCrafting:Abrir",
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

-----------------------------------------------------------
-- wnCrafting Lista
-----------------------------------------------------------

RegisterNUICallback("CraftLista",function(data,cb,imgperfil)
	vSERVER.consultCrafts(mesadecraft)

	local consultCrafts = vSERVER.consultCraftsList()
	if consultCrafts then
		cb({ consultCrafts = consultCrafts })
	end
end)

RegisterNUICallback("VerCraft",function(data,cb,imgperfil)
	itemver = data.item
	criando = 0
	cb({retorno = 'done'})
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- COOLDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
local criando = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if criando > 0 then
			criando = criando - 1
			SendNUIMessage({ action = "attsegundos", criando = criando })
		end
	end
end)



RegisterNUICallback("CriarItem",function(data,cb,imgperfil)
	criando = Config.Craft[mesadecraft].crafts[itemver].tempo * data.qtd
	if parseInt(data.qtd) >= 1 then
		if vSERVER.CriarItem(mesadecraft,itemver,data.qtd) then
			cb({retorno = 'done' })
		else
			criando = 0
			TriggerEvent("Notify","azul","Voce nao tem os itens necessarios para esse <b>Craft</b>.",10000)
			cb({retorno = 'done'})
		end
	end
end)

-----------------------------------------------------------
-- wnCrafting Lista2
-----------------------------------------------------------

RegisterNUICallback("itensnecessarios",function(data,cb,imgperfil)
	vSERVER.consultReq(mesadecraft,itemver)
	local itensnecessarios = vSERVER.consultReqList()
	if itensnecessarios then
		cb({ itensnecessarios = itensnecessarios })
	end
end)
