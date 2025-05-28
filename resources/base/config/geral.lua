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
    kick = "https://discord.com/api/webhooks/1135699628860379246/434F1LIII9PjR_bkIHLpOi-gcUWwao1mRm2xBNJFHVtQxa1qbuyG35OIlJ4um6r0D8P2",
    give = "https://discord.com/api/webhooks/1135699628860379246/434F1LIII9PjR_bkIHLpOi-gcUWwao1mRm2xBNJFHVtQxa1qbuyG35OIlJ4um6r0D8P2",
    ban = "https://discord.com/api/webhooks/1135699628860379246/434F1LIII9PjR_bkIHLpOi-gcUWwao1mRm2xBNJFHVtQxa1qbuyG35OIlJ4um6r0D8P2",
    adminaddgroup = "https://discord.com/api/webhooks/1135699628860379246/434F1LIII9PjR_bkIHLpOi-gcUWwao1mRm2xBNJFHVtQxa1qbuyG35OIlJ4um6r0D8P2",
    adminremgroup = "https://discord.com/api/webhooks/1135699628860379246/434F1LIII9PjR_bkIHLpOi-gcUWwao1mRm2xBNJFHVtQxa1qbuyG35OIlJ4um6r0D8P2",
    noclip = "https://discord.com/api/webhooks/1135699628860379246/434F1LIII9PjR_bkIHLpOi-gcUWwao1mRm2xBNJFHVtQxa1qbuyG35OIlJ4um6r0D8P2",
    teleport = "https://discord.com/api/webhooks/1135699628860379246/434F1LIII9PjR_bkIHLpOi-gcUWwao1mRm2xBNJFHVtQxa1qbuyG35OIlJ4um6r0D8P2",
    
    -- OUTROS WEBHOOKS
    unban = "",
    addcar = "",
    remcar = "",
    fix = "",
    announce = "",
    priority = "",
    delete = "",
    gems = "",
    itemall = "",
    console = "",
    debug = "",
    anticheat = "",
}

