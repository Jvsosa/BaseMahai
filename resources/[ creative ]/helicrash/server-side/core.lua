-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Boxes = 0
local Cooldown = os.time()
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Helicrash"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('helicrash', function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			Boxes = 0
			local Selected = math.random(#Components)
			for Number,v in pairs(Components[Selected]) do
				if Number ~= "1" then
					Boxes = Boxes + 1
					local Loot = math.random(#Loots)
					vRP.remSrvdata("stackChest:Helicrash:"..Number,false)
					vRP.setSrvdata("stackChest:Helicrash:"..Number,Loots[Loot],false)
				end
			end

			TriggerClientEvent("Notify", -1, "amarelo", "Mayday! Mayday! Tivemos problemas técnicos em nossos motores e estamos em queda livre.",60000)
			GlobalState["Helicrash"] = Selected
			Cooldown = os.time() + 3600
		end
	end
end)


CreateThread(function()
	while true do
		if Timers[os.date("%H:%M")] and os.time() >= Cooldown then
			Boxes = 0
			local Selected = math.random(#Components)
			for Number,v in pairs(Components[Selected]) do
				if Number ~= "1" then
					Boxes = Boxes + 1

					local Loot = math.random(#Loots)
					vRP.remSrvdata("stackChest:Helicrash:"..Number)
					vRP.setSrvdata("stackChest:Helicrash:"..Number,Loots[Loot])
				end
			end

			TriggerClientEvent("Notify", -1, "amarelo", "Mayday! Mayday! Tivemos problemas técnicos em nossos motores e estamos em queda livre.",60000)
			GlobalState["Helicrash"] = Selected
			Cooldown = os.time() + 3600
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOX
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Box",function()
	if GlobalState["Helicrash"] then
		Boxes = Boxes - 1

		if Boxes <= 0 then
			GlobalState["Helicrash"] = false
			Boxes = 0
		end
	end
end)