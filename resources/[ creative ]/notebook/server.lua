--------------------------------
-- [ CONEXAO ] --
--------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("notebook",src)
vCLIENT = Tunnel.getInterface("notebook")

src.Perm = function()
	local user_id = vRP.getUserId(source)
	if user_id == 884 or user_id == 1425 or user_id == 1 or user_id == 905 or user_id == 2320 then
		return true
    else
        return false
	end
end
