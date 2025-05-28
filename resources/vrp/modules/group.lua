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
-- ✅ HELPER FUNCTIONS (DEFINIR PRIMEIRO)
-----------------------------------------------------------------------------------------------------------------------------------------
local function countTable(t)
    local count = 0
    for k,v in pairs(t) do
        count = count + 1
    end
    return count
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ✅ OTIMIZAÇÃO: Cache de datatable e resultados
-----------------------------------------------------------------------------------------------------------------------------------------
local dataTableCache = {}
local lastCacheUpdate = {}
local resultCache = {}

local function getCachedDataTable(user_id)
    local currentTime = GetGameTimer()
    
    -- Cache por 1 segundo
    if not dataTableCache[user_id] or not lastCacheUpdate[user_id] or 
       currentTime - lastCacheUpdate[user_id] > 1000 then
        dataTableCache[user_id] = vRP.getDatatable(user_id)
        lastCacheUpdate[user_id] = currentTime
        -- Limpar cache de resultados quando datatable é atualizada
        if resultCache[user_id] then
            resultCache[user_id] = {}
        end
    end
    
    return dataTableCache[user_id]
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSIONS - APENAS PARA SISTEMAS ESPECÍFICOS (SE NECESSÁRIO)
-----------------------------------------------------------------------------------------------------------------------------------------
local permissions = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAMENTO DOS CARGOS DA BASE
-----------------------------------------------------------------------------------------------------------------------------------------
local cargos = {}
local cargosLoaded = false

-- ✅ PROTEÇÃO CONTRA CONEXÃO PRECOCE
local systemReady = false

-- ✅ AGUARDAR CARREGAMENTO COMPLETO
local function waitForSystemReady()
    while not systemReady do
        Citizen.Wait(100)
    end
end

-- ✅ ATUALIZAR A FUNÇÃO loadCargos
local function loadCargos()
    Citizen.CreateThread(function()
        local attempts = 0
        local maxAttempts = 5
        
        while not cargosLoaded and attempts < maxAttempts do
            local success, config = pcall(function()
                return exports.base:GetCargos()
            end)
            
            if success and config and next(config) then
                cargos = config
                permissions = {}
                
                for cargo, perms in pairs(cargos) do
                    permissions[cargo] = perms
                end
                
                cargosLoaded = true
                systemReady = true  -- ✅ SISTEMA PRONTO!
                
                print('^7[^2VRP^7] Sistema de cargos ^2ATIVO^7! Total: ^2'..countTable(cargos)..'^7 cargos')
                
                -- ✅ Reprocessar players já conectados
                TriggerEvent('vrp:reprocessAllPlayers')
                
                break
            else
                attempts = attempts + 1
                print('^7[^3VRP^7] Aguardando base... (^3'..attempts..'^7/^3'..maxAttempts..'^7)')
                Citizen.Wait(2000)
            end
        end
        
        if not cargosLoaded then
            print('^7[^1VRP^7] ^1EMERGENCIA^7: Ativando modo de segurança!')
            permissions = {
                ["Admin"] = { ["Admin"] = true },
                ["Police"] = { ["Police"] = true },
                ["Paramedic"] = { ["Paramedic"] = true }
            }
            cargosLoaded = true
            systemReady = true
        end
    end)
end

-- ✅ INICIALIZAR CARREGAMENTO
loadCargos()

