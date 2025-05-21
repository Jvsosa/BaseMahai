-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("service:Toggle")
AddEventHandler("service:Toggle",function(Service,Color)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local splitName = splitString(Service,"-")
		local serviceName = splitName[1]

		if vRP.hasPermission(user_id,serviceName) then
			if serviceName == "Exercito" or serviceName == "Sheriff" or serviceName == "Corrections" or serviceName == "Ranger" or serviceName == "State" then
				vRP.removePermission(user_id,"Police")
				TriggerEvent("blipsystem:serviceExit",source)
				TriggerClientEvent("vRP:PoliceService",source,false)
			end

			if serviceName == "Paramedic" then
				vRP.removePermission(user_id,serviceName)
				TriggerEvent("blipsystem:serviceExit",source)
				TriggerClientEvent("vRP:ParamedicService",source,false)
				local identity = vRP.userIdentity(user_id)
				PerformHttpRequest("https://discord.com/api/webhooks/1128824929392001044/FFtFL-aiSeBbJJzcp0AEfgJzIfe2bEfaoIOG_-KF0VrGXERkDhXcfdoGkA1f34H2vT9B", function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{     
							title = "**Saiu de Servico**",
							fields = {
								{ 
									name = "📝 Author:", 
									value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
								},
							}, 
							footer = { 
								text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
								icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							thumbnail = { 
								url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							color = 15548997
						}
					}
				}), { ['Content-Type'] = 'application/json' })
			end

			vRP.updatePermission(user_id,serviceName,"wait"..serviceName)
			TriggerClientEvent("Notify",source,"azul","Saiu de serviço.",5000)
			TriggerClientEvent("service:Label",source,serviceName,"Entrar em Serviço",5000)
		elseif vRP.hasPermission(user_id,"wait"..serviceName) then
			if serviceName == "Exercito" or serviceName == "Sheriff" or serviceName == "Corrections" or serviceName == "Ranger" or serviceName == "State" then
				vRP.insertPermission(source,user_id,"Police")
				TriggerClientEvent("vRP:PoliceService",source,true)
				TriggerEvent("blipsystem:serviceEnter",source,"POLICE: "..serviceName,Color)
			end

			if serviceName == "Paramedic" then
				vRP.insertPermission(source,user_id,serviceName)
				TriggerClientEvent("vRP:ParamedicService",source,true)
				TriggerEvent("blipsystem:serviceEnter",source,"Paramedic",Color)
				local identity = vRP.userIdentity(user_id)
				PerformHttpRequest("https://discord.com/api/webhooks/1128824929392001044/FFtFL-aiSeBbJJzcp0AEfgJzIfe2bEfaoIOG_-KF0VrGXERkDhXcfdoGkA1f34H2vT9B", function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{     
							title = "**Entrou de Servico**",
							fields = {
								{ 
									name = "📝 Author:", 
									value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
								},
							}, 
							footer = { 
								text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
								icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							thumbnail = { 
								url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							color = 5763719
						}
					}
				}), { ['Content-Type'] = 'application/json' })
			end

			vRP.updatePermission(user_id,"wait"..serviceName,serviceName)
			TriggerClientEvent("Notify",source,"azul","Entrou em serviço.",5000)
			TriggerClientEvent("service:Label",source,serviceName,"Sair de Serviço",5000)
		end
	end
end)