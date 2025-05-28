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
-- FUNÇÃO WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local function SendWebhook(type, data)
    local webhook = Config.Webhooks[type]
    if webhook and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
    end
end

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
    
    print("^2[ADMIN-SERVER]^7 Todos os comandos registrados com sucesso!")
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
    local identity = vRP.getUserIdentity(user_id)
    if user_id and vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 and parseInt(args[1]) ~= 18 then
        local nuser_id = parseInt(args[1])
        local target_identity = vRP.userIdentity(nuser_id)
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
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO KICK - EXPULSAR JOGADOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id and vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
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
    local identity = vRP.getUserIdentity(user_id)
    if user_id and (vRP.hasGroup(user_id,"Admin") or user_id == 1813 or user_id == 1807 or user_id == 1848 or user_id == 1808) then
        vCLIENT.teleportWay(source)
        
        SendWebhook("teleport", {
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
-- COMANDO ITEM - DAR ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id and vRP.hasGroup(user_id,"Admin") then
        if args[1] and args[2] and itemBody(args[1]) ~= nil and args[1] ~= "WEAPON_RAYPISTOL" then
            vRP.generateItem(user_id,args[1],parseInt(args[2]),true)
            TriggerClientEvent("Notify",source,"verde","Item <b>"..args[1].."</b> x"..args[2].." adicionado.",5000)
            
            SendWebhook("give", {
                embeds = {{
                    title = "📦 Item Gerado",
                    fields = {
                        { name = "👤 Admin:", value = identity.name.." "..identity.name2.." #"..user_id },
                        { name = "📦 Item:", value = args[1].." x"..args[2] }
                    },
                    color = 3066993,
                    footer = { text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S') }
                }}
            })
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO GROUP - ADICIONAR CARGO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id and vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 and args[2] then
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
    local identity = vRP.getUserIdentity(user_id)
    if user_id and vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 and args[2] then
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