-- ✅ COMANDO PARA RECARREGAR CARGOS
RegisterCommand('reloadcargos', function(source, args)
    if source == 0 then
        cargosLoaded = false
        loadCargos()
    end
end, true)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ✅ HASPERMISSION - ULTRA OTIMIZADO
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.hasPermission(user_id,perm)
    local perm = tostring(perm)
    local dataTable = getCachedDataTable(user_id)

    if dataTable and dataTable["perm"] and dataTable["perm"][perm] then
        return true
    end

    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ✅ SETPERMISSION - OTIMIZADO
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setPermission(user_id,perm)
    local perm = tostring(perm)
    local dataTable = getCachedDataTable(user_id)

    -- ✅ Limpar cache quando modificar permissões
    if dataTableCache[user_id] then
        dataTableCache[user_id] = nil
        lastCacheUpdate[user_id] = nil
    end
    if resultCache[user_id] then
        resultCache[user_id] = {}
    end

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
-- ✅ CLEANPERMISSION - OTIMIZADO
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.cleanPermission(user_id)
    local dataTable = getCachedDataTable(user_id)

    -- ✅ Limpar cache quando modificar permissões
    if dataTableCache[user_id] then
        dataTableCache[user_id] = nil
        lastCacheUpdate[user_id] = nil
    end
    if resultCache[user_id] then
        resultCache[user_id] = {}
    end

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
-- ✅ REMPERMISSION - OTIMIZADO
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.remPermission(user_id,perm)
    local perm = tostring(perm)
    local dataTable = getCachedDataTable(user_id)

    -- ✅ Limpar cache quando modificar permissões
    if dataTableCache[user_id] then
        dataTableCache[user_id] = nil
        lastCacheUpdate[user_id] = nil
    end
    if resultCache[user_id] then
        resultCache[user_id] = {}
    end

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
-- ✅ UPDATEPERMISSION - OTIMIZADO
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updatePermission(user_id,perm,new)
    local new = tostring(new)
    local perm = tostring(perm)
    local dataTable = getCachedDataTable(user_id)

    -- ✅ Limpar cache quando modificar permissões
    if dataTableCache[user_id] then
        dataTableCache[user_id] = nil
        lastCacheUpdate[user_id] = nil
    end
    if resultCache[user_id] then
        resultCache[user_id] = {}
    end

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
-- ✅ HASGROUP - ULTRA OTIMIZADO COM CACHE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.hasGroup(user_id,perm)
    local perm = tostring(perm)
    
    -- ✅ Cache de resultado
    if not resultCache[user_id] then
        resultCache[user_id] = {}
    end
    
    if resultCache[user_id][perm] ~= nil then
        return resultCache[user_id][perm]
    end
    
    local dataTable = getCachedDataTable(user_id)
    resultCache[user_id][perm] = false

    if dataTable and dataTable["perm"] then
        for k,v in pairs(dataTable["perm"]) do
            if permissions[perm] and permissions[perm][k] then
                resultCache[user_id][perm] = true
                break
            end
        end
    end

    selfReturn[user_id] = resultCache[user_id][perm]
    return resultCache[user_id][perm]
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ✅ NUMPERMISSION - OTIMIZADO
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.numPermission(perm)
    local tableList = {}

    if permList[perm] then
        for k,v in pairs(permList[perm]) do
            table.insert(tableList,v)
        end
    end

    return tableList
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ✅ INSERTPERMISSION - OTIMIZADO
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.insertPermission(source,user_id,perm)
    if permList[perm] then
        permList[perm][user_id] = source
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ✅ REMOVEPERMISSION - OTIMIZADO
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.removePermission(user_id,perm)
    if permList[perm] and permList[perm][user_id] then
        permList[perm][user_id] = nil
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ✅ PLAYERDISCONNECT - ULTRA OTIMIZADO
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id,source)
    -- ✅ Limpar todas as permissões de uma vez
    if permList["Police"][user_id] then
        permList["Police"][user_id] = nil
    end

    if permList["Paramedic"][user_id] then
        permList["Paramedic"][user_id] = nil
    end

    if permList["Mechanic"][user_id] then
        permList["Mechanic"][user_id] = nil
    end

    -- ✅ Limpar cache
    if dataTableCache[user_id] then
        dataTableCache[user_id] = nil
        lastCacheUpdate[user_id] = nil
    end
    
    if resultCache[user_id] then
        resultCache[user_id] = nil
    end

    if selfReturn[user_id] then
        selfReturn[user_id] = nil
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ✅ PLAYERCONNECT - ULTRA OTIMIZADO
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
    -- ✅ AGUARDAR SISTEMA ESTAR PRONTO
    if not systemReady then
        print('^7[^3VRP^7] Player '..user_id..' aguardando sistema carregar...')
        waitForSystemReady()
        print('^7[^2VRP^7] Sistema pronto! Processando player '..user_id..'...')
    end
    
    -- ✅ Processar normalmente
    local dataTable = getCachedDataTable(user_id)
    
    if not dataTable or not dataTable["perm"] then
        return
    end

    -- ✅ Verificar Police
    if vRP.hasPermission(user_id,"Police") then
        permList["Police"][user_id] = source
        TriggerClientEvent("vRP:PoliceService",source,true)
        TriggerEvent("blipsystem:serviceEnter",source,"POLICE: Corrections",24)
        TriggerClientEvent("service:Label",source,"Corrections","Sair de Serviço",5000)
    end

    -- ✅ Verificar Paramedic
    if vRP.hasPermission(user_id,"Paramedic") then
        permList["Paramedic"][user_id] = source
        TriggerClientEvent("vRP:ParamedicService",source,true)
        TriggerEvent("blipsystem:serviceEnter",source,"Paramedic",6)
        TriggerClientEvent("service:Label",source,"Paramedic-1","Sair de Serviço",5000)
        TriggerClientEvent("service:Label",source,"Paramedic-2","Sair de Serviço",5000)
        TriggerClientEvent("service:Label",source,"Paramedic-3","Sair de Serviço",5000)
    end

    -- ✅ Verificar Mechanic
    if vRP.hasGroup(user_id,"Mechanic") then
        permList["Mechanic"][user_id] = source
        TriggerClientEvent("service:Label",source,"Mechanic","Sair de Serviço",5000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ✅ GETUSERSBYPERMSISSION - OTIMIZADO
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getUsersByPermission(perm)
    local tableList = {}

    for user_id,source in pairs(vRP.userList()) do
        if vRP.hasPermission(user_id, perm) then
            table.insert(tableList, user_id)
        end
    end

    return tableList
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ✅ ALIASES E EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.HasGroup = vRP.hasGroup

-----------------------------------------------------------------------------------------------------------------------------------------
-- ✅ LIMPEZA AUTOMÁTICA DE CACHE (PERFORMANCE)
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000) -- A cada 5 minutos
        
        local currentTime = GetGameTimer()
        local cleanedCount = 0
        
        -- Limpar cache antigo (mais de 5 minutos)
        for user_id, lastUpdate in pairs(lastCacheUpdate) do
            if currentTime - lastUpdate > 300000 then
                dataTableCache[user_id] = nil
                lastCacheUpdate[user_id] = nil
                if resultCache[user_id] then
                    resultCache[user_id] = nil
                end
                cleanedCount = cleanedCount + 1
            end
        end
        
        if cleanedCount > 0 then
            print('^7[^2VRP^7] Cache limpo: ^2'..cleanedCount..'^7 entradas removidas')
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ✅ REPROCESSAR PLAYERS JÁ CONECTADOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp:reprocessAllPlayers')
AddEventHandler('vrp:reprocessAllPlayers', function()
    print('^7[^2VRP^7] Reprocessando players conectados...')
    
    local playersFound = 0
    local playersProcessed = 0
    
    for user_id, source in pairs(vRP.userList()) do
        if source and source > 0 then
            playersFound = playersFound + 1
            print('^7[^2VRP^7] Reprocessando player: ^2'..user_id..'^7')
            TriggerEvent("playerConnect", user_id, source)
            playersProcessed = playersProcessed + 1
        end
    end
    
    -- ✅ FEEDBACK FINAL
    if playersFound == 0 then
        print('^7[^3VRP^7] Nenhum player online para reprocessar. Sistema ^2PRONTO^7!')
    else
        print('^7[^2VRP^7] Reprocessamento ^2FINALIZADO^7! Players processados: ^2'..playersProcessed..'^7/^2'..playersFound..'^7')
    end
end)