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
	if css == "sucesso" then
		textn = "Sucesso"
	end
	if css == "Sucesso" then
		textn = "Sucesso"
	end
	if css == "staff" then
		textn = "prefeitura"
	end
	if css == "vermelho" then
		textn = "negado"
	end
	if css == "negado" then
		textn = "negado"
	end
	if css == "azul" then
		textn = "importante"
	end
	if css == "importante" then
		textn = "importante"
	end
	if css == "amarelo" then
		textn = "AVISO"
	end
	if css == "aviso" then
		textn = "AVISO"
	end
	if css == "policia" then
		textn = "policia"
	end
	if css == "blood" then
		textn = "Sangramento"
	end
	if css == "hunger" then
		textn = "FOME"
	end
	if css == "thirst" then
		textn = "SEDE"
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