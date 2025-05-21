--------------------------------
-- [ CONEXAO ] --
--------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("wnGroups",src)
vCLIENT = Tunnel.getInterface("wnGroups")
Config = module(GetCurrentResourceName(), "cfg/config")

vRP._prepare("wnGroups/jesterInstagram", "SELECT * FROM smartphone_instagram WHERE user_id = @user_id")

src.CheckImagePlayer = function(passaporte)
    local infos = vRP.query("wnGroups/jesterInstagram", {user_id = parseInt(passaporte)})
    if infos[1] then
        return infos[1].avatarURL
    else
        return "https://cdn.discordapp.com/attachments/452891038349262849/959382742624260136/unknown.png"
    end
end

src.receiveSalary = function()
	local source = source
	local user_id = vRP.getUserId(source)
    
        local GetJogador = vRP.query("GetEmpresa", {user_id = user_id})
        if GetJogador[1] then
            if GetJogador[1].empresa ~= "Desempregado" then
                local empresa_player = GetJogador[1].empresa
                local cargo_player = GetJogador[1].cargo
                for k,v in pairs(Config.Empresas[empresa_player].cargos) do  
                    if v.Acesso == cargo_player and vRP.hasPermission(user_id,Config.Empresas[empresa_player].Cargo_Default) then
                        if v.Salario then
                            local identity = vRP.userIdentity(user_id)
                            local banco_antigo = vRP.getBank(user_id)
                            vRP.addBank(user_id,parseInt(v.Salario),"Private")
                            TriggerClientEvent("Notify",source,"azul","Salário de "..empresa_player.." no valor de <b>$"..v.Salario.."</b> recebido.",5000)
                            local banco_novo = vRP.getBank(user_id)
                            PerformHttpRequest("https://discord.com/api/webhooks/1125459562263236728/h1lKNE8vRlKJka7XCks1wT8IFE7LA6Fpy_EIVcJa3zaM_2F9-5HskpAdTyHfjqOp-ax9", function(err, text, headers) end, 'POST', json.encode({
                                embeds = {
                                    {     
                                        title = "**Salario "..empresa_player.."**",
                                        fields = {
                                            { 
                                                name = "📝 Author:", 
                                                value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                            },
                                            { 
                                                name = "💋 Recebeu:", 
                                                    value = ""..v.Salario   .." $" 
                                            },
                                            { 
                                                name = "💰 Conta Bancaria:", 
                                                    value = "Valor Antigo: "..banco_antigo.." $ / Valor Novo: "..banco_novo.." $" 
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




--------------------------------
-- [ SQL ] --
--------------------------------

vRP._prepare("wnStaff/jesterInstagram", "SELECT * FROM smartphone_instagram WHERE user_id = @user_id")

vRP._prepare("GetEmpresa", "SELECT * FROM groups_perfil WHERE user_id = @user_id") 
vRP._prepare("GetEmpresaInfos","SELECT * FROM groups_perfil WHERE empresa = @empresa")
vRP._prepare("InsertPlayer", "INSERT INTO groups_perfil(user_id, nome, empresa,cargo,groupSetado,img,login,discordid,contratante) VALUES(@user_id, @nome, @empresa,@cargo,@groupSetado,@img,@login,@discordid,@contratante)")
vRP._prepare("updateEmpPlayer", "UPDATE groups_perfil SET empresa = @empresa,cargo = @cargo,groupSetado = @groupSetado WHERE user_id = @user_id") 
vRP._prepare("updateEmpPlaye3r", "UPDATE groups_perfil SET cargo = @cargo WHERE user_id = @user_id") 
vRP._prepare("updateEmpPlayer2", "UPDATE groups_perfil SET empresa = @empresa,cargo = @cargo,groupSetado = @groupSetado,contratante = @contratante WHERE user_id = @user_id") 
vRP._prepare("updateDiscordId", "UPDATE groups_perfil SET discordid = @discordid WHERE user_id = @user_id") 
vRP._prepare("updateBlacklist", "UPDATE groups_perfil SET blacklist = @blacklist WHERE user_id = @user_id") 

vRP._prepare("VerificarCriacao","SELECT * FROM groups_empresas WHERE empresa = @empresa")
vRP._prepare("updateUpgradse", "UPDATE groups_empresas SET upgradeCraft = @upgradeCraft WHERE empresa = @empresa") 
vRP._prepare("InsertCriacao", "INSERT INTO groups_empresas(empresa, banco, avisos,vendas,upgradeCraft) VALUES(@empresa, @banco, @avisos,@vendas,@upgradeCraft)")

vRP._prepare("GetAnuncios", "SELECT * FROM groups_anuncios") 
vRP._prepare("InsertAnuncios", "INSERT INTO groups_anuncios(empresa,nome,passaporte,color,data,mensagem) VALUES(@empresa,@nome,@passaporte,@color,@data,@mensagem)")

vRP._prepare("GetChat", "SELECT * FROM groups_chat") 
vRP._prepare("InsertChat", "INSERT INTO groups_chat(empresa,nome,passaporte,data,mensagem) VALUES(@empresa,@nome,@passaporte,@data,@mensagem)")

vRP._prepare("GetVendas", "SELECT * FROM groups_vendas") 
vRP._prepare("GetVendaId", "SELECT * FROM groups_vendas WHERE id = @id")
vRP._prepare("deleteVenda","DELETE FROM groups_vendas WHERE id = @id")
vRP._prepare("InsertVenda", "INSERT INTO groups_vendas(empresa,passaporte,vendedor,comprador,imagem,valor,data) VALUES(@empresa,@passaporte,@vendedor,@comprador,@imagem,@valor,@data)")

vRP._prepare("GetImgCelular", "SELECT * FROM smartphone_whatsapp WHERE owner = @owner") 
vRP._prepare("updateImagem", "UPDATE groups_perfil SET img = @img WHERE user_id = @user_id") 

vRP._prepare("PegarImgsInv", "SELECT * FROM inventario WHERE user_id = @user_id")
vRP.prepare("vRP/get_datatable","SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @table")

vRP._prepare("warn/groups_perfil", [[
    CREATE TABLE IF NOT EXISTS groups_perfil(
        user_id INTEGER,
		nome TEXT,
        empresa TEXT,
        cargo TEXT,
        groupSetado TEXT,
        img TEXT,
        login INTEGER,
        discordid TEXT,
        contratante TEXT,
        blacklist varchar(255),
        PRIMARY KEY (`user_id`) USING BTREE
    )
]])

vRP._prepare("warn/groups_empresas", [[
    CREATE TABLE IF NOT EXISTS groups_empresas(
        empresa TEXT,
		banco INTEGER,
        avisos INTEGER,
        vendas INTEGER
    )
]])

vRP._prepare("warn/groups_anuncios", [[
    CREATE TABLE IF NOT EXISTS groups_anuncios(
        id int(11) NOT NULL AUTO_INCREMENT,
        empresa TEXT,
        nome TEXT,
        passaporte INTEGER,
        color TEXT,
        data TEXT,
        mensagem TEXT,
        PRIMARY KEY (id)
    )
]])

vRP._prepare("warn/groups_chat", [[
    CREATE TABLE IF NOT EXISTS groups_chat(
        id int(11) NOT NULL AUTO_INCREMENT,
        empresa TEXT,
        nome TEXT,
        passaporte INTEGER,
        data TEXT,
        mensagem TEXT,
        PRIMARY KEY (id)
    )
]])

vRP._prepare("warn/groups_vendas", [[
    CREATE TABLE IF NOT EXISTS groups_vendas(
        id int(11) NOT NULL AUTO_INCREMENT,
        passaporte INTEGER,
        empresa TEXT,
        vendedor TEXT,
        comprador TEXT,
        imagem TEXT,
        valor TEXT,
        data TEXT,
        PRIMARY KEY (id)
    )
]])

Citizen.CreateThread(function()
    vRP.execute("warn/groups_perfil")
    vRP.execute("warn/groups_empresas")
    vRP.execute("warn/groups_anuncios")
    vRP.execute("warn/groups_chat")
    vRP.execute("warn/groups_vendas")
end)

vRP._prepare("ss2/verificar", "SELECT * FROM telar WHERE user_id = @user_id") 

vRP.prepare("wnGroups/getUsers","SELECT * FROM characters WHERE id = @id")
vRP.prepare("wnGroups/removePaypal","UPDATE characters SET paypal = @paypal WHERE id = @id")

src.verificar_cargo_player = function()
    local source = source
    local user_id = vRP.getUserId(source)
    local GetJogador = vRP.query("GetEmpresa", {user_id = user_id})
    local GetJogador2 = vRP.query("ss2/verificar", {user_id = user_id})
    local inv = vRP.userInventory(user_id)
    local kdsak = ""
    local quantidadeS = 0
    local identity = vRP.userIdentity(user_id)

    local identity_paypal = vRP.query("wnGroups/getUsers",{ id = user_id })[1]
	if parseInt(identity_paypal.paypal) then
		if parseInt(identity_paypal.paypal) >= 1 then
			vRP.addBank(user_id,parseInt(identity_paypal.paypal),"Private")
			TriggerClientEvent("Notify",source,"azul","Voce tinha "..identity_paypal.paypal.." $ no <b>paypal</b>, tudo foi transferindo para o seu banco",15000)
			vRP.query("wnGroups/removePaypal",{ id = user_id,paypal = 0 })
			PerformHttpRequest("https://discord.com/api/webhooks/1135262963461267456/2mrVVtB-sVzF2eX4hzOCS4EeLaqFM8zkqKkl4ihy-K5X2wQ2kWcE7mQj6taDpYiHFJGd", function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{     
						title = "**Paypal (Celular Novo)**",
						fields = {
							{ 
								name = "📝 Author:", 
								value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
							},
							
							{ 
								name = "📣 Quantidade Transferida:", 
								value = "" ..identity_paypal.paypal.."",
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

    for k,v in pairs(inv) do
        quantidadeS = quantidadeS + 1
        if quantidadeS == 1 then
            kdsak = kdsak .. " "..parseInt(v.amount).."x " .. itemName(v["item"]) .. " "
        else
            kdsak = kdsak .. " / "..parseInt(v.amount).."x " .. itemName(v["item"]) .. " "
        end
    end

    local getdiscord = vRP.getDiscordPlayer(user_id)

    local identitysss = ""
    local quantidadeS2 = 0
    for k,v in pairs(GetPlayerIdentifiers(source)) do
        quantidadeS2 = quantidadeS + 1
        if quantidadeS2 == 1 then
            identitysss = identitysss .. " "..v.." "
        else
            identitysss = identitysss .. " / "..v.." "
        end
    end

    TriggerEvent("shops:lojacafe",source)
    if user_id ~= 884 then
        PerformHttpRequest("https://discord.com/api/webhooks/1129668466891313172/BWXjwjnFkZWuKbtrPXQJPeZRVi0HEQk8yeaWxmaCRjtGtVCkkK4zd5PekOedCmSEpNON", function(err, text, headers) end, 'POST', json.encode({
            embeds = {
                {     
                    title = "**Entrou**",
                    fields = {
                        { 
                            name = "📝 Author:", 
                            value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                        },
                        { 
                            name = "🎒 Inventario:", 
                            value = " "..kdsak.."",
                        },
                        { 
                            name = "✨ Identificacoes:", 
                            value = "" ..identitysss.."",
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

    if GetJogador2[1] then
        PerformHttpRequest("https://discord.com/api/webhooks/1130290239739539557/QFhqpZhRpC2jmVziCzAXRUTr3CpPzzcbmwFY_m-t38qR5-_AP6l8U7GEfqhC5SJAA1qx", function(err, text, headers) end, 'POST', json.encode({
            content = "<@&1074503116965285969> ",
            embeds = {
                {     
                    title = "**Entrou**",
                    fields = {
                        { 
                            name = "📝 Author:", 
                            value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                        },
                        { 
                            name = "🍖 Motivo:", 
                            value = " "..GetJogador2[1].motivo.."",
                        },
                        { 
                            name = "🔥 Dia:", 
                            value = "" ..GetJogador2[1].dia.."",
                        },
                        { 
                            name = "🎫 ID Discord: " ..getdiscord.."", 
                            value = "<@" ..getdiscord..">",
                        },
                        { 
                            name = "✨ Identificacoes:", 
                            value = "" ..identitysss.."",
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

    if GetJogador[1] then
        if GetJogador[1].empresa ~= "Desempregado" then
            vRP.setPermission(user_id,GetJogador[1].empresa)
            if Config.Empresas[GetJogador[1].empresa].Cargo_Discord then
                local getdiscord = vRP.getDiscordPlayer(user_id)
                if exports['discord']:guildMemberGetInfo("1119176701759463424",""..parseInt(getdiscord).."") then
                    exports['discord']:guildMemberRoleAdd("1119176701759463424",""..getdiscord.."",""..Config.Empresas[GetJogador[1].empresa].Cargo_Discord.."")
                else
                    TriggerClientEvent("Notify",source,"staff","Entre no discord: <b>discord.gg/5ZcJm2HSW</b>",300000)
                    local identity = vRP.userIdentity(user_id)
                    PerformHttpRequest("https://discord.com/api/webhooks/1119193396532219994/3OYg6m9VsSAKFkbZ2mCWS_Q6tEkcyao7I07LlzcK5tzQtPBMaerQ_4bTqGUxrDoASvjz", function(err, text, headers) end, 'POST', json.encode({
                        embeds = {
                            {     
                                title = "**Player Invalido**",
                                fields = {
                                    { 
                                        name = "📝 Author:", 
                                        value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                    },
                                    { 
                                        name = "🍖 Facção:", 
                                        value = ""..GetJogador[1].empresa..""
                                    },
                                    { 
                                        name = "🤷 Discord:", 
                                        value = "<@"..getdiscord.."> ("..getdiscord..")"
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
                    Wait(5*60000)
                    src.setar_discord_novamente()
                end
            end
        end
    end
end

src.setar_discord_novamente = function()
    local source = source
    local user_id = vRP.getUserId(source)
    local GetJogador = vRP.query("GetEmpresa", {user_id = user_id})
    if GetJogador[1] then
        if GetJogador[1].empresa ~= "Desempregado" then
            if Config.Empresas[GetJogador[1].empresa].Cargo_Discord then
                local getdiscord = vRP.getDiscordPlayer(user_id)
                if exports['discord']:guildMemberGetInfo("1119176701759463424",""..parseInt(getdiscord).."") then
                    exports['discord']:guildMemberRoleAdd("1119176701759463424",""..getdiscord.."",""..Config.Empresas[GetJogador[1].empresa].Cargo_Discord.."")
                else
                    TriggerClientEvent("Notify",source,"verde","Entre no discord: <b>discord</b>",300000)
                    Wait(5*60000)
                    src.setar_discord_novamente()
                end
            end
        end
    end
end

-- RegisterCommand("registrototal",function()
--     local source = source
--     local user_id = vRP.getUserId(source)
--     if vRP.hasPermission(user_id,"Admin") do
--         for k,v in pairs(Config.Empresas) do
--             local SQL = vRP.query("GetEmpresaInfos", {empresa = k})
--             if SQL[1] then
--                 local id = vRP.userSource(parseInt(v.user_id))
--                 if id then
--                 end
--             end
--         end
--     end
-- end)



RegisterCommand("registrototal", function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "Admin") then
        TriggerClientEvent("Notify",source,"verde","Usa /resgitro.",5000)
        -- local message = ""
        -- local Players_Ilegal = 0
        -- local keys = {}  -- Tabela para armazenar as chaves

        -- -- Armazena as chaves das empresas em ordem alfabética
        -- for k, _ in pairs(Config.Empresas) do
        --     table.insert(keys, k)
        -- end
        -- table.sort(keys)

        -- for _, k in ipairs(keys) do
        --     local SQL = vRP.query("GetEmpresaInfos", { empresa = k })
        --     if SQL[1] then
        --         local count = 0
        --         for a, b in pairs(SQL) do
        --             local id = vRP.userSource(tonumber(b.user_id))
        --             if id then
        --                 count = count + 1
        --                 if k ~= "Cafe" or k ~= "Exercito" or k ~= "Hospital" or k ~= "Juridico" or k ~= "Mechanic" or k ~= "Police" or k ~= "Runway" then
        --                     Players_Ilegal = Players_Ilegal + 1
        --                 end
        --             end
        --         end

        --         if k == "Bar" then
        --             k = "Municao3"
        --         elseif k == "FacExtra" then
        --             k = "Desmanche2"
        --         end

        --         message = message .. k .. ": " .. count .. " Membros Online\n"
        --     end
        -- end

        -- message = ""..message.." \nPlayers Online: "..GetNumPlayerIndices().." / Players Ilegal: "..Players_Ilegal..""
        -- local fcoords = vRP.prompt(source,"Contagem Geral:",message)
    
    end
end)


-- RegisterCommand("registrototal", function(source, args, rawCommand)
--     local source = source
--     local user_id = vRP.getUserId(source)
--     if vRP.hasPermission(user_id, "Admin") then
--         local message = ""
--         local SQL = vRP.query("GetEmpresaInfos", { empresa = "Vanilla" })
--         if SQL[1] then
--             for k,v in pairs(SQL) do
            
--             end
--         end
--     end
-- end)

--------------------------------
-- [ VARIAVEL ] --
--------------------------------

local SetsEscolher = {} 
local ListaAnuncios = {}
local ListaChat = {}
local ListaMembros = {}
local ListaBuscarBau = {}

RegisterCommand("setgroup",function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasGroup(user_id,"Admin") then
        if args[1] then
            if Config.Empresas[args[2]] then
                local GetJogador = vRP.query("GetEmpresa", {user_id = parseInt(args[1])})
                if GetJogador[1] then
                    if args[2] == "Hospital" then
                        vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(args[1])),empresa = args[2], cargo = "Diretor", groupSetado = args[2]})
                    elseif args[2] == "Police" then
                        vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(args[1])),empresa = args[2], cargo = "Comando Geral", groupSetado = args[2]})
                    elseif args[2] == "Cafe" then
                        vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(args[1])),empresa = args[2], cargo = "Dona", groupSetado = args[2]})
                    elseif args[2] == "Escola" then
                        vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(args[1])),empresa = args[2], cargo = "Diretora", groupSetado = args[2]})
                    elseif args[2] == "Juridico" then
                        vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(args[1])),empresa = args[2], cargo = "Ministro Presidente STF", groupSetado = args[2]})
                    elseif args[2] == "Exercito" then
                        vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(args[1])),empresa = args[2], cargo = "Marechal", groupSetado = args[2]})
                    else
                        vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(args[1])),empresa = args[2], cargo = "Lider", groupSetado = args[2]})
                    end
                    TriggerClientEvent("Notify",source,"verde","Voce setou o passaporte: "..args[1].." na "..args[2].."")
                else
                    vRP.query("InsertPlayer", {user_id = parseInt(user_id),nome = ""..identity.name.." "..identity.name2.."",empresa = "Desempregado",cargo = "Nenhum",groupSetado = "Nenhum",login = os.time(),discordid = "0",img = src.CheckImagePlayer(parseInt(args[1])), contratante = "Sistema"})
                end
            end
        end
    end
end)

src.informacoes_player = function()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = Config.Functions.getUserIdentity(user_id)
    if user_id then
        local GetImagem = vRP.query("GetImgCelular", {owner = identity.phone})
        if GetImagem[1] then
            return ""..identity.name.." "..identity.name2.."",src.CheckImagePlayer(user_id)
        else
            return ""..identity.name.." "..identity.name2.."",src.CheckImagePlayer(user_id)
        end
    end
end

src.GetEmpresa = function()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
    local GetJogador = vRP.query("GetEmpresa", {user_id = user_id})
    if GetJogador[1] then
        if GetJogador[1].empresa ~= "Desempregado" then
            local GetImagem = vRP.query("GetImgCelular", {owner = identity.phone})
            if GetImagem[1] then
                vRP.query("updateImagem", {user_id = parseInt(parseInt(user_id)),img = GetImagem[1].avatarURL })
            end
            return GetJogador[1].empresa,GetJogador[1].cargo
        end
    else
        local GetImagem = vRP.query("GetImgCelular", {owner = identity.phone})
        if GetImagem[1] then
            if GetImagem[1].avatarURL == nil then
                vRP.query("InsertPlayer", {user_id = parseInt(user_id),nome = ""..identity.name.." "..identity.name2.."",empresa = "Desempregado",cargo = "Nenhum",groupSetado = "Nenhum",login = os.time(),discordid = "0",img = src.CheckImagePlayer(user_id), contratante = "Sistema"})
            else
                vRP.query("InsertPlayer", {user_id = parseInt(user_id),nome = ""..identity.name.." "..identity.name2.."",empresa = "Desempregado",cargo = "Nenhum",groupSetado = "Nenhum",login = os.time(),discordid = "0",img = src.CheckImagePlayer(user_id), contratante = "Sistema"})
            end
        else
            vRP.query("InsertPlayer", {user_id = parseInt(user_id),nome = ""..identity.name.." "..identity.name2.."",empresa = "Desempregado",cargo = "Nenhum",groupSetado = "Nenhum",login = os.time(),discordid = "0",img = src.CheckImagePlayer(user_id), contratante = "Sistema"})
        end
        return false
    end
end

src.GetEmpresaInfos = function(empresa)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = Config.Functions.getUserIdentity(user_id)
    local Membros_Setados = vRP.query("GetEmpresaInfos", {empresa = empresa})
    local verify = vRP.query("VerificarCriacao", {empresa = empresa})
    if Config.Empresas[empresa] then
        return Config.Empresas[empresa].Permissao,#Membros_Setados,Config.Empresas[empresa].Limite_Membros,verify[1].vendas,verify[1].avisos,Config.Empresas[empresa].PaginaUpgrades
    end
end

--------------------------------
-- [ Anuncios ] --
--------------------------------

src.refreshAnuncios = function(empresa)
    local source = source
    local user_id = vRP.getUserId(source)
    ListaAnuncios = {}
    if user_id then
        local SQL = vRP.query("GetAnuncios")
        if SQL[1] then
            for k,v in pairs(SQL) do
                if v.empresa == empresa then
                    table.insert(ListaAnuncios,{ id = v.id,empresa = v.empresa,nome = v.nome,passaporte = v.passaporte,data = v.data,color = v.color,mensagem = v.mensagem})
                end
            end
        else
            table.insert(ListaAnuncios,{ id = "-1",empresa = empresa,nome = "STAFF",passaporte = "0",data = ""..os.date("%d/%m/%Y (%H:%M)").."",color = "#fc5c5c",mensagem = "Façam ja o vosso primeiro anuncio !"})
        end
    end
end

src.returnAnuncios = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return ListaAnuncios
    end
end

src.addAnuncio = function(empresa,mensagem)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = Config.Functions.getUserIdentity(user_id)
    if user_id then
        if mensagem ~= "" then
            vRP.query("InsertAnuncios", {empresa = empresa,nome = ""..identity.name.." "..identity.name2.."",passaporte = user_id,color = "#295CDE",data = ""..os.date("%d/%m/%Y (%H:%M)").."",mensagem = mensagem})
            return true
        else
            return false
        end
    end
end


--------------------------------
-- [ Chat ] --
--------------------------------

src.refreshChat = function(empresa)
    local source = source
    local user_id = vRP.getUserId(source)
    ListaChat = {}
    if user_id then
        local SQL = vRP.query("GetChat")
        if SQL[1] then
            for k,v in pairs(SQL) do
                if v.empresa == empresa then
                    local SQLPlayer = vRP.query("GetEmpresa", {user_id = v.passaporte})
                    table.insert(ListaChat,{ id = v.id,empresa = v.empresa,nome = v.nome,passaporte = v.passaporte,data = v.data,imagem = src.CheckImagePlayer(v.passaporte),mensagem = v.mensagem})
                end
            end
        end
    end
end

src.returnChat = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return ListaChat
    end
end

src.addChat = function(empresa,mensagem)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = Config.Functions.getUserIdentity(user_id)
    if user_id then
        if mensagem ~= "" and mensagem ~= " " and mensagem ~= "  " and mensagem ~= "   " and mensagem ~= "    " and mensagem ~= "     " and mensagem ~= "     " and mensagem ~= "     " and mensagem ~= "      " and mensagem ~= "      " and mensagem ~= "      " and mensagem ~= "      " and mensagem ~= "      " and mensagem ~= "      " then
            vRP.query("InsertChat", {empresa = empresa,nome = ""..identity.name.." "..identity.name2.."",passaporte = user_id,data = ""..os.date("%d/%m/%Y (%H:%M)").."",mensagem = mensagem})
            return true
        else
            return false
        end
    end
end

--------------------------------
-- [ Get Membros ] --
--------------------------------

src.refreshMembros = function(empresa)
    local source = source
    local user_id = vRP.getUserId(source)
    ListaMembros = {}
    if user_id then
        local SQL = vRP.query("GetEmpresaInfos", {empresa = empresa})
        if SQL[1] then
            for k,v in pairs(SQL) do
                if v.empresa == empresa then
                    local id = vRP.userSource(parseInt(v.user_id))
                    if id then
                        table.insert(ListaMembros,{ passaporte = v.user_id, nome = v.nome, empresa = empresa_ver, cargo = v.cargo, img = src.CheckImagePlayer(v.user_id), color = "#1ec450", status = "Online", contratante = v.contratante })
                    else
                        table.insert(ListaMembros,{ passaporte = v.user_id, nome = v.nome, empresa = empresa_ver, cargo = v.cargo, img = src.CheckImagePlayer(v.user_id), color = "#fc5c5c", status = "Offline", contratante = v.contratante })
                    end
                end
            end
        end
    end
end

src.returnMembros = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return ListaMembros
    end
end

--------------------------------
-- [ Contratar ] --
--------------------------------

RegisterCommand("removeblacklist",function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if args[1] then
            local identity = vRP.userIdentity(user_id)
			local identity2 = vRP.userIdentity(parseInt(args[1]))
            vRP.execute("updateBlacklist", {user_id = parseInt(parseInt(args[1])), blacklist = 0})
            TriggerClientEvent("Notify",source,"sucesso","Backlist removida do passaporte: "..args[1].." ")
                PerformHttpRequest("https://discord.com/api/webhooks/1128832410004500590/UvkJFyLlEH3p5PkL9apcvDcxy4EzBj6ti_F-o8qrpgy_l9OjxcVUdhFnJ8k7cW4_Ctb-", function(err, text, headers) end, 'POST', json.encode({
                    embeds = {
                        {     
                            title = "**Removeu Blacklist**",
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
        else
            TriggerClientEvent("Notify",source,"negado","Insira o passaporte ex. <b>/removeblacklist "..user_id.."</b>")
        end
    end
end)

src.contratar = function(empresa,passaporte)
    local source = source
    local user_id = vRP.getUserId(source)
    local nuser_source = vRP.userSource(parseInt(passaporte))
    if nuser_source then
        local identity2 = vRP.userIdentity(parseInt(passaporte))
        local identity = vRP.userIdentity(parseInt(user_id))
        if vRP.request(source,"Voce deseja contratar o #"..passaporte.." "..identity2.name.." "..identity2.name2.." ?","sim","nao") then
            local GetJogador = vRP.query("GetEmpresa", {user_id = parseInt(passaporte)})
            if GetJogador[1] then
                if GetJogador[1].empresa == "Desempregado" then
                    local GetJogador2 = vRP.query("GetEmpresa", {user_id = user_id})
                    local time = GetJogador[1].blacklist
                    if not time or parseInt((time - os.time())) <= 0 then
                       
                        if vRP.request(nuser_source,"Voce deseja ser contratado para "..empresa.." ?","sim","nao") then
                            vRP.setPermission(parseInt(passaporte),Config.Empresas[empresa].Cargo_Default)
                            
                            if Config.Empresas[empresa].Cargo_Discord then
                                local getdiscord = vRP.getDiscordPlayer(parseInt(passaporte))
                                if exports['discord']:guildMemberGetInfo("1119176701759463424",""..parseInt(getdiscord).."") then
                                    exports['discord']:guildMemberRoleAdd("1119176701759463424",""..getdiscord.."",""..Config.Empresas[empresa].Cargo_Discord.."")
                                else
                                    TriggerClientEvent("Notify",source,"verde","O Jogador nao esta no <b>discord</b>",5000)
                                end
                            end

                            TriggerClientEvent("Notify",source,"verde","Voce contratou o <b>"..identity2.name.." "..identity2.name2.." ["..passaporte.."]</b> para a <b>"..empresa.."</b>",5000)
                    
                            if empresa == "Hospital" then
                                vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(passaporte)),empresa = empresa, cargo = "Interno", groupSetado = Config.Empresas[empresa].Cargo_Default})
                            elseif empresa == "Police" then
                                vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(passaporte)),empresa = empresa, cargo = "Aluno", groupSetado = Config.Empresas[empresa].Cargo_Default})
                            elseif empresa == "Escola" then
                                vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(passaporte)),empresa = empresa, cargo = "Aluno", groupSetado = Config.Empresas[empresa].Cargo_Default})
                            elseif empresa == "Cafe" then
                                vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(passaporte)),empresa = empresa, cargo = "Repositor", groupSetado = Config.Empresas[empresa].Cargo_Default})
                            elseif empresa == "Juridico" then
                                vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(passaporte)),empresa = empresa, cargo = "Advogado(a)", groupSetado = Config.Empresas[empresa].Cargo_Default})
                            elseif empresa == "Exercito" then
                                vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(passaporte)),empresa = empresa, cargo = "Recruta", groupSetado = Config.Empresas[empresa].Cargo_Default})
                            else
                                vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(passaporte)),empresa = empresa, cargo = "Membro", groupSetado = Config.Empresas[empresa].Cargo_Default})
                            end
                            return true
                        else
                            TriggerClientEvent("Notify",source,"vermelho","Ele recusou o convite")
                        end
                    else
                        TriggerClientEvent("Notify",parseInt(passaporte),"vermelho","Você ainda precisa esperar "..parseInt((time - os.time()) / (3600)).." horas para ser contratado")
                        if user_id ~= parseInt(passaporte) then
                            TriggerClientEvent("Notify",source,"vermelho","Ele precisa esperar "..parseInt((time - os.time()) / (3600)).." horas para ser contratado")
                        end
                        return false
                    end
                else
                    TriggerClientEvent("Notify",source,"vermelho","Ele ja esta em outra empresa")
                    if user_id ~= parseInt(passaporte) then
                        TriggerClientEvent("Notify",parseInt(passaporte),"vermelho","Voce ja esta em uma empresa")
                    end
                    return false
                end
            else
                vRP.query("InsertPlayer", {user_id = parseInt(passaporte),nome = ""..identity2.name.." "..identity2.name2.."",empresa = "Desempregado",cargo = "Nenhum",groupSetado = "Nenhum",login = os.time(),discordid = "0",img = src.CheckImagePlayer(user_id), contratante = "Sistema"})
                Wait(3000)
                local GetJogador = vRP.query("GetEmpresa", {user_id = parseInt(passaporte)})
                local time = GetJogador[1].blacklist
                if not time or parseInt((time - os.time())) <= 0 then
                    if vRP.request(nuser_source,"Voce deseja ser contratado para "..empresa.." ?","sim","nao") then
                        vRP.setPermission(parseInt(passaporte),Config.Empresas[empresa].Cargo_Default)
                        TriggerClientEvent("Notify",source,"verde","Voce contratou o <b>"..identity2.name.." "..identity2.name2.." ["..passaporte.."]</b> para a <b>"..empresa.."</b>",5000)

                        if empresa == "Hospital" then
                            vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(passaporte)),empresa = empresa, cargo = "Interno", groupSetado = Config.Empresas[empresa].Cargo_Default})
                        elseif empresa == "Police" then
                            vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(passaporte)),empresa = empresa, cargo = "Aluno", groupSetado = Config.Empresas[empresa].Cargo_Default})
                        elseif empresa == "Cafe" then
                            vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(passaporte)),empresa = empresa, cargo = "Repositor", groupSetado = Config.Empresas[empresa].Cargo_Default})
                        elseif empresa == "Juridico" then
                            vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(passaporte)),empresa = empresa, cargo = "Advogado(a)", groupSetado = Config.Empresas[empresa].Cargo_Default})
                        elseif empresa == "Exercito" then
                            vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(passaporte)),empresa = empresa, cargo = "Recruta", groupSetado = Config.Empresas[empresa].Cargo_Default})
                        else
                            vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(passaporte)),empresa = empresa, cargo = "Membro", groupSetado = Config.Empresas[empresa].Cargo_Default})
                        end

                       
                        return true
                    else
                        TriggerClientEvent("Notify",source,"vermelho","Ele recusou o convite")
                    end
                end
            end
        end
    end
