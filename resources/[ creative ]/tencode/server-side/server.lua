-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("tencode",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local codes = {
	[10] = {
		text = "Confronto em andamento",
		blip = 6,
		criminal = "Teve varios disparo esta tendo um confronto.",
		imagem = "confronto",
	},
	[13] = {
		text = "Oficial ferido",
		blip = 1,
		criminal = "Um Oficial foi baleado va ate o local e ajude.",
		imagem = "ferido",
	},
	[20] = {
		text = "Localização",
		blip = 38,
		criminal = "Um oficial enviou localização.",
		imagem = "locs",
	},
	[32] = {
		text = "Homem armado",
		blip = 83,
		criminal = "Verifique o local.",
		imagem = "outros",
	},
	[38] = {
		text = "Parando veículo suspeito",
		blip = 61,
		criminal = "Verifique o local.",
		imagem = "outros",
	},
	[50] = {
		text = "Acidente de trânsito",
		blip = 77,
		criminal = "Verifique o local.",
		imagem = "outros",
	},
	[78] = {
		text = "Reforço solicitado",
		blip = 4,
		criminal = "Um oficial precisa de reforco, va ate o local.",
		imagem = "reforco",
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDCODE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.sendCode(code)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)
		local identity = vRP.userIdentity(user_id)
		local policeResult = vRP.numPermission("Police")

		for k,v in pairs(policeResult) do
			async(function()
				if code ~= 13 then
					vRPC.playSound(v,"Event_Start_Text","GTAO_FM_Events_Soundset")
				end
				TriggerClientEvent("NotifyPush",v,{ code = code, imagem = codes[parseInt(code)]["imagem"], title = codes[parseInt(code)]["text"], criminal = codes[parseInt(code)]["criminal"], x = coords["x"], y = coords["y"], z = coords["z"], name = identity["name"].." "..identity["name2"], time = os.date("%H:%M"), blipColor = codes[parseInt(code)]["blip"] })
			end)
		end
	end
end