-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("notify")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Shortcuts = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Notify")
AddEventHandler("Notify",function(css,mensagem,timer)
	if css == "verde" then
		textn = "sucesso"
	end
	if css == "vermelho" then
		textn = "negado"
	end
	if css == "blood" then
		textn = "Sangramento"
	end
	if css == "hunger" then
		textn = "FOME"
	end

	if css == "bennys" then
		textn = "BENNYS"
	end
	if css == "flamingo" then
		textn = "Flamingo"
	end
	if css == "runway" then
		textn = "Runway Entertainment"
	end
	if css == "sucesso" then
		textn = "Sucesso"
	end
	if css == "Sucesso" then
		textn = "Sucesso"
	end
	if css == "cafe" then
		textn = "Café UwU"
	end
	if css == "juridico" then
		textn = "Juridico"
	end
	if css == "festinha" then
		textn = "Festinha"
	end
	if css == "exercito" then
		textn = "Exército"
	end	
	if css == "thirst" then
		textn = "SEDE"
	end
	if css == "policia" then
		textn = "Policia"
	end
	if css == "staff" then
		textn = "Staff"
	end
	if css == "mec" then
		textn = "Mecanico"
	end
	if css == "hospital" then
		textn = "Hospital"
	end
	if css == "azul" then
		textn = "importante"
	end
	if css == "amarelo" then
		textn = "AVISO"
	end
	if css == "locked" or css == "unlocked" then
		textn = "GARAGEM"
	end
	if not timer then
		timer = 10000
	end
	SendNUIMessage({ css = css, mensagem = mensagem, timer = timer, notify = true, textn = textn })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOWSHORTCUTS
-----------------------------------------------------------------------------------------------------------------------------------------
function showShortcuts()
	if not Shortcuts then
		SendNUIMessage({ shortcuts = true, shorts = vSERVER.Shortcuts() })
		Shortcuts = true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HIDESHORTCUTS
-----------------------------------------------------------------------------------------------------------------------------------------
function hideShortcuts()
	SendNUIMessage({ shortcuts = false })
	Shortcuts = false
end



-----------------------------------------------------------------------------------------------------------------------------------------
-- HIDESHORTCUTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+shortcuts",showShortcuts)
RegisterCommand("-shortcuts",hideShortcuts)
RegisterKeyMapping("+shortcuts","Visualizar atalhos.","keyboard","TAB")