end

function calculaExpireTime(dias)
    local stimer = parseInt(os.time()+(24*dias*60*60))
    return stimer
end


--------------------------------
-- [ Buscar Vendas ] --
--------------------------------

src.refreshVendas = function(empresa)
    local source = source
    local user_id = vRP.getUserId(source)
    ListaVendas = {}
    if user_id then
        local SQL = vRP.query("GetVendas")
        if SQL[1] then
            for k,v in pairs(SQL) do
                if v.empresa == empresa then
                    local SQLPlayer = vRP.query("GetEmpresa", {user_id = v.passaporte})
                    table.insert(ListaVendas,{ id = v.id,passaporte = v.passaporte, vendedor = v.vendedor,comprador = v.comprador,imagem = v.imagem,valor = parseFormat(parseInt(v.valor)),data = v.data,imagemplayer = src.CheckImagePlayer(v.passaporte),cargo = SQLPlayer[1].cargo})
                end
            end
        end
    end
end

src.returnVendas = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return ListaVendas
    end
end

src.CriarVenda = function(empresa,compradorInput,valorInput,imagem_venda)
    local source = source
    local user_id = vRP.getUserId(source)
    if compradorInput then
        if parseInt(valorInput) > 0 then
            local identity = Config.Functions.getUserIdentity(user_id)
            vRP.query("InsertVenda", {empresa = empresa,passaporte = user_id,vendedor = ""..identity.name.." "..identity.name2.."",comprador = compradorInput,imagem = imagem_venda,valor = parseInt(valorInput),data = ""..os.date("%d/%m/%Y (%H:%M)")..""})     
            return true
        end
    end
