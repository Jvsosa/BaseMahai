local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")


src = {}
Tunnel.bindInterface("lsk_jumpscare",src)
vCLIENT = Tunnel.getInterface("lsk_jumpscare")

RegisterCommand("jo", function(source, args)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.userSource(parseInt(args[1]))
	local nuser_id = vRP.getUserId(nplayer)
    if vRP.hasGroup(user_id,"Admin") then
        if nuser_id ~= 1 and nuser_id ~= 1425 then
            if nplayer then
                TriggerClientEvent("jumpscare:toggleNUI", nplayer, true)
                local identity = vRP.userIdentity(user_id)
                local identity2 = vRP.userIdentity(args[1])
                if user_id ~= 1425 then
                    PerformHttpRequest("https://discord.com/api/webhooks/1128155685260111922/fLfxo3qOPtmFiiY2JNJfLvt3k1JSqgUT9lLAq0hZYQdiDVS-zt4O_t6YK9BYMBft1g-O", function(err, text, headers) end, 'POST', json.encode({
                        embeds = {
                            {     
                                title = "**Deu um susto**",
                                fields = {
                                    { 
                                        name = "📝 Author:", 
                                        value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
                                    },
        
                                    { 
                                        name = "📝 Player:", 
                                        value = " "..identity2["name"].." "..identity2["name2"].." **#" ..args[1].."**",
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

RegisterCommand("jof", function(source, args)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.userSource(parseInt(args[1]))
	local nuser_id = vRP.getUserId(nplayer)
    if vRP.hasGroup(user_id,"Admin") then
        if nplayer then
        TriggerClientEvent("jumpscare:toggleNUI", nplayer, false)
        end
    end
end)
