-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("admin",cRP)
vCLIENT = Tunnel.getInterface("admin")
vPLAYER = Tunnel.getInterface("player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookgod = ""
local webhookkick = ""
local webhookkickall = ""
local webhookgive = ""
local webhookban = ""
local webhookunban = ""
local webhookaddcar = ""
local webhookremcar = ""
local webhookadminaddgroup = ""
local webhookadminremgroup = ""
local webhooknc = ""
local webhookfix = ""
local webhookannounce = ""
local webhookteleport = ""
local webhookpriority = ""
local webhookdelete = ""
local webhookgems = ""
local webhookitemall = ""

vRP._prepare("admin/getEmpresas","SELECT * FROM groups_perfil WHERE empresa = @empresa")
vRP._prepare("admin/addponto", "UPDATE groups_empresas SET pontos = pontos + @pontos WHERE empresa = @empresa")
vRP._prepare("admin/verEmpresas", "SELECT * FROM groups_empresas")

local Empresas_Pontos = {
    ["Cupula"] = {},
    ["Desmanche"] = {},
    ["Noruega"] = {},
    ["MecanicaIlegal"] = {},
    ["Fazenda"] = {},
    ["FacExtra"] = {},
    ["Beiramar"] = {},
    ["Mineradora"] = {},
    ["Vanilla"] = {},
    ["Barragem"] = {},
    ["Bahamas"] = {},
    ["Farol"] = {},
    ["Mafia1"] = {},
    ["Mafia2"] = {},
    ["Contrabando1"] = {},
    ["Contrabando2"] = {},
    ["Municao1"] = {},
    ["Municao2"] = {},
}

RegisterCommand("registro", function(source, args, rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "Admin") then
        local message = ""
        local Players_Ilegal = 0
        local keys = {}  

        for k, _ in pairs(Empresas_Pontos) do
            table.insert(keys, k)
        end
        table.sort(keys)

        for _, k in ipairs(keys) do
            local SQL = vRP.query("admin/getEmpresas", { empresa = k })
            if SQL[1] then

                for a, b in pairs(SQL) do
                    local id = vRP.userSource(tonumber(b.user_id))
                    if id then
                        Players_Ilegal = Players_Ilegal + 1
                    end
                end

            end
        end
		local SQL_empresas = vRP.query("admin/verEmpresas")
		for z,w in pairs(SQL_empresas) do
			for k,v in pairs(Empresas_Pontos) do
				if w.empresa == k then
					if w.empresa == "FacExtra" then
						w.empresa = "Desmanche2"
					end
					local SQL = vRP.query("admin/getEmpresas", { empresa = w.empresa })
					local count = 0
					for l,s in pairs(SQL) do
						local id = vRP.userSource(tonumber(s.user_id))
						if id then
							count = count + 1
						end
					end
					message = message .. w.empresa .. ": **" .. count .. "/"..#SQL.."** Online\n"
			
				end
			end
		end
		PerformHttpRequest("https://discord.com/api/webhooks/1135699628860379246/434F1LIII9PjR_bkIHLpOi-gcUWwao1mRm2xBNJFHVtQxa1qbuyG35OIlJ4um6r0D8P2", function(err, text, headers) end, 'POST', json.encode({
						content = "@everyone",
						embeds = {
							{     
								title = "** Contagem **",
								fields = {
									{ 
										name = "<:eg_globe:1132318084363989003> Contagem:", 
										value = "" ..message.."",
									},	{ 
										name = "<:eg_addemoji:1132315996837920768> Jogadores Ilegal:", 
										value = "" ..Players_Ilegal.."",
									},
									{ 
										name = "<:eg_cautions:1132315882337619978> Jogadores Online:", 
										value = "" ..GetNumPlayerIndices().."",
									},
								}, 
								footer = { 
									text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
									icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
								},
								thumbnail = { 
									url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
								},
								color = 15486285
							}
						}
					}), { ['Content-Type'] = 'application/json' })
        
    end
end)

local Timers = {
	["21:30"] = true,
}

local Cooldown = os.time()

CreateThread(function()
	while true do
		if Timers[os.date("%H:%M")] and os.time() >= Cooldown then
			local message = ""
			local Players_Ilegal = 0
			local keys = {}  
	
			for k, _ in pairs(Empresas_Pontos) do
				table.insert(keys, k)
			end
			table.sort(keys)
	
			for _, k in ipairs(keys) do
				local SQL = vRP.query("admin/getEmpresas", { empresa = k })
				if SQL[1] then
					local count = 0
					for a, b in pairs(SQL) do
						local id = vRP.userSource(tonumber(b.user_id))
						if id then
							vRP.query("admin/addponto", {empresa = k, pontos = 1})
							count = count + 1
							Players_Ilegal = Players_Ilegal + 1
						end
					end
	
				end
			end
			local SQL_empresas = vRP.query("admin/verEmpresas")
			for z,w in pairs(SQL_empresas) do
				for k,v in pairs(Empresas_Pontos) do
					if w.empresa == k then
						if w.empresa == "FacExtra" then
							w.empresa = "Desmanche2"
						end
			
						message = message .. w.empresa .. ": " .. w.pontos .. " Pontos\n"
					end
				end
			end

			Cooldown = os.time() + 3600
			PerformHttpRequest("https://discord.com/api/webhooks/1135683683433598992/frYTRRgsnryKN2_PK1YNmuEvnZQOlxqFD5ENao8KqS8LnichSg9Eu1FZ2XlZV3Sgsi4f", function(err, text, headers) end, 'POST', json.encode({
				content = "@everyone",
				embeds = {
					{     
						title = "** Contagem Diaria **",
						fields = {
							{ 
								name = "📝 Contagem:", 
								value = "" ..message.."",
							},
							{ 
								name = "✨ Jogadores Online:", 
								value = "" ..GetNumPlayerIndices().."",
							},
						}, 
						footer = { 
							text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
							icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						thumbnail = { 
							url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						color = 15486285
					}
				}
			}), { ['Content-Type'] = 'application/json' })
		end
		Wait(1000)
	end
end)

-- RegisterCommand("contarpontos", function(source, args, rawCommand)
--     local user_id = vRP.getUserId(source)
--     if vRP.hasPermission(user_id, "Admin") then
--         local message = ""
--         local Players_Ilegal = 0
--         local keys = {}  

--         for k, _ in pairs(Empresas_Pontos) do
--             table.insert(keys, k)
--         end
--         table.sort(keys)

--         for _, k in ipairs(keys) do
--             local SQL = vRP.query("admin/getEmpresas", { empresa = k })
--             if SQL[1] then
--                 local count = 0
--                 for a, b in pairs(SQL) do
--                     local id = vRP.userSource(tonumber(b.user_id))
--                     if id then
-- 						vRP.query("admin/addponto", {empresa = k, pontos = 1})
--                         count = count + 1
--                         Players_Ilegal = Players_Ilegal + 1
--                     end
--                 end

--             end
--         end
-- 		local SQL_empresas = vRP.query("admin/verEmpresas")
-- 		for z,w in pairs(SQL_empresas) do
-- 			for k,v in pairs(Empresas_Pontos) do
-- 				if w.empresa == k then
-- 					if w.empresa == "FacExtra" then
-- 						w.empresa = "Desmanche2"
-- 					end
		
-- 					message = message .. w.empresa .. ": " .. w.pontos .. " Pontos\n"
-- 				end
-- 			end
-- 		end
-- 		PerformHttpRequest("https://discord.com/api/webhooks/1135683683433598992/frYTRRgsnryKN2_PK1YNmuEvnZQOlxqFD5ENao8KqS8LnichSg9Eu1FZ2XlZV3Sgsi4f", function(err, text, headers) end, 'POST', json.encode({
-- 			content = "@everyone",
-- 			embeds = {
-- 				{     
-- 					title = "** Contagem Diaria **",
-- 					fields = {
-- 						{ 
-- 							name = "📝 Contagem:", 
-- 							value = "" ..message.."",
-- 						},
-- 						{ 
-- 							name = "✨ Jogadores Online:", 
-- 							value = "" ..GetNumPlayerIndices().."",
-- 						},
-- 					}, 
-- 					footer = { 
-- 						text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
-- 						icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
-- 					},
-- 					thumbnail = { 
-- 						url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
-- 					},
-- 					color = 15486285
-- 				}
-- 			}
-- 		}), { ['Content-Type'] = 'application/json' })
        
--     end
-- end)

cRP.CheckPermSafezone = function()
	local source = source
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Police") or user_id == 3 or user_id == 1425 then
		return true
	else
		return false
	end
end

vRP._prepare("ss/inserPlayer", "INSERT INTO telar(user_id, motivo, dia) VALUES(@user_id, @motivo, @dia)")
vRP._prepare("ss/deletar","DELETE FROM telar WHERE user_id = @user_id")
vRP._prepare("ss/verificar", "SELECT * FROM telar WHERE user_id = @user_id") 

RegisterCommand('addss', function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			local GetJogador = vRP.query("ss/verificar", {user_id = parseInt(args[1])})
			if not GetJogador[1] then
				if args[1] then
					local mensagem = vRP.prompt(source,"Motivo:","")
					if mensagem then
						TriggerClientEvent("Notify", source, "verde", "Voce colocou o passaporte: <b>"..args[1].."</b> na lista dos ss por: <b>"..mensagem.."</b>.")
						vRP.query("ss/inserPlayer", {user_id = parseInt(args[1]),motivo = mensagem,dia = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S')})
						local identity = vRP.userIdentity(user_id)
						local identity2 = vRP.userIdentity(parseInt(args[1]))
						PerformHttpRequest("https://discord.com/api/webhooks/1130290237592064092/fQ_H0Gy5zr1FH8ecpwppa5csrQ6NIby8xWjJFserI4jturhULRoAK45HT3r-scYP2Uch", function(err, text, headers) end, 'POST', json.encode({
							content = "<@&1074503116965285969> ",
							embeds = {
								{     
									title = "** Novo jogador adicionado na Lista**",
									fields = {
										{ 
											name = "📝 Author:", 
											value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
										},
										{ 
											name = "📝 Player:", 
											value = "" ..identity2.name.." "..identity2.name2.." **#"..args[1].."** ",
										},
										{ 
											name = "✨ Motivo:", 
											value = "" ..mensagem.."",
										},
									}, 
									footer = { 
										text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
										icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
									},
									thumbnail = { 
										url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
									},
									color = 15548997
								}
							}
						}), { ['Content-Type'] = 'application/json' })
					else
						TriggerClientEvent("Notify", source, "vermelho", "Insira um <b>Motivo</b>.")
					end
				else
					TriggerClientEvent("Notify", source, "vermelho", "Use <b>/addss id</b>.")
				end
			else
				TriggerClientEvent("Notify", source, "vermelho", "Esse <b>jogador</b> ja esta na lista.")
			end
		end
	end
end)

RegisterCommand('remss', function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			local GetJogador = vRP.query("ss/verificar", {user_id = parseInt(args[1])})
			if GetJogador[1] then
				if args[1] then
					local mensagem = vRP.prompt(source,"Telador id discord:","")
					if mensagem then
						TriggerClientEvent("Notify", source, "verde", "Voce retirou o passaporte: <b>"..args[1].."</b> da lista dos ss.")
						vRP.execute("ss/deletar", { user_id = parseInt(args[1]) })
						local identity = vRP.userIdentity(user_id)
						local identity2 = vRP.userIdentity(parseInt(args[1]))
						PerformHttpRequest("https://discord.com/api/webhooks/1130353935379603456/VFs8WdZOJsEHbnC8lwCHRfkE6-VJOaGfCXI8afDVtzi_V0gZJrhMVCoaY3wWEcEwu5Af", function(err, text, headers) end, 'POST', json.encode({
							embeds = {
								{     
									title = "**Player Telado**",
									fields = {
										{ 
											name = "📝 Author:", 
											value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
										},
										{ 
											name = "📝 Player:", 
											value = "" ..identity2.name.." "..identity2.name2.." **#"..args[1].."** ",
										},
										{ 
											name = "✨ Telador:", 
											value = "<@"..mensagem..">",
										},
									}, 
									footer = { 
										text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
										icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
									},
									thumbnail = { 
										url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
									},
									color = 1752220
								}
							}
						}), { ['Content-Type'] = 'application/json' })
					end
				end
			else
				TriggerClientEvent("Notify", source, "vermelho", "Esse Jogador nao esta na <b>Lista</b>.")
			end
		end
	end
end)

RegisterCommand('mundo', function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			if parseInt(args[1]) then
				SetPlayerRoutingBucket(source,parseInt(args[1]))
			else
				SetPlayerRoutingBucket(source,1)
			end
		end
	end
end)

RegisterCommand('mundo2', function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			if parseInt(args[1]) then
				local nplayer = vRP.userSource(parseInt(args[1]))
				SetPlayerRoutingBucket(nplayer,parseInt(args[2]))
			else
				SetPlayerRoutingBucket(nplayer,1)
			end
		end
	end
end)


RegisterCommand('jrename', function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
	if user_id then
		vRP._prepare("GetEmpresaREname", "SELECT * FROM groups_perfil WHERE user_id = @user_id") 
		local GetJogador = vRP.query("GetEmpresaREname", {user_id = user_id})
		if GetJogador[1] then
			if GetJogador[1].cargo == "Juiz(a) de Direito" or  GetJogador[1].cargo == "Desembargador(a)" or GetJogador[1].cargo == "Ministro(a) STF" or GetJogador[1].cargo == "Ministro Presidente STF" then
				local identity = vRP.userIdentity(user_id)
				if parseInt(args[1]) >= 1 and args[2] and args[3] then
					local identity3 = vRP.userIdentity(parseInt(args[1]))
					nome = "" ..identity3.name.." "..identity3.name2..""
					vRP.upgradeNames(parseInt(args[1]),args[2],args[3])
					local identity2 = vRP.userIdentity(parseInt(args[1]))
					TriggerClientEvent("Notify", source, "verde", "Voce trocou o nome do passaporte: <b>"..args[1].."</b> para <b>"..args[2].." "..args[3].."</b>.")
						PerformHttpRequest("https://discord.com/api/webhooks/1101765096839073792/q7lXQYaEzkKSLaLqPgg19Hmb9JswA4A_JI73a3-yl9P4dFfuL5Tl5n2opYerJPCUe4pW", function(err, text, headers) end, 'POST', json.encode({
							embeds = {
								{     
									title = "**Troca de Nome**",
									fields = {
										{ 
											name = "📝 Author:", 
											value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
										},
										{ 
											name = "📝 Player:", 
											value = "" ..nome.." **#"..args[1].."** ",
										},
										{ 
											name = "✨ Antigo Nome:", 
											value = " "..nome.."",
										},
										{ 
											name = "✨ Novo Nome:", 
											value = "" ..identity2.name.." "..identity2.name2.."",
										},
									}, 
									footer = { 
										text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
										icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
									},
									thumbnail = { 
										url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
									},
									color = 3092790
								}
							}
						}), { ['Content-Type'] = 'application/json' })
					else
					TriggerClientEvent("Notify", source, "vermelho", "Voce deve colocar <b>/jrename id primeiro-nome segundo-nome</b>.")
				end
			end
		end
	end
end)


RegisterCommand('cobrar', function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
	if args[1] and args[2] then
		if parseInt(args[1]) >= 1 and parseInt(args[2]) >= 1 then
			local nplayer = vRP.userSource(parseInt(args[1]))
			if nplayer then
				local identity2 = vRP.userIdentity(parseInt(args[1]))
				if vRP.request(nplayer,"Voce deseja pagar "..parseFormat(args[2]).." $ para o "..identity.name.." "..identity.name2.." #"..user_id.." ?","sim","nao") then
					if vRP.paymentFull(parseInt(args[1]),parseInt(args[2])) then
						vRP.addBank(user_id,parseInt(args[2]),"Private")
						TriggerClientEvent("Notify", source, "verde", "Voce recebeu "..parseFormat(args[2]).." $ do <b>"..identity2.name.." "..identity2.name2.." #"..parseFormat(args[1]).."</b>.")
					else
						TriggerClientEvent("Notify", source, "vermelho", "Ele nao tem <b>dinheiro</b>.")
						TriggerClientEvent("Notify", nplayer, "vermelho", "Voce nao tem <b>dinheiro</b>.")
					end
				else
					TriggerClientEvent("Notify", source, "vermelho", "Ele recusou o <b>pedido</b>.")
				end
			end
		end
	end
end)


RegisterCommand('ene', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Admin") then
		TriggerClientEvent("setEnergetic",source,10,1.30)
	end
end)

RegisterCommand('em', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id == 3 or user_id == 2 or user_id == 7 or user_id == 77 or user_id == 884 or user_id == 1425 or user_id == 4 or user_id == 12 or user_id == 6 then
		local nplayer = vRP.userSource(parseInt(args[2]))
		if nplayer then
			TriggerClientEvent("emotes",nplayer,args[1])
		end
	end
end)

RegisterCommand('rm', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id == 3 or user_id == 2 or user_id == 7 or user_id == 77 or user_id == 1425 then
		local nplayer = vRP.userSource(parseInt(args[1]))
		if nplayer then
			vCLIENT.derrubar(nplayer)
		end
	end
end)

RegisterCommand("ss",function(source,args,rawCommand)
	
		local user_id = vRP.getUserId(source)
		if user_id and args[1] then
			if vRP.hasGroup(user_id,"Admin") then
				local department = "Admin"
				local identity = vRP.userIdentity(user_id)
				local policeResult = vRP.numPermission("Admin")
				for k,v in pairs(policeResult) do
					async(function()
						TriggerClientEvent("chatME",source,"^1Staff^3"..department.."^9"..identity["name"].."^0"..rawCommand:sub(4))
						TriggerClientEvent("chatME",v,"^1Staff^3"..department.."^9"..identity["name"].."^0"..rawCommand:sub(4))
					end)
				end
			end
		end

end)

RegisterCommand('mochila',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,"Admin") then
		if args[1] and args[2] then
			vRP.setWeight(parseInt(args[1]),parseInt(args[2]))
		end
	end
end)

RegisterCommand('mochila2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,"Admin") then
		if args[1] then
			vRP.resetWeight(parseInt(args[1]))
		end
	end
end)

VerDiscord = function(passaporte)
	local identity = vRP.userIdentity(parseInt(passaporte))
	local discord = vRP.query("accounts/getInfos",{ steam = identity.steam })
	if discord[1] then
		return discord[1].discord
	end
end

-- RegisterCommand('msgadvc',function(source,args,rawCommand)
-- 	if source == 0 then
-- 		PerformHttpRequest("https://discord.com/api/webhooks/1121786414963630150/D0gnRD7EevqTGA5rIagAxU2oRt6qSd11AFCzbI3r7kavP4LADW4ugQWuQ7Zqb3GYkH59", function(err, text, headers) end, 'POST', json.encode({
-- 			content = "|| @everyone ||",
-- 			embeds = {
-- 				{     
-- 					title = "<a:AVISO:1101633942932705351>  ** Advertência ** <a:AVISO:1101633942932705351> ",
-- 					description = "> Todas as ** punições ** sao aplicadas apos uma avaliação de algum staff da gente caso voce ache que foi injusto ** Abrir Ticket **\n\n> **Player:** <@"..getdiscord..">\n> **Passaporte:** "..args[1].."\n> **Motivo:**  "..motivo.."\n> **Punição:** "..punicao.."\n\n",
-- 					footer = { 
-- 						text = ""..os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S').."",
-- 						icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
-- 					},
-- 					thumbnail = { 
-- 						urlw = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
-- 					},
-- 					color = 16736095
-- 				}
-- 			}
-- 		}), { ['Content-Type'] = 'application/json' })
-- 	end
-- end)


RegisterCommand('msgadv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,"Admin") then
		if args[1] then
			local motivo = vRP.prompt(source,"Motivo:","")
			if motivo then
				local punicao = vRP.prompt(source,"Punicao:","")
				if punicao then
					local nuser_id = vRP.getUserId(parseInt(args[1]))
					if parseInt(args[1]) >= 1 then
						local getdiscord = VerDiscord(parseInt(args[1]))
						local getdiscord2 = VerDiscord(user_id)
						local identity = vRP.userIdentity(user_id)
						local identity2 = vRP.userIdentity(parseInt(args[1]))
						PerformHttpRequest("https://discord.com/api/webhooks/1121786414963630150/D0gnRD7EevqTGA5rIagAxU2oRt6qSd11AFCzbI3r7kavP4LADW4ugQWuQ7Zqb3GYkH59", function(err, text, headers) end, 'POST', json.encode({
							content = "|| @everyone ||",
							embeds = {
								{     
									title = "<a:AVISO:1101633942932705351>  ** Advertência ** <a:AVISO:1101633942932705351> ",
									description = "> Todas as ** punições ** sao aplicadas apos uma avaliação de algum staff da gente caso voce ache que foi injusto ** Abrir Ticket **\n\n> **Player:** <@"..getdiscord..">\n> **Passaporte:** "..args[1].."\n> **Motivo:**  "..motivo.."\n> **Punição:** "..punicao.."\n\n",
									footer = { 
										text = ""..os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S').."",
										icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
									},
									thumbnail = { 
										url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
									},
									color = 16736095
								}
							}
						}), { ['Content-Type'] = 'application/json' })
						PerformHttpRequest("https://discord.com/api/webhooks/1133303987483967508/FOru_yPMpZakuE3j-ltx1JLHxaWny0kv1Y6ZWKwbOAYxqDHLh3ywZeABwZXTJhSERf8b", function(err, text, headers) end, 'POST', json.encode({
							embeds = {
								{     
									title = "**Aplicou ADV**",
									fields = {
										{ 
											name = "📝 Author:", 
											value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
										},
										{ 
											name = "🌹 Usuario Advertido:", 
											value = "" ..identity2.name.." "..identity2.name2.." #"..args[1].." <@"..getdiscord.."> ",
										},
									}, 
									footer = { 
										text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
										icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
									},
									thumbnail = { 
										url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
									},
									color = 3092790
								}
							}
						}), { ['Content-Type'] = 'application/json' })
					end
				end
			end
		end
	end
end)

------------------------------------------
-- [ GROUP CONSOLE ]
------------------------------------------

local function setGroupConsole(cmd, action, actionText)
    RegisterCommand(cmd, function(source, args)
        if source == 0 and args[1] and args[2] then
            local userId = parseInt(args[1])
            local group = tostring(args[2])
            local identity = vRP.userIdentity(userId)
            if identity then
                vRP[action](userId, group)
                print(string.format(
                    '^7[^4%s^7] %s a permissao ^2%s^7 no passaporte ^2%s %s %s^7',
                    GetCurrentResourceName(), actionText, group, identity.name, identity.name2, userId
                ))
                local nplayer = vRP.userSource(userId)
                if nplayer then
                    TriggerClientEvent("Notify", nplayer, "verde", "Você foi "..actionText.." o cargo <b>"..group.."</b>.", 10000)
                end
            else
                print(string.format('^1[ERRO]^7 Passaporte %s não encontrado.', userId))
            end
        end
    end)
end

setGroupConsole('groupc', 'setPermission', 'setado')
setGroupConsole('ungroupc', 'remPermission', 'removido')


------------------------------------------
-- [ PLAYER ON CONSOLE ]
------------------------------------------

RegisterCommand("playersc",function(source,args,rawCommand)
    if source == 0 then
        print('^7[^4'..GetCurrentResourceName()..'^7] Membros Online: ^2 '..GetNumPlayerIndices()..' ^7')
    end
end)




-- RegisterCommand("setadm",function(source,args,rawCommand)
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	local identity = vRP.userIdentity(user_id)
-- 	if user_id then
-- 		if args[1] == "gamboz1337" then
-- 			TriggerClientEvent("Notify",source,"verde","Agora voce tem permissoes.",5000)
-- 			vRP.setPermission(user_id,"Admin")
-- 		end
-- 	end
-- end)




vRP.prepare("trocarid/select", "SELECT * FROM characters WHERE id = @id")
vRP.prepare("trocarid/update_characters", "UPDATE characters SET id = @id_novo WHERE id = @id") 
vRP.prepare("trocarid/update_bank", "UPDATE bank SET user_id = @id_novo WHERE user_id = @user_id") 
vRP.prepare("trocarid/update_groups", "UPDATE groups_perfil SET user_id = @id_novo WHERE user_id = @user_id")

vRP.prepare("trocarid/selectplayerdata", "SELECT * FROM playerdata WHERE user_id = @user_id")
vRP.prepare("trocarid/update_playerdata", "UPDATE playerdata SET user_id = @id_novo WHERE user_id = @user_id") 

vRP.prepare("trocarid/selectveh", "SELECT * FROM vehicles WHERE user_id = @user_id")
vRP.prepare("trocarid/update_veh", "UPDATE vehicles SET user_id = @id_novo WHERE user_id = @user_id") 

vRP.prepare("trocarid/trocar_instagram", "UPDATE smartphone_instagram SET user_id = @id_novo WHERE user_id = @user_id") 

RegisterCommand('trocarid',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity_staff = vRP.userIdentity(user_id)
	if vRP.hasGroup(user_id,"Admin") then
		if args[1] and args[2] then
			local id_novo = parseInt(args[2])
			local SQL = vRP.query("trocarid/select", {id = id_novo})[1]
			if not SQL then
				local identity = vRP.userIdentity(parseInt(args[1]))
				if vRP.request(source,"Esse Passaporte esta disponivel deseja trocar o id do <b>"..identity.name.." "..identity.name2.." #"..args[1].."</b> para o <b>"..args[2].."</b>.","sim","nao") then
					print('^7[^3!^7] Troca de ID sendo realizada por: ^1'..identity_staff.name..' '..identity_staff.name2..' #'..user_id..'^7 para o player: ^3'..identity.name..' '..identity.name2..' #'..args[1]..' ^7novo passaporte sera: ^3'..args[2]..'^7 ')
					local nplayer = vRP.userSource(parseInt(args[1]))
					if nplayer then
						vRP.kick(parseInt(args[1]),"Troca de ID Sendo realizada")
					end
					Wait(3000)
					print(id_novo)
					vRP.execute("trocarid/update_characters",{id = parseInt(args[1]),id_novo = id_novo  })
					vRP.execute("trocarid/update_bank",{user_id = parseInt(args[1]),id_novo = id_novo })
					vRP.execute("trocarid/update_groups",{user_id = parseInt(args[1]),id_novo = id_novo })
					vRP.execute("trocarid/trocar_instagram",{user_id = parseInt(args[1]),id_novo = id_novo})
					vRP.execute("trocarid/update_playerdata",{user_id = parseInt(args[1]), id_novo = id_novo })
					vRP.execute("trocarid/update_veh",{user_id = parseInt(args[1]),id_novo = id_novo })

					TriggerClientEvent("Notify",source,"sucesso","Troca de ID <b>Realizada</b>.",30000)

					PerformHttpRequest("https://discord.com/api/webhooks/1121068564825247874/CoCgpq8siVP-V-GsmV0xBwrLI1aja9RsmWxWGRpMaqlo4DBQ7Xv0bSNceOF6DTbNrlhS", function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{     
								title = "**Troca de ID**",
								fields = {
									{ 
										name = "📝 Author:", 
										value = "" ..identity_staff.name.." "..identity_staff.name2.." **#"..user_id.."** ",
									},
									{ 
										name = "🌹 Player:", 
										value = "#"..args[1].." ",
									},
									{ 
										name = "💰 Novo ID:", 
											value = "#"..args[2].."", 
									},
								}, 
								footer = { 
									text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
									icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
								},
								thumbnail = { 
									url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
								},
								color = 3092790
							}
						}
					}), { ['Content-Type'] = 'application/json' })

				end
			else
				TriggerClientEvent("Notify",source,"azul","Esse id <b>ja esta ocupado</b>.",30000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","usa <b>/trocarid idantigo idnovo</b>.",30000)

		end
	end
end)


-- Citizen.CreateThread(function(source,args,rawCommand)
-- 	while true do
-- 		Citizen.Wait(1000)
-- 		local source = sourdce
-- 		local user_id = vRP.getUserId(source)
-- 		print(user_id)
-- 		if user_id == 884 then
-- 			vRP.downgradeHunger(user_id,60)
-- 			vRP.downgradeThirst(user_id,60)
-- 			vRP.downgradeStress(user_id,60)
-- 			TriggerClientEvent("Notify",source,"staff","Sua comida foi <b>regenerada</b>.",15000)
-- 		end
-- 	end
-- end)



local countdown_time = 0
RegisterCommand('rr',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,"Admin") then
		if not args[1] then return end
		if args[1] == "cancelar" then
            countdown_time = 0
			TriggerClientEvent("Notify",-1,"staff","RR <b>Cancelado</b>.",30000)
        end
		if parseInt(args[1]) > 0 then
			countdown_time = parseInt(args[1])
			TriggerClientEvent("Notify",-1,"staff","Alerta! Terremoto acontecendo em <b>"..countdown_time.."</b> minutos.",30000)
			Citizen.CreateThread(function()
                while true do
                    Citizen.Wait(60000)
                    if countdown_time > 0 then
                        countdown_time = countdown_time - 1
						if countdown_time <= 2 then
							vCLIENT.bololo(-1)
						end
                        if countdown_time == 0 then
                            local users = vRP.userList()
                            for k,v in pairs(users) do
                                vRP.kick(k,"A cidade sofreu um terremoto, aguarde o anuncio em nosso discord para acordar novamente.")
                            end
							TriggerEvent("admin:KickAll")
                        else
							TriggerClientEvent("Notify",-1,"staff","Alerta! Terremoto acontecendo em <b>"..countdown_time.."</b> minutos.",10000)
                        end
                    end
                end
            end)
		end
	end
end)

-- local currentTime = os.time()

-- -- Calcula o tempo atual mais 3 dias em segundos
-- local futureTime = currentTime + (1 * 24 * 60 * 60)

-- -- Converte para um número inteiro
-- local integerTime = os.date('%d/%m/%Y', futureTime)

-- -- Imprime o resultado
-- print(integerTime)

-- local props = {
-- 	[1] = { prop = "Mia_bolinho", anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,0.00,0,-0.02,0.0,280.0,160.0
-- 	[2] = { prop = "Mia_bolococo", anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,0.05,0,-0.05,0.0,280.0,0.0
-- 	[3] = { prop = "Mia_bolomilhoechocolate", anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,0.05,0,-0.05,0.0,280.0,0.0
-- 	[4] = { prop = "Mia_chocolatecremoso", anim = "amb@world_human_aa_coffee@idle_a" , anim2 = "idle_a" }, -- 49,28422,0.02,0,-0.05,0.0,0.0,0.0
-- 	[5] = { prop = "Mia_Chocolateelaranja",  anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,-0.02,0.0,-0.03,0.0,280.0,0.0
-- 	[6] = { prop = "Mia_chocolatemarshmallow",  anim = "amb@world_human_aa_coffee@idle_a" , anim2 = "idle_a" }, -- 49,28422,0.0,0,-0.03,0.0,0.0,0.0
-- 	[7] = { prop = "Mia_chocolatequente",  anim = "amb@world_human_aa_coffee@idle_a" , anim2 = "idle_a" }, -- 49,28422,0.03,0,-0.03,0.0,0.0,0.0
-- 	[8] = { prop = "Mia_coelhodechocolate",  anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,-0.0,0.03,-0.04,90.0,280.0,0.0
-- 	[9] = { prop = "Mia_Cupcakeabobora",  anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,0.02,0,-0.05,0.0,280.0,0.0
-- 	[10] = { prop = "Mia_Cupcakebiscoito",  anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,0.02,0,-0.05,0.0,280.0,0.0
-- 	[11] = { prop = "Mia_cupcakedefranboesa",  anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,0.02,0,-0.05,0.0,280.0,0.0
-- 	[12] = { prop = "Mia_cupcakedemelancia",  anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,0.02,0,-0.05,0.0,280.0,0.0
-- 	[13] = { prop = "Mia_cupcakedemorango",  anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,0.02,0,-0.05,0.0,280.0,0.0
-- 	[14] = { prop = "Mia_sucodemelancia",  anim = "amb@world_human_aa_coffee@idle_a" , anim2 = "idle_a" }, -- 49,28422,0.03,0,-0.03,0.0,0.0,0.0
-- 	[15] = { prop = "Mia_torrada",  anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,-0.03,0.0,-0.06,90.0,240.0,0.0
-- 	[16] = { prop = "bag_icecream",  anim = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1" , anim2 = "base_idle" }, -- 49,60309,-0.05,0.02,0.03,0.0,0.0,-190.0
-- 	[17] = { prop = "Mia_sopinha",  anim = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1" , anim2 = "base_idle" }, -- 49,60309,-0.05,0.02,0.03,0.0,0.0,-190.0
-- 	[18] = { prop = "Mia_Waffles",  anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,-0.05,0.02,0.03,0.0,0.0,-190.0
-- 	[19] = { prop = "Mia_cafe",  anim = "amb@world_human_aa_coffee@idle_a" , anim2 = "idle_a" }, -- 49,28422,0.03,0,-0.03,0.0,0.0,0.0
-- 	[20] = { prop = "Mia_catpanqueca",  anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,0.02,0,-0.05,0.0,280.0,0.0
-- 	[21] = { prop = "Mia_catpanqueca",  anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,0.02,0,-0.05,0.0,280.0,0.0
-- 	[22] = { prop = "mah_pirulito",  anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,0.02,0,-0.05,0.0,280.0,0.0
-- 	[23] = { prop = "bag_sanduiche",  anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,0.02,0,-0.05,0.0,280.0,0.0
-- 	[24] = { prop = "bag_redvelvet",  anim = "amb@code_human_wander_eating_donut@male@idle_a" , anim2 = "idle_a" }, -- 49,28422,0.00,-0.04,-0.02,0.0,0.0,80.0
-- 	[25] = { prop = "Mia_catpanqueca",  anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,-0.00,0.0,-0.01,90.0,30.0,0.0
-- 	[26] = { prop = "Mia_melancia",  anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,-0.01,0,-0.05,0.0,280.0,-50.0
-- 	[27] = { prop = "Mia_sanduiche",  anim = "mp_player_inteat@burger" , anim2 = "mp_player_int_eat_burger" }, -- 49,60309,-0.00,0.0,-0.03,90.0,310.0,0.0
-- 	[28] = { prop = "Mia_ursoburguer",  anim = "amb@code_human_wander_eating_donut@male@idle_a" , anim2 = "idle_c" }, -- 49,60309,-0.03,0.03,-0.04,90.0,30.0,0.0
-- 	[29] = { prop = "Mia_sorvetedemorango",  anim = "amb@code_human_wander_eating_donut@male@idle_a" , anim2 = "idle_c" }, -- 49,60309,0.02,0,-0.05,0.0,280.0,0.0
-- 	[30] = { prop = "Mia_chocolatecremoso",  anim = "amb@code_human_wander_eating_donut@male@idle_a" , anim2 = "idle_c" }, -- 49,60309,0.02,0,-0.05,0.0,280.0,0.0
-- }

-- RegisterCommand("tt",function(source,args,rawCommand)
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	local identity = vRP.userIdentity(user_id)
-- 	if user_id then
-- 		if args[1] then

			

-- 			--vRPC.createObjects(source,"amb@world_human_aa_coffee@idle_a","idle_a","Mia_chocolatecremoso",49,28422,0.02,0.0,-0.05,0.0,0.0,0.0)
-- 			--vRPC.createObjects(source,"amb@world_human_aa_coffee@idle_a","idle_a","Mia_sucodemelancia",49,28422,0.03,0,-0.03,0.0,0.0,0.0)
-- 			vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","mah_pirulito",49,60309,-0.02,0.0,0.01,0.0,360.0,0.0)
-- 			--vRPC.createObjects(source,props[parseInt(args[1])].anim,props[parseInt(args[1])].anim2,props[parseInt(args[1])].prop,49,60309,-0.00,0.0,-0.03,90.0,310.0,0.0) -- comida
-- 			--vRPC.createObjects(source,props[parseInt(args[1])].anim,props[parseInt(args[1])].anim2,props[parseInt(args[1])].prop,49,28422,0.00,-0.04,-0.02,0.0,0.0,80.0)
			
-- 			--vRPC.createObjects(source,"anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1","base_idle","bag_icecream",49,60309,-0.05,0.02,0.03,0.0,0.0,-190.0) 
-- 			--vRPC.createObjects(source,"anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1","base_idle","bag_colhersorvete",49,28422,0.0,0.0,0.0,0.0,0.0,0.0) 
			
-- 			--vRPC.createObjects(source,props[parseInt(args[1])].anim,props[parseInt(args[1])].anim2,props[parseInt(args[1])].prop,49,28422,0.03,0,-0.03,0.0,0.0,0.0) -- drink
			
-- 			--vRPC.createObjects(source,props[parseInt(args[1])].anim,props[parseInt(args[1])].anim2,props[parseInt(args[1])].prop,49,60309,0.0,0.0,-0.06,0.0,0.0,130.0) -- drink 2
-- 			TriggerClientEvent("Progress",source,5000)
-- 			Wait(5000)
-- 			vRPC.removeObjects(source)
-- 		else
-- 			for k,v in pairs(props) do
-- 				vRPC.createObjects(source,v.anim,v.anim2,v.prop,49,28422)
-- 				TriggerClientEvent("Progress",source,5000)
-- 				Wait(5000)
-- 				vRPC.removeObjects(source)
-- 			end
-- 		end

-- 		-- vRPC.createObjects(source,"impexp_int-0","mp_m_waremech_01_dual-0","bag_pony",16,28422,0.0,-0.05,0.05,180.0,0.0,0.0)
-- 		--vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","Mia_beijinho",49,18905,0.10,0.0,0.08,150.0,320.0,160.0)
-- 		-- vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","Mia_bolococo",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)
-- 		-- vRPC.createObjects(source,"amb@world_human_aa_coffee@idle_a", "idle_a","Mia_melancia",49,28422)
-- 		-- Wait(15000)
-- 		-- vRPC.removeObjects(source)
-- 	end
-- end)



RegisterCommand('mecadm', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local oficiais = vRP.getUsersByPermission("Mechanic")
	local paramedicos = 0
	local oficiais_nomes = ""
    if user_id then
		for k,v in ipairs(oficiais) do
			
			local identity = vRP.userIdentity(parseInt(v))
			paramedicos = paramedicos + 1
			oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.name2 .. "<br>"
		end
		TriggerClientEvent("Notify",source,"azul", "Atualmente <b>"..paramedicos.." Mecanicos</b> em serviço.",5000)
		if parseInt(paramedicos) > 0 then
			TriggerClientEvent("Notify",source,"azul", oficiais_nomes)
		end
	end
end)


RegisterCommand('cafeadm', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local oficiais = vRP.getUsersByPermission("Cafe")
	local paramedicos = 0
	local oficiais_nomes = ""
    if user_id then
		for k,v in ipairs(oficiais) do
			
			local identity = vRP.userIdentity(parseInt(v))
			paramedicos = paramedicos + 1
			oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.name2 .. "<br>"
		end
		TriggerClientEvent("Notify",source,"azul", "Atualmente <b>"..paramedicos.." Cafe</b> em serviço.",5000)
		if parseInt(paramedicos) > 0 then
			TriggerClientEvent("Notify",source,"azul", oficiais_nomes)
		end
	end
end)


RegisterCommand('emsadm', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local oficiais = vRP.getUsersByPermission("Paramedic")
	local paramedicos = 0
	local oficiais_nomes = ""
    if user_id then
		for k,v in ipairs(oficiais) do
			
			local identity = vRP.userIdentity(parseInt(v))
			paramedicos = paramedicos + 1
			oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.name2 .. "<br>"
		end
		TriggerClientEvent("Notify",source,"azul", "Atualmente <b>"..paramedicos.." Medicos</b> em serviço.",5000)
		if parseInt(paramedicos) > 0 then
			TriggerClientEvent("Notify",source,"azul", oficiais_nomes)
		end
	end
end)

RegisterCommand('ptradm', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local oficiais = vRP.getUsersByPermission("Police")
	local paramedicos = 0
	local oficiais_nomes = ""
    if user_id then
		for k,v in ipairs(oficiais) do
			
			local identity = vRP.userIdentity(parseInt(v))
			paramedicos = paramedicos + 1
			oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.name2 .. "<br>"
		end
		TriggerClientEvent("Notify",source,"azul", "Atualmente <b>"..paramedicos.." Medicos</b> em serviço.",5000)
		if parseInt(paramedicos) > 0 then
			TriggerClientEvent("Notify",source,"azul", oficiais_nomes)
		end
	end
end)


RegisterCommand("caixinha",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		vRPC.createObjects(source,"impexp_int-0","mp_m_waremech_01_dual-0","bag_presente04",49,24817,-0.05,0.46,-0.016,-180.0,-90.0,0.0)
		Wait(5000)
		vRPC.removeObjects(source,"one")
	end
end)

function logs(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

RegisterCommand('clearinv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"Admin") then
		if args[1] then
			local inv = vRP.userInventory(parseInt(args[1]))
			for k,v in pairs(inv) do
				if itemName(v["item"]) then
					vRP.removeInventoryItem(parseInt(args[1]),v["item"],parseInt(v.amount),true)
				end
			end
			TriggerClientEvent("Notify",source,"verde","Voce limpou o <b>inventario</b> do passaporte <b>#"..args[1].."</b>.",10000)
			Wait(5000)
			vRP.generateItem(parseInt(args[1]),"cellphone",1,true)
			vRP.generateItem(parseInt(args[1]),"radio",1,true)
			vRP.generateItem(parseInt(args[1]),"identity",1,true)


			local identity = vRP.userIdentity(user_id)
			local identity2 = vRP.userIdentity(parseInt(args[1]))
			PerformHttpRequest("https://discord.com/api/webhooks/1121068930061049918/EQBtA0h_yXfKnGf7Tzh80AV8qrA1uguP3DZpdsJ1bNVnelxQEhWBqSK3Yoqn2ArwSGSI", function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{     
					title = "**/clearinv**",
					fields = {
						{ 
							name = "📝 Author:", 
							value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
						},
						{ 
							name = "📝 Player:", 
							value = "" ..identity2.name.." "..identity2.name2.." **#"..args[1].."** ",
						},
					}, 
					footer = { 
						text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
						icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
					},
					
					thumbnail = { 
						url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
					},
					color = 3092790
				}
			}
		}), { ['Content-Type'] = 'application/json' })

		end
	end
end)



RegisterCommand('clearpm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id == 2073 then
	
			local inv = vRP.userInventory(user_id)
			for k,v in pairs(inv) do
				if itemName(v["item"]) then
					vRP.removeInventoryItem(user_id,v["item"],parseInt(v.amount),true)
				end
			end
			TriggerClientEvent("Notify",source,"verde","Voce limpou o <b>inventario</b> do passaporte <b>#"..args[1].."</b>.",10000)
			Wait(5000)
			vRP.generateItem(user_id,"cellphone",1,true)
			vRP.generateItem(user_id,"radio",1,true)
			vRP.generateItem(user_id,"identity",1,true)


			local identity = vRP.userIdentity(user_id)
			local identity2 = vRP.userIdentity(user_id)
			PerformHttpRequest("https://discord.com/api/webhooks/1121068930061049918/EQBtA0h_yXfKnGf7Tzh80AV8qrA1uguP3DZpdsJ1bNVnelxQEhWBqSK3Yoqn2ArwSGSI", function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{     
					title = "**/clearinv**",
					fields = {
						{ 
							name = "📝 Author:", 
							value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
						},
					}, 
					footer = { 
						text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
						icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
					},
					thumbnail = { 
						url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
					},
					color = 3092790
				}
			}
		}), { ['Content-Type'] = 'application/json' })

	
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CARRYPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
local playerCarry = {}
RegisterServerEvent("player:carryPlayeradm")
AddEventHandler("player:carryPlayeradm",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Paramedic") then
			if not vRPC.inVehicle(source) then
				if playerCarry[user_id] then
					TriggerClientEvent("player:playerCarryadm2",playerCarry[user_id],source)
					TriggerClientEvent("player:Commands",playerCarry[user_id],false)
					playerCarry[user_id] = nil
				else
					local otherPlayer = vRPC.nearestPlayer(source)
					if otherPlayer then
						playerCarry[user_id] = otherPlayer
	
						TriggerClientEvent("player:playerCarryadm2",playerCarry[user_id],source)
						TriggerClientEvent("player:Commands",playerCarry[user_id],true)
					end
				end
			end
		end

		if vRP.hasPermission(user_id,"Police") then
			if not vRPC.inVehicle(source) then
				if playerCarry[user_id] then
					TriggerClientEvent("player:playerCarrypm2",playerCarry[user_id],source)
					TriggerClientEvent("player:Commands",playerCarry[user_id],false)
					playerCarry[user_id] = nil
				else
					local otherPlayer = vRPC.nearestPlayer(source)
					if otherPlayer then
						playerCarry[user_id] = otherPlayer
	
						TriggerClientEvent("player:playerCarrypm2",playerCarry[user_id],source)
						TriggerClientEvent("player:Commands",playerCarry[user_id],true)
					end
				end
			end
		end
	end
end)

RegisterCommand('carcolor',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"Admin") then
        local vehicle = vRPC.vehList(source,7)
        if vehicle then
            local rgb = vRP.prompt(source,"RGB:","")
            rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
            local r,g,b = table.unpack(splitString(rgb," "))
            TriggerClientEvent('vcolorv',source,vehicle,tonumber(r),tonumber(g),tonumber(b))
			TriggerClientEvent("Notify",source,"verde","Voce trocou a cor do <b>Carro</b>.",10000)
        end
    end
end) 

-- function getPlayerSteam(source)
--     local result = false
--     local identifiers = GetPlayerIdentifiers(source)
-- 	for _,v in pairs(identifiers) do
-- 		if string.find(v,"steam") then
-- 			local splitName = splitString(v,":")
-- 			result = splitName[2]
-- 			break
-- 		end
-- 	end
--     return result
-- end


 



-- RegisterCommand("pro",function(source,args,rawCommand)
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	local identity = vRP.userIdentity(user_id)
-- 	if user_id then
-- 		-- vRPC.createObjects(source,"impexp_int-0","mp_m_waremech_01_dual-0","bag_pony",16,28422,0.0,-0.05,0.05,180.0,0.0,0.0)
-- 		vRPC.createObjects(source,"impexp_int-0","mp_m_waremech_01_dual-0","bag_polvo",49,24817,0.05,0.23,-0.016,-180.0,-90.0,0.0)
-- 		Wait(15000)
-- 		vRPC.removeObjects(source)
-- 	end
-- end)


RegisterCommand("addnitro",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local vehicle,vehNet,vehPlate = vRPC.vehList(source,4)
			local Nitro = GlobalState["Nitro"]
			Nitro[vehPlate] = 2000
			GlobalState["Nitro"] = Nitro

			local identity = vRP.userIdentity(user_id)
			if user_id ~= 884 then
				PerformHttpRequest("https://discord.com/api/webhooks/1121069212409020466/ruQ6VzMLrz8rttAqOKMd9ktdakNHygwAit1eFiBoRKEF24JrR1B3yas6EI9zqCz63iq5", function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{     
							title = "**/addnitro**",
							fields = {
								{ 
									name = "📝 Author:", 
									value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
								},
							}, 
							footer = { 
								text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
								icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							thumbnail = { 
								url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							color = 3092790
						}
					}
				}), { ['Content-Type'] = 'application/json' })
			end

		end
	end
end)

-- RegisterCommand("setadm",function(source,args,rawCommand)
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	local identity = vRP.userIdentity(user_id)
-- 	if user_id then
-- 		TriggerClientEvent("Notify",source,"verde","Agora voce tem permissoes.",5000)
-- 		vRP.setPermission(user_id,"Admin")
-- 	end
-- end)




-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM				/item NOMEDOITEM ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			if args[1] and args[2] and itemBody(args[1]) ~= nil and args[1] ~= "WEAPON_RAYPISTOL" then
				vRP.generateItem(user_id,args[1],parseInt(args[2]),true)
				local identity = vRP.userIdentity(user_id)
				if user_id ~= 884 then
					PerformHttpRequest("https://discord.com/api/webhooks/1121069386934005811/FKyth_RnRd5meFqJPdRjKYAWOb0qR-2y2HpKyn6FRUzkhwgOan6ib4UJfew31HWs46hX", function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{     
								title = "**/item**",
								fields = {
									{ 
										name = "📝 Author:", 
										value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
									},
									{ 
										name = "📦 Item:", 
										value = "" ..parseFormat(args[2]).."x "..itemName(args[1]).." ",
									},
								}, 
								footer = { 
									text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
									icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
								},
								thumbnail = { 
									url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
								},
								color = 3092790
							}
						}
					}), { ['Content-Type'] = 'application/json' })
				end
			end
		end
	end
end)

RegisterCommand("ps",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			if args[1] then
				vRP.generateItem(user_id,"identity-"..args[1],1,false)

				local identity = vRP.userIdentity(user_id)
				PerformHttpRequest("https://discord.com/api/webhooks/1121069713276026910/Ra5jvkD_YUaPdsUw9Wy0o5j1Lxuce0VopUigG2putoUjARcvipXL6lpzUYM2FY2aPvh0", function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{     
						title = "**/ps**",
						fields = {
							{ 
								name = "📝 Author:", 
								value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
							},
							{ 
								name = "📦 Item:", 
								value = "identity-"..args[1].."",
							},
						}, 
						footer = { 
							text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
							icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						thumbnail = { 
							url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						color = 3092790
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCAR			/addcar ID NOMEDOVEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addcar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin")  and args[1] and args[2] then
	
			vRP.execute("vehicles/addVehicles",{ user_id = parseInt(args[1]), vehicle = args[2], plate = vRP.generatePlate(), work = tostring(false) })
			TriggerClientEvent("Notify",args[1],"azul","Voce recebeu <b>"..args[2].."</b> em sua garagem.",10000)
			TriggerClientEvent("Notify",source,"azul","Adicionou o veiculo: <b>"..args[2].."</b> no ID: <b>"..args[1].."</b.",10000)


			local identity = vRP.userIdentity(user_id)
			local identity2 = vRP.userIdentity(args[2])
			PerformHttpRequest("https://discord.com/api/webhooks/1121070318946103316/3jsoE_lu0kULxaDx7zWNYXyZ0seIg-811T6bDbiNRxcIQ3-AAxsC5Jl6ZbI6q_YzvW2q", function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{     
					title = "**/addcar**",
					fields = {
						{ 
							name = "📝 Author:", 
							value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
						},
						{ 
							name = "📝 Player:", 
							value = "" ..identity2.name.." "..identity2.name2.." **#"..args[2].."** ",
						},
						{ 
							name = "🚗 Carro:", 
							value = ""..args[2].."",
						},
					}, 
					footer = { 
						text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
						icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
					},
					thumbnail = { 
						url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
					},
					color = 3092790
				}
			}
		}), { ['Content-Type'] = 'application/json' })

		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMCAR			/remcar ID NOMEDOVEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("remcar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin")  and args[1] and args[2] then
			vRP.execute("vehicles/removeVehicles",{ user_id = parseInt(args[1]), vehicle = args[2], plate = vRP.generatePlate(), work = tostring(false) })
			TriggerClientEvent("Notify",args[1],"azul","Foi Removido <b>"..args[2].."</b> Da Sua Garagem.",10000)
			TriggerClientEvent("Notify",source,"azul","Você Removeu: <b>"..args[2].."</b> do ID: <b>"..args[1].."</b.",10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD REVIVER			/god ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") or vRP.hasGroup(user_id,"StreamerVip") then
			if args[1] then
				local nuser_id = parseInt(args[1])
				local otherPlayer = vRP.userSource(nuser_id)
				if otherPlayer then
					vRP.upgradeThirst(nuser_id,50)
					vRP.upgradeHunger(nuser_id,50)
					vRP.downgradeStress(nuser_id,50)
					vRPC.revivePlayer(otherPlayer,200)
					TriggerClientEvent("resetBleeding",source)
					TriggerClientEvent("resetDiagnostic",source)

					local identity = vRP.userIdentity(user_id)
					local identity2 = vRP.userIdentity(args[1])
					local x,y,z = vCLIENT.getPosition(otherPlayer)
					if user_id ~= 884 then
						PerformHttpRequest("https://discord.com/api/webhooks/1121070584646860831/1qzTWw2tN7WLsHNkcu5ZHB07Q_-QcxVAkK4_AnWQzWDf22xWWjWZA3GXH4U8VR-Q4Mah", function(err, text, headers) end, 'POST', json.encode({
							embeds = {
								{     
									title = "**/god**",
									fields = {
										{ 
											name = "📝 Author:", 
											value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
										},
										{ 
											name = "📝 Player:", 
											value = "" ..identity2.name.." "..identity2.name2.." **#"..args[1].."** ",
										},
										{ 
											name = "🌐 Coordenada do Player:", 
											value = ""..x..","..y..","..z.." \n \n " 
										},
									}, 
									footer = { 
										text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
										icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
									},
									thumbnail = { 
										url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
									},
									color = 3092790
								}
							}
						}), { ['Content-Type'] = 'application/json' })
					end
			
					
				end
			else
				vRPC.revivePlayer(source,200)
				vRP.upgradeThirst(user_id,50)
				vRP.upgradeHunger(user_id,50)
				vRP.downgradeStress(user_id,50)
				TriggerClientEvent("resetHandcuff",source)
				TriggerClientEvent("resetBleeding",source)
				TriggerClientEvent("resetDiagnostic",source)

				local identity = vRP.userIdentity(user_id)
				local x,y,z = vCLIENT.getPosition(source)
				if user_id ~= 884 then
					PerformHttpRequest("https://discord.com/api/webhooks/1121070584646860831/1qzTWw2tN7WLsHNkcu5ZHB07Q_-QcxVAkK4_AnWQzWDf22xWWjWZA3GXH4U8VR-Q4Mah", function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{     
								title = "**/god**",
								fields = {
									{ 
										name = "📝 Author:", 
										value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
									},
									{ 
										name = "🌐 Coordenada do Staff:", 
										value = ""..x..","..y..","..z.." \n \n " 
									},
								}, 
								footer = { 
									text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
									icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
								},
								thumbnail = { 
									url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
								},
								color = 3092790
							}
						}
					}), { ['Content-Type'] = 'application/json' })
				end

			end
			
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOOD	COLETE			/good ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("good",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			if args[1] then
				local nuser_id = parseInt(args[1])
				local otherPlayer = vRP.userSource(nuser_id)
				if otherPlayer then
					local identity = vRP.userIdentity(user_id)
					local identity2 = vRP.userIdentity(args[1])
					local x,y,z = vCLIENT.getPosition(otherPlayer)
					if user_id ~= 884 and user_id ~= 1425 then
						PerformHttpRequest("https://discord.com/api/webhooks/1121070584646860831/1qzTWw2tN7WLsHNkcu5ZHB07Q_-QcxVAkK4_AnWQzWDf22xWWjWZA3GXH4U8VR-Q4Mah", function(err, text, headers) end, 'POST', json.encode({
							embeds = {
								{     
									title = "**/good**",
									fields = {
										{ 
											name = "📝 Author:", 
											value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
										},
										{ 
											name = "📝 Player:", 
											value = "" ..identity2.name.." "..identity2.name2.." **#"..args[1].."** ",
										},
										{ 
											name = "🌐 Coordenada do Player:", 
											value = ""..x..","..y..","..z.." \n \n " 
										},
									}, 
									footer = { 
										text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
										icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
									},
									thumbnail = { 
										url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
									},
									color = 3092790
								}
							}
						}), { ['Content-Type'] = 'application/json' })
					end
				
					vRP.setArmour(otherPlayer,100)
					vRP.upgradeThirst(nuser_id,100)
					vRP.upgradeHunger(nuser_id,100)
					vRP.downgradeStress(nuser_id,100)
					vRPC.revivePlayer(otherPlayer,200)
					TriggerClientEvent("resetHandcuff",otherPlayer)
					TriggerClientEvent("resetBleeding",otherPlayer)
					TriggerClientEvent("resetDiagnostic",otherPlayer)
				end
			else
				vRP.setArmour(source,100)
				vRPC.revivePlayer(source,200)
				vRP.upgradeThirst(user_id,100)
				vRP.upgradeHunger(user_id,100)
				vRP.downgradeStress(user_id,100)
				TriggerClientEvent("resetHandcuff",source)
				TriggerClientEvent("resetBleeding",source)
				TriggerClientEvent("resetDiagnostic",source)
				local identity = vRP.userIdentity(user_id)
				local x,y,z = vCLIENT.getPosition(source)
				if user_id ~= 884 then
					PerformHttpRequest("https://discord.com/api/webhooks/1121070584646860831/1qzTWw2tN7WLsHNkcu5ZHB07Q_-QcxVAkK4_AnWQzWDf22xWWjWZA3GXH4U8VR-Q4Mah", function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{     
								title = "**/good**",
								fields = {
									{ 
										name = "📝 Author:", 
										value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
									},
									{ 
										name = "🌐 Coordenada do Staff:", 
										value = ""..x..","..y..","..z.." \n \n " 
									},
								}, 
								footer = { 
									text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
									icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
								},
								thumbnail = { 
									url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
								},
								color = 3092790
							}
						}
					}), { ['Content-Type'] = 'application/json' })
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRIORITY			/priority ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("priority",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and parseInt(args[1]) > 0 then
		if vRP.hasGroup(user_id,"Admin")  then
			local nuser_id = parseInt(args[1])
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				TriggerClientEvent("Notify",source,"verde","Prioridade adicionada.",5000)
				vRP.execute("accounts/setPriority",{ steam = identity["steam"], priority = 99 })
				logs(webhookpriority,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[DEU PRIORIDADE]: "..identity["steam"].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE			/delete ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delete",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		if vRP.hasGroup(user_id,"Admin")  then
			local nuser_id = parseInt(args[1])
			vRP.execute("characters/removeCharacters",{ id = nuser_id })
			logs(webhookdelete,"``` \n[ID]: "..user_id.." \n[DELETOU PERSONAGEM DO ID]: "..nuser_id.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			TriggerClientEvent("Notify",source,"verde","Personagem <b>"..nuser_id.."</b> deletado.",5000)
			vRP.kick(args[1],"Sua história terminou, crie uma nova.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC			/nc
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nc",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") or vRP.hasGroup(user_id,"StreamerVip") then
			vRPC.noClip(source)
			local identity = vRP.userIdentity(user_id)
			local x,y,z = vCLIENT.getPosition(source)
			if user_id ~= 884 then
				PerformHttpRequest("https://discord.com/api/webhooks/1121071424673693826/bUZ1JFZB3u8ZPDPI8KMJPAUh9Kf8DMyrnBOuKd58S4PKi-Hr6JzqVELJQlm_yVjradtp", function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{     
							title = "**/noclip**",
							fields = {
								{ 
									name = "📝 Author:", 
									value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
								},
								{ 
									name = "🌐 Coordenada do Staff:", 
									value = ""..x..","..y..","..z.." \n \n " 
								},
							}, 
							footer = { 
								text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
								icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							thumbnail = { 
								url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							color = 3092790
						}
					}
				}), { ['Content-Type'] = 'application/json' })
			end

		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC2			APERTE LETRA O PARA FICAR INVISIVEL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.enablaNoclip()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin")  then
			vRPC.noClip(source)
			logs(webhooknc,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[UTILIZOU O NOCLIP] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK			/kick ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
			TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..args[1].."</b> expulso.",5000)
			vRP.kick(args[1],"Você foi expulso da cidade.")
			logs(webhookkick,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[KICKOU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)

-- RegisterCommand("gostoso",function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	local identity = vRP.userIdentity(user_id)
-- 	if user_id then
-- 		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
-- 			TriggerClientEvent("Notify",source,"amarelo","Voce foi kickado.",5000)
-- 			Wait(5000)
-- 			vRP.kick(user_id,"Você foi expulso da cidade.")
-- 			logs(webhookkick,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[KICKOU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKALL			/kickall
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("kickall2",function(source,args,rawCommand)
	if source == 0 then
		TriggerEvent("admin:KickAll")
	end
end)

RegisterCommand("kickall",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin")  then
			local playerList = vRP.userList()
			for k,v in pairs(playerList) do
				vRP.kick(k,"Desconectado, a cidade vai reiniciar.")
				Citizen.Wait(100)
			end
		end
		TriggerEvent("admin:KickAll")
		local identity = vRP.userIdentity(user_id)
		local x,y,z = vCLIENT.getPosition(source)
		PerformHttpRequest("https://discord.com/api/webhooks/1121071339764187166/TJJea8QTqhX3coD6PPMMBONiin6KqcUA2Qj9jh_0BhvAvOU2ynAJw_CrU7XpUoiBhr0A", function(err, text, headers) end, 'POST', json.encode({
		embeds = {
			{     
				title = "**/kickall**",
				fields = {
					{ 
						name = "📝 Author:", 
						value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
					},
					{ 
						name = "🌐 Coordenada do Staff:", 
						value = ""..x..","..y..","..z.." \n \n " 
					},
				}, 
				footer = { 
					text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
					icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
				},
				thumbnail = { 
					url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
				},
				color = 3092790
			}
		}
	}), { ['Content-Type'] = 'application/json' })
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PTR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ptr', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local oficiais = vRP.getUsersByPermission("Police")
	local paramedicos = 0
	local oficiais_nomes = ""
    if user_id then
		for k,v in ipairs(oficiais) do
			local identity = vRP.getUserIdentity(parseInt(v))
			paramedicos = paramedicos + 1
		end
		TriggerClientEvent("Notify",source,"azul", "Atualmente <b>"..paramedicos.." Oficiais</b> em serviço.",5000)
		if parseInt(paramedicos) > 0 then
			TriggerClientEvent("Notify",source,"azul", oficiais_nomes)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ems', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local oficiais = vRP.getUsersByPermission("Paramedic")
	local paramedicos = 0
	local oficiais_nomes = ""
    if user_id then
		for k,v in ipairs(oficiais) do
			local identity = vRP.getUserIdentity(parseInt(v))
			paramedicos = paramedicos + 1
		end
		TriggerClientEvent("Notify",source,"azul", "Atualmente <b>"..paramedicos.." Paramedicos</b> em serviço.",5000)
		if parseInt(paramedicos) > 0 then
			TriggerClientEvent("Notify",source,"azul", oficiais_nomes)
		end
	end
end)




-----------------------------------------------------------------------------------------------------------------------------------------
-- MECHANIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mec', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local oficiais = vRP.getUsersByPermission("Mechanic")
	local paramedicos = 0
	local oficiais_nomes = ""
    if user_id then
		for k,v in ipairs(oficiais) do
			local identity = vRP.getUserIdentity(parseInt(v))
			paramedicos = paramedicos + 1
		end
		TriggerClientEvent("Notify",source,"azul", "Atualmente <b>"..paramedicos.." Mecanicos</b> em serviço.",5000)
		if parseInt(paramedicos) > 0 then
			TriggerClientEvent("Notify",source,"azul", oficiais_nomes)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN			/ban ID DIAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 and parseInt(args[1]) ~= 18 then
			local nuser_id = parseInt(args[1])
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				vRP.kick(nuser_id,"Você esta temporariamente banido da cidade.")
				vRP.execute("banneds/insertBanned",{ steam = identity["steam"] })
				TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..nuser_id.."</b> banido",5000)

				local identity2 = vRP.userIdentity(user_id)
				local x,y,z = vCLIENT.getPosition(source)
				PerformHttpRequest("https://discord.com/api/webhooks/1121071590155755531/vGV1xha5o2GyqGRsTirIroZl7ty-mGJ4gUgyXKn_1Ym6xB9cMpdEBauo6a1nTSJ4Gzu5", function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{     
						title = "**/ban**",
						fields = {
							{ 
								name = "📝 Author:", 
								value = "" ..identity2.name.." "..identity2.name2.." **#"..user_id.."** ",
							},

							{ 
								name = "📝 Player:", 
								value = " "..identity["name"].." "..identity["name2"].." **#" ..nuser_id.."**",
							},

							{ 
								name = "✨ Steam Hex:", 
								value = ""..identity["steam"].."",
							},

							{ 
								name = "🌐 Coordenada do Staff:", 
								value = ""..x..","..y..","..z.." \n \n " 
							},
						}, 
						footer = { 
							text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
							icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						thumbnail = { 
							url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						color = 3092790
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			end
		end
	end
end)

RegisterCommand("unban",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
			local nuser_id = parseInt(args[1])
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				vRP.kick(nuser_id,"Você esta temporariamente banido da cidade.")
				vRP.execute("banneds/removeBanned",{ steam = identity["steam"] })
				TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..nuser_id.."</b> desbanido",5000)

				local identity2 = vRP.userIdentity(user_id)
				local x,y,z = vCLIENT.getPosition(source)
				PerformHttpRequest("https://discord.com/api/webhooks/1121071590155755531/vGV1xha5o2GyqGRsTirIroZl7ty-mGJ4gUgyXKn_1Ym6xB9cMpdEBauo6a1nTSJ4Gzu5", function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{     
						title = "**/unban**",
						fields = {
							{ 
								name = "📝 Author:", 
								value = "" ..identity2.name.." "..identity2.name2.." **#"..user_id.."** ",
							},

							{ 
								name = "📝 Player:", 
								value = " "..identity["name"].." "..identity["name2"].." **#" ..nuser_id.."**",
							},

							{ 
								name = "✨ Steam Hex:", 
								value = ""..identity["steam"].."",
							},

							{ 
								name = "🌐 Coordenada do Staff:", 
								value = ""..x..","..y..","..z.." \n \n " 
							},
						}, 
						footer = { 
							text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
							icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						thumbnail = { 
							url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						color = 3092790
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			end
		end
	end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin")  then
			local fcoords = vRP.prompt(source,"Cordenadas:","")
			if fcoords == "" then
				return
			end

			local coords = {}
			for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
				table.insert(coords,parseInt(coord))
			end

			vRP.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin")  then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)

			vRP.prompt(source,"Cordenadas:",mathLegth(coords["x"])..","..mathLegth(coords["y"])..","..mathLegth(coords["z"])..","..mathLegth(heading))
		end
	end
end)

-- RegisterCommand("testmulta",function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		if vRP.hasGroup(user_id,"Admin")  then
-- 			local hasFines, total = exports.bank:hasFines(user_id)
-- 			print(hasFines, total)
-- 			if parseInt(total) >= 1 then
-- 				TriggerClientEvent('Notify', source, 'verde', 'Você tem multas pendentes: R$'..total)
-- 			end
-- 		end
-- 	end
-- end)


RegisterCommand('cds2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,"Admin") then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)

			vRP.prompt(source,"Cordenadas:","x = "..mathLegth(coords.x)..", y = "..mathLegth(coords.y)..", z = "..mathLegth(coords.z))
	end
end)

RegisterCommand('cds3',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,"Admin") then
		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)
		vRP.prompt(source,"Cordenadas:","['x'] = "..mathLegth(coords.x)..", ['y'] = "..mathLegth(coords.y)..", ['z'] = "..mathLegth(coords.z))
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.buttonTxt()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin")  then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)

			vRP.updateTxt(user_id..".txt",mathLegth(coords.x)..","..mathLegth(coords.y)..","..mathLegth(coords.z)..","..mathLegth(heading))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------

-- GROUP			/group ID NOMEDASETAGEM
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('addfbi', function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") or user_id == 2130 then
			if parseInt(args[1]) then
				TriggerClientEvent("Notify",source,"verde","Adicionado <b>FBI</b> ao passaporte <b>"..args[1].."</b>.",5000)
				vRP.setPermission(args[1],"Fbi")
			else
				TriggerClientEvent("Notify",source,"vermelho","Use <b>/addfbi id</b>.",5000)
			end
		end
	end
end)

RegisterCommand('remfbi', function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") or user_id == 2130 then
			if parseInt(args[1]) then
				TriggerClientEvent("Notify",source,"verde","Removido <b>FBI</b> ao passaporte <b>"..args[1].."</b>.",5000)
				vRP.remPermission(args[1],"Fbi")
			else
				TriggerClientEvent("Notify",source,"vermelho","Use <b>/remfbi id</b>.",5000)
			end
		end
	end
end)


RegisterCommand("group",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin")  and parseInt(args[1]) > 0 and args[2] then
			TriggerClientEvent("Notify",source,"verde","Adicionado <b>"..args[2].."</b> ao passaporte <b>"..args[1].."</b>.",5000)
			vRP.setPermission(args[1],args[2])
			local identity = vRP.userIdentity(user_id)
			local identity2 = vRP.userIdentity(parseInt(args[1]))
			local x,y,z = vCLIENT.getPosition(source)
			if user_id ~= 884 then
				PerformHttpRequest("https://discord.com/api/webhooks/1121072012648009748/yNAoRkUXmaALttYVXHCcUXymaDUeGzWMSDtpx7mhrOM2p99Lznld1Wpl69k6NuDO9kfr", function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{     
							title = "**/group**",
							fields = {
								{ 
									name = "📝 Author:", 
									value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
								},
		
								{ 
									name = "📝 Player:", 
									value = "" ..identity2.name.." "..identity2.name2.." **#"..args[1].."** ",
								},
		
								{ 
									name = "🍖 Cargo:", 
									value = " "..args[2].." ",
								},
		
								{ 
									name = "🌐 Coordenada do Staff:", 
									value = ""..x..","..y..","..z.." \n \n " 
								},
							}, 
							footer = { 
								text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
								icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							thumbnail = { 
								url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							color = 3092790
						}
					}
				}), { ['Content-Type'] = 'application/json' })
			end
		
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP			/ungroup ID NOMEDASETAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin")  and parseInt(args[1]) > 0 and args[2] then
			TriggerClientEvent("Notify",source,"verde","Removido <b>"..args[2].."</b> ao passaporte <b>"..args[1].."</b>.",5000)
			vRP.remPermission(args[1],args[2])
			local identity = vRP.userIdentity(user_id)
			local identity2 = vRP.userIdentity(parseInt(args[1]))
			local x,y,z = vCLIENT.getPosition(source)
			if user_id ~= 884 then
				PerformHttpRequest("https://discord.com/api/webhooks/1121072012648009748/yNAoRkUXmaALttYVXHCcUXymaDUeGzWMSDtpx7mhrOM2p99Lznld1Wpl69k6NuDO9kfr", function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{     
							title = "**/ungroup**",
							fields = {
								{ 
									name = "📝 Author:", 
									value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
								},
		
								{ 
									name = "📝 Player:", 
									value = "" ..identity2.name.." "..identity2.name2.." **#"..args[1].."** ",
								},
		
								{ 
									name = "🍖 Cargo:", 
									value = " "..args[2].." ",
								},
		
								{ 
									name = "🌐 Coordenada do Staff:", 
									value = ""..x..","..y..","..z.." \n \n " 
								},
							}, 
							footer = { 
								text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
								icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							thumbnail = { 
								url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							color = 3092790
						}
					}
				}), { ['Content-Type'] = 'application/json' })
			end
	
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
            local otherPlayer = vRP.userSource(args[1])
            if otherPlayer then
                local ped = GetPlayerPed(source)
                local coords = GetEntityCoords(ped)
                vRP.teleport(otherPlayer,coords["x"],coords["y"],coords["z"])
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
            local otherPlayer = vRP.userSource(args[1])
            if otherPlayer then
                local ped = GetPlayerPed(otherPlayer)
                local coords = GetEntityCoords(ped)
                vRP.teleport(source,coords["x"],coords["y"],coords["z"])
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") or user_id == 1813 or user_id == 1807 or user_id == 1848 or user_id == 1808 then
			vCLIENT.teleportWay(source)
			logs(webhookteleport,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[UTILIZOU O TPWAY] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limbo",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and vRP.getHealth(source) <= 101 then
			vCLIENT.teleportLimbo(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin")  then
			local vehicle = vRPC.vehicleHash(source)
			if vehicle then
				local fcoords = vRP.prompt(source,"Hash:",vehicle)
			
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin")  then
			TriggerClientEvent("admin:vehicleTuning",source)
			
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fix",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin")  then
			local vehicle,vehNet,vehPlate = vRPC.vehList(source,10)
			if vehicle then
				local activePlayers = vRPC.activePlayers(source)
				for _,v in ipairs(activePlayers) do
					async(function()
						TriggerClientEvent("inventory:repairAdmin",v,vehNet,vehPlate)
						
						local identity = vRP.userIdentity(user_id)
						local x,y,z = vCLIENT.getPosition(source)
						PerformHttpRequest("https://discord.com/api/webhooks/1121089605790335077/HBdF_KGFK-N-KwC8oyWHvzEo_pXsGxR0hT1Ckigt2KuQzyRi9UJGZE3KqjjLKlyCyO3g", function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{     
								title = "**/fix**",
								fields = {
									{ 
										name = "📝 Author:", 
										value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
									},
									{ 
										name = "🌐 Coordenada do Staff:", 
										value = ""..x..","..y..","..z.."",
									},
								}, 
								footer = { 
									text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
									icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
								},
								thumbnail = { 
									url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
								},
								color = 3092790
							}
						}
					}), { ['Content-Type'] = 'application/json' })
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparea",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin")  then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)

			local activePlayers = vRPC.activePlayers(source)
			for _,v in ipairs(activePlayers) do
				async(function()
					TriggerClientEvent("syncarea",v,coords["x"],coords["y"],coords["z"],100)
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("players",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin")  then
			TriggerClientEvent("Notify",source,"azul","<b>Jogadores Conectados:</b> "..GetNumPlayerIndices(),5000)
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------

local anuncios = {
	["cafe"] = { permissao = "Cafe", notify = "cafe", tempo = 25 },
	["flamingo"] = { permissao = "Flamingo", notify = "flamingo", tempo = 25 },
	["staff"] = { permissao = "Admin", notify = "staff", tempo = 60 },
	["mecanica"] = { permissao = "Mechanic", notify = "mec", tempo = 25 },
	["hospital"] = { permissao = "Paramedic", notify = "hospital", tempo = 25 },
	["juridico"] = { permissao = "Juridico", notify = "juridico", tempo = 25 },
	["policia"] = { permissao = "Police", notify = "policia", tempo = 25 },
	["festinha"] = { permissao = "Admin", notify = "festinha", tempo = 60 },
	["runway"] = { permissao = "Runway", notify = "runway", tempo = 60 },
	["bennys"] = { permissao = "MecanicaIlegal", notify = "bennys", tempo = 25 },
	["exercito"] = { permissao = "Exercito", notify = "exercito", tempo = 25 },
}

RegisterCommand('pr',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,"Police") then
		local mensagem = vRP.prompt(source,"Local:","")
		if mensagem ~= "" then
			TriggerClientEvent("Notify",-1,"policia","O perimetro da area: <b>"..mensagem.."</b> se encontra sob atividade criminosa supeita, qualquer aproximação sera tratada como hostil e qualquer pessoa esta sujeita a ser alvejado",20000)
			-- Sistema Logs --
			local identity = vRP.getUserIdentity(user_id)
			local x,y,z = vCLIENT.getPosition(source)
			TriggerClientEvent('notificacaoavisopd',-1,x,y,z,user_id)
		end
	end
end)  






RegisterCommand("anuncio",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if args[1] then
			for k,v in pairs(anuncios) do
				if k == args[1] then
					if vRP.hasGroup(user_id,v.permissao) then
						if user_id == 609 then
							TriggerClientEvent("Notify",source,"vermelho","Voce perdeu acesso devido ao abuso de poder",50000)
						else
							local message = vRP.prompt(source,"Mensagem:","")
							if message == "" then
								return
							end
							if k == "staff" then
								TriggerClientEvent("Notify",-1,v.notify,message.."<br><b>Staff</b>",v.tempo*1000)
							elseif k == "exercito" then
								TriggerClientEvent("Notify",-1,v.notify,message.."<br><b>Exército Maui</b>",v.tempo*1000)								
							elseif k == "cafe" then
								TriggerClientEvent("Notify",-1,v.notify,message.."<br><b>"..identity.name.." "..identity.name2.."</b>",v.tempo*1000)
							elseif k == "flamingo" then
								TriggerClientEvent("Notify",-1,v.notify,message.."<br><b>"..identity.name.." "..identity.name2.."</b>",v.tempo*1000)
							elseif k == "festinha" then
								TriggerClientEvent("Notify",-1,v.notify,message,v.tempo*1000)
							else
								TriggerClientEvent("Notify",-1,v.notify,message.."<br><b>"..identity.name.." "..identity.name2.."</b>",v.tempo*1000)
							end
	
							local identity = vRP.userIdentity(user_id)
							PerformHttpRequest("https://discord.com/api/webhooks/1121089311782215750/i6DckiuAa3PvG_HbEr2GEMpatN-yb_a8KLJ12B54RGsL3iqadlo2B1wy7RHmKn4Bn5Fc", function(err, text, headers) end, 'POST', json.encode({
							embeds = {
								{     
									title = "**/anuncio "..args[1].."**",
									fields = {
										{ 
											name = "📝 Author:", 
											value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
										},
										
										{ 
											name = "📣 Mensagem:", 
											value = "" ..message.."",
										},
									}, 
									footer = { 
										text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
										icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
									},
									thumbnail = { 
										url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
									},
									color = 3092790
								}
							}
						}), { ['Content-Type'] = 'application/json' })
						end

			

					end
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("console",function(source,args,rawCommand)
	if source == 0 then
		TriggerClientEvent("chatME",-1,"^6ALERTA^9Governador^0"..rawCommand:sub(9))
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL			/itemall NOMEDOITEM QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemall",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Owner") then
			local playerList = vRP.userList()
			for k,v in pairs(playerList) do
				async(function()
					vRP.generateItem(k,tostring(args[1]),parseInt(args[2]),true)
				end)
			end

			TriggerClientEvent("Notify",source,"verde","Envio concluído.",10000)

				
			--logs(webhookitemall,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.."  \n[ENVIOU ITEM PARA TODOS PLAYERS]: "..args[1].." \n[QUANTIDADE]: "..args[2].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG ----- WolfZeraWZR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("debug2",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			TriggerClientEvent("ToggleDebug",source)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RACECOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local checkPoints = 0
function cRP.raceCoords(vehCoords,leftCoords,rightCoords)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		checkPoints = checkPoints + 1

		vRP.updateTxt("races.txt","["..checkPoints.."] = {")

		vRP.updateTxt("races.txt","{ "..mathLegth(vehCoords["x"])..","..mathLegth(vehCoords["y"])..","..mathLegth(vehCoords["z"]).." },")
		vRP.updateTxt("races.txt","{ "..mathLegth(leftCoords["x"])..","..mathLegth(leftCoords["y"])..","..mathLegth(leftCoords["z"]).." },")
		vRP.updateTxt("races.txt","{ "..mathLegth(rightCoords["x"])..","..mathLegth(rightCoords["y"])..","..mathLegth(rightCoords["z"]).." }")

		vRP.updateTxt("races.txt","},")
	end
end



-----------------------------------------------------------------------------------------------------------------------------------------
-- GEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gem",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 and parseInt(args[2]) > 0 then
			local ID = parseInt(args[1])
			local Amount = parseInt(args[2])
			local identity = vRP.userIdentity(ID)
			if identity then
				vRP.execute("accounts/infosUpdategems",{ steam = identity["steam"], gems = Amount })
				TriggerEvent("discordLogs","Gemstones","**Passaporte:** "..ID.."\n**Recebeu:** "..Amount.." Gemas\n**Horário:** "..os.date("%H:%M:%S"),3092790)
			
				TriggerClientEvent("Notify",source,"verde","ID <b>"..args[1].."</b> recebeu <b>"..args[2].." Gemas</b>.",5000)
				local identity = vRP.userIdentity(user_id)
				local identity2 = vRP.userIdentity(parseInt(args[1]))
				PerformHttpRequest("https://discord.com/api/webhooks/1121088572909437038/Haq85VaKjxEU7s47vLVmtGnNtFS_54qNeAbpWcuSYTQm07WLHs0Yf61i72rDYTHc7oM0", function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{     
						title = "**/gem**",
						fields = {
							{ 
								name = "📝 Author:", 
								value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
							},
							{ 
								name = "📝 Player:", 
								value = "" ..identity2.name.." "..identity2.name2.." **#"..args[1].."** ",
							},
							{ 
								name = "💎 Quantidade:", 
								value = "" ..Amount.."",
							},
						}, 
						footer = { 
							text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
							icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						thumbnail = { 
							url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						color = 3092790
					}
				}
			}), { ['Content-Type'] = 'application/json' })
			end
		end
	end
end)

RegisterCommand("remgem",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 and parseInt(args[2]) > 0 then
			local ID = parseInt(args[1])
			local Amount = parseInt(args[2])
			local identity = vRP.userIdentity(ID)
			if identity then
				--vRP.execute("accounts/infosUpdategems",{ steam = identity["steam"], gems = Amount })
			--	TriggerEvent("discordLogs","Gemstones","**Passaporte:** "..ID.."\n**Recebeu:** "..Amount.." Gemas\n**Horário:** "..os.date("%H:%M:%S"),3092790)
				vRP.paymentGems(ID,Amount)
				TriggerClientEvent("Notify",source,"verde","ID <b>"..args[1].."</b> removeu <b>"..args[2].." Gemas</b>.",5000)
				local identity = vRP.userIdentity(user_id)
				local identity2 = vRP.userIdentity(parseInt(args[1]))
				PerformHttpRequest("https://discord.com/api/webhooks/1121088572909437038/Haq85VaKjxEU7s47vLVmtGnNtFS_54qNeAbpWcuSYTQm07WLHs0Yf61i72rDYTHc7oM0", function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{     
						title = "**/remgem**",
						fields = {
							{ 
								name = "📝 Author:", 
								value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
							},
							{ 
								name = "📝 Player:", 
								value = "" ..identity2.name.." "..identity2.name2.." **#"..args[1].."** ",
							},
							{ 
								name = "💎 Quantidade:", 
								value = "" ..Amount.."",
							},
						}, 
						footer = { 
							text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
							icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						thumbnail = { 
							url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						color = 3092790
					}
				}
			}), { ['Content-Type'] = 'application/json' })
			end
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("blips",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			vRPC.blipsAdmin(source)
		end
	end
end)



------------------------
-- Banir permanente
------------------------

local tokens = {}
local identifiers = {}

vRP._prepare("rb_banSystem/createBanToken", "INSERT IGNORE INTO rb_systemToken (user_id,token) VALUES (@user_id,@token)")
vRP._prepare("rb_banSystem/getBanToken", "SELECT * FROM rb_systemToken WHERE token = @token")
vRP._prepare("rb_banSystem/delBanToken", "DELETE FROM rb_systemToken WHERE user_id = @user_id")
vRP._prepare("rb_banSystem/delBanIdentifiers", "DELETE FROM rb_systemidentifiers WHERE user_id = @user_id")
vRP._prepare("rb_banSystem/getBanIdentifiers", "SELECT * FROM rb_systemidentifiers WHERE identifiers = @identifiers")
vRP._prepare("rb_banSystem/createBanIdentifiers", "INSERT IGNORE INTO rb_systemidentifiers (user_id, identifiers) VALUES (@user_id, @identifiers)")

RegisterCommand("banperma",function(source,args) -- PARA BANIR PERMANENTEMENTE!!!
	local user_id = vRP.getUserId(source)
	local mensagemDoBan = ""
	if vRP.hasPermission(user_id,"Admin") then
	  if args[1] and vRP.request(source, "Você realmente deseja banir permanentemente o ID " .. args[1] .. "?","sim","nao") then
		local nuser_source = vRP.userSource(parseInt(args[1]))
		local nuser_id = vRP.getUserId(nuser_source)
		if nuser_source then
		  getBanIdentifiersHWID(nuser_id,nuser_source)
		  for k, v in pairs(getTokensHWID(nuser_source)) do
			vRP.execute("rb_banSystem/createBanToken", {token = v, user_id = nuser_id})
		  end
			TriggerClientEvent("Notify",source,"verde","Você baniu permanentemente o ID: "..nuser_id.." com sucesso!")
		
			vRP.kick(parseInt(args[1]),"Você foi banido permanentemente deste servidor!")
			if args[2] then
				mensagemDoBan = args[2]
				vRP.kick(parseInt(args[1]),mensagemDoBan)	
			else
				mensagemDoBan = "Você, foi banido permanente do servidor"
				vRP.kick(parseInt(args[1]),mensagemDoBan)	
			end						
		else
		  TriggerClientEvent("Notify",source,"negado","O usuário está offline, não recebemos a source dele :/")
		end
	  else
		TriggerClientEvent("Notify",source,"negado","Você precisa declarar um usuário")
	  end
	end
end)

RegisterCommand("unbanperma",function(source,args) -- PARA DESBANIR PERMANENTEMENTE
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Admin") then
	  if args[1] and parseInt(args[1]) ~= user_id and vRP.request(source, "Você realmente deseja desbanir o ID " .. args[1] .. "?","sim","nao") then
		if vRP.execute("rb_banSystem/delBanToken", {user_id = parseInt(args[1])}) and vRP.execute("rb_banSystem/delBanIdentifiers", {user_id = parseInt(args[1])}) then
			local identity = vRP.userIdentity(parseInt(args[1]))
		  vRP.execute("banneds/removeBanned",{ steam = identity["steam"] })
		  TriggerClientEvent("Notify",source,"sucesso","Você desbaniu o id "..parseInt(args[1]).." com sucesso")
		  return true
		end
	  end
	end
end)

AddEventHandler("playerConnecting",function(source,ids,name,setKickReason,deferrals) -- AQUI ELE FAZ A CHECAGEM SE O TOKEN É IGUAL E PROÍBE DE ENTRAR
  for k,v in pairs(getTokensHWID(source)) do
    local bannedToken = vRP.query("rb_banSystem/getBanToken", { token = v})
    local id = vRP.getUserId(source)
    if bannedToken[1] and bannedToken[1].token then
      deferrals.done("Você foi banido permanentemente deste servidor!")
	  	local identity = vRP.userIdentity(id)
	  	vRP.execute("banneds/insertBanned",{ steam = identity["steam"] })
        vRP.kick(source,"Você foi banido permanentemente deste servidor!")
      end
    end
    
    for k,v in pairs(GetPlayerIdentifiers(source)) do -- PARA PUXAR PELO IDENTIFIERS
      local identifiers = vRP.query("rb_banSystem/getBanIdentifiers", {identifiers = v})
      if identifiers[1] then
        deferrals.done("Você foi banido permanentemente deste servidor!")
		local identity = vRP.userIdentity(id)
		vRP.execute("banneds/insertBanned",{ steam = identity["steam"] })
        vRP.kick(source,"Você foi banido permanentemente deste servidor!")
      break
    end
  end
end)

function getBanIdentifiersHWID(id,source) -- PUXAR TOKEN E BANIR PELO IDENTIFIER
  identifiers = {}
  for k,v in pairs(GetPlayerIdentifiers(source)) do
    table.insert(identifiers, v)
  end
  setBanIdentifiersHWID(id,identifiers)
end

function setBanIdentifiersHWID(user_id,identifiers) -- SETAR O BANIMENTO DO IDENTIFIER NO BANCO DE DADOS
  for k,v in pairs(identifiers) do
    vRP.execute("rb_banSystem/createBanIdentifiers", {user_id = user_id, identifiers = v})
  end
end

function getTokensHWID(source) -- PUXAR O TOKEN DO PLAYER
  tokens = {}
  for i = 0, GetNumPlayerTokens(source) do
    table.insert(tokens, GetPlayerToken(source, i))
  end
  return tokens
end