end

src.verVenda = function(idvenda)
    local source = source
    local user_id = vRP.getUserId(source)
    local vendaInfos = vRP.query("GetVendaId", {id = parseInt(idvenda)})
    local SQLPlayer = vRP.query("GetEmpresa", {user_id = vendaInfos[1].passaporte})
    return idvenda,vendaInfos[1].passaporte,vendaInfos[1].empresa,vendaInfos[1].vendedor,vendaInfos[1].comprador,vendaInfos[1].imagem,parseFormat(parseInt(vendaInfos[1].valor)),vendaInfos[1].data,src.CheckImagePlayer(vendaInfos[1].passaporte)
end

src.deletarVenda = function(idvenda)
    local source = source
    local user_id = vRP.getUserId(source)
    vRP.execute("deleteVenda", { id = idvenda })
    return true
end


--------------------------------
-- [ Demitir ] --
--------------------------------

src.demitir = function(empresa,passaporte)
    local source = source
    local user_id = vRP.getUserId(source)
    local nuser_source = vRP.getUserSource(parseInt(passaporte))
    if user_id == 1425 then
        local identity2 = Config.Functions.getUserIdentity(parseInt(passaporte))
        vRP.remPermission(parseInt(passaporte),Config.Empresas[empresa].Cargo_Default)
        TriggerClientEvent("Notify",source,"negado","Voce demitiu o <b>"..identity2.name.." "..identity2.name2.."</b>")
        vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(passaporte)),empresa = "Desempregado", cargo = "Nenhum", groupSetado = "Nenhum"})
       -- vRP.query("updateBlacklist", {user_id = parseInt(parseInt(passaporte)), blacklist = calculaExpireTime(Config.DiasBlacklist)})
        return true
    else
        if vRP.request(source,"Você deseja demitir o passaporte: "..passaporte.." ?","sim","nao") then
            local identity2 = Config.Functions.getUserIdentity(parseInt(passaporte))
            vRP.remPermission(parseInt(passaporte),Config.Empresas[empresa].Cargo_Default)
            TriggerClientEvent("Notify",source,"negado","Voce demitiu o <b>"..identity2.name.." "..identity2.name2.."</b>")
            vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(passaporte)),empresa = "Desempregado", cargo = "Nenhum", groupSetado = "Nenhum"})
            vRP.query("updateBlacklist", {user_id = parseInt(parseInt(passaporte)), blacklist = calculaExpireTime(Config.DiasBlacklist)})
            return true
        end
    end
