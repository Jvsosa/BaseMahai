-- Configuração: altere o valor para ajustar a velocidade da corrida (1.0 = padrão do GTA V)
local RUN_SPEED = 1.2

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if IsPedSprinting(ped) then
            SetRunSprintMultiplierForPlayer(PlayerId(), RUN_SPEED)
        else
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
        end
    end
end)

-- Restaura stamina aos poucos para aumentar o tempo de corrida (~20 segundos)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500) -- a cada 0.5 segundo
        local ped = PlayerPedId()
        if IsPedSprinting(ped) then
            RestorePlayerStamina(PlayerId(), 0.025) -- valor baixo para ~20s de corrida
        end
    end
end)