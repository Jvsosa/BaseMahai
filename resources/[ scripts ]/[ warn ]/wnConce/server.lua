--------------------------------
-- [ CONEXAO ] --
--------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("wnConce",src)
vCLIENT = Tunnel.getInterface("wnConce")
Config = module(GetCurrentResourceName(), "cfg/config")


local actived = {}

vRP._prepare("warn/selectwnConce", "SELECT * FROM wnConce_Carros") 
vRP._prepare("warn/selectwnConce2", "SELECT * FROM wnConce_Carros WHERE carro = @carro") 
vRP._prepare("warn/set_estoque","UPDATE wnConce_Carros SET estoque = @estoque WHERE carro = @carro")
vRP._prepare("warn/update_estoque", "UPDATE wnConce_Carros SET estoque = estoque + @estoque WHERE carro = @carro") 
vRP._prepare("wnConce/jesterInstagram", "SELECT * FROM smartphone_instagram WHERE user_id = @user_id")

src.return_nome = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local identity = vRP.userIdentity(user_id)
        local infos = vRP.execute("wnConce/jesterInstagram", {user_id = parseInt(user_id)})
        if infos[1] then
            return ""..identity.name.." "..identity.name2.."",infos[1].avatarURL
        else
            return ""..identity.name.." "..identity.name2.."","https://cdn.discordapp.com/attachments/452891038349262849/959382742624260136/unknown.png"
        end
    end
end

src.consultCarros = function(ConceNumber,carroLista)
    local source = source
    local user_id = vRP.getUserId(source)
    listCarros = {}
    if user_id then
        if carroLista == "Possuidos" then
            local vehicle = vRP.query("vehicles/getVehicles",{ user_id = user_id })
            for k,v in pairs(vehicle) do
                if vehicleName(v.vehicle) then
                    table.insert(listCarros,{ k = v.vehicle, carro = vehicleName(v.vehicle), bau = vehicleChest(v.vehicle) })
                end
            end
        else
            local SQL = vRP.query("warn/selectwnConce")
            for k,v in pairs(SQL) do
                if v.tipo == carroLista then
                    local seguro = v.valor/10
                    if vehicleName(v.carro) then
                        if v.tipo == "Alugados" then
                            table.insert(listCarros,{k = v.carro, carro = vehicleName(v.carro), seguro = parseFormat(parseInt(70000)), bau = vehicleChest(v.carro), valor2 = v.valor, valor = parseFormat(parseInt(v.valor)), estoque = v.estoque, tipo = v.tipo })
                        else
                            table.insert(listCarros,{k = v.carro, carro = vehicleName(v.carro), seguro = parseFormat(seguro), bau = vehicleChest(v.carro), valor2 = v.valor, valor = parseFormat(parseInt(v.valor)), estoque = v.estoque, tipo = v.tipo })
                        end
                    end
                end
            end
        end
    end
end

src.consultCarrosList = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return listCarros
    end
end

src.AlterarMundo = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local random = math.random(9000,20000)
        SetPlayerRoutingBucket(source,random)
    end
end

src.AlterarMundo2 = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        SetPlayerRoutingBucket(source,1)
    end
end

src.ConfirmTestDrive = function(carro)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.request(source,"Você deseja realizar o teste no carro "..vehicleName(carro).." ?") then
            return true
        else
            return false
        end
    end
end

