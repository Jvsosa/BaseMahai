local Config = module("base","config/geral")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- Função auxiliar para split string
-----------------------------------------------------------------------------------------------------------------------------------------
function splitString(str, delimiter)
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- Função auxiliar para log Discord
-----------------------------------------------------------------------------------------------------------------------------------------
local function sendDiscordLog(title, identity, user_id, color)
    PerformHttpRequest(
        "https://discord.com/api/webhooks/1128824929392001044/FFtFL-aiSeBbJJzcp0AEfgJzIfe2bEfaoIOG_-KF0VrGXERkDhXcfdoGkA1f34H2vT9B",
        function(err, text, headers) end,
        'POST',
        json.encode({
            embeds = {
                {
                    title = title,
                    fields = {
                        {
                            name = "📝 Author:",
                            value = string.format("%s %s **#%s**", identity.name, identity.name2, user_id)
                        }
                    },
                    footer = {
                        text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                        icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                    },
                    thumbnail = {
                        url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
                    },
                    color = color
                }
            }
        }),
        { ['Content-Type'] = 'application/json' }
    )
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("service:Toggle")
AddEventHandler("service:Toggle", function(Service, Color)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local splitName = splitString(Service, "-")
    local serviceName = splitName[1]

    local serviceConfig = Config.Toggle[serviceName]
    if not serviceConfig then
        TriggerClientEvent("Notify", source, "vermelho", "Serviço não configurado.", 5000)
        return
    end
    
    for i, cargo in ipairs(serviceConfig.cargos) do
        local temEmServico = vRP.hasPermission(user_id, cargo.em_servico)
        local temForaServico = vRP.hasPermission(user_id, cargo.fora_de_servico)
        
        if temEmServico then
            vRP.remPermission(user_id, cargo.em_servico)
            vRP.setPermission(user_id, cargo.fora_de_servico)
            
            if serviceName == "Police" then
                vRP.removePermission(user_id, "Police")
            elseif serviceName == "Paramedic" then
                vRP.removePermission(user_id, "Paramedic")
            elseif serviceName == "Mechanic" then
                vRP.removePermission(user_id, "Mechanic")
            end
            
            TriggerEvent("blipsystem:serviceExit", source)
            TriggerClientEvent("Notify", source, "azul", "Saiu de serviço.", 5000)
            TriggerClientEvent("service:Label", source, serviceName, "Entrar em Serviço")

            if serviceName == "Paramedic" then
                local identity = vRP.userIdentity(user_id)
                sendDiscordLog("**Saiu de Servico**", identity, user_id, 15548997)
            end
            return
        end

        if temForaServico then
            vRP.remPermission(user_id, cargo.fora_de_servico)
            vRP.setPermission(user_id, cargo.em_servico)
            
            if serviceName == "Police" then
                vRP.insertPermission(source, user_id, "Police")
            elseif serviceName == "Paramedic" then
                vRP.insertPermission(source, user_id, "Paramedic")
            elseif serviceName == "Mechanic" then
                vRP.insertPermission(source, user_id, "Mechanic")
            end
            
            TriggerClientEvent("Notify", source, "azul", "Entrou em serviço.", 5000)
            TriggerClientEvent("service:Label", source, serviceName, "Sair de Serviço")

            if serviceName == "Paramedic" then
                local identity = vRP.userIdentity(user_id)
                sendDiscordLog("**Entrou de Servico**", identity, user_id, 5763719)
            end
            return
        end
    end

    TriggerClientEvent("Notify", source, "vermelho", "Você não possui permissão para este serviço.", 5000)
end)