local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
fclient = Tunnel.getInterface("nation_creator")
func = {}
Tunnel.bindInterface("nation_creator", func)


multiCharacter = true

---------------------------------------------------------------------------
-----------------------VERIFICAÇÃO DE PERMISSÃO--------------------------
---------------------------------------------------------------------------

if multiCharacter then
    vRP._prepare("nation_creator/createAgeColumn","ALTER TABLE characters ADD IF NOT EXISTS age INT(11) NOT NULL DEFAULT 20")
    vRP._prepare("nation_creator/update_user_first_spawn","UPDATE characters SET name2 = @name2, name = @name, age = @age WHERE id = @user_id")
    vRP._prepare("nation_creator/create_characters","INSERT INTO characters(steam,name,name2,phone,serial,blood) VALUES(@steam,@name,@name2,@phone,@serial,@blood)")
    vRP._prepare("nation_creator/remove_characters","UPDATE characters SET deleted = 1 WHERE id = @id")
    vRP._prepare("nation_creator/get_characters","SELECT * FROM characters WHERE steam = @steam and deleted = 0")
    vRP._prepare("nation_creator/get_character","SELECT * FROM characters WHERE steam = @steam and deleted = 0 and id = @user_id")
    CreateThread(function() vRP.execute("nation_creator/createAgeColumn") end)
else
    vRP._prepare("nation_creator/update_user_first_spawn","UPDATE characters SET name2 = @name2, name = @name, age = @age WHERE user_id = @user_id")
end

function func.checkPermission(permission, src)
    local source = src or source
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



function func.saveChar(name, lastName, age, char, id)
    local source = source
    local user_id = id or vRP.getUserId(source)
    if char then
        vRP.execute("playerdata/setUserdata",{ user_id = parseInt(user_id), key = "nation_char", value = json.encode(char,{indent=false}) })
    end
    if name and lastName and age then
        vRP.execute("nation_creator/update_user_first_spawn",{ user_id = user_id, name2 = lastName, name = name, age = age })
    end
    local discord = getPlayerDiscord(source)
    local getdiscord = vRP.getDiscordPlayer(user_id)
    if getdiscord then
        TriggerEvent("discordLogs","rename"," "..getdiscord.." "..user_id.." "..name.." "..lastName.."", 0)
    else
        print("^7[^1!^7] O Passaporte ^3"..user_id.."^7 nao tem discord ^3Vinculado^7")
    end
    TriggerClientEvent("nation_barbershop:init", source, char)
    vRP._updateSelectSkin(user_id, GetEntityModel(GetPlayerPed(source)))
    return true
end

function getUserChar(user_id, source, nation)
    local char
    local data = vRP.userData(user_id, "nation_char")
    if next(data) ~= nil then
        char = data
        char.gender = getGender(user_id) or char.gender
    elseif not nation then
        data = vRP.userData(user_id, "currentCharacterMode")
        if next(data) ~= nil then 
            local gender = "male"
            local char = data
            if char and char.gender and char.gender == 1 then
                gender = "female"
            else 
                gender = getGender(user_id) or "male"
            end
            char = fclient.setOldChar(source, char, getUserClothes(user_id), gender, user_id)
        end
    end
    return char
end

local userlogin = {}
function playerSpawn(user_id, source, first_spawn)
    if first_spawn then
        Wait(1000)
		processSpawnController(source,getUserChar(user_id, source),user_id)
	end
end

AddEventHandler("vRP:playerSpawn",playerSpawn)

function processSpawnController(source,char,user_id)
    getUserLastPosition(source, user_id)
	local source = source

	if char then
		if not userlogin[user_id] then
			userlogin[user_id] = true
			fclient._spawnPlayer(source,false)
		else
			fclient._spawnPlayer(source,true)
		end
        fclient.setPlayerChar(source, char, true)
        TriggerClientEvent("nation_barbershop:init", source, char)
        setPlayerTattoos(source, user_id)
        fclient._setClothing(source, getUserClothes(user_id))
	else
        userlogin[user_id] = true
        local data = vRP.userData(user_id, "currentCharacterMode")
        if next(data) ~= nil then
            local gender = "male"
            local char = data
            if char and char.gender and char.gender == 1 then
                gender = "female"
            else 
                gender = getGender(user_id)
            end
            fclient._spawnPlayer(source,false)
            fclient._setOldChar(source, char, getUserClothes(user_id), gender, user_id)
        else
		    fclient._startCreator(source)
        end
	end
end

function setPlayerTattoos(source, user_id)
    TriggerClientEvent("forcereloadtattos", source)
end

function func.setPlayerTattoos(id)
    local source = source
    local user_id = id or vRP.getUserId(source)
    if user_id then
        setPlayerTattoos(source, user_id)
    end
end

