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

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOKS CENTRALIZADOS
-----------------------------------------------------------------------------------------------------------------------------------------
Config.Webhooks = {
    -- WEBHOOKS PRINCIPAIS
    playerConnect = "https://discord.com/api/webhooks/1135699628860379246/434F1LIII9PjR_bkIHLpOi-gcUWwao1mRm2xBNJFHVtQxa1qbuyG35OIlJ4um6r0D8P2",
    registro = "https://discord.com/api/webhooks/1135699628860379246/434F1LIII9PjR_bkIHLpOi-gcUWwao1mRm2xBNJFHVtQxa1qbuyG35OIlJ4um6r0D8P2",
    addss = "https://discord.com/api/webhooks/1130290237592064092/fQ_H0Gy5zr1FH8ecpwppa5csrQ6NIby8xWjJFserI4jturhULRoAK45HT3r-scYP2Uch",
    
    -- WEBHOOKS ADMIN COMANDOS
    god = "https://discord.com/api/webhooks/1135699628860379246/434F1LIII9PjR_bkIHLpOi-gcUWwao1mRm2xBNJFHVtQxa1qbuyG35OIlJ4um6r0D8P2",
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

