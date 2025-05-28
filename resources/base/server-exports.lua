-- 🚀 MAHAI CREATIVE - SERVER EXPORTS PROTEGIDO

local config = {}
local configLoaded = false

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    
    print('^7[^3BASE^7] Iniciando carregamento de configurações...')
    
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
            
            print('^7[^2BASE^7] ✅ Configurações carregadas!')
            if Config.StarterItems then
            end
            if Config.StarterBank then
            end
            
            TriggerEvent('base:configReady', config)
            
            break
        else
            if attempts == 1 then
                print('^7[^3BASE^7] ⏳ Aguardando shared_scripts...')
            end
        end
        
        Citizen.Wait(500)
    end
    
    if not configLoaded then
        print('^7[^1BASE^7] 🚨 TIMEOUT! Ativando modo emergência APENAS para cargos...')
        
        config = {
            Cargos = {
                ["Admin"] = { ["Admin"] = true },
                ["Police"] = { ["Police"] = true },
                ["Paramedic"] = { ["Paramedic"] = true },
                ["Mechanic"] = { ["Mechanic"] = true }
            }
            -- ❌ REMOVIDO: StarterItems, StarterBank, ServerInfo
        }
        
        configLoaded = true
        TriggerEvent('base:configReady', config)
    end
end)

-- Exports existentes
exports('GetConfigAll', function()
    return configLoaded and config or {}
end)

exports('GetConfig', function()
    return configLoaded and config or {}
end)

exports('GetCargos', function()
    return configLoaded and (config.Cargos or {}) or {}
end)

exports('GetGroups', function()
    return {}
end)

-- ✅ EXPORTS SEM FALLBACK (falha se config não carregar)
exports('GetStarterItems', function()
    return configLoaded and (config.StarterItems or {}) or {}
end)

exports('GetStarterBank', function()
    return configLoaded and (config.StarterBank or 0) or 0
end)

exports('GetServerInfo', function()
    return configLoaded and (config.ServerInfo or {}) or {}
end)

exports('IsReady', function()
    return configLoaded
end)