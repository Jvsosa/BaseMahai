--------------------------------
-- [ CONEXAO ] --
--------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("wnCardapio",src)
vCLIENT = Tunnel.getInterface("wnCardapio")
Config = module(GetCurrentResourceName(), "cfg/config")



src.consultCarros = function(ConceNumber,Lista)
    local source = source
    local user_id = vRP.getUserId(source)
    listCardapio = {}
    if user_id then
        for k,v in pairs(Config.Comidas[ConceNumber][Lista]) do
            table.insert(listCardapio,{index = itemIndex(k), valor = parseFormat(v.valor), nome = itemName(k) })
        end
    end
end

src.consultCarrosList = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return listCardapio
    end
end