src.comprarCarro = function(carro,red,green,blue)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then

        if vRP.getFines(user_id) > 0 then
            TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
            return
        end

        local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = carro })
        if vehicle[1] then
            TriggerClientEvent("Notify",source,"amarelo","Já possui um <b>"..vehicleName(carro).."</b>.",3000)
            return
        else
            local SQL = vRP.query("warn/selectwnConce2", {carro = carro })
            if SQL[1].estoque >= 1 then
                if SQL[1].tipo == "Alugados" then
                    if vRP.request(source,"Você deseja realizar a compra do carro "..vehicleName(carro).." por "..SQL[1].valor.." Perolas ?") then
                        if vRP.paymentGems(user_id,SQL[1].valor) then
                            local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = carro })
                            vRP.execute("vehicles/rentalVehicles",{ user_id = user_id, vehicle = carro, plate = vRP.generatePlate(), work = "false" })
                            TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..vehicleName(carro).."</b> concluído.",5000)
                            local identity = vRP.userIdentity(user_id)
                            PerformHttpRequest("https://discord.com/api/webhooks/1121058109071314954/3G4IKISxxuRnukQ5xCrEpdLfNUDDElKPcs9Na3RZ5iGdmg1vXPriChQs5P_WgJR5nXYO", function(err, text, headers) end, 'POST', json.encode({
                            embeds = {
                                {     
                                    title = "**Alugou Carro**",
                                    fields = {
                                        { 
                                            name = "📝 Author:", 
                                            value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                        },
                                        { 
                                            name = "🚗 Carro:", 
                                            value = ""..vehicleName(carro).."",
                                        },
                                        { 
                                            name = "💸 Valor:", 
                                                value = ""..SQL[1].valor.." $ \n \n " 
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




                                
                            return true
                        end
                    end
                else
                    if vRP.request(source,"Você deseja realizar a compra do carro "..vehicleName(carro).." por "..SQL[1].valor.." $ ?") then
                        local maxVehs = vRP.query("vehicles/countVehicles",{ user_id = user_id, work = "false" })
                        local identity = vRP.userIdentity(user_id)
                        local amountVehs = identity["garage"]
                        if vRP.userPremium(user_id) then
							amountVehs = amountVehs + 2
						end
                        if parseInt(maxVehs[1]["qtd"]) >= parseInt(amountVehs) then
							TriggerClientEvent("Notify",source,"amarelo","Atingiu o máximo de veículos.",3000)
							return
						end
                        if vRP.paymentFull(user_id,parseInt(SQL[1].valor)) then
							vRP.execute("vehicles/addVehicles",{ user_id = user_id, vehicle = carro, plate = vRP.generatePlate(), work = "false" })
							TriggerClientEvent("Notify",source,"verde","Compra concluída.",5000)


                            local identity = vRP.userIdentity(user_id)
                            PerformHttpRequest("https://discord.com/api/webhooks/1121057815809773578/jxOYdrozQMEENr5izTH8NCGhq7VkvWzNawD3QPml_VgLBHd8NWbppWmqITZkdbBJuxv2", function(err, text, headers) end, 'POST', json.encode({
                            embeds = {
                                {     
                                    title = "**Comprou Carro**",
                                    fields = {
                                        { 
                                            name = "📝 Author:", 
                                            value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                        },
                                        { 
                                            name = "🚗 Carro:", 
                                            value = ""..vehicleName(carro).."",
                                        },
                                        { 
                                            name = "💸 Valor:", 
                                                value = ""..parseFormat(SQL[1].valor).." Perolas \n \n " 
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

                            return true
						else
							TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
						end
                    end
                end
            end
        end
    end
end

src.comprarCarroVip = function(carro,red,green,blue)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then

        if vRP.getFines(user_id) > 0 then
            TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
            return
        end

        local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = carro })
        if vehicle[1] then
            TriggerClientEvent("Notify",source,"amarelo","Já possui um <b>"..vehicleName(carro).."</b>.",3000)
            return
        else
            local SQL = vRP.query("warn/selectwnConce2", {carro = carro })
            if SQL[1].estoque >= 1 then
                local valor_carro_completo = SQL[1].valor * 3
                if vRP.request(source,"Você deseja realizar a compra do carro "..vehicleName(carro).." por "..valor_carro_completo.." Perolas ?") then
                    if vRP.paymentGems(user_id,valor_carro_completo) then
                        local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = carro })
                        vRP.execute("vehicles/addVehicles",{ user_id = user_id, vehicle = carro, plate = vRP.generatePlate(), work = "false" })
                        TriggerClientEvent("Notify",source,"verde","Voce comprou o veículo <b>"..vehicleName(carro).."</b> concluído.",5000)

                            local identity = vRP.userIdentity(user_id)
                            PerformHttpRequest("https://discord.com/api/webhooks/1121059059462852668/AIAPdIYlrMPsKuJQAuXY4FIM8raD_5amap5g4dKJmq0IuSXhoCq4_Ix7xYYXxLPw-lRv", function(err, text, headers) end, 'POST', json.encode({
                            embeds = {
                                {     
                                    title = "**Alugou Carro**",
                                    fields = {
                                        { 
                                            name = "📝 Author:", 
                                            value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                        },
                                        { 
                                            name = "🚗 Carro:", 
                                            value = ""..vehicleName(carro).."",
                                        },
                                        { 
                                            name = "💸 Valor:", 
                                                value = ""..SQL[1].valor.." Perolas \n \n " 
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

                        return true
                    end
                end
            end
        end
    end
end

src.venderCarro = function(carro)
    local source = source
	local user_id = vRP.getUserId(source)
    if user_id then
        local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = carro })
        local SQL = vRP.query("warn/selectwnConce2", {carro = carro })
     
        if carro then
       
            if SQL[1] then
           
                local vehPrices = SQL[1].valor 
                if vehicle[1] then
              
                    if vehicle[1]["tax"] <= os.time() then
                        local vehiclePrice = parseInt(vehPrices * 0.10)
                        if vRP.request(source,"Você deseja pagara taxa do carro "..vehicleName(carro).." por "..parseFormat(vehiclePrice).." $ ?") then
                            if vRP.paymentFull(user_id,vehiclePrice) then
                                vRP.execute("vehicles/updateVehiclesTax",{ user_id = user_id, vehicle = carro })
                                TriggerClientEvent("tablet:Update",source,"requestPossuidos")
                            else
                                TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
                            end
                        end
                    else
                        
                        if carro == "faggio" or carro == "manchez" or carro == "bf400" or carro == "baller6" then
                            TriggerClientEvent("Notify",source,"amarelo","Veículos de serviço não podem ser vendidos.",3000)
                            actived[user_id] = nil
                            return false
                        end

                        if vRP.getFines(user_id) > 0 then
                            TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
                            actived[user_id] = nil
                            return false
                        end
                
                        local vehType = vehicleType(vehName)
                        if vehType == "work" then
                            TriggerClientEvent("Notify",source,"amarelo","Veículos de serviço não podem ser vendidos.",3000)
                            actived[user_id] = nil
                            return false
                        end
                
                        local SQL = vRP.query("warn/selectwnConce2", {carro = carro })
                        local vehPrices = SQL[1].valor * 0.5
                        if SQL[1].tipo ~= "Alugados" then
                            if vRP.request(source,"Você deseja vender o carro "..vehicleName(carro).." por "..parseFormat(vehPrices).." $ ?") then
                                local vehicles = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = carro })
                                if vehicles[1] then
                                    vRP.remSrvdata("custom:"..user_id..":"..carro)
                                    vRP.remSrvdata("vehChest:"..user_id..":"..carro)
                                    vRP.remSrvdata("vehGloves:"..user_id..":"..carro)
                                    vRP.execute("vehicles/removeVehicles",{ user_id = user_id, vehicle = carro })
                                    vRP.addBank(user_id,vehPrices,"Private")
                                    TriggerClientEvent("itensNotify",source,{ "recebeu","dollars",parseFormat(vehPrices),"Dólares" })

                                    local identity = vRP.userIdentity(user_id)
                                    PerformHttpRequest("https://discord.com/api/webhooks/1121058792411508776/qifq3VzEs7i3Zy3X4txX5pvZIlcCPVQYyX7vY8eyq0aN6AxehP8HeWyWMA900sh72Y2a", function(err, text, headers) end, 'POST', json.encode({
                                    embeds = {
                                        {     
                                            title = "**Vendeu Carro**",
                                            fields = {
                                                { 
                                                    name = "📝 Author:", 
                                                    value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                                },
                                                { 
                                                    name = "🚗 Carro:", 
                                                    value = ""..vehicleName(carro).."",
                                                },
                                                { 
                                                    name = "💸 Valor:", 
                                                        value = ""..parseFormat(vehPrices).." $ \n \n " 
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
                        else
                            TriggerClientEvent("Notify",source,"negado","Você nao pode vender carro <b>Alugado</b>.",10000)
                        end
                    end
                end
            else
                local vehPrices = 5000
                if vehicle[1] then
                    if vehicle[1]["tax"] <= os.time() then
                        local vehiclePrice = parseInt(vehPrices * 0.10)
                        if vRP.paymentFull(user_id,vehiclePrice) then
                            vRP.execute("vehicles/updateVehiclesTax",{ user_id = user_id, vehicle = carro })
                            TriggerClientEvent("tablet:Update",source,"requestPossuidos")
                        else
                            TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
                        end
                    else
                        if vRP.getFines(user_id) > 0 then
                            TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
                            actived[user_id] = nil
                            return false
                        end
                
                        local vehType = vehicleType(vehName)
                        if vehType == "work" then
                            TriggerClientEvent("Notify",source,"amarelo","Veículos de serviço não podem ser vendidos.",3000)
                            actived[user_id] = nil
                            return false
                        end
                
                        local SQL = vRP.query("warn/selectwnConce2", {carro = carro })
                        local vehPrices = SQL[1].valor * 0.5
                        if SQL[1].tipo ~= "Alugados" then
                            if vRP.request(source,"Você deseja vender o carro "..vehicleName(carro).." por "..parseFormat(vehPrices).." $ ?") then
                                local vehicles = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = carro })
                                if vehicles[1] then
                                    vRP.remSrvdata("custom:"..user_id..":"..carro)
                                    vRP.remSrvdata("vehChest:"..user_id..":"..carro)
                                    vRP.remSrvdata("vehGloves:"..user_id..":"..carro)
                                    vRP.execute("vehicles/removeVehicles",{ user_id = user_id, vehicle = carro })
                                    vRP.addBank(user_id,vehPrices,"Private")
                                    TriggerClientEvent("itensNotify",source,{ "recebeu","dollars",parseFormat(vehPrices),"Dólares" })

                                    local identity = vRP.userIdentity(user_id)
                                    PerformHttpRequest("https://discord.com/api/webhooks/1121058792411508776/qifq3VzEs7i3Zy3X4txX5pvZIlcCPVQYyX7vY8eyq0aN6AxehP8HeWyWMA900sh72Y2a", function(err, text, headers) end, 'POST', json.encode({
                                    embeds = {
                                        {     
                                            title = "**Vendeu Carro**",
                                            fields = {
                                                { 
                                                    name = "📝 Author:", 
                                                    value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                                },
                                                { 
                                                    name = "🚗 Carro:", 
                                                    value = ""..vehicleName(carro).."",
                                                },
                                                { 
                                                    name = "💸 Valor:", 
                                                        value = ""..parseFormat(vehPrices).." $ \n \n " 
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
                        else
                            TriggerClientEvent("Notify",source,"negado","Você nao pode vender carro <b>Alugado</b>.",10000)
                        end
                    end
                end
            end
           
        end
    end
end

local plateVehs = {}
function src.startDrive()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if actived[user_id] == nil then
			actived[user_id] = true

			if not exports["hud"]:Wanted(user_id) then
				if vRP.request(source,"Iniciar o teste por <b>$100</b> dólares?") then
					if vRP.paymentFull(user_id,100) then
						plateVehs[user_id] = "PDMS"..(1000 + user_id)

						TriggerEvent("engine:tryFuel",plateVehs[user_id],100)
						TriggerClientEvent("update:Route",source,user_id)
						TriggerEvent("plateEveryone",plateVehs[user_id])
						SetPlayerRoutingBucket(source,user_id)
						actived[user_id] = nil

						return true,plateVehs[user_id]
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					end
				end
			end

			actived[user_id] = nil
		end
	end
	return false
end

function src.removeDrive()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		--TriggerEvent("plateReveryone",plateVehs[user_id])
		TriggerClientEvent("update:Route",source,0)
		SetPlayerRoutingBucket(source,0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if actived[user_id] then
		actived[user_id] = nil
	end

	if plateVehs[user_id] then
		plateVehs[user_id] = nil
	end
end)