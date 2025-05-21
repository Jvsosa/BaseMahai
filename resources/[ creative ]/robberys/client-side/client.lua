-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("robberys",cRP)
vSERVER = Tunnel.getInterface("robberys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local robberys = {}
local robberyId = "1"
local robberyTimer = 0
local robberySeconds = 0
local robberyActive = false
local activeTimers = GetGameTimer()

function cRP.getPosition()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
	return x,y,z
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
	
			if not robberyActive then
		
				for k,v in pairs(robberys) do
					local distance = #(coords - vector3(v["coords"][1],v["coords"][2],v["coords"][3]))
			
					if distance <= 5 then
						timeDistance = 1
						DrawMarker(36, v["coords"][1],v["coords"][2],v["coords"][3]-0.6,0,0,0,0,0,0,0.2,0.2,0.3,  255, 255,255,100 ,false,0,0,1)
						DrawMarker(27, v["coords"][1],v["coords"][2],v["coords"][3]-0.7,0,0,0,0,0,0,0.4,0.4,0.5, 255, 255,255,100 ,false,0,0,1)
						DrawMarker(1, v["coords"][1],v["coords"][2],v["coords"][3]-1,0,0,0,0,0,0,0.4,0.4,0.4, 93, 144,245,100 ,false,0,0,1)
						if IsControlJustPressed(1,38) and robberySeconds <= 0 then
							robberySeconds = 5
						
				
	
							if vSERVER.checkRobbery(k) then
							
								robberyId = k
								robberyTimer = v["timer"]
								activeTimers = GetGameTimer()

								vSERVER.AlertarPMs(v["coords"][1],v["coords"][2],v["coords"][3],k.name)
								SendNUIMessage({ show = true, timer = "AGUARDE "..robberyTimer.." SEGUNDOS" })

								robberyActive = true
							end
						end
					end
				end
			else
				local distance = #(coords - vector3(robberys[robberyId]["coords"][1],robberys[robberyId]["coords"][2],robberys[robberyId]["coords"][3]))
				if distance > robberys[robberyId]["distance"] or GetEntityHealth(ped) <= 101 then
					SendNUIMessage({ show = false })
					robberyActive = false
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if robberyActive then
			if GetGameTimer() >= activeTimers then
				robberyTimer = robberyTimer - 1
				activeTimers = GetGameTimer() + 1000
				SendNUIMessage({ timer = "AGUARDE "..robberyTimer.." SEGUNDOS" })

				if robberyTimer <= 0 then
					vSERVER.paymentRobbery(robberyId)
					SendNUIMessage({ show = false })
					robberyActive = false
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSECONDS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if robberySeconds > 0 then
			robberySeconds = robberySeconds - 1
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INPUTROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.inputRobberys(robberyTables)
	robberys = robberyTables

	print('teste')

	local innerTable = {}
	for k,v in pairs(robberys) do
		table.insert(innerTable,{ v["coords"][1],v["coords"][2],v["coords"][3],1,"E",v["name"],"Pressione para iniciar o roubo" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end



RegisterNetEvent("RB:AdicionarCDS")
AddEventHandler("RB:AdicionarCDS",function(x,y,z)
    Blips = AddBlipForCoord(x,y,z)
    SetBlipSprite(Blips, 161)
    SetBlipColour(Blips, 11)
    AddTextEntry('Chamar:Policia', 'Roubo')
    BeginTextCommandSetBlipName('Chamar:Policia')
    EndTextCommandSetBlipName(Blips)
    Wait(30000)
    RemoveBlip(Blips)
end)
