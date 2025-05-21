-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local serviceList = {
	{ 2507.82,-347.16,94.09,"Police",1.8,6 },
	{ -2187.66,3187.85,32.82,"Exercito",1.8,6 },
	--{ 1852.85,3687.79,34.07,"Sheriff-1",1.0,17 },
	--{ -447.28,6013.01,32.41,"Sheriff-2",1.0,17 },
	{ 1840.20,2578.48,46.07,"Corrections",1.0,24 },
	--{ 385.43,794.42,187.48,"Ranger",1.0,69 },
	--{ 382.01,-1596.39,29.91,"State",1.0,11 },
	{ 1144.37,-1543.05,35.03,"Paramedic-1",1.0,6 },
	{ -813.75,-1236.11,8.14,"Paramedic-2",1.8,6 },
	{ -813.89,-1236.68,7.33,"Paramedic-3",1.5,6 },
	{ 153.16,-3052.8,7.04,"Mechanic",1.8,6 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for k,v in pairs(serviceList) do
		print(k,v[1],v[2],v[3])
		exports["target"]:AddCircleZone("service:"..v[4],vector3(v[1],v[2],v[3]),0.75,{
			name = "service:"..v[4],
			heading = 3374176
		},{
			shop = k,
			distance = 3,
			options = {
				{
					label = "Entrar em Serviço",
					event = "service:Toggle",
					tunnel = "shop"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Toggle")
AddEventHandler("service:Toggle",function(Service)
	TriggerServerEvent("service:Toggle",serviceList[Service][4],serviceList[Service][6])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:LABEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Label")
AddEventHandler("service:Label",function(Service,Text)
	if Service == "Police" then
		exports["target"]:LabelText("service:Sheriff-1",Text)
		exports["target"]:LabelText("service:Police",Text)
	elseif Service == "Paramedic" then
		exports["target"]:LabelText("service:Paramedic-1",Text)
		exports["target"]:LabelText("service:Paramedic-2",Text)
		exports["target"]:LabelText("service:Paramedic-3",Text)
	else
		exports["target"]:LabelText("service:"..Service,Text)
	end
end)