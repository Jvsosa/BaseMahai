--------------------------------
-- [ CONEXAO ] --
--------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("wnStaff",src)
vSERVER = Tunnel.getInterface("wnStaff")
Config = module(GetCurrentResourceName(), "cfg/config")
local staffOpen = false

Config = {}




RegisterCommand("painel",function()
    if not staffOpen then
		if vSERVER.Check_Permissao() then
			NetworkSetInSpectatorMode(false)
			local nome,sobrenome,imagem = vSERVER.ReturnNames()
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showMenu",
			nome = nome,
			sobrenome = sobrenome,
			imagem = imagem,
			}) 
			StartScreenEffect("MenuMGSelectionIn", 0, true)
		end
    end
end)

function src.getPosition()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
	return x,y,z
end

RegisterNUICallback("staffClose",function(data)
	SetNuiFocus(false,false)
	StopScreenEffect("MenuMGSelectionIn")
	staffOpen = false
end)

-----------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------
RegisterNUICallback("CoordsLista",function(data,cb,imgperfil)
	vSERVER.consultTeleportes()
	local teleporteslista = vSERVER.consultList()
	if teleporteslista then
		cb({ teleporteslista = teleporteslista })
	end
end)

RegisterNUICallback("teleport",function(data,cb)
	local ped = PlayerPedId()
	SetEntityCoords(ped,tonumber(data.x),tonumber(data.y),tonumber(data.z))
end)

RegisterNUICallback("addteleport",function(data,cb)
	if vSERVER.addTeleport(data.nome,data.coord) then
		cb({retorno = 'done'})
	end
end)

RegisterNUICallback("deleteteleport",function(data,cb)
	if vSERVER.delTeleport(data.id,data.nome) then
		cb({ })
	end
end)

-----------------------------------------------------------
-- Logs
-----------------------------------------------------------
RegisterNUICallback("LogsLista",function(data,cb)
	vSERVER.consultLogs()
	local logslista = vSERVER.consultLogsList()
	if logslista then
		cb({ logslista = logslista })
	end
end)

-----------------------------------------------------------
-- Controle de Usuarios
-----------------------------------------------------------
RegisterNUICallback("ControleLista",function(data,cb)
	vSERVER.consultControle()
	local controlelista = vSERVER.consultControleList()
	if controlelista then
		cb({ controlelista = controlelista })
	end
end)

-----------------------------------------------------------
-- Punicoes
-----------------------------------------------------------
RegisterNUICallback("PunicoesLista",function(data,cb)
	vSERVER.consultPunicoes()
	local punicoes = vSERVER.consultPunicoesList()
	if punicoes then
		cb({ punicoes = punicoes })
	end
end)


RegisterNUICallback("ItensLista",function(data,cb)
	vSERVER.consultItens()
	local itens = vSERVER.consultItenstsList()
	if itens then
		cb({ itens = itens })
	end
end)

RegisterNUICallback("garagemLista",function(data,cb)
	vSERVER.consultGaragemTotal()
	local garagem = vSERVER.consultGaragemListTotal()
	if garagem then
		cb({ garagem = garagem })
	end
end)

RegisterNUICallback("AnunciarLista",function(data,cb)
	vSERVER.consultAnuncios()
	local anuncios = vSERVER.consultAnunciosList()
	if anuncios then
		cb({ anuncios = anuncios })
	end
end)

RegisterNUICallback("AnunciosLogs",function(data,cb)
	vSERVER.consultLogsAnuncios()
	local anunciosLogs = vSERVER.consultLogsAnunciosList()
	if anunciosLogs then
		cb({ anunciosLogs = anunciosLogs })
	end
end)

-----------------------------------------------------------
-- Aplicar Punicoes
-----------------------------------------------------------

local item_pegar = "nada"
local carro_pegar = "nada"
local anuncio_pegar = "nada"

RegisterNUICallback("enviarItem",function(data,cb)
	item_pegar = data.item
	cb({ })
end)

RegisterNUICallback("enviarCarro",function(data,cb)
	carro_pegar = data.carro
	cb({ })
end)

RegisterNUICallback("enviarAnuncioInfo",function(data,cb)
	anuncio_pegar = data.nomeanuncio
	cb({ })
end)

RegisterNUICallback("fazeranuncioall",function(data,cb)
	if vSERVER.fazeranuncioempregos(anuncio_pegar,data.textoAnuncio) then
		cb({retorno = 'done'})
	end
end)


RegisterNUICallback("pegarItemConfirm",function(data,cb)
	if vSERVER.pegarItem(item_pegar,data.quantidade) then
		cb({retorno = 'done'})
	end
end)

