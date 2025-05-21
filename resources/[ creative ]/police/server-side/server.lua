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
Tunnel.bindInterface("police",cRP)
vCLIENT = Tunnel.getInterface("police")
vTASKBAR = Tunnel.getInterface("taskbar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local prisonMarkers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local preset = {
	["mp_m_freemode_01"] = {
		["hat"] = { item = 0, texture = 0 }, --chapeu
		["pants"] = { item = 36, texture = 0 },  --calca
		["vest"] = { item = 0, texture = 0 }, --colete
		["bracelet"] = { item = -1, texture = 0 }, --pulseira
		["backpack"] = { item = 0, texture = 0 }, --mochila
		["decals"] = { item = 0, texture = 0 }, --adesivos
		["mask"] = { item = 0, texture = 0 }, --mascara
		["shoes"] = { item = 57, texture = 0 }, --sapatos
		["tshirt"] = { item = 15, texture = 0 }, --camisa
		["torso"] = { item = 438, texture = 0 }, --jaqueta
		["accessory"] = { item = 0, texture = 0 }, --acessorios
		["watch"] = { item = -1, texture = 0 }, --relogio 
		["arms"] = { item = 0, texture = 0 }, --maos
		["glass"] = { item = 0, texture = 0 }, --oculos
		["ear"] = { item = -1, texture = 0 } --brinco
	},
	["mp_f_freemode_01"] = {
		["hat"] = { item = 0, texture = 0 }, --chapeu
		["pants"] = { item = 41, texture = 0 },  --calca
		["vest"] = { item = 0, texture = 0 }, --colete
		["bracelet"] = { item = -1, texture = 0 }, --pulseira
		["backpack"] = { item = 0, texture = 0 }, --mochila
		["decals"] = { item = 0, texture = 0 }, --adesivos
		["mask"] = { item = 0, texture = 0 }, --mascara
		["shoes"] = { item = 88, texture = 0 }, --sapatos
		["tshirt"] = { item = 14, texture = 0 }, --camisa
		["torso"] = { item = 226, texture = 0 }, --jaqueta
		["accessory"] = { item = 0, texture = 0 }, --acessorios
		["watch"] = { item = -1, texture = 0 }, --relogio 
		["arms"] = { item = 185, texture = 0 }, --maos
		["glass"] = { item = 0, texture = 0 }, --oculos
		["ear"] = { item = -1, texture = 0 } --brinco
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:PRISONCLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:prisonClothes")
AddEventHandler("police:prisonClothes",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 then
		if vRP.hasGroup(user_id,"Police") then
			local mHash = vRP.modelPlayer(entity[1])
			if mHash == "mp_m_freemode_01" or mHash == "mp_f_freemode_01" then
				TriggerClientEvent("updateRoupas",entity[1],preset[mHash])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PTR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ptr', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local oficiais = vRP.getUsersByPermission("Police")
	local paramedicos = 0
	local oficiais_nomes = ""
    if user_id then
		for k,v in ipairs(oficiais) do
			local identity = vRP.getUserIdentity(parseInt(v))
			paramedicos = paramedicos + 1
		end
		TriggerClientEvent("Notify",source,"azul", "Atualmente <b>"..paramedicos.." Oficiais</b> em serviço.",5000)
		if parseInt(paramedicos) > 0 then
			TriggerClientEvent("Notify",source,"azul", oficiais_nomes)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ems', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local oficiais = vRP.getUsersByPermission("Paramedic")
	local paramedicos = 0
	local oficiais_nomes = ""
    if user_id then
		for k,v in ipairs(oficiais) do
			local identity = vRP.getUserIdentity(parseInt(v))
			paramedicos = paramedicos + 1
		end
		TriggerClientEvent("Notify",source,"azul", "Atualmente <b>"..paramedicos.." Paramedicos</b> em serviço.",5000)
		if parseInt(paramedicos) > 0 then
			TriggerClientEvent("Notify",source,"azul", oficiais_nomes)
		end
	end
end)




-----------------------------------------------------------------------------------------------------------------------------------------
-- MECHANIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mec', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local oficiais = vRP.getUsersByPermission("Mechanic")
	local paramedicos = 0
	local oficiais_nomes = ""
    if user_id then
		for k,v in ipairs(oficiais) do
			local identity = vRP.getUserIdentity(parseInt(v))
			paramedicos = paramedicos + 1
		end
		TriggerClientEvent("Notify",source,"azul", "Atualmente <b>"..paramedicos.." Mecanicos</b> em serviço.",5000)
		if parseInt(paramedicos) > 0 then
			TriggerClientEvent("Notify",source,"azul", oficiais_nomes)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANREC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cleanrec",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		if vRP.hasPermission(user_id,"setState") then
			local nuser_id = parseInt(args[1])
			if nuser_id > 0 then
				vRP.execute("prison/cleanRecords",{ nuser_id = nuser_id })
				TriggerClientEvent("Notify",source,"verde","Limpeza efetuada.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initPrison(nuser_id,services,fines,text)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if actived[user_id] == nil then
			actived[user_id] = true

			local identity = vRP.userIdentity(user_id)
			if identity then
				local otherPlayer = vRP.userSource(nuser_id)
				if otherPlayer then
					vCLIENT.syncPrison(otherPlayer,true,false)
					TriggerClientEvent("radio:outServers",otherPlayer)
				end

				vRP.execute("prison/insertPrison",{ police = identity["name"].." "..identity["name2"], nuser_id = parseInt(nuser_id), services = services, fines = fines, text = text, date = os.date("%d/%m/%Y").." ás "..os.date("%H:%M") })
				vRPC.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
				TriggerClientEvent("Notify",source,"verde","Prisão efetuada.",5000)
				TriggerClientEvent("police:Update",source,"reloadPrison")
				vRP.initPrison(nuser_id,services)

				if fines > 0 then
					vRP.addFines(nuser_id,fines*0.3)
				end

				TriggerEvent("discordLogs","Police","**Por:** "..parseFormat(user_id).."\n**Passaporte:** "..parseFormat(nuser_id).."\n**Serviços:** "..parseFormat(services).."\n**Multa:** $"..parseFormat(fines).."\n**Horário:** "..os.date("%H:%M:%S").."\n**Motivo:** "..text,13541152)
			end

			actived[user_id] = nil
		end
	end
end

RegisterCommand('padv', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Admin") then
		local identity = vRP.userIdentity(user_id)
		if identity then
			local nuser_id = parseInt(args[1])
			local otherPlayer = vRP.userSource(nuser_id)
			if otherPlayer then
				vCLIENT.syncPrison(otherPlayer,true,false)
				TriggerClientEvent("radio:outServers",otherPlayer)
			end

			vRP.execute("prison/insertPrison",{ police = identity["name"].." "..identity["name2"], nuser_id = parseInt(nuser_id), services = parseInt(args[2]), fines = 0, text = "Advertencia", date = os.date("%d/%m/%Y").." ás "..os.date("%H:%M") })
			vRPC.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
			TriggerClientEvent("Notify",source,"verde","Prisão efetuada.",5000)
			TriggerClientEvent("police:Update",source,"reloadPrison")
			vRP.initPrison(nuser_id,parseInt(args[2]))
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHUSER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchUser(nuser_id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local nuser_id = parseInt(nuser_id)
		local identity = vRP.userIdentity(nuser_id)
		if identity then
			local fines = vRP.getFines(nuser_id)
			local records = vRP.query("prison/getRecords",{ nuser_id = parseInt(nuser_id) })

			return { true,identity["name"].." "..identity["name2"],identity["phone"],fines,records,identity["port"],identity["locate"] }
		end
	end

	return { false }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initFine(nuser_id,fines,text)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and fines > 0 then
		if actived[user_id] == nil then
			actived[user_id] = true

			TriggerEvent("discordLogs","Police","**Por:** "..parseFormat(user_id).."\n**Passaporte:** "..parseFormat(nuser_id).."\n**Multa:** $"..parseFormat(fines).."\n**Horário:** "..os.date("%H:%M:%S").."\n**Motivo:** "..text,2316674)
			TriggerClientEvent("Notify",source,"verde","Multa aplicada.",5000)
			TriggerClientEvent("police:Update",source,"reloadFine")
			vRP.addFines(nuser_id,fines*0.3)

			actived[user_id] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updatePort(nuser_id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local portStatus = "Desativado"
		local nuser_id = parseInt(nuser_id)
		local identity = vRP.userIdentity(nuser_id)

		if parseInt(identity["port"]) == 0 then
			portStatus = "Ativado"
			vRP.upgradePort(nuser_id,1)
		else
			vRP.upgradePort(nuser_id,0)
		end

		TriggerClientEvent("police:Update",source,"reloadSearch",parseInt(nuser_id))
		TriggerEvent("discordLogs","Police","**Por:** "..parseFormat(user_id).."\n**Passaporte:** "..parseFormat(nuser_id).."\n**Porte:** "..portStatus.."\n**Horário:** "..os.date("%H:%M:%S"),6303352)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISONSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(prisonMarkers) do
			if prisonMarkers[k][1] > 0 then
				prisonMarkers[k][1] = prisonMarkers[k][1] - 1

				if prisonMarkers[k][1] <= 0 then
					if vRP.userSource(prisonMarkers[k][2]) then
						TriggerEvent("blipsystem:serviceExit",k)
					end

					prisonMarkers[k] = nil
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISONITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local prisonItens = {
	{ ["item"] = "cigarette", ["min"] = 4, ["max"] = 8, ["perc"] = 100 },
	{ ["item"] = "cannedsoup", ["min"] = 1, ["max"] = 1, ["perc"] = 20 },
	{ ["item"] = "canofbeans", ["min"] = 1, ["max"] = 1, ["perc"] = 20 },
	{ ["item"] = "key", ["min"] = 1, ["max"] = 1, ["perc"] = 25 },
	{ ["item"] = "cotton", ["min"] = 1, ["max"] = 1, ["perc"] = 50 },
	{ ["item"] = "saline", ["min"] = 1, ["max"] = 1, ["perc"] = 50 },
	{ ["item"] = "sulfuric", ["min"] = 1, ["max"] = 1, ["perc"] = 50 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REDUCEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.reducePrison()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local randPercent = math.random(1000)
		local randItens = math.random(#prisonItens)
		local amountItens = math.random(prisonItens[randItens]["min"],prisonItens[randItens]["max"])

		if parseInt(randPercent) <= parseInt(prisonItens[randItens]["perc"]) then
			vRP.generateItem(user_id,prisonItens[randItens]["item"],amountItens,true)
		end

		vRP.updatePrison(user_id)

		local identity = vRP.userIdentity(user_id)
		if parseInt(identity["prison"]) <= 0 then
			vCLIENT.syncPrison(source,false,true)
		else
			vCLIENT.asyncServices(source)
			TriggerClientEvent("Notify",source,"azul","Restam <b>"..parseInt(identity["prison"]).." serviços</b>.",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKKEY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkKey()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policeResult = vRP.numPermission("Police")
		if parseInt(#policeResult) <= 5 then
			TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
			return false
		end

		local consultItem = vRP.getInventoryItemAmount(user_id,"key")
		if consultItem[1] > 0 then
			if not vRP.checkBroken(consultItem[2]) then
				if vRP.tryGetInventoryItem(user_id,consultItem[2],1,true) then
					vCLIENT.syncPrison(source,false,false)
					prisonMarkers[source] = { 600,user_id }
					vRP.execute("characters/fixPrison",{ user_id = user_id })

					for k,v in pairs(policeResult) do
						async(function()
							TriggerClientEvent("Notify",v,"amarelo","Recebemos a informação de um fugitivo da penitenciária.",5000)
						end)
					end

					TriggerEvent("blipsystem:serviceEnter",source,"Prisioneiro",48)

					return true
				end
			end
		end

		return false
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	local identity = vRP.userIdentity(user_id)
	if parseInt(identity["prison"]) > 0 then
		TriggerClientEvent("Notify",source,"azul","Restam <b>"..parseInt(identity["prison"]).." serviços</b>.",5000)
		vCLIENT.syncPrison(source,true,true)
	end
end)