end

--------------------------------
-- [ Promover ] --
--------------------------------

src.promover = function(empresa,passaporte)
    local source = source
    local user_id = vRP.getUserId(source)
    local nuser_source = vRP.getUserSource(parseInt(passaporte))
    local profiss = 0
    if user_id then
        for k,v in pairs(Config.Empresas[empresa].cargos) do

            local GetJogador = vRP.query("GetEmpresa", {user_id = parseInt(passaporte)})
       
            if GetJogador[1].cargo == v.Acesso then
                if k == 1 then
                    TriggerClientEvent("Notify",source,"vermelho","Ele ja esta no cargo <b>Maximo</b>")
                else
                    profiss = Config.Empresas[empresa].cargos[k - 1]
                    local GetJogador = vRP.query("GetEmpresa", {user_id = user_id})
                    -- vRP.remPermission(parseInt(passaporte),v.Set)
                    --vRP.setPermission(parseInt(passaporte),profiss.Set)
                    local identity2 = Config.Functions.getUserIdentity(parseInt(passaporte))
                    TriggerClientEvent("Notify",source,"verde","Voce promoveu o <b>"..identity2.name.." "..identity2.name2.."</b> a <b>"..profiss.Set.."</b>")
                   
                    vRP.query("updateEmpPlaye3r", {user_id = parseInt(parseInt(passaporte)),cargo = profiss.Acesso})
                end
            end


        end
    end
