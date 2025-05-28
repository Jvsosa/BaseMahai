-- 🚀 MAHAI CREATIVE - SERVER EXPORTS PROTEGIDO

local config = {}
local configLoaded = false

Citizen.CreateThread(function()
    Citizen.Wait(1000) -- Reduzido para carregar mais rápido
    
    print('^7[^3BASE^7] Iniciando carregamento de cargos...')
    
    local attempts = 0
    local maxAttempts = 15
    
    while not configLoaded and attempts < maxAttempts do
        attempts = attempts + 1
        
        if Config and Config.Cargos and type(Config.Cargos) == "table" then
            config = Config
            configLoaded = true
            
            local function countTable(t)
                local count = 0
                for k,v in pairs(t) do count = count + 1 end
                return count
            end
            
            print('^7[^2BASE^7] ✅ Cargos carregados! Total: ^2'..countTable(Config.Cargos)..'^7')
            
            -- ✅ NOTIFICAR O VRP
            TriggerEvent('base:cargosReady', config.Cargos)
            
            break
        else
            if attempts == 1 then
                print('^7[^3BASE^7] ⏳ Aguardando shared_scripts...')
            end
        end
        
        Citizen.Wait(500) -- Mais rápido
    end
    
    if not configLoaded then
        print('^7[^1BASE^7] 🚨 TIMEOUT! Ativando modo emergência...')
        
        config = {
            Cargos = {
                ["Admin"] = { ["Admin"] = true },
                ["Police"] = { ["Police"] = true },
                ["Paramedic"] = { ["Paramedic"] = true },
                ["Mechanic"] = { ["Mechanic"] = true }
            }
        }
        
        configLoaded = true
        TriggerEvent('base:cargosReady', config.Cargos)
    end
end)

exports('GetConfigAll', function()
    return configLoaded and config or { Cargos = {} }
end)

exports('GetConfig', function()
    return configLoaded and config or { Cargos = {} }
end)

exports('GetCargos', function()
    return configLoaded and (config.Cargos or {}) or {}
end)

exports('GetGroups', function()
    return {}
end)

-- ✅ STATUS CHECK
exports('IsReady', function()
    return configLoaded
end)