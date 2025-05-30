-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS GLOBAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local vRP = nil
local Tunnel = nil
local Proxy = nil
local cRP = nil
local vRPC = nil
local vCLIENT = nil

local Empresas_Pontos = {
    ["Cupula"] = {}, ["Desmanche"] = {}, ["Noruega"] = {}, ["MecanicaIlegal"] = {}, ["Fazenda"] = {}, ["FacExtra"] = {},
    ["Beiramar"] = {}, ["Mineradora"] = {}, ["Vanilla"] = {}, ["Barragem"] = {}, ["Bahamas"] = {}, ["Farol"] = {},
    ["Mafia1"] = {}, ["Mafia2"] = {}, ["Contrabando1"] = {}, ["Contrabando2"] = {}, ["Municao1"] = {}, ["Municao2"] = {}
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP TUNNELS - AGUARDAR CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    Citizen.Wait(5000)
    
    print("^3[ADMIN-SERVER]^7 Tentando carregar VRP...")
    
    while not vRP do
        Citizen.Wait(100)
        if _G.vRP then
            vRP = _G.vRP
        else
            Tunnel = module("vrp","lib/Tunnel")
            Proxy = module("vrp","lib/Proxy")
            vRP = Proxy.getInterface("vRP")
        end
    end
    
    while not vRP.getUserId do
        Citizen.Wait(100)
        print("^3[ADMIN-SERVER]^7 VRP carregado mas funções ainda não disponíveis...")
    end
    
    print("^2[ADMIN-SERVER]^7 VRP carregado com sucesso!")
    
    -----------------------------------------------------------------------------------------------------------------------------------------
    -- CONNECTION
    -----------------------------------------------------------------------------------------------------------------------------------------
    cRP = {}
    Tunnel.bindInterface("admin",cRP)
    vRPC = Tunnel.getInterface("admin")
    vCLIENT = Tunnel.getInterface("admin")
    
    print("^2[ADMIN-SERVER]^7 Registrando comandos admin...")
    Citizen.Wait(2000)
    
    -----------------------------------------------------------------------------------------------------------------------------------------
    -- PREPARAR QUERIES DO BANCO DE DADOS
    -----------------------------------------------------------------------------------------------------------------------------------------
    vRP._prepare("admin/getEmpresas","SELECT * FROM groups_perfil WHERE empresa = @empresa")
    vRP._prepare("admin/addponto", "UPDATE groups_empresas SET pontos = pontos + @pontos WHERE empresa = @empresa")
    vRP._prepare("admin/verEmpresas", "SELECT * FROM groups_empresas")
    
    -- PREPARAR QUERIES PARA WHITELIST
    vRP.prepare("base/wl", "SELECT * FROM accounts WHERE steam = @steam")
    vRP.prepare("base/wlUpdate", "UPDATE accounts SET whitelist = @whitelist WHERE steam = @steam")
    
    -- PREPARAR QUERIES PARA QUEUE
    vRP.prepare("warn/selectCharacters", "SELECT * FROM characters WHERE steam = @steam")
    
    print("^2[ADMIN-SERVER]^7 Todas as queries preparadas com sucesso!")
    print("^2[ADMIN-SERVER]^7 Todos os comandos registrados com sucesso!")
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS WL E UNWL - VERSÃO CORRIGIDA (REMOVER vRP.prepare DAQUI)
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('wl', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local identity = vRP.userIdentity(user_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        if args[1] then
            local getUser = vRP.query("base/wl", {steam = args[1]})
            if getUser[1] then
                vRP.execute("base/wlUpdate",{ steam = args[1], whitelist = 1 })
                TriggerClientEvent("Notify",source,"verde","Hex <b>"..args[1].."</b> liberada na whitelist.",5000)
                
                local x,y,z = vCLIENT.getPosition(source)
                
                -- WEBHOOK USANDO SISTEMA CENTRALIZADO
                SendWebhook("wl", {
                    embeds = {{
                        title = "✅ Whitelist Liberada",
                        fields = {
                            { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                            { name = "🔑 Hex Liberada:", value = args[1] },
                            { name = "📍 Coordenadas:", value = "X: "..math.floor(x).." | Y: "..math.floor(y).." | Z: "..math.floor(z) }
                        },
                        color = 65280,
                        footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                    }}
                })
            else
                TriggerClientEvent("Notify",source,"vermelho","Essa hex não existe no banco de dados.",5000)
            end
        else
            TriggerClientEvent("Notify",source,"amarelo","Use: <b>/wl [HEX]</b>",5000)
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando.", 5000)
    end
end)

RegisterCommand('unwl', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local identity = vRP.userIdentity(user_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        if args[1] then
            local getUser = vRP.query("base/wl", {steam = args[1]})
            if getUser[1] then
                vRP.execute("base/wlUpdate",{ steam = args[1], whitelist = 0 })
                TriggerClientEvent("Notify",source,"verde","Whitelist removida da hex <b>"..args[1].."</b>.",5000)
                
                local x,y,z = vCLIENT.getPosition(source)
                
                -- WEBHOOK USANDO SISTEMA CENTRALIZADO
                SendWebhook("unwl", {
                    embeds = {{
                        title = "❌ Whitelist Removida",
                        fields = {
                            { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                            { name = "🔑 Hex Removida:", value = args[1] },
                            { name = "📍 Coordenadas:", value = "X: "..math.floor(x).." | Y: "..math.floor(y).." | Z: "..math.floor(z) }
                        },
                        color = 16711680,
                        footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                    }}
                })
            else
                TriggerClientEvent("Notify",source,"vermelho","Essa hex não existe no banco de dados.",5000)
            end
        else
            TriggerClientEvent("Notify",source,"amarelo","Use: <b>/unwl [HEX]</b>",5000)
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando.", 5000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO GOD - REVIVER JOGADORES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god",function(source,args,rawCommand)
    if not vRP then
        return
    end
    
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    end
    
    local identity = vRP.userIdentity(user_id)
    local hasPermission = vRP.hasGroup(user_id,"Admin")
    
    if hasPermission then
        if args[1] then
            -- Reviver outro jogador
            local targetId = parseInt(args[1])
            local otherPlayer = vRP.userSource(targetId)
            
            if otherPlayer then
                vRP.varyHealth(otherPlayer, 400)
                vRP.setArmour(otherPlayer, 100)
                vRP.upgradeThirst(targetId, 100)
                vRP.upgradeHunger(targetId, 100)
                vRP.downgradeStress(targetId, 100)
                
                TriggerClientEvent("admin:revivePlayer", otherPlayer, 200)
                TriggerClientEvent("resetHandcuff", otherPlayer)
                TriggerClientEvent("resetBleeding", otherPlayer)
                TriggerClientEvent("resetDiagnostic", otherPlayer)
                
                local identity2 = vRP.userIdentity(targetId)
                TriggerClientEvent("Notify", otherPlayer, "verde", "Você foi revivido por um administrador.", 5000)
                
                -- WEBHOOK PARA REVIVER OUTRO JOGADOR
                SendWebhook("god", {
                    embeds = {{
                        title = "⚡ God Mode - Reviver Player",
                        fields = {
                            { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                            { name = "🎯 Revivido:", value = identity2.name.." "..identity2.name2.." #"..targetId }
                        },
                        color = 3066993,
                        footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                    }}
                })
            end
        else
            -- Reviver a si mesmo
            vRP.varyHealth(source, 400)
            vRP.setArmour(source, 100)
            vRP.upgradeThirst(user_id, 100)
            vRP.upgradeHunger(user_id, 100)
            vRP.downgradeStress(user_id, 100)
            
            TriggerClientEvent("admin:revivePlayer", source, 200)
            TriggerClientEvent("resetHandcuff", source)
            TriggerClientEvent("resetBleeding", source)
            TriggerClientEvent("resetDiagnostic", source)
            
            -- WEBHOOK PARA AUTO-REVIVER
            SendWebhook("god", {
                embeds = {{
                    title = "⚡ God Mode - Auto Revive",
                    fields = {
                        { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                        { name = "💫 Ação:", value = "Se reviveu" }
                    },
                    color = 65280,
                    footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                }}
            })
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO REGISTRO - CONTAGEM DE EMPRESAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("registro", function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "Admin") then
        local message = ""
        local Players_Ilegal = 0
        local keys = {}

        -- Ordenar as empresas
        for k, _ in pairs(Empresas_Pontos) do
            table.insert(keys, k)
        end
        table.sort(keys)

        -- Contar jogadores ilegais
        for _, k in ipairs(keys) do
            local SQL = vRP.query("admin/getEmpresas", { empresa = k })
            if SQL[1] then
                for _, b in pairs(SQL) do
                    local id = vRP.userSource(tonumber(b.user_id))
                    if id then
                        Players_Ilegal = Players_Ilegal + 1
                    end
                end
            end
        end

        -- Contar jogadores por empresa
        local SQL_empresas = vRP.query("admin/verEmpresas")
        for _, w in pairs(SQL_empresas) do
            for k, _ in pairs(Empresas_Pontos) do
                if w.empresa == k then
                    if w.empresa == "FacExtra" then
                        w.empresa = "Desmanche2"
                    end
                    local SQL = vRP.query("admin/getEmpresas", { empresa = w.empresa })
                    local count = 0
                    for _, s in pairs(SQL) do
                        local id = vRP.userSource(tonumber(s.user_id))
                        if id then
                            count = count + 1
                        end
                    end
                    message = message .. w.empresa .. ": **" .. count .. "/" .. #SQL .. "** Online\n"
                end
            end
        end

        -- Enviar para o webhook
        SendWebhook("registro", {
            content = "@everyone",
            embeds = {{
                title = "** Contagem **",
                fields = {
                    { name = "<:eg_globe:1132318084363989003> Contagem:", value = message },
                    { name = "<:eg_addemoji:1132315996837920768> Jogadores Ilegal:", value = Players_Ilegal },
                    { name = "<:eg_cautions:1132315882337619978> Jogadores Online:", value = GetNumPlayerIndices() }
                },
                footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'), icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png" },
                thumbnail = { url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png" },
                color = 15486285
            }}
        })
    else
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando.", 5000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO ADDSS - ADICIONAR JOGADOR À LISTA SS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addss', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.userIdentity(user_id)
    if user_id and vRP.hasPermission(user_id,"Admin") then
        local GetJogador = vRP.query("ss/verificar", {user_id = parseInt(args[1])})
        if not GetJogador[1] then
            if args[1] then
                local mensagem = vRP.prompt(source,"Motivo:","")
                if mensagem then
                    TriggerClientEvent("Notify", source, "verde", "Voce colocou o passaporte: <b>"..args[1].."</b> na lista dos ss por: <b>"..mensagem.."</b>.")
                    vRP.query("ss/inserPlayer", {user_id = parseInt(args[1]),motivo = mensagem,dia = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S')})
                    local identity2 = vRP.userIdentity(parseInt(args[1]))
                    
                    SendWebhook("addss", {
                        content = "<@&1074503116965285969> ",
                        embeds = {{     
                            title = "** Novo jogador adicionado na Lista**",
                            fields = {
                                { name = "📝 Author:", value = identity.name.." "..identity.name2.." **#"..user_id.."** " },
                                { name = "📝 Player:", value = identity2.name.." "..identity2.name2.." **#"..args[1].."** " },
                                { name = "✨ Motivo:", value = mensagem }
                            }, 
                            footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'), icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png" },
                            thumbnail = { url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png" },
                            color = 15548997
                        }}
                    })
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
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO NC - NOCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nc",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and (vRP.hasGroup(user_id,"Admin") or vRP.hasGroup(user_id,"StreamerVip")) then
        if vCLIENT then
            vCLIENT.noClip(source)
            local x,y,z = vCLIENT.getPosition(source)
            local identity = vRP.userIdentity(user_id)
            
            SendWebhook("noclip", {
                embeds = {{
                    title = "🚁 Noclip Ativado",
                    fields = {
                        { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                        { name = "📍 Posição:", value = "X: "..math.floor(x).." | Y: "..math.floor(y).." | Z: "..math.floor(z) }
                    },
                    color = 3447003,
                    footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                }}
            })
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO BAN - BANIR JOGADOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 and parseInt(args[1]) ~= 18 then
        local identity = vRP.userIdentity(user_id)
        local nuser_id = parseInt(args[1])
        local target_identity = vRP.userIdentity(nuser_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        if target_identity then
            vRP.kick(nuser_id,"Você esta temporariamente banido da cidade.")
            vRP.execute("banneds/insertBanned",{ steam = target_identity["steam"] })
            TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..nuser_id.."</b> banido",5000)
            
            SendWebhook("ban", {
                embeds = {{
                    title = "🔨 Player Banido",
                    fields = {
                        { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                        { name = "🚫 Banido:", value = target_identity.name.." "..target_identity.name2.." #"..nuser_id }
                    },
                    color = 16711680,
                    footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                }}
            })
        else
            TriggerClientEvent("Notify", source, "vermelho", "Jogador ID <b>"..nuser_id.."</b> não encontrado.", 5000)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO unban - DESBANIR JOGADOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
        local identity = vRP.userIdentity(user_id)
        local nuser_id = parseInt(args[1])
        local target_identity = vRP.userIdentity(nuser_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        if target_identity then
            vRP.execute("banneds/removeBanned",{ steam = target_identity["steam"] })
            TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..nuser_id.."</b> desbanido com sucesso!",5000)
            
            local x,y,z = vCLIENT.getPosition(source)
            
            -- WEBHOOK USANDO SISTEMA CENTRALIZADO
            SendWebhook("unban", {
                embeds = {{
                    title = "🔓 Player Desbanido",
                    fields = {
                        { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                        { name = "✅ Desbanido:", value = target_identity.name.." "..target_identity.name2.." #"..nuser_id },
                        { name = "🔑 Steam Hex:", value = target_identity.steam },
                        { name = "📍 Coordenadas Admin:", value = "X: "..math.floor(x).." | Y: "..math.floor(y).." | Z: "..math.floor(z) }
                    },
                    color = 65280,
                    footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                }}
            })
        else
            TriggerClientEvent("Notify", source, "vermelho", "Jogador ID <b>"..nuser_id.."</b> não encontrado.", 5000)
        end
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO KICK - EXPULSAR JOGADOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
        local identity = vRP.userIdentity(user_id)
        local nuser_id = parseInt(args[1])
        local target_identity = vRP.userIdentity(nuser_id)
        
        TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..args[1].."</b> expulso.",5000)
        vRP.kick(args[1],"Você foi expulso da cidade.")
        
        SendWebhook("kick", {
            embeds = {{
                title = "👢 Player Expulso",
                fields = {
                    { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                    { name = "🚪 Expulso:", value = target_identity and (target_identity.name.." "..target_identity.name2.." #"..nuser_id) or "ID: "..nuser_id }
                },
                color = 16776960,
                footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
            }}
        })
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO TPWAY - TELEPORT PARA WAYPOINT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and (vRP.hasGroup(user_id,"Admin") or user_id == 1813 or user_id == 1807 or user_id == 1848 or user_id == 1808) then
        local identity = vRP.userIdentity(user_id)
        vCLIENT.teleportWay(source)
        
        SendWebhook("tpway", {
            embeds = {{
                title = "🌀 Teleport Waypoint",
                fields = {{ name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id }},
                color = 8388736,
                footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
            }}
        })
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO TPTOME - TELEPORTAR JOGADOR PARA ADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
        local otherPlayer = vRP.userSource(args[1])
        if otherPlayer then
            local ped = GetPlayerPed(source)
            local coords = GetEntityCoords(ped)
            vRP.teleport(otherPlayer,coords["x"],coords["y"],coords["z"])

            local identity = vRP.userIdentity(user_id)
            local identity2 = vRP.userIdentity(args[1])
            local x,y,z = vCLIENT.getPosition(source)
            local x2,y2,z2 = vCLIENT.getPosition(otherPlayer)
            
            -- WEBHOOK USANDO SISTEMA CENTRALIZADO
            SendWebhook("tptome", {
                embeds = {{     
                    title = "🔄 Teleport Player para Admin",
                    fields = {
                        { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                        { name = "🎯 Player Puxado:", value = identity2.name.." "..identity2.name2.." #"..args[1] },
                        { name = "📍 Coordenada Admin:", value = "X: "..math.floor(x).." | Y: "..math.floor(y).." | Z: "..math.floor(z) },
                        { name = "📍 Coordenada Player:", value = "X: "..math.floor(x2).." | Y: "..math.floor(y2).." | Z: "..math.floor(z2) }
                    }, 
                    color = 3092790,
                    footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                }}
            })
            
            TriggerClientEvent("Notify", source, "verde", "Você puxou <b>"..identity2.name.." "..identity2.name2.." #"..args[1].."</b> para sua localização.", 5000)
            TriggerClientEvent("Notify", otherPlayer, "azul", "Você foi teleportado por um administrador.", 5000)
        else
            TriggerClientEvent("Notify", source, "vermelho", "Jogador não está online.", 5000)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO TPTO - TELEPORT PARA JOGADOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
        local otherPlayer = vRP.userSource(args[1])
        if otherPlayer then
            local ped = GetPlayerPed(otherPlayer)
            local coords = GetEntityCoords(ped)
            vRP.teleport(source,coords["x"],coords["y"],coords["z"])

            local identity = vRP.userIdentity(user_id)
            local identity2 = vRP.userIdentity(args[1])
            local x,y,z = vCLIENT.getPosition(source)
            local x2,y2,z2 = vCLIENT.getPosition(otherPlayer)
            
            -- WEBHOOK CORRIGIDO PARA USAR 'tpto'
            SendWebhook("tpto", {
                embeds = {{     
                    title = "🌀 Teleport para Jogador",
                    fields = {
                        { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                        { name = "🎯 Player:", value = identity2.name.." "..identity2.name2.." #"..args[1] },
                        { name = "📍 Coordenada Admin:", value = "X: "..math.floor(x).." | Y: "..math.floor(y).." | Z: "..math.floor(z) },
                        { name = "📍 Coordenada Player:", value = "X: "..math.floor(x2).." | Y: "..math.floor(y2).." | Z: "..math.floor(z2) }
                    }, 
                    color = 3092790,
                    footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                }}
            })
            
            TriggerClientEvent("Notify", source, "verde", "Teleportado para <b>"..identity2.name.." "..identity2.name2.." #"..args[1].."</b>", 5000)
        else
            TriggerClientEvent("Notify", source, "vermelho", "Jogador não está online.", 5000)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO ITEM - DAR ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local identity = vRP.userIdentity(user_id)
        
        if args[1] and args[2] and args[3] and parseInt(args[1]) > 0 and parseInt(args[3]) > 0 then
            local target_id = parseInt(args[1])
            local item_name = args[2]
            local quantity = parseInt(args[3])
            
            -- Lista de itens bloqueados
            local blockedItems = {
                ["WEAPON_RAYPISTOL"] = true,
                ["weapon_raypistol"] = true
            }
            
            if not blockedItems[item_name] then
                -- Verificar se o jogador existe
                local target_identity = vRP.userIdentity(target_id)
                if target_identity then
                    -- Tentar gerar o item
                    vRP.generateItem(target_id, item_name, quantity, true)
                    
                    -- Sempre assumir sucesso e dar feedback positivo
                    local target_name = target_identity.name.." "..target_identity.name2.." #"..target_id
                    
                    TriggerClientEvent("Notify", source, "verde", "Item <b>"..item_name.."</b> x"..quantity.." dado para <b>"..target_name.."</b>.", 5000)
                    
                    -- Notificar o jogador que recebeu o item
                    local target_source = vRP.userSource(target_id)
                    if target_source then
                        TriggerClientEvent("Notify", target_source, "azul", "Você recebeu <b>"..item_name.."</b> x"..quantity.." de um administrador.", 5000)
                    end
                    
                    SendWebhook("give", {
                        embeds = {{
                            title = "📦 Item Dado",
                            fields = {
                                { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                                { name = "🎯 Recebeu:", value = target_name },
                                { name = "📦 Item:", value = item_name.." x"..quantity }
                            },
                            color = 3066993,
                            footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                        }}
                    })
                else
                    TriggerClientEvent("Notify", source, "vermelho", "Jogador ID <b>"..target_id.."</b> não encontrado.", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "vermelho", "Item <b>"..item_name.."</b> está bloqueado.", 5000)
            end
        else
            TriggerClientEvent("Notify", source, "amarelo", "Use: <b>/item [ID] [NOME_DO_ITEM] [QUANTIDADE]</b>", 5000)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO GROUP - ADICIONAR CARGO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 and args[2] then
        local identity = vRP.userIdentity(user_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        local target_identity = vRP.userIdentity(parseInt(args[1]))
        TriggerClientEvent("Notify",source,"verde","Adicionado <b>"..args[2].."</b> ao passaporte <b>"..args[1].."</b>.",5000)
        vRP.setPermission(args[1],args[2])
        
        SendWebhook("adminaddgroup", {
            embeds = {{
                title = "➕ Cargo Adicionado",
                fields = {
                    { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                    { name = "🎯 Alvo:", value = target_identity and (target_identity.name.." "..target_identity.name2.." #"..args[1]) or "ID: "..args[1] },
                    { name = "🏷️ Cargo:", value = args[2] }
                },
                color = 65280,
                footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
            }}
        })
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO UNGROUP - REMOVER CARGO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 and args[2] then
        local identity = vRP.userIdentity(user_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        local target_identity = vRP.userIdentity(parseInt(args[1]))
        TriggerClientEvent("Notify",source,"verde","Removido <b>"..args[2].."</b> ao passaporte <b>"..args[1].."</b>.",5000)
        vRP.remPermission(args[1],args[2])
        
        SendWebhook("adminremgroup", {
            embeds = {{
                title = "➖ Cargo Removido",
                fields = {
                    { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                    { name = "🎯 Alvo:", value = target_identity and (target_identity.name.." "..target_identity.name2.." #"..args[1]) or "ID: "..args[1] },
                    { name = "🏷️ Cargo:", value = args[2] }
                },
                color = 16711680,
                footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
            }}
        })
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO TUNING - TUNAGEM DE VEÍCULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local identity = vRP.userIdentity(user_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        local x,y,z = vCLIENT.getPosition(source)
        
        TriggerClientEvent("admin:vehicleTuning", source)
        TriggerClientEvent("Notify", source, "verde", "Tuning ativado no veículo!", 5000)
        
        SendWebhook("tuning", {
            embeds = {{
                title = "🔧 Tuning Ativado",
                fields = {
                    { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                    { name = "🚗 Ação:", value = "Ativou tuning no veículo" },
                    { name = "📍 Coordenadas:", value = "X: "..math.floor(x).." | Y: "..math.floor(y).." | Z: "..math.floor(z) }
                },
                color = 16776960,
                footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
            }}
        })
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO FIX - REPARAR VEÍCULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fix",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        TriggerClientEvent("admin:fixVehicle", source)
        
        local x,y,z = vCLIENT.getPosition(source)
        
        -- Tentar obter identity com fallback
        local identity = vRP.userIdentity(user_id)
        local admin_name = "Admin #"..user_id
        
        if identity and identity.name and identity.name2 then
            admin_name = identity.name.." "..identity.name2.." #"..user_id
        end
        
        -- USAR A FUNÇÃO GLOBAL DO GERAL.LUA
        SendWebhook("fix", {
            embeds = {{
                title = "🔧 Comando Fix Executado",
                fields = {
                    { name = "👤 Admin:", value = admin_name },
                    { name = "📍 Coordenadas:", value = "X: "..math.floor(x).." | Y: "..math.floor(y).." | Z: "..math.floor(z) },
                    { name = "🚗 Ação:", value = "Comando /fix executado" }
                },
                color = 3092790,
                footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
            }}
        })
        
    end
end)

------------------------------------------
-- [ PLAYER ON CONSOLE ]
------------------------------------------

RegisterCommand("playersc",function(source,args,rawCommand)
    if source == 0 then
        print('^7[^4'..GetCurrentResourceName()..'^7] Membros Online: ^2 '..GetNumPlayerIndices()..' ^7')
    end
end)

------------------------------------------
-- [ GROUP CONSOLE ]
------------------------------------------

RegisterCommand('groupc',function(source,args,rawCommand)
    if source == 0 then
        if args[1] and args[2] then
            local identity = vRP.userIdentity(parseInt(args[1]))
            vRP.setPermission(parseInt(args[1]),args[2])
            print('^7[^4'..GetCurrentResourceName()..'^7] Setado a permissao ^2 '..args[2]..'^7 no passaporte ^2 '..identity.name..' '..identity.name2..' '..args[1]..' ^7')
        end
    end
end)

------------------------------------------
-- [ UNGROUP CONSOLE ]
------------------------------------------

RegisterCommand('ungroupc',function(source,args,rawCommand)
    if source == 0 then
        if args[1] and args[2] then
            local identity = vRP.userIdentity(parseInt(args[1]))
            vRP.remPermission(parseInt(args[1]),args[2])
            print('^7[^4'..GetCurrentResourceName()..'^7] Retirado a permissao ^2 '..args[2]..'^7 no passaporte ^2 '..identity.name..' '..identity.name2..' '..args[1]..' ^7')
        end
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS DE COORDENADAS
-----------------------------------------------------------------------------------------------------------------------------------------
function mathLength(number)
    return math.floor(number * 100) / 100
end

RegisterCommand("cds",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local ped = GetPlayerPed(source)
        local coords = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)
        
        local coordsText = mathLength(coords["x"])..","..mathLength(coords["y"])..","..mathLength(coords["z"])..","..mathLength(heading)
        vRP.prompt(source,"Coordenadas:",coordsText)
        
        TriggerClientEvent("Notify", source, "azul", "Coordenadas copiadas!", 3000)
    end
end)

RegisterCommand('cds2',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local ped = GetPlayerPed(source)
        local coords = GetEntityCoords(ped)
        
        local coordsText = "x = "..mathLength(coords.x)..", y = "..mathLength(coords.y)..", z = "..mathLength(coords.z)
        vRP.prompt(source,"Coordenadas:",coordsText)
        
        TriggerClientEvent("Notify", source, "azul", "Coordenadas copiadas!", 3000)
    end
end)

RegisterCommand('cds3',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local ped = GetPlayerPed(source)
        local coords = GetEntityCoords(ped)
        
        local coordsText = "['x'] = "..mathLength(coords.x)..", ['y'] = "..mathLength(coords.y)..", ['z'] = "..mathLength(coords.z)
        vRP.prompt(source,"Coordenadas:",coordsText)
        
        TriggerClientEvent("Notify", source, "azul", "Coordenadas copiadas!", 3000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO TPCDS - TELEPORT PARA COORDENADAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds", function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local identity = vRP.userIdentity(user_id)
        local fcoords = vRP.prompt(source, "Coordenadas:", "")
        
        if fcoords == "" then
            TriggerClientEvent("Notify", source, "vermelho", "Coordenadas não informadas!", 5000)
            return
        end

        local coords = {}

        -- Formato: x,y,z ou x,y,z,heading
        if string.match(fcoords, "^[-%d%.]+,[-%d%.]+,[-%d%.]+,?[-%d%.]*$") then
            for coord in string.gmatch(fcoords, "[^,]+") do
                table.insert(coords, tonumber(coord))
            end
        -- Formato: x = 123, y = 456, z = 789
        elseif string.match(fcoords, "x%s*=%s*[-%d%.]+,?%s*y%s*=%s*[-%d%.]+,?%s*z%s*=%s*[-%d%.]+") then
            local x, y, z = string.match(fcoords, "x%s*=%s*([-%d%.]+),?%s*y%s*=%s*([-%d%.]+),?%s*z%s*=%s*([-%d%.]+)")
            coords = { tonumber(x), tonumber(y), tonumber(z) }
        -- Formato: ['x'] = 123, ['y'] = 456, ['z'] = 789
        elseif string.match(fcoords, "%['x'%]%s*=%s*[-%d%.]+,%s*%['y'%]%s*=%s*[-%d%.]+,%s*%['z'%]%s*=%s*[-%d%.]+") then
            local x, y, z = string.match(fcoords,"%['x'%]%s*=%s*([-%d%.]+),%s*%['y'%]%s*=%s*([-%d%.]+),%s*%['z'%]%s*=%s*([-%d%.]+)")
            coords = { tonumber(x), tonumber(y), tonumber(z) }
        else
            TriggerClientEvent("Notify",source,"vermelho","Formato inválido de coordenadas!",5000)
            return
        end

        if coords[1] and coords[2] and coords[3] then
            vRP.teleport(source, coords[1], coords[2], coords[3])
            TriggerClientEvent("Notify", source, "verde", "Teleportado para as coordenadas!", 5000)
            
            -- Webhook para tpcds usando sistema centralizado
            SendWebhook("tpto", {
                embeds = {{
                    title = "🌀 Teleport por Coordenadas",
                    fields = {
                        { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                        { name = "📍 Coordenadas:", value = "X: "..coords[1].." | Y: "..coords[2].." | Z: "..coords[3] }
                    },
                    color = 2829875,
                    footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                }}
            })
        else
            TriggerClientEvent("Notify",source,"vermelho","Coordenadas inválidas!",5000)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO SETMOCHILA - AUMENTAR MOCHILA DO JOGADOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('setmochila',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local identity = vRP.userIdentity(user_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        if args[1] and args[2] then
            local target_id = parseInt(args[1])
            local weight = parseInt(args[2])
            
            if target_id > 0 and weight > 0 then
                local nplayer = vRP.userSource(target_id)
                if nplayer then
                    local nidentity = vRP.userIdentity(target_id)
                    
                    if nidentity then
                        vRP.setWeight(target_id, weight)
                        
                        TriggerClientEvent("Notify", source, "verde", "Mochila do passaporte <b>"..target_id.."</b> alterada para <b>"..weight.."kg</b>!", 5000)
                        TriggerClientEvent("Notify", nplayer, "azul", "Sua mochila foi alterada para <b>"..weight.."kg</b> por um administrador.", 5000)
                        
                        -- WEBHOOK USANDO SISTEMA CENTRALIZADO
                        SendWebhook("setmochila", {
                            embeds = {{
                                title = "🎒 Mochila Alterada",
                                fields = {
                                    { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                                    { name = "🎯 Jogador:", value = nidentity.name.." "..nidentity.name2.." #"..target_id },
                                    { name = "📦 Nova Capacidade:", value = weight.."kg" }
                                },
                                color = 3066993,
                                footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                            }}
                        })
                    else
                        TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do jogador.", 5000)
                    end
                else
                    TriggerClientEvent("Notify", source, "vermelho", "Jogador ID <b>"..target_id.."</b> não está online.", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "amarelo", "IDs devem ser maiores que 0.", 5000)
            end
        else
            TriggerClientEvent("Notify", source, "amarelo", "Use: <b>/setmochila [ID] [PESO]</b>", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando.", 5000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO MOCHILARESET - RESETAR MOCHILA DO JOGADOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mochilareset',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local identity = vRP.userIdentity(user_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        if args[1] then
            local target_id = parseInt(args[1])
            
            if target_id > 0 then
                local nplayer = vRP.userSource(target_id)
                if nplayer then
                    local nidentity = vRP.userIdentity(target_id)
                    
                    if nidentity then
                        vRP.resetWeight(target_id)
                        
                        TriggerClientEvent("Notify", source, "verde", "Mochila do passaporte <b>"..target_id.."</b> foi resetada!", 5000)
                        TriggerClientEvent("Notify", nplayer, "azul", "Sua mochila foi resetada por um administrador.", 5000)
                        
                        -- WEBHOOK USANDO SISTEMA CENTRALIZADO
                        SendWebhook("resetmochila", {
                            embeds = {{
                                title = "🔄 Mochila Resetada",
                                fields = {
                                    { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                                    { name = "🎯 Jogador:", value = nidentity.name.." "..nidentity.name2.." #"..target_id },
                                    { name = "🔧 Ação:", value = "Mochila resetada ao padrão" }
                                },
                                color = 16776960,
                                footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                            }}
                        })
                    else
                        TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do jogador.", 5000)
                    end
                else
                    TriggerClientEvent("Notify", source, "vermelho", "Jogador ID <b>"..target_id.."</b> não está online.", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "amarelo", "ID deve ser maior que 0.", 5000)
            end
        else
            TriggerClientEvent("Notify", source, "amarelo", "Use: <b>/mochilareset [ID]</b>", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando.", 5000)
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO LIMPARINV - LIMPAR INVENTÁRIO DO JOGADOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limparinv',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local identity = vRP.userIdentity(user_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        if args[1] then
            local target_id = parseInt(args[1])
            
            if target_id > 0 then
                local nplayer = vRP.userSource(target_id)
                if nplayer then
                    local nidentity = vRP.userIdentity(target_id)
                    
                    if nidentity then
                        -- Obter inventário atual ANTES de limpar
                        local inventory = vRP.userInventory(target_id)
                        local itemsRemoved = {}
                        local totalItems = 0
                        
                        -- Contar e coletar itens para log
                        if inventory then
                            for slot, item in pairs(inventory) do
                                if item and item.item then
                                    table.insert(itemsRemoved, {
                                        item = item.item,
                                        amount = item.amount or 1
                                    })
                                    totalItems = totalItems + (item.amount or 1)
                                end
                            end
                        end
                        
                        -- MÉTODO 1: Limpar item por item usando vRP.removeInventoryItem
                        if inventory then
                            for slot, item in pairs(inventory) do
                                if item and item.item then
                                    vRP.removeInventoryItem(target_id, item.item, item.amount or 1, false)
                                end
                            end
                        end
                        
                        -- MÉTODO 2 (alternativo): Resetar inventário via datatable
                        local dataTable = vRP.getDatatable(target_id)
                        if dataTable then
                            dataTable["inventory"] = {}
                        end
                        
                        -- Forçar atualização do inventário no cliente
                        if nplayer then
                            -- Aguardar um pouco para garantir que o servidor processou
                            Citizen.SetTimeout(500, function()
                                TriggerClientEvent("inventory:Update", nplayer, "updateMochila")
                            end)
                            
                            -- Segunda atualização para garantir
                            Citizen.SetTimeout(1500, function()
                                TriggerClientEvent("inventory:Update", nplayer, "updateMochila")
                            end)
                        end
                        
                        TriggerClientEvent("Notify", source, "verde", "Inventário do passaporte <b>"..target_id.."</b> foi limpo! ("..totalItems.." itens removidos)", 5000)
                        TriggerClientEvent("Notify", nplayer, "amarelo", "Seu inventário foi limpo por um administrador.", 5000)
                        
                        -- Preparar lista de itens para webhook
                        local itemsList = ""
                        if #itemsRemoved > 0 then
                            for i, item in ipairs(itemsRemoved) do
                                if i <= 10 then -- Limitar a 10 itens no webhook
                                    itemsList = itemsList .. item.item .. " x" .. item.amount .. "\n"
                                elseif i == 11 then
                                    itemsList = itemsList .. "... e mais " .. (#itemsRemoved - 10) .. " itens"
                                    break
                                end
                            end
                        else
                            itemsList = "Nenhum item encontrado"
                        end
                        
                        -- WEBHOOK USANDO SISTEMA CENTRALIZADO
                        SendWebhook("limparinv", {
                            embeds = {{
                                title = "🗑️ Inventário Limpo",
                                fields = {
                                    { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                                    { name = "🎯 Jogador:", value = nidentity.name.." "..nidentity.name2.." #"..target_id },
                                    { name = "📦 Total de Itens:", value = totalItems.." itens removidos" },
                                    { name = "📋 Itens Removidos:", value = itemsList }
                                },
                                color = 16711680,
                                footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                            }}
                        })
                    else
                        TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do jogador.", 5000)
                    end
                else
                    TriggerClientEvent("Notify", source, "vermelho", "Jogador ID <b>"..target_id.."</b> não está online.", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "amarelo", "ID deve ser maior que 0.", 5000)
            end
        else
            TriggerClientEvent("Notify", source, "amarelo", "Use: <b>/limparinv [ID]</b>", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando.", 5000)
    end
end)

------------------------------------------
-- [ COMANDO DE TROCAR COR DO CARRO - VERSÃO CORRIGIDA ]
------------------------------------------

RegisterCommand('carcolor',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local identity = vRP.userIdentity(user_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        -- Verificar se o jogador está em um veículo
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(source), false)
        if vehicle == 0 then
            TriggerClientEvent("Notify", source, "vermelho", "Você precisa estar em um veículo!", 5000)
            return
        end
        
        if args[1] and args[2] and args[3] then
            -- Usar argumentos diretos: /carcolor 255 0 0
            local r = tonumber(args[1])
            local g = tonumber(args[2])
            local b = tonumber(args[3])
            
            if r and g and b and r >= 0 and r <= 255 and g >= 0 and g <= 255 and b >= 0 and b <= 255 then
                -- Enviar para o cliente para mudar a cor
                TriggerClientEvent('admin:changeCarColor', source, r, g, b)
                TriggerClientEvent("Notify", source, "verde", "Cor do veículo alterada para RGB("..r..","..g..","..b..")!", 5000)
                
                local x,y,z = vCLIENT.getPosition(source)
                
                -- WEBHOOK USANDO SISTEMA CENTRALIZADO
                SendWebhook("carcolor", {
                    embeds = {{
                        title = "🎨 Cor do Veículo Alterada",
                        fields = {
                            { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                            { name = "🚗 Veículo:", value = "Veículo atual" },
                            { name = "🎨 Nova Cor:", value = "RGB("..r..","..g..","..b..")" },
                            { name = "📍 Coordenadas:", value = "X: "..math.floor(x).." | Y: "..math.floor(y).." | Z: "..math.floor(z) }
                        },
                        color = 2829875,
                        footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                    }}
                })
            else
                TriggerClientEvent("Notify", source, "vermelho", "Valores RGB devem ser entre 0 e 255!", 5000)
            end
        else
            -- Usar prompt para cores RGB
            local rgb = vRP.prompt(source, "RGB (formato: R G B):", "255 0 0")
            if rgb and rgb ~= "" then
                local colors = {}
                for color in string.gmatch(rgb, "%S+") do
                    table.insert(colors, tonumber(color))
                end
                
                if #colors == 3 then
                    local r, g, b = colors[1], colors[2], colors[3]
                    if r and g and b and r >= 0 and r <= 255 and g >= 0 and g <= 255 and b >= 0 and b <= 255 then
                        -- Enviar para o cliente para mudar a cor
                        TriggerClientEvent('admin:changeCarColor', source, r, g, b)
                        TriggerClientEvent("Notify", source, "verde", "Cor do veículo alterada para RGB("..r..","..g..","..b..")!", 5000)
                        
                        local x,y,z = vCLIENT.getPosition(source)
                        
                        -- WEBHOOK USANDO SISTEMA CENTRALIZADO
                        SendWebhook("carcolor", {
                            embeds = {{
                                title = "🎨 Cor do Veículo Alterada",
                                fields = {
                                    { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                                    { name = "🚗 Veículo:", value = "Veículo atual" },
                                    { name = "🎨 Nova Cor:", value = "RGB("..r..","..g..","..b..")" },
                                    { name = "📍 Coordenadas:", value = "X: "..math.floor(x).." | Y: "..math.floor(y).." | Z: "..math.floor(z) }
                                },
                                color = 2829875,
                                footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                            }}
                        })
                    else
                        TriggerClientEvent("Notify", source, "vermelho", "Valores RGB devem ser entre 0 e 255!", 5000)
                    end
                else
                    TriggerClientEvent("Notify", source, "vermelho", "Formato inválido! Use: R G B (ex: 255 0 0)", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "amarelo", "Use: <b>/carcolor [R] [G] [B]</b> ou sem argumentos para usar prompt", 5000)
            end
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando.", 5000)
    end
end)

------------------------------------------
-- [ COMANDO DE KICK ALL - VERSÃO CORRIGIDA ]
------------------------------------------

RegisterCommand("kickall",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local identity = vRP.userIdentity(user_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        -- Obter lista de jogadores online
        local playerList = vRP.userList()
        local totalPlayers = 0
        
        -- Contar jogadores
        for k,v in pairs(playerList) do
            totalPlayers = totalPlayers + 1
        end
        
        TriggerClientEvent("Notify", source, "amarelo", "Kickando "..totalPlayers.." jogadores...", 5000)
        
        -- Kickar todos os jogadores
        for k,v in pairs(playerList) do
            if k ~= user_id then -- Não kickar o próprio admin
                vRP.kick(k,"Desconectado, a cidade vai reiniciar.")
                Citizen.Wait(100)
            end
        end
        
        TriggerClientEvent("Notify", source, "verde", "Todos os jogadores foram kickados! ("..totalPlayers.." players)", 5000)
        
        -- Trigger evento personalizado se necessário
        TriggerEvent("admin:KickAll")
        
        -- WEBHOOK USANDO SISTEMA CENTRALIZADO
        SendWebhook("kickall", {
            embeds = {{
                title = "🚪 KICK ALL Executado",
                fields = {
                    { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                    { name = "👥 Jogadores Kickados:", value = totalPlayers.." players" },
                    { name = "⚠️ Motivo:", value = "Reinicialização da cidade" }
                },
                color = 16776960,
                footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
            }}
        })
        
    else
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando.", 5000)
    end
end)

------------------------------------------
-- [ COMANDO DE KICKALL CONSOLE ]
------------------------------------------
RegisterCommand("kickallc",function(source,args,rawCommand)
    if source == 0 then
        local playerList = vRP.userList()
        local totalPlayers = 0
        
        -- Contar jogadores
        for k,v in pairs(playerList) do
            totalPlayers = totalPlayers + 1
        end
        
        print("^3[ADMIN-CONSOLE]^7 Kickando "..totalPlayers.." jogadores...")
        
        -- Kickar todos os jogadores
        for k,v in pairs(playerList) do
            vRP.kick(k,"Desconectado, a cidade vai reiniciar.")
            Citizen.Wait(100)
        end
        
        print("^2[ADMIN-CONSOLE]^7 Todos os jogadores foram kickados! ("..totalPlayers.." players)")
        TriggerEvent("admin:KickAll")
    end
end)

------------------------------------------
-- [ COMANDO DE LIMPAR AREA - VERSÃO CORRIGIDA ]
------------------------------------------

RegisterCommand("limparea",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local identity = vRP.userIdentity(user_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        local ped = GetPlayerPed(source)
        local coords = GetEntityCoords(ped)
        
        -- Obter lista de jogadores online
        local playerList = vRP.userList()
        local playersAffected = 0
        
        -- Enviar comando de limpeza para todos os jogadores online
        for user_id_loop, source_loop in pairs(playerList) do
            if source_loop then
                TriggerClientEvent("syncarea", source_loop, coords["x"], coords["y"], coords["z"], 100)
                playersAffected = playersAffected + 1
            end
        end
        
        TriggerClientEvent("Notify", source, "verde", "Área limpa! Comando enviado para "..playersAffected.." jogadores.", 5000)
        
        local x,y,z = vCLIENT.getPosition(source)
        
        -- WEBHOOK USANDO SISTEMA CENTRALIZADO
        SendWebhook("limparea", {
            embeds = {{
                title = "🧹 Área Limpa",
                fields = {
                    { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                    { name = "📍 Coordenadas:", value = "X: "..math.floor(coords["x"]).." | Y: "..math.floor(coords["y"]).." | Z: "..math.floor(coords["z"]) },
                    { name = "👥 Jogadores Afetados:", value = playersAffected.." players" },
                    { name = "🌀 Raio:", value = "100 metros" }
                },
                color = 2829875,
                footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
            }}
        })
        
    else
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando.", 5000)
    end
end)



------------------------------------------
-- [ COMANDO DE ANUNCIO - VERSÃO CORRIGIDA ]
------------------------------------------

RegisterCommand("anuncio",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local identity = vRP.userIdentity(user_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        if args[1] then
            local tipoAnuncio = args[1]:upper()
            local tiposPermitidos = {
                ["POLICIA"] = { cor = "azul", perm = "Admin" },
                ["HOSPITAL"] = { cor = "verde", perm = "Admin" },
                ["MECANICA"] = { cor = "amarelo", perm = "Admin" },
                ["PREFEITURA"] = { cor = "roxo", perm = "Admin" },
                ["EVENTO"] = { cor = "laranja", perm = "Admin" },
                ["IMPORTANTE"] = { cor = "vermelho", perm = "Admin" },
                ["GERAL"] = { cor = "azul", perm = "Admin" }
            }
            
            if tiposPermitidos[tipoAnuncio] then
                if vRP.hasGroup(user_id, tiposPermitidos[tipoAnuncio].perm) then
                    local message = vRP.prompt(source, "Mensagem do anúncio:", "")
                    if message and message ~= "" then
                        -- Enviar anúncio para todos os jogadores
                        local playerList = vRP.userList()
                        local playersNotified = 0
                        
                        for user_id_loop, source_loop in pairs(playerList) do
                            if source_loop then
                                TriggerClientEvent("Notify", source_loop, tiposPermitidos[tipoAnuncio].cor, 
                                    "📢 <b>ANÚNCIO "..tipoAnuncio.."</b><br>"..message.."<br><b>"..identity.name.." "..identity.name2.."</b>", 10000)
                                playersNotified = playersNotified + 1
                            end
                        end
                        
                        TriggerClientEvent("Notify", source, "verde", "Anúncio enviado para "..playersNotified.." jogadores!", 5000)
                        
                        local x,y,z = vCLIENT.getPosition(source)
                        
                        -- WEBHOOK USANDO SISTEMA CENTRALIZADO
                        SendWebhook("anuncio", {
                            embeds = {{
                                title = "📢 Anúncio "..tipoAnuncio,
                                fields = {
                                    { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                                    { name = "📝 Tipo:", value = tipoAnuncio },
                                    { name = "💬 Mensagem:", value = message },
                                    { name = "👥 Jogadores Notificados:", value = playersNotified.." players" },
                                    { name = "📍 Coordenadas:", value = "X: "..math.floor(x).." | Y: "..math.floor(y).." | Z: "..math.floor(z) }
                                },
                                color = 2829875,
                                footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                            }}
                        })
                    else
                        TriggerClientEvent("Notify", source, "vermelho", "Mensagem não pode estar vazia!", 5000)
                    end
                else
                    TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para este tipo de anúncio!", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "amarelo", "Tipos disponíveis: <b>policia, hospital, mecanica, prefeitura, evento, importante, geral</b>", 8000)
            end
        else
            TriggerClientEvent("Notify", source, "amarelo", "Use: <b>/anuncio [TIPO]</b><br>Tipos: policia, hospital, mecanica, prefeitura, evento, importante, geral", 8000)
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando.", 5000)
    end
end)

------------------------------------------
-- [ COMANDO DE GEM - VERSÃO CORRIGIDA ]
------------------------------------------

RegisterCommand("gem",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local identity = vRP.userIdentity(user_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        if args[1] and args[2] then
            local target_id = parseInt(args[1])
            local amount = parseInt(args[2])
            
            if target_id > 0 and amount > 0 then
                local target_identity = vRP.userIdentity(target_id)
                
                if target_identity then
                    -- Tentar adicionar gemas (usando diferentes métodos possíveis)
                    if vRP.execute then
                        vRP.execute("accounts/infosUpdategems", { steam = target_identity["steam"], gems = amount })
                    elseif vRP.addGems then
                        vRP.addGems(target_id, amount)
                    elseif vRP.giveMoney then
                        -- Fallback: usar sistema de dinheiro se não houver sistema de gemas
                        vRP.giveMoney(target_id, amount)
                    end
                    
                    TriggerClientEvent("Notify", source, "verde", "ID <b>"..target_id.."</b> recebeu <b>"..amount.." Gemas</b>.", 5000)
                    
                    local target_source = vRP.userSource(target_id)
                    if target_source then
                        TriggerClientEvent("Notify", target_source, "azul", "Você recebeu <b>"..amount.." gemas</b> de um administrador.", 5000)
                    end
                    
                    -- WEBHOOK USANDO SISTEMA CENTRALIZADO
                    SendWebhook("gem", {
                        embeds = {{
                            title = "💎 Gemas Adicionadas",
                            fields = {
                                { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                                { name = "🎯 Jogador:", value = target_identity.name.." "..target_identity.name2.." #"..target_id },
                                { name = "💎 Quantidade:", value = amount.." gemas" }
                            },
                            color = 16776960,
                            footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                        }}
                    })
                else
                    TriggerClientEvent("Notify", source, "vermelho", "Jogador ID <b>"..target_id.."</b> não encontrado.", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "amarelo", "IDs e quantidades devem ser maiores que 0.", 5000)
            end
        else
            TriggerClientEvent("Notify", source, "amarelo", "Use: <b>/gem [ID] [QUANTIDADE]</b>", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando.", 5000)
    end
end)

------------------------------------------
-- [ COMANDO DE REMGEM - VERSÃO CORRIGIDA ]
------------------------------------------

RegisterCommand("remgem",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        local identity = vRP.userIdentity(user_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        if args[1] and args[2] then
            local target_id = parseInt(args[1])
            local amount = parseInt(args[2])
            
            if target_id > 0 and amount > 0 then
                local target_identity = vRP.userIdentity(target_id)
                
                if target_identity then
                    -- Tentar remover gemas (usando diferentes métodos possíveis)
                    if vRP.paymentGems then
                        vRP.paymentGems(target_id, amount)
                    elseif vRP.removeGems then
                        vRP.removeGems(target_id, amount)
                    elseif vRP.tryPayment then
                        -- Fallback: usar sistema de dinheiro se não houver sistema de gemas
                        vRP.tryPayment(target_id, amount)
                    end
                    
                    TriggerClientEvent("Notify", source, "verde", "ID <b>"..target_id.."</b> perdeu <b>"..amount.." Gemas</b>.", 5000)
                    
                    local target_source = vRP.userSource(target_id)
                    if target_source then
                        TriggerClientEvent("Notify", target_source, "amarelo", "Você perdeu <b>"..amount.." gemas</b> por ação administrativa.", 5000)
                    end
                    
                    -- WEBHOOK USANDO SISTEMA CENTRALIZADO
                    SendWebhook("remgem", {
                        embeds = {{
                            title = "💎 Gemas Removidas",
                            fields = {
                                { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                                { name = "🎯 Jogador:", value = target_identity.name.." "..target_identity.name2.." #"..target_id },
                                { name = "💎 Quantidade:", value = amount.." gemas removidas" }
                            },
                            color = 16711680,
                            footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                        }}
                    })
                else
                    TriggerClientEvent("Notify", source, "vermelho", "Jogador ID <b>"..target_id.."</b> não encontrado.", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "amarelo", "IDs e quantidades devem ser maiores que 0.", 5000)
            end
        else
            TriggerClientEvent("Notify", source, "amarelo", "Use: <b>/remgem [ID] [QUANTIDADE]</b>", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando.", 5000)
    end
end)


------------------------------------------
-- [ DAR DINHEIRO ]
------------------------------------------

RegisterCommand("money",function(source,args,rawCommand)
    if source == 0 then
        -- COMANDO DO CONSOLE
        if args[1] and args[2] then
            local target_id = parseInt(args[1])
            local amount = parseInt(args[2])
            
            if target_id > 0 and amount > 0 then
                local identity = vRP.userIdentity(target_id)
                if identity then
                    vRP.generateItem(target_id,"dollars",amount,true)
                    print('^7[^4'..GetCurrentResourceName()..'^7] Você deu dinheiro ^2 '..identity.name..' '..identity.name2..' #'..target_id..' '..amount..' $ ^7')
                else
                    print('^7[^4'..GetCurrentResourceName()..'^7] ^1Jogador ID '..target_id..' não encontrado^7')
                end
            else
                print('^7[^4'..GetCurrentResourceName()..'^7] ^1Use: money [ID] [QUANTIDADE]^7')
            end
        else
            print('^7[^4'..GetCurrentResourceName()..'^7] ^1Use: money [ID] [QUANTIDADE]^7')
        end
    else
        -- COMANDO NO JOGO
        local user_id = vRP.getUserId(source)
        if user_id and vRP.hasGroup(user_id,"Admin") then
            local identity = vRP.userIdentity(user_id)
            
            -- Verificação de segurança para identity
            if not identity or not identity.name or not identity.name2 then
                TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
                return
            end
            
            if args[1] and args[2] then
                -- DAR DINHEIRO PARA OUTRO JOGADOR
                local target_id = parseInt(args[1])
                local amount = parseInt(args[2])
                
                if target_id > 0 and amount > 0 then
                    local target_identity = vRP.userIdentity(target_id)
                    if target_identity then
                        vRP.generateItem(target_id,"dollars",amount,true)
                        
                        TriggerClientEvent("Notify", source, "verde", "ID <b>"..target_id.."</b> recebeu <b>$"..amount.."</b>.", 5000)
                        
                        local target_source = vRP.userSource(target_id)
                        if target_source then
                            TriggerClientEvent("Notify", target_source, "azul", "Você recebeu <b>$"..amount.."</b> de um administrador.", 5000)
                        end
                        
                        local x,y,z = vCLIENT.getPosition(source)
                        
                        -- WEBHOOK USANDO SISTEMA CENTRALIZADO
                        SendWebhook("money", {
                            embeds = {{
                                title = "💰 Dinheiro Dado",
                                fields = {
                                    { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                                    { name = "🎯 Recebeu:", value = target_identity.name.." "..target_identity.name2.." #"..target_id },
                                    { name = "💵 Quantidade:", value = "$"..amount },
                                    { name = "📍 Coordenadas:", value = "X: "..math.floor(x).." | Y: "..math.floor(y).." | Z: "..math.floor(z) }
                                },
                                color = 65280,
                                footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                            }}
                        })
                    else
                        TriggerClientEvent("Notify", source, "vermelho", "Jogador ID <b>"..target_id.."</b> não encontrado.", 5000)
                    end
                else
                    TriggerClientEvent("Notify", source, "amarelo", "IDs e quantidades devem ser maiores que 0.", 5000)
                end
            elseif args[1] then
                -- DAR DINHEIRO PARA SI MESMO
                local amount = parseInt(args[1])
                
                if amount > 0 then
                    vRP.generateItem(user_id,"dollars",amount,true)
                    
                    TriggerClientEvent("Notify", source, "verde", "Você recebeu <b>$"..amount.."</b>.", 5000)
                    
                    local x,y,z = vCLIENT.getPosition(source)
                    
                    -- WEBHOOK USANDO SISTEMA CENTRALIZADO
                    SendWebhook("money", {
                        embeds = {{
                            title = "💰 Dinheiro Spawnado",
                            fields = {
                                { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                                { name = "💵 Quantidade:", value = "$"..amount },
                                { name = "📍 Coordenadas:", value = "X: "..math.floor(x).." | Y: "..math.floor(y).." | Z: "..math.floor(z) }
                            },
                            color = 16776960,
                            footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                        }}
                    })
                else
                    TriggerClientEvent("Notify", source, "amarelo", "Quantidade deve ser maior que 0.", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "amarelo", "Use: <b>/money [QUANTIDADE]</b> ou <b>/money [ID] [QUANTIDADE]</b>", 5000)
            end
        else
            TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando.", 5000)
        end
    end
end)


------------------------------------------
-- [ PLAYER DROPPED ]
------------------------------------------
AddEventHandler('playerDropped', function(reason)
    local playerId = source
    local user_id = vRP.getUserId(playerId)
    if user_id then
        local identity = vRP.userIdentity(user_id)
        local nome = "Sem Nome"
        if identity then
            nome = identity.name.." "..identity.name2
        end
        print('\n^7[^1'..GetCurrentResourceName()..'^7] Usuario: ^1'..nome..' #'..user_id..'^7 src: ^3'..playerId..'.')
        print('^7[^1'..GetCurrentResourceName()..'^7] Saiu da ^1cidade^7.^7')
        print('^7[^5'..GetCurrentResourceName()..'^7] Motivo: ^5'..reason..'^7.^7')
    else
        print('\n^7[^1'..GetCurrentResourceName()..'^7] Src: ^3'..playerId..'.')
        print('^7[^5'..GetCurrentResourceName()..'^7] Motivo: ^5'..reason..'^7.^7')
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO AUXILIAR PARA OBTER STEAM ID
-----------------------------------------------------------------------------------------------------------------------------------------
function getSteam(source)
    local identifiers = GetPlayerIdentifiers(source)
    for k,v in pairs(identifiers) do
        if string.find(v,"steam:") then
            return v
        end
    end
    return nil
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO AUXILIAR PARA OBTER DISCORD ID  
-----------------------------------------------------------------------------------------------------------------------------------------
function getDiscord(source)
    local identifiers = GetPlayerIdentifiers(source)
    for k,v in pairs(identifiers) do
        if string.find(v,"discord:") then
            return v
        end
    end
    return nil
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO AUXILIAR PARA OBTER LICENSE
-----------------------------------------------------------------------------------------------------------------------------------------
function getLicense(source)
    local identifiers = GetPlayerIdentifiers(source)
    for k,v in pairs(identifiers) do
        if string.find(v,"license:") then
            return v
        end
    end
    return nil
end

AddEventHandler("Queue:playerConnecting",function(source,identifiers,deferrals)
    vRP.prepare("warn/selectCharacters", "SELECT * FROM characters WHERE steam = @steam")
    local steam = getSteam(source)
    if steam then
        local SQL = vRP.query("warn/selectCharacters", {steam = steam})
        if SQL[1] then
            local personagens = ""
            local quantidade = 0
            local identitysss = ""
            local quantidadeS2 = 0
            for k,v in pairs(GetPlayerIdentifiers(source)) do
                quantidadeS2 = quantidadeS2 + 1
                if quantidadeS2 == 1 then
                    identitysss = identitysss .. ""..v.." \n"
                else
                    identitysss = identitysss .. ""..v.." \n"
                end
            end
            for k,v in pairs(SQL) do
                if quantidade == 0 then
                    personagens = ''..v.name..' '..v.name2..' #'..v.id..''
                else
                    personagens = ''..personagens..'\n'..v.name..' '..v.name2..' #'..v.id..''
                end
                quantidade = quantidade + 1
            end
            print('\n^7[^3'..GetCurrentResourceName()..'^7] steam:^3'..steam..'^7.')
            for k,v in pairs(SQL) do
                print('^7[^3'..GetCurrentResourceName()..'^7] Personagem: ^3'..v.name..' '..v.name2..' #^3'..v.id..'^7.^7')
            end
            print('^7[^3'..GetCurrentResourceName()..'^7] Esta se ^3conectando^7 na cidade.^7\n')
        else
            local quantidade = 0

            local identitysss = ""
            local quantidadeS2 = 0
            for k,v in pairs(GetPlayerIdentifiers(source)) do
                quantidadeS2 = quantidadeS2 + 1
                if quantidadeS2 == 1 then
                    identitysss = identitysss .. ""..v.." \n"
                else
                    identitysss = identitysss .. ""..v.." \n"
                end
            end

            print('\n^7[^1'..GetCurrentResourceName()..'^7] steam:^1'..steam..'^7.')
            print('^7[^1'..GetCurrentResourceName()..'^7] Esta se ^1conectando^7 na cidade.^7\n')
        end
    end
end)

------------------------------------------
-- [ COMANDO RG2 - INFORMAÇÕES COMPLETAS DO JOGADOR ]
------------------------------------------

RegisterCommand('rg2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasGroup(user_id, "Admin") then
        local identity = vRP.userIdentity(user_id)
        
        -- Verificação de segurança para identity
        if not identity or not identity.name or not identity.name2 then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados do admin. Tente novamente.", 5000)
            return
        end
        
        if args[1] then
            local target_id = parseInt(args[1])
            
            if target_id > 0 then
                local target_identity = vRP.userIdentity(target_id)
                
                if target_identity then
                    local target_source = vRP.userSource(target_id)
                    
                    -- INFORMAÇÕES BÁSICAS
                    local playerInfo = {
                        name = target_identity.name or "N/A",
                        name2 = target_identity.name2 or "N/A",
                        age = target_identity.age or "N/A",
                        phone = target_identity.phone or "N/A",
                        registration = target_identity.registration or "N/A",
                        steam = target_identity.steam or "N/A",
                        discord = target_identity.discord or "N/A",
                        license = target_identity.license or "N/A"
                    }
                    
                    -- INFORMAÇÕES DE LOCALIZAÇÃO (se online)
                    local locationInfo = {
                        online = target_source ~= nil,
                        x = 0,
                        y = 0,
                        z = 0
                    }
                    
                    if target_source then
                        local coords = vCLIENT.getPosition(target_source)
                        if coords then
                            locationInfo.x = math.floor(coords[1] or 0)
                            locationInfo.y = math.floor(coords[2] or 0)
                            locationInfo.z = math.floor(coords[3] or 0)
                        end
                    end
                    
                    -- INFORMAÇÕES FINANCEIRAS
                    local financialInfo = {
                        wallet = vRP.getInventoryItemAmount(target_id, "dollars") or 0,
                        bank = vRP.getBankMoney(target_id) or 0
                    }
                    
                    -- INFORMAÇÕES DE GRUPOS/CARGOS
                    local groups = vRP.getUserGroups(target_id) or {}
                    local groupsList = ""
                    local groupCount = 0
                    
                    for group, _ in pairs(groups) do
                        if groupCount == 0 then
                            groupsList = group
                        else
                            groupsList = groupsList .. ", " .. group
                        end
                        groupCount = groupCount + 1
                    end
                    
                    if groupsList == "" then
                        groupsList = "Nenhum cargo"
                    end
                    
                    -- INFORMAÇÕES DE SAÚDE (se online)
                    local healthInfo = {
                        health = "N/A",
                        thirst = "N/A",
                        hunger = "N/A",
                        stress = "N/A"
                    }
                    
                    if target_source then
                        healthInfo.health = GetEntityHealth(GetPlayerPed(target_source)) or "N/A"
                        healthInfo.thirst = vRP.getThirst(target_id) or "N/A"
                        healthInfo.hunger = vRP.getHunger(target_id) or "N/A"
                        healthInfo.stress = vRP.getStress(target_id) or "N/A"
                    end
                    
                    -- INFORMAÇÕES DE INVENTÁRIO
                    local inventory = vRP.userInventory(target_id) or {}
                    local itemCount = 0
                    local totalWeight = 0
                    local maxWeight = vRP.getWeight(target_id) or 0
                    
                    for slot, item in pairs(inventory) do
                        if item and item.item then
                            itemCount = itemCount + (item.amount or 1)
                        end
                    end
                    
                    -- Calcular peso atual
                    for slot, item in pairs(inventory) do
                        if item and item.item then
                            local itemWeight = vRP.getItemWeight(item.item) or 0
                            totalWeight = totalWeight + (itemWeight * (item.amount or 1))
                        end
                    end
                    
                    -- MONTAR MENSAGEM PARA ADMIN
                    local message = "📋 <b>INFORMAÇÕES COMPLETAS - " .. playerInfo.name .. " " .. playerInfo.name2 .. " #" .. target_id .. "</b><br><br>"
                    
                    message = message .. "👤 <b>DADOS PESSOAIS:</b><br>"
                    message = message .. "• Nome: " .. playerInfo.name .. " " .. playerInfo.name2 .. "<br>"
                    message = message .. "• Idade: " .. playerInfo.age .. " anos<br>"
                    message = message .. "• Telefone: " .. playerInfo.phone .. "<br>"
                    message = message .. "• RG: " .. playerInfo.registration .. "<br><br>"
                    
                    message = message .. "🌐 <b>STATUS:</b><br>"
                    message = message .. "• Online: " .. (locationInfo.online and "✅ Sim" or "❌ Não") .. "<br>"
                    if locationInfo.online then
                        message = message .. "• Localização: X:" .. locationInfo.x .. " Y:" .. locationInfo.y .. " Z:" .. locationInfo.z .. "<br>"
                    end
                    message = message .. "<br>"
                    
                    message = message .. "💰 <b>FINANCEIRO:</b><br>"
                    message = message .. "• Carteira: $" .. financialInfo.wallet .. "<br>"
                    message = message .. "• Banco: $" .. financialInfo.bank .. "<br>"
                    message = message .. "• Total: $" .. (financialInfo.wallet + financialInfo.bank) .. "<br><br>"
                    
                    message = message .. "🏷️ <b>CARGOS:</b><br>"
                    message = message .. "• " .. groupsList .. "<br><br>"
                    
                    if locationInfo.online then
                        message = message .. "❤️ <b>SAÚDE:</b><br>"
                        message = message .. "• Vida: " .. healthInfo.health .. "<br>"
                        message = message .. "• Sede: " .. healthInfo.thirst .. "%<br>"
                        message = message .. "• Fome: " .. healthInfo.hunger .. "%<br>"
                        message = message .. "• Stress: " .. healthInfo.stress .. "%<br><br>"
                    end
                    
                    message = message .. "🎒 <b>INVENTÁRIO:</b><br>"
                    message = message .. "• Itens: " .. itemCount .. " unidades<br>"
                    message = message .. "• Peso: " .. math.floor(totalWeight) .. "/" .. maxWeight .. "kg<br>"
                    
                    -- EXIBIR PARA O ADMIN
                    TriggerClientEvent("Notify", source, "azul", message, 15000)
                    
                    local x, y, z = vCLIENT.getPosition(source)
                    
                    -- WEBHOOK USANDO SISTEMA CENTRALIZADO
                    SendWebhook("rg2", {
                        embeds = {{
                            title = "📋 Consulta RG2 - Informações Completas",
                            fields = {
                                { name = "👤 Admin:", value = identity.name .. " " .. identity.name2 .. " #" .. user_id },
                                { name = "🎯 Consultado:", value = playerInfo.name .. " " .. playerInfo.name2 .. " #" .. target_id },
                                { name = "📱 Telefone:", value = playerInfo.phone },
                                { name = "📄 RG:", value = playerInfo.registration },
                                { name = "🌐 Status:", value = locationInfo.online and "✅ Online" or "❌ Offline" },
                                { name = "💰 Dinheiro:", value = "$" .. financialInfo.wallet .. " (carteira) + $" .. financialInfo.bank .. " (banco)" },
                                { name = "🏷️ Cargos:", value = groupsList },
                                { name = "🎒 Inventário:", value = itemCount .. " itens (" .. math.floor(totalWeight) .. "/" .. maxWeight .. "kg)" },
                                { name = "📍 Admin Local:", value = "X: " .. math.floor(x) .. " | Y: " .. math.floor(y) .. " | Z: " .. math.floor(z) }
                            },
                            color = 3447003,
                            footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                        }}
                    })
                    
                else
                    TriggerClientEvent("Notify", source, "vermelho", "Jogador ID <b>" .. target_id .. "</b> não encontrado.", 5000)
                end
            else
                TriggerClientEvent("Notify", source, "amarelo", "ID deve ser maior que 0.", 5000)
            end
        else
            TriggerClientEvent("Notify", source, "amarelo", "Use: <b>/rg2 [ID]</b>", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando.", 5000)
    end
end)


