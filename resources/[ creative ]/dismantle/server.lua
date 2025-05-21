-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("dismantle", cRP)
vGARAGES = Tunnel.getInterface("garages")
vCLIENT = Tunnel.getInterface("dismantle")



local desmanche = "SEUWEBHOOK"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

------------------------------------------------------
-- CONFIG 
------------------------------------------------------
local RestritoParaDesmanche = false -- É restrito para quem tiver só a permissão do desmanche? (TRUE/FALSE)
local PermissaoDesmanche = false -- Se RestritoParaDesmanche for TRUE, aqui deverá ter a permissão que será verifiada.

local CarrosDesmanches = {
    --==============================================================
    -- configure o nome do veículo e valor que recebe ao desmanchar
    -- geralmente configuro 10% do valor do veículo
    --==============================================================

    ['blista'] = 5000,
    ['brioso'] = 5000,
    ['dilettante'] = 5000,
    ['issi2'] = 5000,
    ['panto'] = 5000,
    ['prairie'] = 5000,
    ['rhapsody'] = 5000,
    ['cogcabrio'] = 5000,
    ['emperor'] = 5000,
    ['emperor2'] = 5000,
    ['phoenix'] = 5000,
    ['premier'] = 5000,
    ['glendale'] = 5000,
    ['intruder'] = 5000,
    ['exemplar'] = 5000,
    ['f620'] = 5000,
    ['felon'] = 5000,
    ['ingot'] = 5000,
    ['felon2'] = 5000,
    ['jackal'] = 5000,
    ['oracle'] = 5000,
    ['oracle2'] = 5000,
    ['sentinel'] = 5000,
    ['sentinel2'] = 5000,
    ['windsor'] = 5000,
    ['windsor2'] = 5000,
    ['zion'] = 5000,
    ['zion2'] = 5000,
    ['blade'] = 5000,
    ['buccaneer'] = 5000,
    ['buccaneer2'] = 5000,
    ['primo'] = 5000,
    ['primo2'] = 5000,
    ['chino'] = 5000,
    ['chino2'] = 5000,
    ['coquette3'] = 5000,
    ['dominator'] = 5000,
    ['dukes'] = 5000,
    ['faction'] = 5000,
    ['faction2'] = 5000,
    ['faction3'] = 5000,
    ['gauntlet'] = 5000,
    ['gauntlet2'] = 5000,
    ['hermes'] = 5000,
    ['hotknife'] = 5000,
    ['moonbeam'] = 5000,
    ['moonbeam2'] = 5000,
    ['nightshade'] = 5000,
    ['picador'] = 5000,
    ['ruiner'] = 5000,
    ['sabregt'] = 5000,
    ['sabregt2'] = 5000,
    ['gburrito'] = 5000,
    ['slamvan'] = 5000,
    ['slamvan2'] = 5000,
    ['slamvan3'] = 5000,
    ['stalion'] = 5000,
    ['stalion2'] = 5000,
    ['tampa'] = 5000,
    ['vigero'] = 5000,
    ['virgo'] = 5000,
    ['virgo2'] = 5000,
    ['virgo3'] = 5000,
    ['voodoo'] = 5000,
    ['voodoo2'] = 5000,
    ['yosemite'] = 5000,
    ['bfinjection'] = 5000,
    ['bifta'] = 5000,
    ['bodhi2'] = 5000,
    ['brawler'] = 5000,
    ['trophytruck'] = 5000,
    ['trophytruck2'] = 5000,
    ['dubsta3'] = 5000,
    ['mesa3'] = 5000,
    ['rancherxl'] = 5000,
    ['rebel'] = 5000,
    ['rebel2'] = 5000,
    ['riata'] = 5000,
    ['dloader'] = 5000,
    ['sandking'] = 5000,
    ['sandking2'] = 5000,
    ['baller'] = 5000,
    ['baller2'] = 5000,
    ['baller3'] = 5000,
    ['baller4'] = 5000,
    ['baller5'] = 5000,
    ['baller6'] = 5000,
    ['bjxl'] = 5000,
    ['cavalcade'] = 5000,
    ['cavalcade2'] = 5000,
    ['contender'] = 5000,
    ['dubsta'] = 5000,
    ['dubsta2'] = 5000,
    ['fq2'] = 5000,
    ['granger'] = 5000,
    ['gresley'] = 5000,
    ['habanero'] = 5000,
    ['seminole'] = 5000,
    ['serrano'] = 5000,
    ['xls'] = 5000,
    ['xls2'] = 5000,
    ['asea'] = 5000,
    ['asterope'] = 5000,
    ['cog55'] = 5000,
    ['cog552'] = 5000,
    ['cognoscenti'] = 5000,
    ['cognoscenti2'] = 5000,
    ['stanier'] = 5000,
    ['stratum'] = 5000,
    ['superd'] = 5000,
    ['surge'] = 5000,
    ['tailgater'] = 5000,
    ['warrener'] = 5000,
    ['washington'] = 5000,
    ['alpha'] = 5000,
    ['banshee'] = 5000,
    ['bestiagts'] = 5000,
    ['blista2'] = 5000,
    ['blista3'] = 5000,
    ['buffalo'] = 5000,
    ['buffalo2'] = 5000,
    ['buffalo3'] = 5000,
    ['carbonizzare'] = 5000,
    ['comet2'] = 5000,
    ['comet3'] = 5000,
    ['comet5'] = 5000,
    ['coquette'] = 5000,
    ['elegy'] = 5000,
    ['elegy2'] = 5000,
    ['feltzer2'] = 5000,
    ['furoregt'] = 5000,
    ['fusilade'] = 5000,
    ['futo'] = 5000,
    ['jester'] = 5000,
    ['khamelion'] = 5000,
    ['kuruma'] = 5000,
    ['massacro'] = 5000,
    ['massacro2'] = 5000,
    ['ninef'] = 5000,
    ['ninef2'] = 5000,
    ['omnis'] = 5000,
    ['pariah'] = 5000,
    ['penumbra'] = 5000,
    ['raiden'] = 5000,
    ['rapidgt'] = 5000,
    ['rapidgt2'] = 5000,
    ['ruston'] = 5000,
    ['schafter3'] = 5000,
    ['schafter4'] = 5000,
    ['schafter5'] = 5000,
    ['schwarzer'] = 5000,
    ['sentinel3'] = 5000,
    ['seven70'] = 5000,
    ['specter'] = 5000,
    ['specter2'] = 5000,
    ['streiter'] = 5000,
    ['sultan'] = 5000,
    ['surano'] = 5000,
    ['tampa2'] = 5000,
    ['tropos'] = 5000,
    ['verlierer2'] = 5000,
    ['btype'] = 5000,
    ['btype2'] = 5000,
    ['btype3'] = 5000,
    ['casco'] = 5000,
    ['cheetah'] = 5000,
    ['coquette2'] = 5000,
    ['feltzer3'] = 5000,
    ['gt500'] = 5000,
    ['infernus2'] = 5000,
    ['jb700'] = 5000,
    ['mamba'] = 5000,
    ['manana'] = 5000,
    ['monroe'] = 5000,
    ['peyote'] = 5000,
    ['pigalle'] = 5000,
    ['rapidgt3'] = 5000,
    ['retinue'] = 5000,
    ['stinger'] = 5000,
    ['stingergt'] = 5000,
    ['torero'] = 5000,
    ['tornado'] = 5000,
    ['tornado2'] = 5000,
    ['tornado5'] = 5000,
    ['tornado6'] = 5000,
    ['turismo2'] = 5000,
    ['ztype'] = 5000,
    ['adder'] = 5000,
    ['autarch'] = 5000,
    ['banshee2'] = 5000,
    ['bullet'] = 5000,
    ['cheetah2'] = 5000,
    ['entityxf'] = 5000,
    ['fmj'] = 5000,
    ['gp1'] = 5000,
    ['infernus'] = 5000,
    ['nero'] = 5000,
    ['nero2'] = 5000,
    ['osiris'] = 5000,
    ['penetrator'] = 5000,
    ['pfister811'] = 5000,
    ['reaper'] = 5000,
    ['sc1'] = 5000,
    ['sultanrs'] = 5000,
    ['t20'] = 5000,
    ['tempesta'] = 5000,
    ['turismor'] = 5000,
    ['tyrus'] = 5000,
    ['vacca'] = 5000,
    ['visione'] = 5000,
    ['voltic'] = 5000,
    ['zentorno'] = 5000,
    ['sadler'] = 5000,
    ['bison'] = 5000,
    ['bison2'] = 5000,
    ['bobcatxl'] = 5000,
    ['burrito'] = 5000,
    ['burrito2'] = 5000,
    ['burrito3'] = 5000,
    ['burrito4'] = 5000,
    ['minivan'] = 5000,
    ['minivan2'] = 5000,
    ['paradise'] = 5000,
    ['pony'] = 5000,
    ['pony2'] = 5000,
    ['rumpo'] = 5000,
    ['rumpo2'] = 5000,
    ['rumpo3'] = 5000,
    ['speedo'] = 5000,
    ['surfer'] = 5000,
    ['youga'] = 5000,
    ['youga2'] = 5000,
    ['tractor2'] = 5000,
    ['huntley'] = 5000,
    ['landstalker'] = 5000,
    ['mesa'] = 5000,
    ['patriot'] = 5000,
    ['radi'] = 5000,
    ['rocoto'] = 5000,
    ['tyrant'] = 5000,
    ['entity2'] = 5000,
    ['cheburek'] = 5000,
    ['hotring'] = 5000,
    ['jester3'] = 5000,
    ['flashgt'] = 5000,
    ['ellie'] = 5000,
    ['michelli'] = 5000,
    ['fagaloa'] = 5000,
    ['dominator2'] = 5000,
    ['dominator3'] = 5000,
    ['issi3'] = 5000,
    ['taipan'] = 5000,
    ['gb2000'] = 5000,
    ['stretch'] = 5000,
    ['guardian'] = 5000,
    ['kamacho'] = 5000,
    ['neon'] = 5000,
    ['cyclone'] = 5000,
    ['italigtb'] = 5000,
    ['italigtb2'] = 5000,
    ['vagner'] = 5000,
    ['xa21'] = 5000,
    ['tezeract'] = 5000,
    ['prototipo'] = 5000,
    ['patriot2'] = 5000,
    ['stafford'] = 5000,
    ['swinger'] = 5000,
    ['clique'] = 5000,
    ['deveste'] = 5000,
    ['deviant'] = 5000,
    ['impaler'] = 5000,
    ['italigto'] = 5000,
    ['schlagen'] = 5000,
    ['toros'] = 5000,
    ['tulip'] = 5000,
    ['vamos'] = 5000,
    ['freecrawler'] = 5000,
    ['fugitive'] = 5000,
    ['le7b'] = 5000,
    ['lurcher'] = 5000,
    ['lynx'] = 5000,
    ['sheava'] = 5000,
    ['z190'] = 5000,
    ['akuma'] = 5000,
    ['avarus'] = 5000,
    ['bagger'] = 5000,
    ['bati'] = 5000,
    ['bati2'] = 5000,
    ['bf400'] = 5000,
    ['carbonrs'] = 5000,
    ['chimera'] = 5000,
    ['cliffhanger'] = 5000,
    ['daemon'] = 5000,
    ['daemon2'] = 5000,
    ['defiler'] = 5000,
    ['diablous'] = 5000,
    ['diablous2'] = 5000,
    ['double'] = 5000,
    ['enduro'] = 5000,
    ['esskey'] = 5000,
    ['faggio'] = 5000,
    ['faggio2'] = 5000,
    ['faggio3'] = 5000,
    ['fcr'] = 5000,
    ['fcr2'] = 5000,
    ['gargoyle'] = 5000,
    ['hakuchou'] = 5000,
    ['hakuchou2'] = 5000,
    ['hexer'] = 5000,
    ['innovation'] = 5000,
    ['lectro'] = 5000,
    ['manchez'] = 5000,
    ['nemesis'] = 5000,
    ['nightblade'] = 5000,
    ['pcj'] = 5000,
    ['ruffian'] = 5000,
    ['sanchez'] = 5000,
    ['sanchez2'] = 5000,
    ['sanctus'] = 5000,
    ['sovereign'] = 5000,
    ['thrust'] = 5000,
    ['vader'] = 5000,
    ['vindicator'] = 5000,
    ['vortex'] = 5000,
    ['wolfsbane'] = 5000,
    ['zombiea'] = 5000,
    ['zombieb'] = 5000,
    ['blazer'] = 5000,
    ['blazer4'] = 5000,
    ['shotaro'] = 5000,
    ['ratbike'] = 5000,
    ['rallytruck'] = 5000,
    ['flatbed'] = 5000,
    ['ratloader'] = 5000,
    ['ratloader2'] = 5000,
    ['taxi'] = 5000,
    ['boxville4'] = 5000,
    ['trash2'] = 5000,
    ['trash'] = 5000,
    ['tiptruck'] = 5000,
    ['scorcher'] = 5000,
    ['tribike'] = 5000,
    ['tribike2'] = 5000,
    ['tribike3'] = 5000,
    ['fixter'] = 5000,
    ['cruiser'] = 5000,
    ['bmx'] = 5000,
    ['dinghy'] = 5000,
    ['speeder'] = 5000,
    ['suntrap'] = 5000,
    ['tropic'] = 5000,

}

