-- 🚀 MAHAI CREATIVE - CONFIGURAÇÕES GERAIS
Config = Config or {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGURAÇÕES DE SPAWN INICIAL
-----------------------------------------------------------------------------------------------------------------------------------------
Config.StarterItems = {
    ["sandwich"] = 5,
    ["soda"] = 5,
    ["cellphone"] = 1,
    ["dollars"] = 7000,
}

Config.StarterBank = 5000
Config.ServerInfo = {
    gameType = "Mahai City",
    mapName = "www.Mahai-Store.com"
}

Config.General = {
    enableSpawnPosition = false,
    autoGenerateIdentity = true
}

Config.Basico = {
    radios = {
        { channel = 911, perm = "Police.permission" },
        { channel = 112, perm = "admin.permission" },
        { channel = 113, perm = "admin.permission" }

    }
}



Config = Config or {}

Config.Toggle = {
    ['Paramedic'] = { 
        blip = { x = 1127.35, y = -1621.46, z = 34.87 },
        webhook = "",
        MarcarGPS = { ativo = true, nome = "Hospital", cor = 23 },
        cargos = {
            [1] = { em_servico = "Diretor-Paramedic", fora_de_servico = "waitDiretor-Paramedic" },
            [2] = { em_servico = "Gerente-Paramedic", fora_de_servico = "waitGerente-Paramedic" },
            [3] = { em_servico = "Paramedic", fora_de_servico = "waitParamedic" },
        }
    },
    ['Cafe'] = { 
        blip = { x = -593.96, y = -1052.45, z = 22.34 },
        webhook = "",
        cargos = {
            [1] = { em_servico = "Chefe-Cafe", fora_de_servico = "waitChefe-Cafe" },
            [2] = { em_servico = "Gerente-Cafe", fora_de_servico = "waitGerente-Cafe" },
            [3] = { em_servico = "Cafe", fora_de_servico = "waitCafe" },
        }
    },
    ['Police'] = { 
        blip = { x = 2507.82, y = -347.16, z = 94.09 },
        webhook = "",
        cargos = {
            [1] = { em_servico = "Police", fora_de_servico = "waitpolice" },
        }
    },
    ['Exercito'] = { 
        blip = { x = -2187.66, y = 3187.85, z = 32.82 },
        webhook = "",
        cargos = {
            [1] = { em_servico = "Exercito", fora_de_servico = "waitExercito" },
        }
    },
    ['Corrections'] = { 
        blip = { x = 1840.20, y = 2578.48, z = 46.07 },
        webhook = "",
        cargos = {
            [1] = { em_servico = "Corrections", fora_de_servico = "waitCorrections" },
        }
    },
    ['Mechanic'] = { 
        blip = { x = 153.16, y = -3052.8, z = 7.04 },
        webhook = "",
        cargos = {
            [1] = { em_servico = "Mechanic", fora_de_servico = "waitMechanic" },
        }
    },
}

-- ADICIONAR NOVA SEÇÃO PARA COORDENADAS DOS SERVIÇOS
Config.ServiceLocations = {
    { 2507.82, -347.16, 94.09, "Police", 1.8, 6 },
    { -2187.66, 3187.85, 32.82, "Exercito", 1.8, 6 },
    --{ 1852.85, 3687.79, 34.07, "Sheriff-1", 1.0, 17 },
    --{ -447.28, 6013.01, 32.41, "Sheriff-2", 1.0, 17 },
    { 1840.20, 2578.48, 46.07, "Corrections", 1.0, 24 },
    --{ 385.43, 794.42, 187.48, "Ranger", 1.0, 69 },
    --{ 382.01, -1596.39, 29.91, "State", 1.0, 11 },
    { 1144.37, -1543.05, 35.03, "Paramedic-1", 1.0, 6 },
    { -813.75, -1236.11, 8.14, "Paramedic-2", 1.8, 6 },
    { -813.89, -1236.68, 7.33, "Paramedic-3", 1.5, 6 },
    { 153.16, -3052.8, 7.04, "Mechanic", 1.8, 6 }
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOKS CENTRALIZADOS
-----------------------------------------------------------------------------------------------------------------------------------------
Config.Webhooks = {
    -- WEBHOOKS PRINCIPAIS
    playerConnect = "https://discord.com/api/webhooks/1135699628860379246/434F1LIII9PjR_bkIHLpOi-gcUWwao1mRm2xBNJFHVtQxa1qbuyG35OIlJ4um6r0D8P2",
    registro = "https://discord.com/api/webhooks/1135699628860379246/434F1LIII9PjR_bkIHLpOi-gcUWwao1mRm2xBNJFHVtQxa1qbuyG35OIlJ4um6r0D8P2",
    addss = "https://discord.com/api/webhooks/1130290237592064092/fQ_H0Gy5zr1FH8ecpwppa5csrQ6NIby8xWjJFserI4jturhULRoAK45HT3r-scYP2Uch",
    
    -- WEBHOOKS ADMIN COMANDOS
    god = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    kick = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    give = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    ban = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    adminaddgroup = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    adminremgroup = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    noclip = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    tpway = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    tpto = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    tptome = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    tuning = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    fix = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    setmochila = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    resetmochila = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    limparinv = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    carcolor = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    kickall = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    limparea = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    gem = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    remgem = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    money = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    wl = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    unwl = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",

    -- OUTROS WEBHOOKS
    unban = "https://discord.com/api/webhooks/1377326641113731122/8dVnisbP_q6l9UIDTS0eQMZG2GUVKKZlghndjjZYZWSft8YajwX0ELfFcnl18b2Ir2lJ",
    addcar = "",
    remcar = "",
    announce = "",
    priority = "",
    delete = "",
    gems = "",
    itemall = "",
    console = "",
    debug = "",
    anticheat = "",
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO WEBHOOK CENTRALIZADA
-----------------------------------------------------------------------------------------------------------------------------------------
function SendWebhook(type, data)
    local webhook = Config.Webhooks[type]
    if webhook and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers) 
            -- Opcional: log de erro se necessário
            if err ~= 200 then
                print("" .. type)
            end
        end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
    else
        print("^3[WEBHOOK WARNING]^7 Webhook não configurado para: " .. type)
    end
end

-- Tornar a função global
_G.SendWebhook = SendWebhook

return Config