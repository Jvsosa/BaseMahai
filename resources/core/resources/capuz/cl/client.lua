local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
local bool = false


RegisterNetEvent("setCapuz")
AddEventHandler("setCapuz",function(cb)
    local ped = PlayerPedId()
    bool = cb
    SendNUIMessage({ show = bool})
    if bool then
        SetPedComponentVariation(ped,1,194,1,2)
        enableThread()
    else 
        DisplayRadar(true)
        SetPedComponentVariation(ped,1,0,0,2)
    end

end)


function enableThread()
    while true do
        Wait(1)
        DisplayRadar(false)
        DisableControlAction(0, 200, true) -- esc
        DisableControlAction(0, 199, true) -- esc
        if not bool then return end
    end
end