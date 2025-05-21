-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("checkin",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentCheckin()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local PoliceQtd = 0
		local policia = vRP.getUsersByPermission("Paramedic")
		for k,v in pairs(policia) do
			PoliceQtd = PoliceQtd + 1
		end

		if PoliceQtd < 1 then
			if vRP.request(source,"Prosseguir o tratamento por <b>$2000</b> dólares?","Sim","Não") then
				if vRP.paymentFull(user_id,2000) then
					vRP.upgradeHunger(user_id,20)
					vRP.upgradeThirst(user_id,20)
					vRP.upgradeStress(user_id,10)
					TriggerEvent("Repose",source,user_id,900)
					return true
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Existe <b>medicos</b> em servico.",5000)
		end
	end

	return false
end