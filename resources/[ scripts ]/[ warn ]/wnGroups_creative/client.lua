--------------------------------
-- [ CONEXAO ] --
--------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("wnGroups",src)
vSERVER = Tunnel.getInterface("wnGroups")

--------------------------------
-- [ VARIAVEL ] --
--------------------------------

local nui_open = false
local empresa_ver = "Desempregado"
local imagem_venda = ""
local passaporte_ver = 0
local AdminOn = false


CreateThread(function()
	while true do
		Wait(30*60000)
		vSERVER.receiveSalary()
	end
end)



--------------------------------
-- [ COMANDOS ] --
--------------------------------

RegisterCommand("tablet",function()
    if not nui_open then
		local empresa,cargo = vSERVER.GetEmpresa()
		empresa_ver = empresa
		if empresa then
			local Permissao,Membros_Setados,Limite_Membros,vendas,avisos,paginaUpgrades = vSERVER.GetEmpresaInfos(empresa_ver)
			local nome,imagem = vSERVER.informacoes_player(empresa)
			SetNuiFocus(true,true)
			SetCursorLocation(0.5, 0.5)
			StartScreenEffect("MenuMGSelectionIn", 0, true)
			SendNUIMessage({ action = "showMenu",
		
			nome = nome,
			cargo = cargo,
			paginaUpgrades = paginaUpgrades,
			imagem = imagem,
			Permissao = Permissao,
			Membros_Setados = Membros_Setados,
			Limite_Membros = Limite_Membros,
			vendas = vendas,
			avisos = avisos,
			empresa = empresa
		
			}) 
			AdminOn = false
		else
			TriggerEvent("Notify", "vermelho", "Você não está contratado em lugar nenhum.", 5000)
		end
	end
end)


RegisterNetEvent("wnGroups:checkEmpresa")
AddEventHandler("wnGroups:checkEmpresa",function(user_id)
  	vSERVER.verificar_cargo_player()
end)

RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	StopScreenEffect("MenuMGSelectionIn")
	nui_open = false
	AdminOn = false
end)


--------------------------------
-- [ Anuncios ] --
--------------------------------

RegisterNUICallback("anunciosLista",function(data,cb)
	vSERVER.refreshAnuncios(empresa_ver)
	local anunciosLista = vSERVER.returnAnuncios()
	if anunciosLista then
		cb({ anunciosLista = anunciosLista })
	end
end)

RegisterNUICallback("enivarAnuncio",function(data,cb)
	if vSERVER.addAnuncio(empresa_ver,data.mensagem) then
		cb({retorno = 'done'})
	end
end)

--------------------------------
-- [ Chat ] --
--------------------------------

RegisterNUICallback("chatLista",function(data,cb)
	vSERVER.refreshChat(empresa_ver)
	local chatLista = vSERVER.returnChat()
	if chatLista then
		cb({ chatLista = chatLista })
	end
end)

RegisterNUICallback("enviarChat",function(data,cb)
	if vSERVER.addChat(empresa_ver,data.mensagem) then
		cb({retorno = 'done'})
	end
end)

--------------------------------
-- [ Membros ] --
--------------------------------

RegisterNUICallback("membrosLista",function(data,cb)
	vSERVER.refreshMembros(empresa_ver)
	local membrosLista = vSERVER.returnMembros()
	if membrosLista then
		cb({ membrosLista = membrosLista })
	end
end)

--------------------------------
-- [ Promover ] --
--------------------------------

RegisterNUICallback("promover",function(data,cb)
	if data.passaporte then
		vSERVER.promover(empresa_ver,data.passaporte,AdminOn)
		cb({ retorno = 'done' })
	end
end)

--------------------------------
-- [ Rebaixar ] --
--------------------------------

RegisterNUICallback("rebaixar",function(data,cb)
	if data.passaporte then
		vSERVER.rebaixar(empresa_ver,data.passaporte,AdminOn)
		cb({ retorno = 'done' })
	end
end)

--------------------------------
-- [ Demitir ] --
--------------------------------

RegisterNUICallback("demitir",function(data,cb)
	if data.passaporte then
		vSERVER.demitir(empresa_ver,data.passaporte)
		cb({ retorno = 'done' })
	end
end)

--------------------------------
-- [ Contratar Verify ] --
--------------------------------

RegisterNUICallback("passaporteContratar",function(data,cb)
	if data.passaporte then
		if vSERVER.contratar(empresa_ver,data.passaporte) then
			cb({ retorno = 'done' })
		end
	end
end)


--------------------------------
-- [ Bau fac ] --
--------------------------------

RegisterNUICallback("bauFac",function(data,cb)
	vSERVER.refreshBau(empresa_ver)
	local bauFac = vSERVER.returnBau()
	if bauFac then
		cb({ bauFac = bauFac })
	end
end)

--------------------------------
-- [ Vendas ] --
--------------------------------

RegisterNUICallback("ListaVendas",function(data,cb)
	vSERVER.refreshVendas(empresa_ver)
	local ListaVendas = vSERVER.returnVendas()
	if ListaVendas then
		cb({ ListaVendas = ListaVendas })
	end
end)

RegisterNUICallback("imagemVenda",function(data,cb)
	if data.linkimagem then
		imagem_venda = data.linkimagem
		cb({ retorno = 'done' })
	end
end)

RegisterNUICallback("criarVendaConfirm",function(data,cb)
	if vSERVER.CriarVenda(empresa_ver,data.compradorInput,data.valorInput,imagem_venda) then
		cb({ retorno = 'done' })
	end
end)

RegisterNUICallback("deletarVenda",function(data,cb)
	if vSERVER.deletarVenda(data.idvenda) then
		cb({ retorno = 'done' })
	end
end)

RegisterNUICallback("verVenda",function(data,cb)
	local idvenda,passaporte,empresa,vendedor,comprador,imagem,valor,data,imagemplayer = vSERVER.verVenda(data.idvenda)
	cb({ retorno = 'done', idvenda = idvenda, passaporte = passaporte, empresa = empresa, vendedor = vendedor, comprador = comprador, imagem = imagem,valor = valor, data = data,imagemplayer = imagemplayer })
end)

RegisterNUICallback("pagarUpgrade",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	StopScreenEffect("MenuMGSelectionIn")
	nui_open = false
	AdminOn = false
	vSERVER.upgrade(empresa_ver)
end)