RegisterNUICallback("pegarCarroConfirmar",function(data,cb)
	if vSERVER.pegarCarro(carro_pegar,data.passaporte) then
		cb({retorno = 'done'})
	end
end)










--------------------------------
-- [ ENVIAR ID ] --
--------------------------------

local passaporte_inv = 0

RegisterNUICallback("EnviarID",function(data,cb)
	if data.passaporte then
		if parseInt(data.passaporte) ~= 1425 or parseInt(data.passaporte) ~= 3 then
			print(data.passaporte)
			passaporte_inv = data.passaporte

			if data.tipo == "SADVS" then
				cb({ tipo = data.tipo })
			end
	
			if data.tipo == "VERPERFIL" then
				local carteira,banco,nome,sobrenome,registro,celular,idade,emprego,vip,coins,img,banner = vSERVER.SetIdentidade(data.passaporte)
				cb({ tipo = data.tipo,carteira = carteira,banco = banco,nome = nome,sobrenome = sobrenome,registro = registro,celular = celular,idade = idade,emprego = emprego,vip = vip,coins = coins,img = img,banner = banner})
			end
		else
			TriggerEvent("Notify", "vermelho", "Voce nao tem permissao para verificar esse <b>usuario</b>.")
		end
	end
end)

--------------------------------
-- [ SISTEMA VER INEVNTARIO ] --
--------------------------------

RegisterNUICallback("PegarInv",function(data,cb)
	vSERVER.consultInventario(passaporte_inv)
	local inventario = vSERVER.consultInventarioList()
	if inventario then
		cb({ inventario = inventario })
	end
end)

RegisterNUICallback("removerItem",function(data,cb)
	if vSERVER.removerItem(passaporte_inv,data.item,data.quantidade) then
		cb({retorno = 'done'})
	end
end)

--------------------------------
-- [ SISTEMA VER GARAGEM ] --
--------------------------------

RegisterNUICallback("PegarGaragem",function(data,cb)
	vSERVER.consultGaragem(passaporte_inv)
	local garagem = vSERVER.consultGaragemList()
	if garagem then
		cb({ garagem = garagem })
	end
end)

RegisterNUICallback("removerCarro",function(data,cb)
	if vSERVER.removerCarro(passaporte_inv,data.item) then
		cb({retorno = 'done'})
	end
end)

local carro_ver = ""

RegisterNUICallback("verBauCarro",function(data,cb)
	carro_ver = data.carro
	cb({retorno = 'done'})
end)

RegisterNUICallback("verBauCarroList",function(data,cb)
	vSERVER.consultverBauCarro(passaporte_inv,carro_ver)
	local carroBau = vSERVER.consultverBauCarroList()
	if carroBau then
		cb({ carroBau = carroBau })
	end
end)

RegisterNUICallback("removerItemBauCarro",function(data,cb)
	if vSERVER.removerItemBauCarro(passaporte_inv,carro_ver,data.item,data.quantidade) then
		cb({retorno = 'done'})
	end
end)

--------------------------------
-- [ SISTEMA VER CASAS ] --
--------------------------------

RegisterNUICallback("PegarCasas",function(data,cb)
	vSERVER.consultCasas(passaporte_inv)
	local casas = vSERVER.consultCasasList()
	if casas then
		cb({ casas = casas })
	end
end)

RegisterNUICallback("removerCasa",function(data,cb)
	if vSERVER.removerCasa(passaporte_inv,data.casa) then
		cb({retorno = 'done'})
	end
end)

local casa_ver = ""

RegisterNUICallback("verBauCasa",function(data,cb)
	casa_ver = data.casa
	cb({retorno = 'done'})
end)

RegisterNUICallback("verBauCasaList",function(data,cb)
	vSERVER.consultverBauCasa(passaporte_inv,casa_ver)
	local casasBau = vSERVER.consultverBauCasaList()
	if casasBau then
		cb({ casasBau = casasBau })
	end
end)

RegisterNUICallback("removerItemBauCasa",function(data,cb)
	if vSERVER.removerItemBauCasa(passaporte_inv,casa_ver,data.item,data.quantidade) then
		cb({retorno = 'done'})
	end
end)

--------------------------------
-- [ SISTEMA VER EMPREGOS ] --
--------------------------------

RegisterNUICallback("PegarEmpregos",function(data,cb)
	vSERVER.consultEmpregos(passaporte_inv)
	local empregos = vSERVER.consultEmpregosList()
	if empregos then
		cb({ empregos = empregos })
	end
end)

RegisterNUICallback("addEmprego",function(data,cb)
	vSERVER.consultaddEmpregos(passaporte_inv)
	local listEmprego = vSERVER.consultaddEmpregosList()
	if listEmprego then
		cb({ listEmprego = listEmprego })
	end
end)