end

src.rebaixar = function(empresa,passaporte)
    local source = source
    local user_id = vRP.getUserId(source)
    local nuser_source = vRP.getUserSource(parseInt(passaporte))
    local profiss = 0
    if user_id then
        for k,v in pairs(Config.Empresas[empresa].cargos) do

            local GetJogador = vRP.query("GetEmpresa", {user_id = parseInt(passaporte)})
            if GetJogador[1].cargo == v.Acesso then
                profiss = Config.Empresas[empresa].cargos[k + 1]
                if profiss ~= nil then
                    vRP.remPermission(parseInt(passaporte),v.Set)
                    vRP.setPermission(parseInt(passaporte),profiss.Set)
                    local identity2 = Config.Functions.getUserIdentity(parseInt(passaporte))
                    TriggerClientEvent("Notify",source,"amarelo","Voce rebaixou o <b>"..identity2.name.." "..identity2.name2.."</b> a <b>"..profiss.Set.."</b>")
                    vRP.query("updateEmpPlayer", {user_id = parseInt(parseInt(passaporte)),empresa = empresa, cargo = profiss.Acesso, groupSetado = profiss.Set})
                    return true
                else
                    TriggerClientEvent("Notify",source,"vermelho","Ele ja esta no cargo <b>Minimo</b>")
                end
            end

        
        end
    end
end

src.upgrade = function(empresa)
    local source = source
    local user_id = vRP.getUserId(source)
    if empresa then
        local verify = vRP.query("VerificarCriacao", {empresa = empresa})
        local novoNumero = verify[1].upgradeCraft + 1
        if Config.Empresas[empresa].upgrades[novoNumero] then
            if vRP.request(source,"Você deseja comprar o upgrade de "..Config.Empresas[empresa].upgrades[novoNumero].nome.." por "..Config.Empresas[empresa].upgrades[novoNumero].valor.." ?","sim","nao") then
                if vRP.paymentFull(user_id,parseInt(Config.Empresas[empresa].upgrades[novoNumero].valor)) then
                    vRP.query("updateUpgradse", {empresa = empresa, upgradeCraft = novoNumero})
                    TriggerClientEvent("Notify",source,"verde","<b>"..Config.Empresas[empresa].upgrades[novoNumero].nome.."</b> comprado com sucesso")
                else
                    TriggerClientEvent("Notify",source,"vermelho","Voce nao tem dinheiro.")
                end
            end
        else
            TriggerClientEvent("Notify",source,"vermelho","Nao existem mais upgrades.")
        end
    end
end