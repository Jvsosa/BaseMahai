local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
local idgens = Tools.newIDGenerator()
Tunnel.bindInterface("wnRoutes",src)
Config = module(GetCurrentResourceName(),"cfg/config")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPermission(permissao)
	local source = source
	local user_id = vRP.getUserId(source)
	local checked = false
	if permissao == "none" then
		return true
	else
		if vRP.hasPermission(user_id,permissao) then
			return true
		end
	end
end


src.Lista_Itens = function(emprego_rota)
    local source = source
    local user_id = vRP.getUserId(source)
	ListaItens = {}
	for k,v in pairs(Config.Itens[emprego_rota]) do
		table.insert(ListaItens,{ index = k, item = itemName(k), img = itemIndex(k), item2 = k, ipurl = Config.Url  })
	end
end

src.PlayersContratadosList = function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return ListaItens
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------

function src.checkPayment(componente,rank)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	Quantidade_Pegar = math.random(Config.Itens[rank][componente].qtd_min,Config.Itens[rank][componente].qtd_max)
	if user_id then
		if (vRP.inventoryWeight(user_id) + (itemWeight(componente) * parseInt(Quantidade_Pegar))) <= vRP.getWeight(user_id) then
			vRP.generateItem(user_id,componente,Quantidade_Pegar,true)
			vRP.upgradeStress(user_id,1)
		
			PerformHttpRequest(Config.Rotas[rank].log, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{     
						title = "**Farm "..componente.."**",
						fields = {
							{ 
								name = "📝 Author:", 
								value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
							},
							{ 
								name = "📦 Criou:", 
								value = ""..parseFormat(Quantidade_Pegar).."x "..itemName(componente)..""
							},
						}, 
						footer = { 
							text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
							icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						image = { 
							url = "http://localhost/itens/"..itemIndex(componente)..".png",
						},
						thumbnail = { 
							url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						color = 3092790
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			if Config.Rotas[rank].log2 then
				PerformHttpRequest(Config.Rotas[rank].log2, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{     
							title = "**Farm "..componente.."**",
							fields = {
								{ 
									name = "📝 Author:", 
									value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
								},
								{ 
									name = "📦 Criou:", 
									value = ""..parseFormat(Quantidade_Pegar).."x "..itemName(componente)..""
								},
							}, 
							footer = { 
								text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
								icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							image = { 
								url = "http://localhost/itens/"..itemIndex(componente)..".png",
							},
							thumbnail = { 
								url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							color = 3092790
						}
					}
				}), { ['Content-Type'] = 'application/json' })
			end

			return true
		end
	end
	return false
end