local discord_id = ""

RegisterNUICallback("setDiscordId",function(data,cb)
	if data.id ~= "" then
		discord_id = data.id
		cb({retorno = 'done'})
	else
		TriggerEvent("Notify", "negado", "Voce precisa inserir o <b>id do discord<b/>")
	end
end)

RegisterNUICallback("removerCargo",function(data,cb)
	if vSERVER.removerCargo(passaporte_inv,data.emprego,discord_id) then
		cb({retorno = 'done'})
	end
end)

RegisterNUICallback("confirmaremprego",function(data,cb)
	if vSERVER.confirmaremprego(passaporte_inv,data.emprego,data.tipo,discord_id,data.iddc) then
		cb({retorno = 'done'})
	end
end)

--------------------------------
-- [ SISTEMA VER OPCOES RAPIDAS ] --
--------------------------------

RegisterNUICallback("opcoesRapidas",function(data,cb)
	if vSERVER.opcoesRapidas(passaporte_inv,data.tipo) then
		cb({retorno = 'done'})
	end
end)

RegisterNetEvent("wnalgemas")
AddEventHandler("wnalgemas",function()
	SetPedComponentVariation(PlayerPedId(),7,0,0,2)
end)

--------------------------------
-- [ TROCAR NOME ] --
--------------------------------

RegisterNUICallback("trocarnome",function(data,cb)
	if vSERVER.trocarNome(passaporte_inv,data.PrimeiroNome,data.SegundoNome) then
		local nome2,sobrenome2,imagem = vSERVER.ReturnNames()
		local carteira,banco,nome,sobrenome,registro,celular,idade,emprego,vip,coins,img,banner = vSERVER.SetIdentidade(passaporte_inv)
		cb({retorno = 'done',nome = nome,sobrenome = sobrenome, nome2 = nome2,sobrenome2 = sobrenome2})
	end
end)

--------------------------------
-- [ TROCAR CARTEIRA ] --
--------------------------------

RegisterNUICallback("trocarcarteira",function(data,cb)
	if vSERVER.trocarCarteira(passaporte_inv,data.valor,data.tipo) then
		local nome,sobrenome,imagem = vSERVER.ReturnNames()
		local carteira,banco,nome,sobrenome,registro,celular,idade,emprego,vip,coins,img,banner = vSERVER.SetIdentidade(passaporte_inv)
		cb({retorno = 'done',carteira = carteira})
	end
end)

--------------------------------
-- [ TROCAR BANCO ] --
--------------------------------

RegisterNUICallback("trocarbanco",function(data,cb)
	if vSERVER.trocarBanco(passaporte_inv,data.valor,data.tipo) then
		local nome,sobrenome,imagem = vSERVER.ReturnNames()
		local carteira,banco,nome,sobrenome,registro,celular,idade,emprego,vip,coins,img,banner = vSERVER.SetIdentidade(passaporte_inv)
		cb({retorno = 'done',banco = banco})
	end
end)

--------------------------------
-- [ TROCAR CELULAR ] --
--------------------------------

RegisterNUICallback("trocarcelular",function(data,cb)
	if vSERVER.trocarCelular(passaporte_inv,data.celularnovo) then
		local nome,sobrenome,imagem = vSERVER.ReturnNames()
		local carteira,banco,nome,sobrenome,registro,celular,idade,emprego,vip,coins,img,banner = vSERVER.SetIdentidade(passaporte_inv)
		cb({retorno = 'done',celular = celular})
	end
end)

--------------------------------
-- [ TROCAR REGISTRO ] --
--------------------------------

RegisterNUICallback("trocarregistro",function(data,cb)
	if vSERVER.trocarRegistro(passaporte_inv,data.registronovo) then
		local nome,sobrenome,imagem = vSERVER.ReturnNames()
		local carteira,banco,nome,sobrenome,registro,celular,idade,emprego,vip,coins,img,banner = vSERVER.SetIdentidade(passaporte_inv)
		cb({retorno = 'done',registro = registro})
	end
end)

--------------------------------
-- [ SCREENSHOT ] --
--------------------------------
Screenshot = exports["screenshot-basic"]
src.panelScreenshot = function(lib,id)
    Screenshot:requestScreenshotUpload(lib, "files[]", function(data)
       local url = json.decode(data).attachments[1].url
       vSERVER.addScreenshot(url,id)
    end)
 end

RegisterNUICallback("screenshot",function(data,cb)
	if passaporte_inv then
		local image,staff = vSERVER.tirarscreenshot(parseInt(passaporte_inv))
		cb({retorno = 'done',imagem = image})
	end
end)

