local Config = module("base","config/geral")

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    for k, v in pairs(Config.ServiceLocations) do
        exports["target"]:AddCircleZone("service:"..v[4], vector3(v[1], v[2], v[3]), 0.75, {
            name = "service:"..v[4],
            heading = 3374176
        }, {
            shop = k,
            distance = 3,
            options = {
                {
                    label = "Entrar em Serviço",
                    event = "service:Toggle",
                    tunnel = "shop"
                }
            }
        })
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Toggle")
AddEventHandler("service:Toggle", function(Service)
    -- Service é o índice da Config.ServiceLocations (k)
    local serviceData = Config.ServiceLocations[Service]
    if serviceData then
        -- Envia para o server: nome do serviço (ex: "Paramedic-1") e cor (serviceData[6])
        TriggerServerEvent("service:Toggle", serviceData[4], serviceData[6])
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:LABEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Label")
AddEventHandler("service:Label", function(Service, Text)
    -- Atualiza o texto dos alvos conforme o serviço
    if Service == "Police" then
        exports["target"]:LabelText("service:Sheriff-1", Text)
        exports["target"]:LabelText("service:Police", Text)
    elseif Service == "Paramedic" then
        exports["target"]:LabelText("service:Paramedic-1", Text)
        exports["target"]:LabelText("service:Paramedic-2", Text)
        exports["target"]:LabelText("service:Paramedic-3", Text)
    else
        exports["target"]:LabelText("service:"..Service, Text)
    end
end)