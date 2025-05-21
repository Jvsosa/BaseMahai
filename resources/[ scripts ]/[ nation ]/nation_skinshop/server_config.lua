local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
fclient = Tunnel.getInterface("nation_skinshop")
func = {}
Tunnel.bindInterface("nation_skinshop", func)


---------------------------------------------------------------------------
-----------------------VERIFICAÇÃO DE PERMISSÃO--------------------------
---------------------------------------------------------------------------
function func.checkPermission(permission)
    local source = source
    local user_id = vRP.getUserId(source)
    if type(permission) == "table" then
        for i, perm in pairs(permission) do
            if vRP.hasPermission(user_id, perm) then
                return true
            end
        end
        return false
    end
    return vRP.hasPermission(user_id, permission)
end

---------------------------------------------------------------------------
-----------------------VERIFICAÇÃO DE PAGAMENTO--------------------------
---------------------------------------------------------------------------

-- function func.tryPayClothes(value)
--     local source = source
--     local user_id = vRP.getUserId(source)
--     if value >= 0 then
--         if vRP.withdrawCash(user_id, value) or vRP.paymentBank(user_id, value) or value == 0 then
--             return true
--         end
--     end
--     return false
-- end

--------- CREATIVE V5 ------------
function func.tryPayClothes(value)
    local source = source
    local user_id = vRP.getUserId(source)
    if value >= 0 then
        if vRP.paymentFull(user_id, value) or value == 0 then
            local clothes = fclient.getCloths(source)
            vRP.execute("playerdata/setUserdata",{ user_id = parseInt(user_id), key = "Clothings", value = json.encode(clothes) })
            return true
        end
    end
    return false
end

function func.updateClothes()
    local source = source
    local user_id = vRP.getUserId(source)
    local clothes = fclient.getCloths(source)
    vRP.execute("playerdata/setUserdata",{ user_id = parseInt(user_id), key = "Clothings", value = json.encode(clothes) })
end