--------------------------------
-- [ ENVIAR MENSAGEM ] --
--------------------------------

RegisterNUICallback("enviarMensagem",function(data,cb)
	if vSERVER.enviarMsg(passaporte_inv,data.mensagem) then
		cb({retorno = 'done'})
	end
end)

--------------------------------
-- [ SKINS ] --
--------------------------------

RegisterNUICallback("skinsLista",function(data,cb)
	vSERVER.consultSkins()
	local skins = vSERVER.consultSkinsList()
	if skins then
		cb({ skins = skins })
	end
end)

RegisterNUICallback("setarSkin",function(data,cb)
	if vSERVER.SetarSkin(passaporte_inv,data.set) then
		cb({retorno = 'done'})
	end
end)

RegisterNetEvent("skinmenuwn")
AddEventHandler("skinmenuwn",function(mhash)
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Citizen.Wait(10)
    end

    if HasModelLoaded(mhash) then
        SetPlayerModel(PlayerId(),mhash)
        SetModelAsNoLongerNeeded(mhash)
    end
end)

--------------------------------
-- [ BAUS FAC ] --
--------------------------------

local baufac_ver = ""

RegisterNUICallback("RegisterBauFac",function(data,cb)
	baufac_ver = data.bau
	cb({retorno = 'done'})
end)

RegisterNUICallback("bausfacLista",function(data,cb)
	vSERVER.consultBausfac()
	local bausfac = vSERVER.consultBausfacList()
	if bausfac then
		cb({ bausfac = bausfac })
	end
end)

RegisterNUICallback("verbausfacLista",function(data,cb)
	vSERVER.consultverBauFac(baufac_ver)
	local verbausfac = vSERVER.consultverBauCasaFac()
	if verbausfac then
		cb({ verbausfac = verbausfac })
	end
end)

RegisterNUICallback("removerItemBauFac",function(data,cb)
	if vSERVER.removerItemBauFac(baufac_ver,data.item,data.quantidade) then
		cb({retorno = 'done'})
	end
end)

--------------------------------
-- [ GROUPS ] --
--------------------------------

local group_ver = ""

RegisterNUICallback("RegisterGroup",function(data,cb)
	group_ver = data.empresa
	cb({retorno = 'done'})
end)

RegisterNUICallback("verGrousList",function(data,cb)
	vSERVER.conseultGroups()
	local groups = vSERVER.conseultGroupsList()
	if groups then
		cb({ groups = groups })
	end
end)

RegisterNUICallback("verPlayersGroup",function(data,cb)
	vSERVER.conseultverPlayersGroup(group_ver)
	local verPlayersGroup = vSERVER.conseultverPlayersGroupList()
	if verPlayersGroup then
		cb({ verPlayersGroup = verPlayersGroup })
	end
end)

RegisterNUICallback("demitirGroups",function(data,cb)
		vSERVER.demitirGroups(data.passaporte,group_ver,data.tipo) 
		cb({retorno = 'done'})
end)

--------------------------------
-- [ SISTEMA BANIMENTOS ] --
--------------------------------


RegisterNUICallback("addBan",function(data,cb)
	if vSERVER.addBan(data.motivo,passaporte_inv,discord_id) then
		cb({retorno = 'done'})
	end
end)

RegisterNUICallback("addKick",function(data,cb)
	if vSERVER.addKick(data.motivo,passaporte_inv) then
		cb({retorno = 'done'})
	end
end)

RegisterNUICallback("addAdv",function(data,cb)
	if vSERVER.addAdv(data.motivo,passaporte_inv) then
		cb({retorno = 'done'})
	end
end)

RegisterNetEvent("tacklewnstaff:Player")
AddEventHandler("tacklewnstaff:Player",function()
	local coords = GetEntityForwardVector(PlayerPedId())
	SetPedToRagdollWithFall(PlayerPedId(),10000,10000,0,coords[1],coords[2],coords[3],10.0,0.0,0.0,0.0,0.0,0.0,0.0)
end)

RegisterNetEvent("entity:fire")
AddEventHandler("entity:fire",function()
	StartEntityFire(PlayerPedId())
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:INITSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:initSpectate")
AddEventHandler("admin:initSpectate",function(source)
	if not NetworkIsInSpectatorMode() then
		local Pid = GetPlayerFromServerId(source)
		local Ped = GetPlayerPed(Pid)
		NetworkSetInSpectatorMode(true,Ped)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:RESETSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:resetSpectate")
AddEventHandler("admin:resetSpectate",function()
	if NetworkIsInSpectatorMode() then
		NetworkSetInSpectatorMode(false)
	end
end)