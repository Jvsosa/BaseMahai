-- Configuração: altere o valor para ajustar a velocidade da corrida (1.0 = padrão do GTA V)
local RUN_SPEED = 1.2

-- ✅ OTIMIZAÇÃO: Cache PlayerPed
local playerPed = PlayerPedId()
local playerId = PlayerId()

-- Atualizar cache a cada 5 segundos
Citizen.CreateThread(function()
    while true do
        playerPed = PlayerPedId()
        playerId = PlayerId()
        Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100) -- Otimizado de 0 para 100ms
        
        if IsPedSprinting(playerPed) then
            SetRunSprintMultiplierForPlayer(playerId, RUN_SPEED)
        else
            SetRunSprintMultiplierForPlayer(playerId, 1.0)
        end
    end
end)

-- 🚀 STAMINA AUMENTADA - 45 SEGUNDOS DE CORRIDA
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500) -- Aumentado para 500ms (menos frequente)
        
        if IsPedSprinting(playerPed) then
            -- ✅ CORRIGIDO: Valor baixo para stamina controlada
            RestorePlayerStamina(playerId, 0.045) -- ~45 segundos de corrida
        end
    end
end)