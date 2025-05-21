local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

ftsC = Tunnel.getInterface("fts_registradora")

local Blips = {}

local cooldown = 0

CreateThread(function()
    while true do
        sleep = 1000
        for k,v in pairs(Lojinhas) do 
            local ped = PlayerPedId()
            local pCDS = GetEntityCoords(ped)
            local cds = vector3(v.x,v.y,v.z)
            local distance = #(pCDS - cds)
            if distance <= 2 then
                sleep = 4
                if distance <= 0.5 then
                    sleep = 4

                    drawText2D("PRESSIONE  ~r~E~w~  PARA ~r~ROUBAR~w~ A CAIXA REGISTRADORA",4,0.5,0.93,0.50,255,255,255,180)
                    if IsControlJustPressed(0,38) then
                        if cooldown <= 0 then
                            ftsC.CheckRoubo(k,v.x,v.y,v.z,v.h)
                            cooldown = 30
                        else
                            TriggerEvent("Notify","vermelho","Espere "..cooldown.." segundos para assaltar novamente!",5000)
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

Citizen.CreateThread(function()
	while cooldown do
		Citizen.Wait(1000)
		if cooldown then
			if cooldown >= 1 then
				cooldown = cooldown - 1
			end
		end
	end
end)

RegisterNetEvent("fts:AdicionarCDS")
AddEventHandler("fts:AdicionarCDS",function(x,y,z)
    Blips = AddBlipForCoord(x,y,z)
    SetBlipSprite(Blips, 161)
    SetBlipColour(Blips, 5)
    AddTextEntry('Chamar:Policia', 'Ocorrência policial')
    BeginTextCommandSetBlipName('Chamar:Policia')
    EndTextCommandSetBlipName(Blips)
    Wait(30000)
    RemoveBlip(Blips)
end)

function drawText2D(text,font,x,y,scale,r,g,b,a)    
    SetTextFont(font)    
    SetTextScale(scale,scale)    
    SetTextColour(r,g,b,a)    
    SetTextOutline()    
    SetTextCentre(1)    
    SetTextEntry('STRING')    
    AddTextComponentString(text)    
    DrawText(x,y)
end