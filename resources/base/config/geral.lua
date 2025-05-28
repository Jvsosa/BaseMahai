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
    -- identity-{user_id} será gerado pelo sistema
}

Config.StarterBank = 5000  --Dinheiro inicial no banco
-- Config.SpawnPosition = Posicao de spawn inicial (se enableSpawnPosition for true)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGURAÇÕES DO SERVIDOR
-----------------------------------------------------------------------------------------------------------------------------------------
Config.ServerInfo = {
    gameType = "Mahai City",
    mapName = "www.Mahai-Store.com"
}

Config.General = {
    enableSpawnPosition = false,  -- Se true, usa Config.SpawnPosition
    autoGenerateIdentity = true   -- Se true, gera identity automaticamente
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOKS
-----------------------------------------------------------------------------------------------------------------------------------------
Config.Webhooks = {
    playerConnect = ""  -- Adicione seu webhook aqui se necessário
}

