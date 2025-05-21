--------------------------------
-- [ CONEXAO ] --
--------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("wnPresente",src)
vSERVER = Tunnel.getInterface("wnPresente")

local urlImg = "nui://wnInventory/nui/imgs"

RegisterNetEvent('wnPresente:Abrir')
AddEventHandler('wnPresente:Abrir',function()
    if not nui_open then
		local item = vSERVER.ReceberItem(1)
		local nome,index = vSERVER.GetInfosItem(item)
		SetNuiFocus(true,true)
		SetCursorLocation(0.5, 0.5)
		StartScreenEffect("MenuMGSelectionIn", 0, true)
		SendNUIMessage({ action = "showMenu", nome = nome, index = index, urlImg = urlImg }) 
	end
end)

RegisterNetEvent('wnPresente2:Abrir')
AddEventHandler('wnPresente2:Abrir',function()
    if not nui_open then
		local item = vSERVER.ReceberItem(2)
		local nome,index = vSERVER.GetInfosItem(item)
		SetNuiFocus(true,true)
		SetCursorLocation(0.5, 0.5)
		StartScreenEffect("MenuMGSelectionIn", 0, true)
		SendNUIMessage({ action = "showMenu", nome = nome, index = index, urlImg = urlImg }) 
	end
end)

RegisterNUICallback("close",function(data)
	vRP._DeletarObjeto(source)
	vRP._stopAnim(false)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	StopScreenEffect("MenuMGSelectionIn")
	nui_open = false
end)
