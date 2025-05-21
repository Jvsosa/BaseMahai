RegisterNetEvent("Progress")
AddEventHandler("Progress",function(time)

	SendNUIMessage({ time = tonumber(time) })
end)



