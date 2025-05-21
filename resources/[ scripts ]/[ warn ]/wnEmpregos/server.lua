--------------------------------
-- [ CONEXAO ] --
--------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("wnEmpregos",src)
vCLIENT = Tunnel.getInterface("wnEmpregos")
Config = module(GetCurrentResourceName(), "cfg/config")

vRP._prepare("warn/empregos", [[
    CREATE TABLE IF NOT EXISTS empregos(
        user_id INTEGER,
		level INTEGER,
        exp INTEGER,
        PRIMARY KEY (`user_id`) USING BTREE
    )
]])

Citizen.CreateThread(function()
    vRP.execute("warn/empregos")
end)

vRP._prepare("wnInventory2/insert", "INSERT INTO inventario(user_id,imagem,banner) VALUES(@user_id,@imagem,@banner)")
vRP._prepare("wnInventory2/view", "SELECT * FROM inventario WHERE user_id = @user_id")

vRP._prepare("wnEmpregos/insert", "INSERT INTO empregos(user_id,level,exp) VALUES(@user_id,@level,@exp)")
vRP._prepare("wnEmpregos/view", "SELECT * FROM empregos WHERE user_id = @user_id")
vRP._prepare("wnEmpregos/updatexp", "UPDATE empregos SET exp = exp + @exp WHERE user_id = @user_id") 
vRP._prepare("wnEmpregos/update", "UPDATE empregos SET level = level, exp = @exp WHERE user_id = @user_id") 

vRP._prepare("wnInventory/jesterInstagram", "SELECT * FROM smartphone_instagram WHERE user_id = @user_id")

src.CheckImagePlayer = function(passaporte)
    local infos = vRP.query("wnInventory/jesterInstagram", {user_id = parseInt(passaporte)})
    if infos[1] then
        return infos[1].avatarURL
    else
        return "https://cdn.discordapp.com/attachments/452891038349262849/959382742624260136/unknown.png"
    end
end

src.Identidade = function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
        local identity = vRP.userIdentity(user_id)
        local carteira = vRP.getInventoryItemAmount(user_id,"dollars")
        local infos2 = vRP.query("wnEmpregos/view", {user_id = parseInt(user_id)})
        if infos2[1] then
            return parseFormat(carteira[1]),parseFormat(identity.bank),""..identity.name.." "..identity.name2.."",user_id,src.CheckImagePlayer(user_id),infos2[1].level,infos2[1].exp
        else
            vRP.query("wnEmpregos/insert", {user_id = parseInt(user_id),level = 1,exp = 0})
            local infos2 = vRP.query("wnEmpregos/view", {user_id = parseInt(user_id)})
            return parseFormat(carteira[1]),parseFormat(identity.bank),""..identity.name.." "..identity.name2.."",user_id,src.CheckImagePlayer(user_id),infos2[1].level,infos2[1].exp
        end
    end
end

src.checkLevel = function(emprego)
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
        return true
    end
end

src.Payment = function(emprego)
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
        local dinheiror = math.random(Config.Empregos[emprego].valorMin,Config.Empregos[emprego].valorMax)
        vRP.generateItem(user_id,"dollars",parseInt(dinheiror),true)
		TriggerClientEvent("Notify",source,"verde","Você recebeu <b>$"..parseFormat(parseInt(dinheiror)).." dólares</b>.")
        return dinheiror
	end
end

src.Payment2 = function(emprego)
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
        local dinheiror = math.random(4,6)
        if (vRP.inventoryWeight(user_id) + (itemWeight("materialreciclavel") * parseInt(dinheiror))) <= vRP.getWeight(user_id) then
            vRP.generateItem(user_id,"materialreciclavel",parseInt(dinheiror),true)
        else
            TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
        end
        return dinheiror
	end
end

src.Payment3 = function(emprego)
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		local randomItem = math.random(#Config.Frutas)
		selectItem = Config.Frutas[randomItem]
		amountItem = math.random(2,4)

        if (vRP.inventoryWeight(user_id) + (itemWeight(selectItem) * parseInt(amountItem))) <= vRP.getWeight(user_id) then
            vRP.generateItem(user_id,selectItem,amountItem,true)
            return amountItem
        else
            TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
        end
        return amountItem
	end
end


function src.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
        local consultItem = vRP.getInventoryItemAmount(user_id,"materialreciclavel")
		if vRP.tryGetInventoryItem(user_id,"materialreciclavel",consultItem[1]) then
			randmoney = math.random(40,65)
            vRP.generateItem(user_id,"dollars",parseInt(25*consultItem[1]),true)
			TriggerClientEvent("Notify",source,"verde","Você recebeu <b>$"..parseFormat(parseInt(randmoney*consultItem[1])).." dólares</b>.")
			return true
        else
            TriggerClientEvent("Notify",source,"vermelho","Voce precisa de <b>2x "..itemName('materialreciclavel').."</b>.")
		end
	end
end