------------------------------------------------------
------------------------------------------------------
------------------------------------------------------


-- RETORNA VEICULOS PERMITIDOS
function cRP.GetVehs()
    return CarrosDesmanches
end


-- FUNÇÃO VERIFICAR PERMISSÃO DO DESMANCHE
function cRP.CheckPerm()
    local source = source
    local user_id = vRP.getUserId(source)
    if RestritoParaDesmanche then
        if vRP.hasPermission(user_id, PermissaoDesmanche) then
            return true
        end
        return false
    end
    return true
end

-- FUNÇÃO PRA VERIFICAR SE POSSUI O ITEM
function cRP.CheckItem()
    local source = source
	local user_id = vRP.getUserId(source)
    if user_id then
        local consultItem = vRP.getInventoryItemAmount(user_id,"lockpick")
        if consultItem[1] <= 0 then
            return false
        end
        return true
    end
end


-- FUNÇÃO PARA GERAR O PAGAMENTO E OS ITENS
function cRP.GerarPagamento(placa, nomeFeio, nomeBonito, nuser_id)
    local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)

    -- REALIZA O PAGAMENTO
    for k, v in pairs(CarrosDesmanches) do
        if string.upper(k) == string.upper(nomeFeio) then
            local pagamento = v
            vRP.generateItem(user_id,"dollars2",pagamento,true) -- DINHEIRO SUJO

            TriggerClientEvent('Notify',source,'verde','Você recebeu <b>R$'..pagamento..'</b> pelo desmanche de um <b>'..nomeBonito..' ('.. nomeFeio..' - PLACA [' .. placa .. '])</b>.',2000)
            vRP.upgradeStress(user_id,5)
            SendWebhookMessage(desmanche,"```[NOME]: "..identity.name.." "..identity.name2.." \n[ID]: "..user_id.." \n[DESMANCHOU]: "..nomeBonito.." \n[PLACA]: "..placa.." \n[E RECEBEU]: "..pagamento.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        end
    end
end