function getUserLastPosition(source, user_id)
    local coords = {402.76,-996.28,-99.00}
    local datatable = vRP.getDatatable(user_id)
    if datatable and datatable.position then
        local p = datatable.position
        coords = { p.x, p.y, p.z }
    else
        local data = vRP.userData(user_id, "Datatable")
        if next(data) ~= nil then
            local p = data.position
            coords = { p.x, p.y, p.z }
        end
    end
    fclient._setPlayerLastCoords(source, coords)
    return coords
end


function func.getUserLastPosition()
    local source = source
    local user_id = vRP.getUserId(source)
    getUserLastPosition(source, user_id)
end


function format(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end


function func.changeSession(session)
    local source = source
    SetPlayerRoutingBucket(source, session)
end

function func.updateLogin()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        userlogin[user_id] = true
        local char = getUserChar(user_id, source)
        if char then 
            TriggerClientEvent("nation_barbershop:init", source, char)
            setPlayerTattoos(source, user_id)
        end
    end
end

function func.getCharsInfo()
    local source = source
    local steam = getPlayerSteam(source)
    local data = vRP.query("nation_creator/get_characters",{ steam = steam })
    local info = { chars = {} }
    for k,v in ipairs(data) do
        local char = getUserChar(v.id, source) or {}
        local clothes = getUserClothes(v.id)
        local bank = vRP.userBank(v.id,"Private")
        local gender = "masculino"
        if char.gender and char.gender == "female" then
            gender = "feminino"
        elseif char.gender ~= "male" then
            gender = "outros"
        end
        info.chars[k] = {
            name = v.name.." "..v.name2, age = v.age.." anos", bank = "$ "..format(bank["value"]), clothes = clothes,
            registration = v.serial, phone = v.phone, user_id = v.id, id = "#"..v.id, gender = gender, char = char
        }
    end
    info.maxChars = getUserMaxChars(source) 
    return info
end

function getUserMaxChars(source)
    local steam = getPlayerSteam(source)
    local infoAccount = vRP.infoAccount(steam)
    
    if infoAccount then
        local amountCharacters = parseInt(infoAccount["chars"])

        if vRP.steamPremium(steam) then
            amountCharacters = amountCharacters + 1
        end

        return parseInt(amountCharacters)
    end

    return 1
end

function getUserClothes(user_id)
    local data = vRP.userData(user_id, "Clothings")
    if next(data) ~= nil then
        local clothes = data
        if clothes then
            return clothes
        end
    end
    data = vRP.userData(user_id, "vRP:datatable")
    if next(data) ~= nil then
        local datatable = data
        if datatable and datatable.customization then
            return datatable.customization
        end
    end
    local datatable = vRP.getDatatable(user_id) or {}
    return datatable.customization or {}
end

function getUserTattoos(user_id)
    local data = vRP.userData(user_id,"Tatuagens")
    if data and data ~= '' then
       local custom = data  
       return custom or {}
    end
    data = vRP.userData(user_id,"Tatuagens")
    if data and data ~= '' then
       local custom = data
       return custom or {}
    end
    return {}
end

function getGender(user_id)
    local datatable = vRP.getDatatable(user_id) or vRP.userData(user_id, "Datatable") or {}
    if type(datatable) == "table" then
        local model = datatable.skin or datatable.customization
        if model then
            if type(model) == "table" then
                model = model.modelhash or model.model
            end
            if model == GetHashKey("mp_m_freemode_01") then
                return "male"
            elseif model == GetHashKey("mp_f_freemode_01") then
                return "female"
            else
                return model
            end
        end
    end
end

function func.getOverlay()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local char = getUserChar(user_id, source, true)
        if char and char.overlay then
            return char.overlay
        end
    end
    return 0
end

vRP.prepare("nation_creator/getVehicleBooster", "SELECT * FROM vehicles WHERE user_id = @user_id AND vehicle = @vehicle")

function func.playChar(info)
    local source = source
    local steam = getPlayerSteam(source)
    local data = vRP.query("nation_creator/get_character",{ steam = steam, user_id = info.user_id })
    if #data > 0 then
        --TriggerEvent("baseModule:idLoaded",source,info.user_id,nil)
        vRP.characterChosen(source,info.user_id,nil)
        playerSpawn(info.user_id, source, true)
        local identity = vRP.userIdentity(info.user_id)
        local discord = getPlayerDiscord(source)
        TriggerClientEvent("tattoos:apply",source,vRP.userData(user_id,"Tatuagens"))
        TriggerClientEvent("wnGroups:checkEmpresa",source)
        TriggerClientEvent("corridas:VerCorridas",source)
        TriggerEvent("admin:CheckBan",source)
        local getdiscord = vRP.getDiscordPlayer(info.user_id)
        if parseInt(getdiscord) > 1 then
           --local discord_booster = exports['discord']:guildMemberBooster("1006315714677846056",""..parseInt(getdiscord).."")
            if not exports['discord']:guildMemberBooster("1006315714677846056",""..parseInt(getdiscord).."") then
                local carro_1 = vRP.query("nation_creator/getVehicleBooster",{ user_id = info.user_id, vehicle = "gxa45" })
                if carro_1[1] then
                    vRP.execute("vehicles/removeVehicles",{ user_id = info.user_id, vehicle = "gxa45", plate = vRP.generatePlate(), work = tostring(false) })
                    TriggerClientEvent("Notify",source,"discord","Seus beneficios booster terminaram foi retirado da sua garagem o <b>Carro Booster</b>.",10000)
                    print("^7[^1!^7] O ^3Carro Booster^7 do passaporte: ^3"..info.user_id.."^7 foi retirado com sucesso.")
                end
                local carro_2 = vRP.query("nation_creator/getVehicleBooster",{ user_id = info.user_id, vehicle = "babyhuracan" })
                if carro_2[1] then
                    vRP.execute("vehicles/removeVehicles",{ user_id = info.user_id, vehicle = "babyhuracan", plate = vRP.generatePlate(), work = tostring(false) })
                    TriggerClientEvent("Notify",source,"discord","Seus beneficios booster terminaram foi retirado da sua garagem o <b>Carro Booster</b>.",10000)
                    print("^7[^1!^7] O ^3Carro Booster^7 do passaporte: ^3"..info.user_id.."^7 foi retirado com sucesso.")
                end
            end
            if parseInt(getdiscord) then
                TriggerEvent("discordLogs","rename"," "..parseInt(getdiscord).." "..info.user_id.." "..identity.name.." "..identity.name2.."", 0)
            else
                print("^7[^1!^7] O Passaporte ^3"..info.user_id.."^7 nao tem discord ^3Vinculado^7")
            end
        end
    end
end

function func.tryDeleteChar(info)
    local source = source
    local steam = getPlayerSteam(source)
    local data = vRP.query("nation_creator/get_character",{ steam = steam, user_id = info.user_id })
    if #data > 0 then
        vRP._execute("nation_creator/remove_characters",{ id = info.user_id })
        return true, ""
    end
    return false, "error"
end

function func.tryCreateChar()
    local source = source
    local steam = getPlayerSteam(source)
    local data = vRP.query("nation_creator/get_characters",{ steam = steam })
    if #data < getUserMaxChars(source) then
        vRP.execute("nation_creator/create_characters",{ steam = steam, name = "", name2 = "", phone = vRP.generatePhone(), serial = vRP.generateSerial(), blood = math.random(4) })
        local myChars = vRP.query("nation_creator/get_characters",{ steam = steam })
        local user_id = myChars[#myChars].id
        --TriggerEvent("baseModule:idLoaded",source,user_id,"mp_m_freemode_01")
        vRP.characterChosen(source,user_id,"mp_m_freemode_01")
        return true
    end
end

function getPlayerSteam(source)
    local result = false
    local identifiers = GetPlayerIdentifiers(source)
	for _,v in pairs(identifiers) do
		if string.find(v,"steam") then
			local splitName = splitString(v,":")
			result = splitName[2]
			break
		end
	end
    return result
end

function getPlayerDiscord(source)
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
    if user_id and identity then
        return identity.discord
    end
end

RegisterCommand("bvida", function(source) -- setar as customizações dnv (tipo bvida)
    local user_id = vRP.getUserId(source)
    local char = getUserChar(user_id, source)
    if char then
        fclient._setPlayerChar(source, char, true)
        TriggerClientEvent("nation_barbershop:init", source, char)
        setPlayerTattoos(source, user_id)
        fclient._setClothing(source, getUserClothes(user_id))
    end
end)

RegisterCommand('resetchar',function(source, args) -- COMANDO DE ADMIN PARA RESETAR PERSONAGEM
    if func.checkPermission({"Admin"}, source) then
        if args[1] then 
            local id = tonumber(args[1])
            if id then
                local src = vRP.getUserSource(id)
                if src and vRP.request(source, "Deseja resetar o id "..id.." ?", 30) then
                    fclient._startCreator(src)
                end
            end
        elseif vRP.request(source, "Deseja resetar seu personagem ?", 30) then
            fclient._startCreator(source)
        end
    end
end)

RegisterCommand('spawn',function(source) -- COMANDO DE ADMIN PARA SIMULAR O SPAWN
    if func.checkPermission({"admin.permissao", "mod.permissao", "Admin"}, source) or not vRP.getUserId(source) then
        if multiCharacter then
            TriggerClientEvent("spawn:setupChars", source)
        else
            playerSpawn(vRP.getUserId(source), source, true)
        end
    end
end)