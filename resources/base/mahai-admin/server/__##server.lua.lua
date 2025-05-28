-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP TUNNELS - AGUARDAR CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
local vRP = nil
local Tunnel = nil
local Proxy = nil
local cRP = nil
local vRPC = nil
local vCLIENT = nil

Citizen.CreateThread(function()
    -- Aguardar 5 segundos para VRP carregar
    Citizen.Wait(5000)
    
    print("^3[ADMIN-SERVER]^7 Tentando carregar VRP...")
    
    -- Tentar carregar VRP
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
    
    -- Aguardar VRP estar funcional
    while not vRP.getUserId do
        Citizen.Wait(100)
        print("^3[ADMIN-SERVER]^7 VRP carregado mas funções ainda não disponíveis...")
    end
    
    
    -----------------------------------------------------------------------------------------------------------------------------------------
    -- CONNECTION
    -----------------------------------------------------------------------------------------------------------------------------------------
    cRP = {}
    Tunnel.bindInterface("admin",cRP)
    vRPC = Tunnel.getInterface("admin")
    vCLIENT = Tunnel.getInterface("admin")
    

    
    -- AGUARDAR MAIS UM POUCO PARA GARANTIR
    Citizen.Wait(2000)
    
    -----------------------------------------------------------------------------------------------------------------------------------------
    -- PREPARAR QUERIES DO BANCO DE DADOS
    -----------------------------------------------------------------------------------------------------------------------------------------
    vRP._prepare("admin/getEmpresas","SELECT * FROM groups_perfil WHERE empresa = @empresa")
    vRP._prepare("admin/addponto", "UPDATE groups_empresas SET pontos = pontos + @pontos WHERE empresa = @empresa")
    vRP._prepare("admin/verEmpresas", "SELECT * FROM groups_empresas")
    
    
    -----------------------------------------------------------------------------------------------------------------------------------------
    -- REGISTRAR TODOS OS COMANDOS AQUI DENTRO
    -----------------------------------------------------------------------------------------------------------------------------------------
    
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

    RegisterCommand("nc",function(source,args,rawCommand)
        local user_id = vRP.getUserId(source)
        if user_id then
            if vRP.hasGroup(user_id,"Admin") or vRP.hasGroup(user_id,"StreamerVip") then
                if vCLIENT then
                    vCLIENT.noClip(source)
                    local x,y,z = vCLIENT.getPosition(source)
                    local identity = vRP.userIdentity(user_id)
                else
                    TriggerClientEvent("Notify", source, "vermelho", "Sistema admin ainda carregando, tente novamente.", 5000)
                    print("^1[ADMIN]^7 vCLIENT não está pronto para o user_id:", user_id)
                end
            end
        end
    end)

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
                        TriggerClientEvent("Notify",source,"verde","Jogador revivido com sucesso.",5000)
                    end
                else
                    vRPC.revivePlayer(source,200)
                    vRP.upgradeThirst(user_id,50)
                    vRP.upgradeHunger(user_id,50)
                    vRP.downgradeStress(user_id,50)
                    TriggerClientEvent("resetHandcuff",source)
                    TriggerClientEvent("resetBleeding",source)
                    TriggerClientEvent("resetDiagnostic",source)
                    TriggerClientEvent("Notify",source,"verde","Você foi revivido.",5000)
                end
            end
        end
    end)

    RegisterCommand("ban",function(source,args,rawCommand)
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        if user_id then
            if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 and parseInt(args[1]) ~= 18 then
                local nuser_id = parseInt(args[1])
                local identity = vRP.userIdentity(nuser_id)
                if identity then
                    vRP.kick(nuser_id,"Você esta temporariamente banido da cidade.")
                    vRP.execute("banneds/insertBanned",{ steam = identity["steam"] })
                    TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..nuser_id.."</b> banido",5000)
                end
            end
        end
    end)

    RegisterCommand("kick",function(source,args,rawCommand)
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        if user_id then
            if vRP.hasGroup(user_id,"Admin") and parseInt(args[1]) > 0 then
                TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..args[1].."</b> expulso.",5000)
                vRP.kick(args[1],"Você foi expulso da cidade.")
            end
        end
    end)

    RegisterCommand("tpway",function(source,args,rawCommand)
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        if user_id then
            if vRP.hasGroup(user_id,"Admin") or user_id == 1813 or user_id == 1807 or user_id == 1848 or user_id == 1808 then
                vCLIENT.teleportWay(source)
            end
        end
    end)

    RegisterCommand("item",function(source,args,rawCommand)
        local user_id = vRP.getUserId(source)
        local identity = vRP.userIdentity(user_id)
        if user_id then
            if vRP.hasGroup(user_id,"Admin") then
                if args[1] and args[2] and itemBody(args[1]) ~= nil and args[1] ~= "WEAPON_RAYPISTOL" then
                    vRP.generateItem(user_id,args[1],parseInt(args[2]),true)
                    TriggerClientEvent("Notify",source,"verde","Item <b>"..args[1].."</b> x"..args[2].." adicionado.",5000)
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
            end
        end
    end)

    RegisterCommand("ungroup",function(source,args,rawCommand)
        local user_id = vRP.getUserId(source)
        local identity = vRP.userIdentity(user_id)
        if user_id then
            if vRP.hasGroup(user_id,"Admin")  and parseInt(args[1]) > 0 and args[2] then
                TriggerClientEvent("Notify",source,"verde","Removido <b>"..args[2].."</b> ao passaporte <b>"..args[1].."</b>.",5000)
                vRP.remPermission(args[1],args[2])
            end
        end
    end)

    -- ADICIONE TODOS OS OUTROS COMANDOS AQUI...
    -- Copie e cole cada RegisterCommand que estava fora da thread
    
    print("^2[ADMIN-SERVER]^7 VRP carregado com sucesso!")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOKS E VARIÁVEIS (podem ficar fora)
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

-- ✅ VARIÁVEIS PODEM FICAR FORA
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

-- THREADS E OUTROS SISTEMAS QUE NÃO DEPENDEM DE vRP PODEM FICAR FORA...