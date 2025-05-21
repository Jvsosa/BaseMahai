local oRP = {}
Tunnel.bindInterface("RKG_Store:Desmanche", oRP)
local vCLIENT = Tunnel.getInterface("RKG_Store:Desmanche")

local vehicle_dismantle = {}
local orgPlayer = {}

function oRP.CheckPerm(org_name)
	local source = source
	local user_id = vRP.getUserId(source)
	local org_perm = Config_Desmanche[org_name].Permission
	if user_id then
		if vRP.hasGroup(user_id,org_perm) then
			orgPlayer[user_id] = nil
			orgPlayer[user_id] = Config_Desmanche[org_name].Permission
			return true
		end
		return false
	end
end

function oRP.checkVehIsDismantled(veh_plate,veh_name)
	local source = source
	local user_id = vRP.getUserId(source)
	if not veh_plate then
		TriggerClientEvent("Notify",source,"vermelho","O veículo precisa ter uma placa para ser desmanchado")
		return false

	end
    local consult = vRP.userPlate(veh_plate)
    if consult and consult.user_id then
		local getEmpresa = vRP.query("GetEmpresa", {user_id = parseInt(consult.user_id)})[1]
		if getEmpresa and getEmpresa["groupSetado"] == orgPlayer[user_id] then
			TriggerClientEvent("Notify",source,"vermelho","O Veículo pertece a um membro de sua organização!")
			orgPlayer[user_id] = nil
			return false
		end
		
        return true
    end
    return false
end

function oRP.setVehicleDismantle(data)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vehicle_dismantle[user_id] then
			vehicle_dismantle[user_id] = { veh = data.veh, veh_plate = data.veh_plate }
		end
	end
end

vRP.prepare("RKG_Desmanche/consultPrice", "SELECT * FROM wnconce_carros WHERE carro = @carro")
function oRP.dismantleVehicle(vehicle,veh_plate,veh_name,perm)
	local source = source
    local user_id = vRP.getUserId(source)
    local consult = vRP.userPlate(veh_plate)


	if perm == "Desmanche" then
		log = "https://discord.com/api/webhooks/1119202635719905291/aPssPoCmwcfsZaCc4hkv5EkKsTp5k1Hh_EafIRylpsKtr7cTUxsKJx58atOtEZNdSwZr"
	end

	local vehiclePrice = vRP.query("RKG_Desmanche/consultPrice",{carro = veh_name})[1]
	local newPrice = 0 
	if not vehiclePrice then

		newPrice = 50000

	end

	if not consult.user_id then
		if vehicle_dismantle[user_id] then
			vehicle_dismantle[user_id] = nil
		end
		vCLIENT.resetService(source)
		TriggerClientEvent("Notify",source,"vermelho","O carro está clonado então não pode ser desmanchado")
		return
	end

    if consult.user_id then
		local getEmpresa = vRP.query("GetEmpresa", {user_id = parseInt(consult.user_id)})[1]

		if getEmpresa and getEmpresa["groupSetado"] == orgPlayer[user_id] then
			if vehicle_dismantle[user_id] then
				vehicle_dismantle[user_id] = nil
				orgPlayer[user_id] = nil
			end
			TriggerClientEvent("Notify",source,"vermelho","O Veículo pertece a um membro de sua organização!")
			return
		end

		if vehicle_dismantle[user_id] and vehicle_dismantle[user_id].veh == vehicle and vehicle_dismantle[user_id].veh_plate == veh_plate then
			local identity = vRP.userIdentity(user_id)
			local n_identity = vRP.userIdentity(consult.user_id)

			if not vehiclePrice then
				price_veh = 50000
	
				vRP.giveInventoryItem(user_id,"dollars2",parseInt(price_veh),true)
	
				TriggerClientEvent("garages:Delete",source)
	
				if vehicle_dismantle[user_id] then
					vehicle_dismantle[user_id] = nil
				end
	
				if n_identity then
					vRP.addFines(parseInt(consult.user_id),parseInt(price_veh*0.3))
				end
				vCLIENT.resetService(source)
				orgPlayer[user_id] = nil
				local identity = vRP.userIdentity(user_id)
				PerformHttpRequest(log, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{     
							title = "**Desmanche "..veh_name.."**",
							fields = {
								{ 
									name = "📝 Author:", 
									value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
								},
								{ 
									name = "💸 Valor:", 
									value = ""..parseFormat(price_veh).." $"
								},
								{ 
									name = "🚗 Dono do Carro:", 
										value = "" ..n_identity.name.." "..n_identity.name2.." **#"..consult.user_id.."** ",
								},
							}, 
							footer = { 
								text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
								icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							thumbnail = { 
								url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							color = 3092790
						}
					}
				}), { ['Content-Type'] = 'application/json' })

			else
				price_veh = vehiclePrice["valor"] / 5

				if vehiclePrice["tipo"] == "Alugados" then
					price_veh = 50000
					TriggerClientEvent("Notify",source,"azul","Este veículo era alugado então você só conseguiu $"..parseFormat(price_veh).." da venda das peças!")
				end
	
				vRP.giveInventoryItem(user_id,"dollars2",parseInt(price_veh),true)
	
				TriggerClientEvent("garages:Delete",source)
	
				if vehicle_dismantle[user_id] then
					vehicle_dismantle[user_id] = nil
				end
	
				if n_identity then
					vRP.addFines(parseInt(consult.user_id),parseInt(price_veh*0.3))
				end
				vCLIENT.resetService(source)
				orgPlayer[user_id] = nil
				local identity = vRP.userIdentity(user_id)
				PerformHttpRequest(log, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{     
							title = "**Desmanche "..veh_name.."**",
							fields = {
								{ 
									name = "📝 Author:", 
									value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
								},
								{ 
									name = "💸 Valor:", 
									value = ""..parseFormat(price_veh).." $"
								},
								{ 
									name = "🚗 Dono do Carro:", 
										value = "" ..n_identity.name.." "..n_identity.name2.." **#"..consult.user_id.."** ",
								},
							}, 
							footer = { 
								text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
								icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							thumbnail = { 
								url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							color = 3092790
						}
					}
				}), { ['Content-Type'] = 'application/json' })

			end

		

			

		end
    end
end

function tD(n)
	n = math.ceil(n * 100) / 100
	return n
end