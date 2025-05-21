Citizen.CreateThread(function()
    while true do
        -- Remove wanted level
        ClearPlayerWantedLevel(PlayerId())
        SetPlayerWantedLevel(PlayerId(), 0, false)
        SetPlayerWantedLevelNow(PlayerId(), false)

        -- Remove hostile NPC blips (red circles)
        local playerPed = PlayerPedId()
        local blip = GetFirstBlipInfoId(7) -- 7 = radius blip (hostile)
        while DoesBlipExist(blip) do
            RemoveBlip(blip)
            blip = GetNextBlipInfoId(7)
        end

        -- Remove minimap flashing
        SetRadarAsExteriorThisFrame()
        SetRadarAsInteriorThisFrame(GetHashKey("v_michael"), 0.0, 0.0, 0.0, 0, 0)

        Citizen.Wait(500)
    end
end)
