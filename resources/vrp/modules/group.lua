-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local permList = {}
local selfReturn = {}
permList["Taxi"] = {}
permList["Police"] = {}
permList["Runners"] = {}
permList["Mechanic"] = {}
permList["Paramedic"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local permissions = {

	
	["Dono"] = {
		["Dono"] = true,
		["Admin"] = true,
	},
	["Admin"] = {
		["Admin"] = true,
	},
	["Suporte"] = {
		["Suporte"] = true
	},
	["Moderator"] = {
		["Admin"] = true,
		["Moderator"] = true
	},
	["StreamerVip"] = {
		["StreamerVip"] = true,
	},
	["player.blips"] = {
		["Admin"] = true,
		["Moderator"] = true,
		["Suporte"] = true,
		["player.blips"] = true
	},
	["player.noclip"] = {
		["Admin"] = true,
		["Moderator"] = true,
		["Suporte"] = true,
		["player.noclip"] = true
	},
	["player.teleport"] = {
		["Admin"] = true,
		["Moderator"] = true,
		["Suporte"] = true,
		["player.teleport"] = true
	},
	["player.secret"] = {
		["Admin"] = true,
		["Moderator"] = true,
		["Suporte"] = true,
		["player.secret"] = true
	},
	["player.spec"] = {
		["Admin"] = true,
		["Moderator"] = true,
		["Suporte"] = true,
		["player.spec"] = true
	},
	["spec.permissao"] = {
		["Admin"] = true,
		["Moderator"] = true,
		["Suporte"] = true,
		["spec.permissao"] = true
	},
	["player.wall"] = {
		["Admin"] = true,
		["Moderator"] = true,
		["Suporte"] = true,
		["player.wall"] = true
	},
	["mqcu.permissao"] = {
		["Admin"] = true,
		["Moderator"] = true,
		["Suporte"] = true,
		["mqcu.permissao"] = true
	},
	

	["ClubAnitta"] = {
		["ClubAnitta"] = true,	
	},

	["Cupula"] = {
		["Cupula"] = true,	
	},

	
	["Noruega"] = {
		["Noruega"] = true,	
	},

	["Argentina"] = {
		["Argentina"] = true,	
	},

	["Gueto1"] = {
		["Gueto1"] = true,	
	},

	["Gueto2"] = {
		["Gueto2"] = true,	
	},

	["Fbi"] = {
		["Fbi"] = true,	
	},

	["Gueto3"] = {
		["Gueto3"] = true,	
	},
	
	["Flamingo"] = {
		["Flamingo"] = true,	
	},

	["MecanicaIlegal"] = {
		["MecanicaIlegal"] = true,	
	},

	["Escola"] = {
		["Escola"] = true,	
	},

	["Runway"] = {
		["Runway"] = true,	
	},

	["Anitta"] = {
		["Anitta"] = true,	
	},
	
	["Police"] = {
		["Police"] = true,	
	},

	["Exercito"] = {
		["Exercito"] = true,	
	},

	["Paramedic"] = {
		["Paramedic"] = true,
	},

	["Hospital"] = {
		["Hospital"] = true,
		["Paramedic"] = true,
	},

	["Paramedic"] = {
		["Paramedic"] = true,
	},
	
	["Mechanic"] = {
		["Mechanic"] = true,
	},

	["Juridico"] = {
		["Juridico"] = true,
	},
	
	["Weazel"] = {
		["Weazel"] = true,
	},	

	------------------------------
	-- Utilitarios
	------------------------------

	["cam"] = {
		["cam"] = true
	},	
	["roupas"] = {
		["roupas"] = true		
	},
	["spotify"] = {
		["spotify"] = true		
	},	
	["wecolor"] = {
		["wecolor"] = true		
	},	


	------------------------------
	-- Mansoes
	------------------------------

	["malibu"] = {
		["malibu"] = true
	},	
	["weston"] = {
		["weston"] = true		
	},

	------------------------------
	-- Vip
	------------------------------

	["vipsilver"] = {
		["vipsilver"] = true		
	},
	["vipgold"] = {
		["vipgold"] = true				
	},	
	["vipplatinum"] = {
		["vipplatinum"] = true				
	},
	["vipdiamond"] = {
		["vipdiamond"] = true				
	},
	["vipadvanced"] = {
		["vipadvanced"] = true				
	},
	["vipmaui"] = {
		["vipmaui"] = true
	},
	["vipkids"] = {
		["vipkids"] = true
	},
	["vipfac"] = {
		["vipfac"] = true
	},

	["Richers"] = {
		["Richers"] = true
	},


	["Cafe"] = {
		["Cafe"] = true,
	},

	------------------------------
	-- Cargos Ilegal
	------------------------------

	["Vanilla"] = {
		["Vanilla"] = true
	},

	["Bahamas"] = {
		["Bahamas"] = true
	},

	["Farol"] = {
		["Farol"] = true
	},

	["Beiramar"] = {
		["Beiramar"] = true
	},

	["Barragem"] = {
		["Barragem"] = true
	},

	["Mineradora"] = {
		["Mineradora"] = true
	},

	["Mafia1"] = {
		["Mafia1"] = true
	},

	["Mafia2"] = {
		["Mafia2"] = true
	},

	["Municao1"] = {
		["Municao1"] = true
	},

	["Municao2"] = {
		["Municao2"] = true
	},
	
	["Municao3"] = {
		["Municao3"] = true
	},

	["Contrabando1"] = {
		["Contrabando1"] = true
	},

	["heliponto"] = {
		["heliponto"] = true
	},

	["Contrabando2"] = {
		["Contrabando2"] = true
	},

	["Desmanche"] = {
		["Desmanche"] = true
	},

	["FacExtra"] = {
		["FacExtra"] = true
	},

	["FacExtra2"] = {
		["FacExtra2"] = true
	},

	["Bar"] = {
		["Bar"] = true
	},

	["Fazenda"] = {
		["Fazenda"] = true
	},
	
	["Streamer"] = {
		["Streamer"] = true
	},

	------------------------------
	-- Cargos Bruxas
	------------------------------

	["covencura"] = {
		["covencura"] = true
	},	
	
	["covenfogo"] = {
		["covenfogo"] = true
	},
	
	["covengelo"] = {
		["covengelo"] = true
	},	

	["covennature"] = {
		["covennature"] = true
	},	
	
	["coventrans"] = {
		["coventrans"] = true
	},		

	["covenbanshee"] = {
		["covenbanshee"] = true
	},		
	
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.hasPermission(user_id,perm)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	if dataTable then
		if dataTable["perm"] then
			if dataTable["perm"][perm] then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setPermission(user_id,perm)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	if dataTable then
		if dataTable["perm"] == nil then
			dataTable["perm"] = {}
		end

		if dataTable["perm"][perm] == nil then
			dataTable["perm"][perm] = true
		end
	else
		local userTables = vRP.userData(user_id,"Datatable")

		if userTables["inventory"] then
			if userTables["perm"] == nil then
				userTables["perm"] = {}
			end

			if userTables["perm"][perm] == nil then
				userTables["perm"][perm] = true
			end

			vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(userTables) })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.cleanPermission(user_id)
	local dataTable = vRP.getDatatable(user_id)

	if dataTable then
		if dataTable["perm"] then
			dataTable["perm"] = {}
		end
	else
		local userTables = vRP.userData(user_id,"Datatable")

		if userTables["inventory"] then
			if userTables["perm"] then
				userTables["perm"] = {}
				vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(userTables) })
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.remPermission(user_id,perm)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	if dataTable then
		if dataTable["perm"] then
			if dataTable["perm"][perm] then
				dataTable["perm"][perm] = nil
			end
		end
	else
		local userTables = vRP.userData(user_id,"Datatable")

		if userTables["inventory"] then
			if userTables["perm"] then
				if userTables["perm"][perm] then
					userTables["perm"][perm] = nil
					vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(userTables) })
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updatePermission(user_id,perm,new)
	local new = tostring(new)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	if dataTable then
		if dataTable["perm"] == nil then
			dataTable["perm"] = {}
		end

		if dataTable["perm"][perm] then
			dataTable["perm"][perm] = nil
		end

		dataTable["perm"][new] = true
	else
		local userTables = vRP.userData(user_id,"Datatable")
		if userTables["inventory"] then
			if userTables["perm"] == nil then
				userTables["perm"] = {}
			end

			if userTables["perm"][perm] then
				userTables["perm"][perm] = nil
			end

			userTables["perm"][new] = true

			vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(userTables) })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.hasGroup(user_id,perm)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	selfReturn[user_id] = false

	if dataTable then
		if dataTable["perm"] then
			for k,v in pairs(dataTable["perm"]) do
				if permissions[perm][k] then
					selfReturn[user_id] = true
					break
				end
			end
		end
	end

	return selfReturn[user_id]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.numPermission(perm)
	local tableList = {}

	for k,v in pairs(permList[perm]) do
		table.insert(tableList,v)
	end

	return tableList
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSERTPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.insertPermission(source,user_id,perm)
	if permList[perm] then
		permList[perm][user_id] = source
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.removePermission(user_id,perm)
	if permList[perm][user_id] then
		permList[perm][user_id] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id,source)
	if permList["Police"][user_id] then
		permList["Police"][user_id] = nil
	end

	if permList["Paramedic"][user_id] then
		permList["Paramedic"][user_id] = nil
	end

	if permList["Mechanic"][user_id] then
		permList["Mechanic"][user_id] = nil
	end


	if selfReturn[user_id] then
		selfReturn[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	if vRP.hasPermission(user_id,"Police") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService",source,true)
		TriggerEvent("blipsystem:serviceEnter",source,"POLICE: Corrections",24)
		TriggerClientEvent("service:Label",source,"Corrections","Sair de Serviço",5000)
	end

	if vRP.hasPermission(user_id,"Paramedic") then
		permList["Paramedic"][user_id] = source
		TriggerClientEvent("vRP:ParamedicService",source,true)
		TriggerEvent("blipsystem:serviceEnter",source,"Paramedic",6)
		TriggerClientEvent("service:Label",source,"Paramedic-1","Sair de Serviço",5000)
		TriggerClientEvent("service:Label",source,"Paramedic-2","Sair de Serviço",5000)
		TriggerClientEvent("service:Label",source,"Paramedic-3","Sair de Serviço",5000)
	end

	if vRP.hasGroup(user_id,"Mechanic") then
		permList["Mechanic"][user_id] = source
		TriggerClientEvent("service:Label",source,"Mechanic","Sair de Serviço",5000)
	end
end)

function vRP.getUsersByPermission(perm)
    local tableList = {}

    for user_id,source in pairs(vRP.userList()) do
        if vRP.hasPermission(user_id, perm) then
            table.insert(tableList, user_id)
        end
    end

    return tableList
end
vRP.HasGroup = vRP.hasGroup