local menuactive = false
local elevatorIndex = nil

function ToggleActionMenu()
	menuactive = not menuactive

	if menuactive then
		SetNuiFocus(true, true)
		
		SendNUIMessage({ showmenu = true, data = elevators[elevatorIndex] })
		TriggerEvent("hideHud")
	else
		elevatorIndex = nil
		SetNuiFocus(false)
		StopScreenEffect("MenuMGSelectionIn")
		SendNUIMessage({ hidemenu = true })
		TriggerEvent("showHud")
	end
end

RegisterNUICallback("ButtonClick",function(data,cb)
	local ped = PlayerPedId()
	print(elevators[elevatorIndex][data])
	if elevators[elevatorIndex][data] then
		local cds = elevators[elevatorIndex][data].coordTp
		DoScreenFadeOut(1000)
		ToggleActionMenu()

		SetTimeout(1400, function()
			SetEntityCoords(ped, cds.x, cds.y, cds.z,0,0,0,0)
			SetEntityHeading(ped, cds.h)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			DoScreenFadeIn(1000)
		end)
	end

	if data == "nothing" then
		TriggerEvent("Notify","negado","Botão quebrado.")
		-- TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^5Negado: ^0Botao Quebrado.')
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

Citizen.CreateThread(function()
	SetNuiFocus(false, false)
	TransitionFromBlurred(1000)
	elevatorIndex = nil

	while true do
		local sleep = 1000

		for i, e in pairs(elevators) do
			for k, v in pairs(e) do
				v = v.blip

				local ped = PlayerPedId()
				local x, y, z = table.unpack(GetEntityCoords(ped))
				local bowz, cdz = GetGroundZFor_3dCoord(v.x, v.y, v.z)
				local distance = GetDistanceBetweenCoords(v.x, v.y, cdz, x, y, z,true)
				local elevator = v

				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), elevator.x, elevator.y, elevator.z, true ) <= 5 then
					sleep = 5

					DrawMarker(41, elevator.x, elevator.y, elevator.z-0.6,0,0,0,0,0,0,0.2,0.2,0.3,  255, 255,255,100 ,false,0,0,1)
					DrawMarker(27, elevator.x, elevator.y, elevator.z-0.7,0,0,0,0,0,0,0.4,0.4,0.5, 255, 255,255,100 ,false,0,0,1)
					DrawMarker(1, elevator.x, elevator.y, elevator.z-1,0,0,0,0,0,0,0.4,0.4,0.4, 93, 144,245,100 ,false,0,0,1)

					if IsControlJustPressed(0,38) then
						elevatorIndex = i
						StartScreenEffect("MenuMGSelectionIn", 0, true)
						ToggleActionMenu()
					end
				end

			end
		end

		Citizen.Wait(sleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end