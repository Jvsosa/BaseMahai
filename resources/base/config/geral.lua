Config = {}

Config.Logo_Cidade = "https://i.imgur.com/9tgc2PX.png" -- Insira um LINK
Config.Webhook_Upload = "https://discordapp.com/api/webhooks/1339200393044820009/ENAPhm5YcYyj3_iUHPgeu3f0CdVwuch_8Kd7_okdF_U26S-yGDyk4227JYXeB8nlcwgn"
------------------------------------------
-- [ CONFIGURAÇAO BASE ]
------------------------------------------
Config.Basico = {
    nome_cidade = "Mahai City", -- Este nome ele vai aparecer nas tags na sua cidade como o Game Type
    link_loja = "www.Mahai-City.com", -- Coloque aqui o link da sua loja da cidade
    webhook = "", -- Webhook para enviar mensagem para o bot alterar o nome do usuario formato: id nome sobrenome
    dinheiro_inicial = 11000, -- Quantidade de dinheiro ganho na hora que cria o personagem
    whitelist = true, -- Sistema de Whitelist, caso queira que o sistema de whitelist esteja off coloque false 
    spawn = {
        creatorCoords = { x = -811.7, y = 175.22, z = 76.73, h = 107.72 }, -- Coordenada aonde o jogador vai criar o personagem ou selecionar o personagem
        spawnCoords = { x = 272.47, y = -1197.29, z = 29.28 }, -- Coordenada aonde o jogador vai dar spawn apos criar o personagem
    },
    itens_inicial = {
        [1] = { item = "backpack", quantidade = 3 },
        [2] = { item = "hamburguer", quantidade = 3 },
        [3] = { item = "cellphone", quantidade = 1 },
        [4] = { item = "radio", quantidade = 1 },
        [5] = { item = "dollars", quantidade = 5000 },
        [6] = { item = "water", quantidade = 3 },
    },
    url_images = {
        inventario = "http://localhost/itens/", -- Coloque aqui o URL das suas imagens dos itens ! (TEM QUE SER HOSPEDADO)
        garagem = "http://localhost/cars/", -- Coloque aqui o URL das suas imagens dos itens ! (TEM QUE SER HOSPEDADO)
    },
    discord_status = {
        SetDiscordAppId = 1275551976901574728, -- Coloque o id de Aplicaçao aqui
        SetDiscordRichPresenceAsset = "image", -- Nome da imagem upada no site do discord
        SetDiscordRichPresenceAssetSmall = "image", -- Nome da imagem upada no site do discord
        SetDiscordRichPresenceAssetText = "Mahai City", -- Nome da sua cidade
        SetDiscordRichPresenceAction = "https://discord.gg/MahaiCity", -- Link do discord da sua cidade
    },
    npcs = {
        VehicleDensity = 0.0,
        RandomVehicleDensity = 0.0,
        ParkedVehicleDensity = 0.0,
        AmbientVehicleRange = 0.0,
        ScenarioPedDensity = { 2.0,2.0 },
        PedDensity = 2.0,
        clearArea = { -- [ LIMPAR OS NPCS DE CERTA AREA (DEIXAR O NUMERO SEMPRE COM TERMINO DE .0) ]
            [1] = { x = 1145.11, y = -1537.08, z = 35.37, limpar_npcs = true, limpar_vehs = true, raio = 80.0 },  -- [ HOSPITAL ]
        },
    },
    otimizacoes = {
        limpar_vehs = { ativo = true, minutos = 180 }, -- [ LIMPA TODOS OS VEICULOS SEM JOGADORES DENTRO ]
        limpar_npcs = { ativo = true, minutos = 10 }, -- [ RECOMENDO DEIXAR A CADA 150 JOGADORES ONLINE E GERADO 10.000 NPCS A CADA 10 MINUTOS ]
    },
    chat = {
        ["Staff"] = { permissoes = { 'Helper' } },
        ["Policia"] = { permissoes = { 'Police' } },
        ["Hospital"] = { permissoes = { 'Paramedic' } },
        ["Cafe"] = { permissoes = { 'Cafe' } },
    },
    carros_baby = { -- Caso tenha algum carro de baby, coloque aqui assim o jogador adulto nao podera entrar no veiculo !
        ['babyamarokbr'] = true,
        ['miniaranha'] = true,
        ['bmxbaby'] = true,
        ['minibronco'] = true,
        ['minievoque'] = true,
        ['babygs63'] = true,
        ['gtrag'] = true,
        ['flybee'] = true,
        ['babyhuracan'] = true,
        ['babylancer'] = true,
        ['rmodgt63mini'] = true,
        ['minicag'] = true,
        ['mustangag'] = true,
        ['minipepa'] = true,
        ['porscheag'] = true,
        ['babyr34'] = true,
        ['babyr1250'] = true,
        ['hbkombi'] = true,
        ['hbvolatus'] = true,
        ['honeybeeftoro'] = true,
        ['HoneyBeeJettaGli'] = true,
        ['HoneyBeeSomClass'] = true,
        ['terzo'] = true,
        ['mini2xlr35sakura'] = true,
        ['mini2xlr35kuromi'] = true,
        ['rx7tortuguitamini'] = true,
    },
    radios = {
        { channel = 1, perm = "Helper" },
        { channel = 2, perm = "Police" },
        { channel = 3, perm = "Police" },
        { channel = 4, perm = "Police" },
        { channel = 5, perm = "Police" },
        { channel = 6, perm = "Police" },
        { channel = 7, perm = "Police" },
        { channel = 8, perm = "Police" },
        { channel = 9, perm = "Police" },
        { channel = 10, perm = "Police" },
        { channel = 11, perm = "Police" },
        { channel = 12, perm = "Police" },
        { channel = 15, perm = "Police" },
        { channel = 16, perm = "Police" },
        { channel = 17, perm = "Police" },
        { channel = 18, perm = "Police" },
        { channel = 19, perm = "Police" },
        { channel = 20, perm = "Police" },
        { channel = 911, perm = "Police" },
        { channel = 30, perm = "Cafe" },
        { channel = 31, perm = "Paramedic" },
        { channel = 32, perm = "Paramedic" },
        { channel = 33, perm = "Paramedic" },
    },
    reboques = { -- [ CASO COLOQUE UM VEICULO AQUI SERA POSSIVEL REBOCAR UM CARRO COM ELE ]
        ['energyrepair'] = true,
        ['flatbed'] = true,
        ['WRflatbed'] = true,
    },
    playersFake = {
        ["00:00"] = 0,
        ["01:00"] = 0,
        ["02:00"] = 0,
        ["03:00"] = 0,
        ["04:00"] = 0,
        ["05:00"] = 0,
        ["06:00"] = 0,
        ["07:00"] = 0,
        ["08:00"] = 0,
        ["09:00"] = 0,
        ["10:00"] = 0,
        ["11:00"] = 0,
        ["12:00"] = 0,
        ["13:00"] = 0,
        ["14:00"] = 0,
        ["15:00"] = 0,
        ["16:00"] = 0,
        ["17:00"] = 0,
        ["18:00"] = 0,
        ["19:00"] = 0,
        ["20:00"] = 0,
        ["21:00"] = 0,
        ["22:00"] = 0,
        ["23:00"] = 0,
    },
    fivemanage = {
        token = "", --  [ Faça o login e gere um token: https://fivemanage.com/dashboard (VIDEO: https://youtu.be/4r6ZITae9qg ) ]
    },
    outros = {
        ForcarPrimeiraPessoaAtirar = false, -- [ CASO COLOQUE TRUE ELE VAI FORCAR A PRIMEIRA VISAO NA HORA DE ATIRAR DE DENTRO DE UM VEICULO ] 
        hudStreet = true, -- [ CASO VOCE QUEIRA DESATIVAR O NOME DA RUA NA HUD COLOQUE FALSE ] 
        sistemaDeDerrubar = {
            ativo = true, -- Caso queira o sistema de pressionar "E" duas vezes e se jogar no chao desativado coloque false
            stress = 0, -- Quantidade de stress ganho sempre que se jogar no chao.
        },
    }
}

------------------------------------------------------------------------------------
-- [ COMANDOS ]
------------------------------------------------------------------------------------

-- Config.Lisboa = {
--     url = "",
-- }

Config.Comandos = {
    ["/mundo"] = { perms = { "Admin","Moderator" }, webhook = "" }, -- Altera voce para outra dimensao [ /mundo (NUMERO) ] 
    ["/mundo2"] = { perms = { "Admin","Moderator" }, webhook = "" }, -- Altera algum jogador para outra dimensao [ /mundo (ID) (NUMERO) ] 
    ["/energetico"] = { perms = { "Admin","Moderator" }, webhook = "" }, -- Voce com esse comando pode ativar o energetico em voce infinito !
    ["/emote2"] = { perms = { "Admin" }, webhook = "" }, -- Usando esse comando voce pode forçar algum jogador a usar certa animacao usando [ /emote2 (NUMERO) ]
    ["/derrubar"] = { perms = { "Admin","Moderator" }, webhook = "" }, -- Usando esse comando voce pode forçar algum jogador a usar certa animacao usando [ /emote2 (QUANTIDADE) ]
    ["/setmochila"] = { perms = { "Admin" }, webhook = "" }, -- Usando este comando voce pode aumentar a mochila de algum jogador [ /mochila (ID) (QUANTIDADE) ]
    ["/mochilareset"] = { perms = { "Admin","Moderator" }, webhook = "" }, -- Usando este comando voce pode resetar a mochila de algum jogador [ /mochilareset (ID) ]
    ["/limparinv"] = { perms = { "Admin","Moderator" }, webhook = "" }, -- Usando este comando voce pode limpar a mochila de algum jogador [ /limparinv (ID) ]
    ["/carcolor"] = { perms = { "Admin" }, webhook = "" }, -- Usando este comando voce pode trocar a cor de um veiculo que estiver dentro dele !
    ["/addnitro"] = { perms = { "Admin" }, webhook = "" }, -- Usando este comando voce pode adicionar nitro no carro que voce estiver dentro !
    ["/item"] = { perms = { "Admin" }, webhook = "" }, -- Usando este comando voce pode criar itens no seu inventario [ /item (SPAWN) (QUANTIDADE) ]
    ["/god"] = { perms = { "Admin","Moderator","Helper" }, webhook = "" }, -- Usando este comando voce pode dar god em pessoas ou em si mesmo usando [ /god ou /god (ID) ]
    ["/god2"] = { perms = { "Admin" }, webhook = "" }, -- Dar God em Area
    ["/good"] = { perms = { "Admin" }, webhook = "" }, -- Usando este comando voce pode dar god em pessoas ou em si mesmo usando [ /good ou /good (ID) ] (REGENERA FOME E SEDE & COLETE)
    ["/nc"] = { perms = { "Admin","Moderator","Helper" }, webhook = "" }, -- Usando este comando voce podera entrar no noclip
    ["/kick"] = { perms = { "Admin","Moderator" }, webhook = "" }, -- Usando este comando voce pode expulsar algum jogador da cidade [ /kick (ID) ]
    ["/kickall"] = { perms = { "Admin" }, webhook = "" }, -- Usando este comando voce pode expulsar todos da cidade 
    ["/tpcds"] = { perms = { "Admin","Moderator","Helper" }, webhook = "" }, -- Usando este comando voce podera se teleportar para uma coordenada
    ["/cds"] = { perms = {  } }, -- Pegar uma Coordenada 
    ["/cds2"] = { perms = {  } }, -- Pegar uma Coordenada 
    ["/cds3"] = { perms = {  } }, -- Pegar uma Coordenada 
    ["/tptome"] = { perms = { "Admin","Moderator","Helper" }, webhook = "" }, -- Usando este comando voce podera puxar algum jogador para voce
    ["/tpto"] = { perms = { "Admin","Moderator","Helper" }, webhook = "" }, -- Usando este comando voce podera ir ate algum jogador 
    ["/tpway"] = { perms = { "Admin","Moderator","Helper" }, webhook = "" }, -- Usando este comando voce podera ir ate o waypoint marcado no mapa
    ["/group"] = { perms = { "Admin" }, webhook = "" }, -- Comando usado para setar grupos em usuario [ /group id cargo ]
    ["/ungroup"] = { perms = { "Admin" }, webhook = "" }, -- Comando usado para retirar grupos de um usuario [ /ungroup id cargo ]
    ["/tuning"] = { perms = { "Admin" }, webhook = "" }, -- Comando usado para tunar um veiculo automaticamente
    ["/fix"] = { perms = { "Admin","Moderator" }, webhook = "" }, -- Comando usado para reparar um veiculo
    ["/limparea"] = { perms = { "Admin","Moderator","Helper","Police" }, webhook = "" }, -- Comando para limpar a area retirar todos os objetos, marcas entre outras coisas
    ["/debug2"] = { perms = { "Admin","Moderator","Helper" } }, -- Comando para conseguir ver hash dos props
    ["/gem"] = { perms = { "Admin" } , webhook = "" }, -- Comando para adicionar gemas para um jogador
    ["/remgem"] = { perms = { "Admin" }, webhook = "" }, -- Comando para remover gemas de um jogador
    ["/money"] = { perms = { "Admin","CONSOLE" }, webhook = "" }, -- Comando para spawnar dinheiro [ /money quantidade ] [ /money id quantidade ] [ /money id quantidade ] (CONSOLE)
    ["/rdinheiro"] = { perms = { "Admin" }, webhook = "" }, -- Comando usado para remover dinheiro do banco de algum usuario [ /rdinheiro (ID) (QUANTIDADE) ]
    ["/blindado"] = { perms = { "Admin" }, webhook = "" }, -- Deixar veiculo o veiculo que voce esta dentro blidando 
    ["/copiarroupa"] = { perms = { "Admin","Moderator","Helper" }, webhook = "" }, -- Copiar roupa de um jogador da cidade
    ["/addfuel"] = { perms = { "Admin","Moderator" }, webhook = "" }, -- Adicionar gasolina no seu veiculo
    ["/resetp"] = { perms = { "Admin" }, webhook = "" }, -- Resete o personagem de algum jogador nao perde nenhum item nem veiculos, apenas aparecencia [ /resetp id ]
    ["/car"] = { perms = { "Admin" }, webhook = "" }, -- De Spawn de um veiculo usando o comando [ /car spawn-do-carro ]
    ["/dv"] = { perms = { "Admin","Moderator","Helper" }, webhook = "" },
    ["/sistema"] = { perms = { "Admin" }, webhook = "" }, -- Comando para alterar alguma informaçao no usuario, preset / steam / discord
    ["/spawn"] = { perms = { "Admin" }, webhook = "" }, -- Comando para voce voltar para o spawn, na parte da criaçao
    ["/luz"] = { perms = { "Influencer" } }, -- Comando usado para criar uma lampada, para tirar fotos com luz
    ["/wl"] = { perms = { "Admin","Moderator" }, webhook = "" }, -- Comando usado para liberar whitelist [ /wl (steam hex) ]
    ["/unwl"] = { perms = { "Admin","Moderator" }, webhook = "" },-- Comando usado para retirar whitelist [ /wl (steam hex) ]

    -- [ COMANDOS DO CONSOLE ]
    ["/kickallc"] = { perms = { "CONSOLE" } }, -- Usando este comando voce vai kickar todos na cidade porem funciona apenas no [ CONSOLE ]
    ["/msgdc"] = { perms = { "CONSOLE" } }, -- Este Comando faz voce enviar a mensagem de "CIDADE ONLINE" no Chat Geral
    ["/godc"] = { perms = { "CONSOLE" } }, -- Este comando voce da god em um player pela console
    ["/groupc"] = { perms = { "CONSOLE" } }, -- Usado para setar permissoes pela console do servidor, sem precisar entrar nele
    ["/ungroupc"] = { perms = { "CONSOLE" } }, -- Usado para remover permissoes pela console do servidor, sem precisar entrar nele
    ["/playersc"] = { perms = { "CONSOLE" } }, -- Usado para ver quantos jogadores tem na cidade, sem entrar na cidade
    ["/gemc"] = { perms = { "CONSOLE" } }, -- Dar Gemas pelo console da cidade
    ["/remgemc"] = { perms = { "CONSOLE" } }, -- Remover Gemas pelo console da cidade
    ["/reloadconfig"] = { perms = { "CONSOLE" } }, -- Voce podera usar este comando para dar reload em alguma config por exemplo [ reloadconfig geral ou reloadconfig blip-mapa ]

    -- [ COMANDOS JOGADORES ]

    ["/cam"] = { perms = { "Admin","Influencer","Camera" }, webhook = "" }, -- Acesse uma camera 3d na cidade, para tirar fotos melhores

    -- [ FUNCOES JOGADORES ]

    ["postit"] = { webhook = "" }, -- Verifique quem colocou os postit espalhados na sua cidade
    ["disparos"] = { webhook = "disparos" }, -- Caso algum jogador realize um disparo, voce vai ter acesso a ver logo. 
    ["Perimetro"] = { perms = { "Police" }, webhook = "" },
    ["Forcar-RemoverCarro"] = { perms = { "Police","Paramedic" }, webhook = "" },
    ["rv"] = { webhook = "cvrv" }, -- Log de quando algum jogador remove o outro do veiculo.
    ["cv"] = { webhook = "cvrv" }, -- Log de quando algum jogador coloca o outro do veiculo.
    ["log-mortes"] = { webhook = "mortes" }, -- Log de mortes, sempre que algum jogador matar outro com uma arma voce recebe a logo.

    ["punicao"] = { webhook = "punicao" }, -- Log de registro de HWID
    ["hwid-registro"] = { webhook = "hwid" }, -- Log de registro de HWID
    ["hwid-banido"] = { webhook = "hwid" }, -- Log de registro de HWID
    ["Registro-HWID"] = { webhook = "hwid" }, -- Log de registro de HWID
    ["desmanche"] = { webhook = "desmanche" }, -- Log de registro de HWID
 

    -- [ FUNÇOES STAFF ]

    ["Carregar-Admin"] = { perms = { "Admin","Moderator","Paramedic" }, webhook = "" },

    -- [ LOGS INVENTARIO ]

    ["Inventario-UsarItem"] = { webhook = "" }, -- Voce vai receber log com todos os itens usados no inventario do jogador
    ["Inventario-Lockpick"] = { webhook = "" }, -- Essa log voce podera ver em qual veiculo foi usado a lockpick, e coordenada
    ["Inventario-Fogueira"] = { webhook = "" }, -- Log importante para caso coloquem fogueiras em locais indevidos
    ["Inventario-EnviarItem"] = { webhook = "" }, -- Caso algum jogador enviar algum item voce pode saber via log
    ["Inventario-DroparItem"] = { webhook = "" }, -- Caso algum jogador dropar algum item voce pode saber via log
    ["Inventario-PegarItem"] = { webhook = "" },

    -- [ LOGS BAUS ]

    ["Baus-GuardarItem"] = { webhook = "" }, -- Voce vai receber log sempre que alguem guardar algum item no bau de Facçao
    ["Baus-RetirarItem"] = { webhook = "" }, -- Voce vai receber log sempre que alguem retirar algum item no bau de Facçao
    
    ["Baus-Carro-GuardarItem"] = { webhook = "" },
    ["Baus-Carro-RetirarItem"] = { webhook = "" },

    ["Baus-Casa-Abrir"] = { webhook = "" },
    ["Baus-Casa-GuardarItem"] = { webhook = "" },
    ["Baus-Casa-RetirarItem"] = { webhook = "" },

    -- [ LOGS REVISTAR ]

    ["Revistar-Abrir"] = { webhook = "" }, -- Sempre que alguem revistar voce vai ficar informado.
    ["Revistar-Colocou"] = { webhook = "" }, -- Caso algum jogador coloque itens de outro inventario, apartir do sistema de revistar voce podera ver qual item foi.
    ["Revistar-Pegou"] = { webhook = "" }, -- Caso algum jogador remova itens de outro inventario, apartir do sistema de revistar voce podera ver qual item foi.

    -- [ LOGS IMPORTANTES ]

    ["Função-giveInventoryItem"] = { webhook = "" }, -- Esta e uma funçao basica da vRP e aconcelhado ter na cidade para ter certeza que nenhum item esta sendo spawnado por cheaters !
    ["Função-generateItem"] = { webhook = "" }, -- Esta e uma funçao basica da vRP e aconcelhado ter na cidade para ter certeza que nenhum item esta sendo spawnado por cheaters !
    ["Função-tryGetInventoryItem"] = { webhook = "" }, -- Esta e uma funçao basica da vRP e aconcelhado ter na cidade para ter certeza que nenhum item esta sendo spawnado por cheaters !
    ["Função-removeInventoryItem"] = { webhook = "" }, -- Esta e uma funçao basica da vRP e aconcelhado ter na cidade para ter certeza que nenhum item esta sendo spawnado por cheaters !
    ["Função-paymentFull"] = { webhook = "" }, -- Esta e uma funçao basica da vRP e aconcelhado ter na cidade para ter certeza que nenhum item esta sendo spawnado por cheaters !
    ["Função-withdrawCash"] = { webhook = "" }, -- Esta e uma funçao basica da vRP e aconcelhado ter na cidade para ter certeza que nenhum item esta sendo spawnado por cheaters !
    ["Função-paymentBank"] = { webhook = "" }, -- Esta e uma funçao basica da vRP e aconcelhado ter na cidade para ter certeza que nenhum item esta sendo spawnado por cheaters !
    ["Função-setBankMoney"] = { webhook = "" }, -- Esta e uma funçao basica da vRP e aconcelhado ter na cidade para ter certeza que nenhum item esta sendo spawnado por cheaters !
    ["Função-addBank"] = { webhook = "" }, -- Esta e uma funçao basica da vRP e aconcelhado ter na cidade para ter certeza que nenhum item esta sendo spawnado por cheaters !
    ["Função-addFines"] = { webhook = "" }, -- Esta e uma funçao basica da vRP e aconcelhado ter na cidade para ter certeza que nenhum item esta sendo spawnado por cheaters !
    ["Função-Hackers"] = { webhook = "" }, -- Este webhook e uma funcao basica para verificar se algum usuario, esta abusando de algum cheat para stopar algum aruqivo, caso use anticheat ignore.
}

------------------------------------------------------------------------------------
-- [ SISTEMA DO INFLUENCERS ]
------------------------------------------------------------------------------------

-- COMANDOS
-- [ /msgdc ] -- Ele vai enviar uma mensagem de cidade aberta no chat geral
-- [ /pl quantia ] -- Adicionar players fake

Config.DiscordBot = {
    StatusDiscord = {
        guild_id = "1364244217660047421",
        channel_id = "1364244218482266136",
        message_id = "1364244218482266136",
        connect = "1364244218482266136",
        banner = "",
        link_loja = "",
    },
    webhooks = {
        abertura_cidade = "https://discord.com/api/webhooks/1364244441912705127/v7F7Yp5nlJ_ejgawLYPrrJZ0tDg-7pjIoeouzxwm3CWnhSV5_X6Xt8SfwOfZRY4FvXpv",
        connect = "128.163.0.1",
        banner = "https://discord.com/api/webhooks/1364244441912705127/v7F7Yp5nlJ_ejgawLYPrrJZ0tDg-7pjIoeouzxwm3CWnhSV5_X6Xt8SfwOfZRY4FvXpv",
        channels = {
            regras = "Regras",
            atualizacoes = "https://discord.com/api/webhooks/1364244441912705127/v7F7Yp5nlJ_ejgawLYPrrJZ0tDg-7pjIoeouzxwm3CWnhSV5_X6Xt8SfwOfZRY4FvXpv"
        },
    },
    Influencer_Config = {
        guild_id = "",
        webhook = "",
        skin_adultos = {
            ["mp_m_freemode_01"] = true,
            ["mp_f_freemode_01"] = true,
            ["Mia_barbie"] = true,
        },
        settings = {
            [1] = { 
                role_id = "",
                beneficios = {
                    grupos = { 'Influencer' },
                    carros = { 
                        [1] = { carro = "sl63amg22", baby = false },
                        [2] = { carro = "gtrag", baby = true },
                    },
                    itens = {},
                },
            },
            [2] = { 
                role_id = "",
                beneficios = {
                    grupos = { 'Streamer' },
                    carros = { 
                        [1] = { carro = "sl63amg22", baby = false },
                        [2] = { carro = "gtrag", baby = true },
                    },
                    itens = {},
                },
            },
            [3] = { 
                role_id = "",
                beneficios = {
                    grupos = { 'Tiktok' },
                    carros = { 
                        [1] = { carro = "sl63amg22", baby = false },
                        [2] = { carro = "gtrag", baby = true },
                    },
                    itens = {},
                },
            },
        },
    },
    DiscordBoost_Config = {
        guild_id = "1364244217660047421",
        role_id = "1364245774610731019",
        webhook = "https://discord.com/api/webhooks/1364244441912705127/v7F7Yp5nlJ_ejgawLYPrrJZ0tDg-7pjIoeouzxwm3CWnhSV5_X6Xt8SfwOfZRY4FvXpv",
        skin_adultos = {
            ["mp_m_freemode_01"] = true,
            ["mp_f_freemode_01"] = true,
            ["Mia_barbie"] = true,
        },
        beneficios = {
            grupos = { 'Booster' },
            carros = { 
                [1] = { carro = "rs322", baby = false },
                [2] = { carro = "urusperf23", baby = false },
                [3] = { carro = "babyhuracan", baby = true },
            },
            itens = {
                [1] = { item = "dollars", quantidade = 50000 },
            },
        },
    },
}

------------------------------------------------------------------------------------
-- [ EMOJIS DAS LOGS ]
------------------------------------------------------------------------------------

Config.Emojis = {
    ["user"] = "<:maui_user:1188470524217659452>",
    ["user2"] = "<:wnUser:1288282011013873725>",
    ["docs"] = "<:maui_docs:1203768560300859484>",
    ["pen"] = "<:maui_pen:1187286169285836831>",
    ["preco"] = "<:wnPreco:1178912395276583013>",
    ["anuncio"] = "<:wnAnuncio:1178904964530176010>",
    ["aviso"] = "<:maui_aviso:1188468038085906462>",
    ["pergunta"] = "<:wnPergunta:1178906434533085245>",
    ["fivem"] = "<:wnFiveM:1179777513371742288>",
    ["carro"] = "<:wnCarro:1250633630858874902>",
    ["cord"] = "<:wnLoc:1351255939038314570>",
    ["roupas"] = "<:wnRoupas:1250655257235816550>",
    ["bau"] = "<:wnBau:1250667047503790110>",
    ["inventario"] = "<:wnInventario:1250678952759136286>",
    ["link"] = "<:wnLink:1179778545002741801>",
}

------------------------------------------------------------------------------------
-- FORMATO: 
-- [ PERMS = { "PERMISAO PARA ACESSAR O ANUNCIO" } ]
-- [ TEMPO = (QUANTIDADE) TEMPO EM SEGUNDOS ]
-- [ NOTIFY = E A NOTIFY REGISTRADO NO SCRIPT NOTIFY ]
-- [ NOME_PERSONAGEM = SE VOCE QUER QUE APARECA O NOME DA PESSOA QUE FEZ O ANUNCIO ]
------------------------------------------------------------------------------------

Config.Webhook_Anuncio_Geral = "anuncios"
Config.Anuncio = {
    ["cafe"] = { perms = { "Cafe" }, tempo = 20, notify = "cafe", nome_personagem = true, webhook = "" },
    ["staff"] = { perms = { "Admin" }, tempo = 60, notify = "staff", nome_personagem = false, webhook = "" },
    ["cupula"] = { perms = { "Admin" }, tempo = 60, notify = "cupula", nome_personagem = false, webhook = "" },
    ["policia"] = { perms = { "Police" }, tempo = 30, notify = "policia", nome_personagem = true, webhook = "" },
    ["hospital"] = { perms = { "Paramedic" }, tempo = 30, notify = "Paramedic", nome_personagem = true, webhook = "" },
}

------------------------------------------
-- [ ROUBO A NPC ]
------------------------------------------

Config.Roubo_NPC = {
    webhook = "",
    itens = {
        { item = "dollars2", min = 425, max = 525 },
        { item = "dices", min = 1, max = 2 },
        { item = "radio", min = 1, max = 2 },
        { item = "keyboard", min = 1, max = 2 },
        { item = "mouse", min = 1, max = 2 },
        { item = "playstation", min = 1, max = 2 },
        { item = "xbox", min = 1, max = 2 },
        { item = "dish", min = 1, max = 2 },
        { item = "pan", min = 1, max = 2 },
        { item = "fan", min = 1, max = 2 },
        { item = "blender", min = 1, max = 2 },
        { item = "switch", min = 1, max = 2 },
        { item = "cup", min = 1, max = 2 },
        { item = "lampshade", min = 1, max = 2 },
        { item = "goldring", min = 1, max = 2 },
        { item = "watch", min = 1, max = 2 },
        { item = "bracelet", min = 1, max = 2 },
        { item = "dildo", min = 1, max = 2 },
        { item = "spray01", min = 1, max = 2 },
        { item = "spray02", min = 1, max = 2 },
        { item = "spray03", min = 1, max = 2 },
        { item = "spray04", min = 1, max = 2 },
        { item = "sneakers", min = 1, max = 2 },
        { item = "slipper", min = 1, max = 2 },
        { item = "rimel", min = 1, max = 2 },
        { item = "brush", min = 1, max = 2 },
        { item = "soap", min = 1, max = 2 },	
    }
}

------------------------------------------
-- [ VENDA DE DROGAS ]
------------------------------------------

Config.Venda_Drogas = {
    log_console = true, -- [ SE VOCE DESEJA LOG NO CONSOLE (true / false) ]
    bonus = 0, -- [ BONUS POR CADA POLICIAL ATIVO ]
    BloquearArma = false, -- [ CASO ESTA FUNCAO ESTIVER ATIVA ELE NAO DEIXA A PESSOA ARMADA VENDER MUNICAO ! ]
    webhooks = {
        ["Vendas"] = "",
        ["Denunciado"] = "",
    },
    itens = {
        { item = "lean",  priceMin = 650, priceMax = 780, randMin = 2, randMax = 3, wnPoliceSystem = "C21H30O2" },
        { item = "lean2",  priceMin = 640, priceMax = 700, randMin = 2, randMax = 3 , wnPoliceSystem = "C21H30O2"},
        { item = "lean3",  priceMin = 900, priceMax = 1200, randMin = 2, randMax = 3, wnPoliceSystem = "C21H30O2" },
        { item = "cocaine", priceMin = 650, priceMax = 780, randMin = 2, randMax = 3, wnPoliceSystem = "C43K12M9" },
        { item = "cocaine2",  priceMin = 640, priceMax = 700, randMin = 2, randMax = 3, wnPoliceSystem = "C43K12M9" },
        { item = "cocaine3",  priceMin = 900, priceMax = 1200, randMin = 2, randMax = 3, wnPoliceSystem = "C43K12M9" },
        { item = "meth",  priceMin = 650, priceMax = 780, randMin = 2, randMax = 3 , wnPoliceSystem = "A87P23N4"},
        { item = "meth2",  priceMin = 640, priceMax = 700, randMin = 2, randMax = 3, wnPoliceSystem = "A87P23N4" },
        { item = "meth3",  priceMin = 900, priceMax = 1200, randMin = 2, randMax = 3, wnPoliceSystem = "A87P23N4" },
        { item = "lsd",  priceMin = 650, priceMax = 780, randMin = 2, randMax = 3 , wnPoliceSystem = "A12F56G1"},
        { item = "lsd2",  priceMin = 640, priceMax = 700, randMin = 2, randMax = 3, wnPoliceSystem = "A12F56G1" },
        { item = "lsd3",  priceMin = 900, priceMax = 1200, randMin = 2, randMax = 3, wnPoliceSystem = "A12F56G1" },
    },
}

------------------------------------------
-- [ DESMANCHE ]
------------------------------------------

Config.Desmanche = {
    Valor_Default = 50000, -- [ ESSE E O VALOR QUE O USUARIO VAI GANHAR CASO O CARRO NAO ESTEJA REGISTRADO DO WNCONCE SQL ]
    Valor_Maximo = 100000, -- [ VALOR MAXIMO QUE CADA VEICULO PODE DAR ]
    Valor_Carro_Gemas = 85000,
    Multiplicar = 1.5, -- [ MULTIPLADOR DE VALOR DEIXE NA MEDIA DE 1.5 ]
    Locais = {
        ["Desmanche"] = {
            Permissoes = { 'Desmanche' },
            Locations = {
                Init = vector3( 2672.93,3475.1,55.54 ),
                Body = vector3( 2670.4,3475.28,55.72 ),
                Tire = vector3( 2670.4,3475.28,55.72 ),
            },
        },
    }
}

------------------------------------------
-- [ ROUBO REGISTRADORA ]
------------------------------------------

Config.Roubo_Registradora = {
    quantidade_policia = 2,
    webhook = "",
    task = false,
    TempoDeRoubo = 15,
    item = {
        necessario = false,
        item = "lockpick",
        quantidade = 1,
    },
    dinheiro_ganho = {
        minimo = 3000,
        maximo = 5000,
    },
    blips = {
        [1] = { ['x'] = 24.49, ['y'] = -1344.99, ['z'] = 29.49, ['h'] = 265.0 },
        [2] = { ['x'] = 24.50, ['y'] = -1347.34, ['z'] = 29.49, ['h'] = 267.0 },
        [3] = { ['x'] = 2554.90, ['y'] = 380.94, ['z'] = 108.62, ['h'] = 349.0 },
        [4] = { ['x'] = 2557.23, ['y'] = 380.83, ['z'] = 108.62, ['h'] = 354.0 },
        [5] = { ['x'] = 1165.07, ['y'] = -324.50, ['z'] = 69.20, ['h'] = 127.0 },
        [6] = { ['x'] = 1164.67, ['y'] = -322.76, ['z'] = 69.20, ['h'] = 94.0 },
        [7] = { ['x'] = -706.10, ['y'] = -915.43, ['z'] = 19.21, ['h'] = 116.0 },
        [8] = { ['x'] = -706.16, ['y'] = -913.65, ['z'] = 19.21, ['h'] = 85.0 },
        [9] = { ['x'] = -47.96, ['y'] = -1759.34, ['z'] = 29.42, ['h'] = 74.0 },
        [10] = { ['x'] = -46.80, ['y'] = -1757.94, ['z'] = 29.42, ['h'] = 45.0 },
        [11] = { ['x'] = 372.58, ['y'] = 326.39, ['z'] = 103.56, ['h'] = 252.0 },
        [12] = { ['x'] = 373.10, ['y'] = 328.64, ['z'] = 103.56, ['h'] = 255.0 },
        [13] = { ['x'] = -3242.24, ['y'] = 1000.01, ['z'] = 12.83, ['h'] = 352.0 },
        [14] = { ['x'] = -3244.56, ['y'] = 1000.20, ['z'] = 12.83, ['h'] = 354.0 },
        [15] = { ['x'] = 1727.88, ['y'] = 6415.21, ['z'] = 35.03, ['h'] = 239.0 },
        [16] = { ['x'] = 1728.90, ['y'] = 6417.25, ['z'] = 35.03, ['h'] = 240.0 },
        [17] = { ['x'] = 549.03, ['y'] = 2671.36, ['z'] = 42.15, ['h'] = 93.0 },
        [18] = { ['x'] = 549.33, ['y'] = 2669.04, ['z'] = 42.15, ['h'] = 93.0 },
        [19] = { ['x'] = 1958.96, ['y'] = 3742.01, ['z'] = 32.34, ['h'] = 298.0 },
        [20] = { ['x'] = 1960.12, ['y'] = 3740.01, ['z'] = 32.34, ['h'] = 295.0 },
        [21] = { ['x'] = 2678.07, ['y'] = 3279.42, ['z'] = 55.24, ['h'] = 327.0 },
        [22] = { ['x'] = 2676.03, ['y'] = 3280.56, ['z'] = 55.24, ['h'] = 327.0 },
        [23] = { ['x'] = 1696.57, ['y'] = 4923.95, ['z'] = 42.06, ['h'] = 353.0 },
        [24] = { ['x'] = 1698.06, ['y'] = 4922.96, ['z'] = 42.06, ['h'] = 323.0 },
        [25] = { ['x'] = -1818.89, ['y'] = 792.94, ['z'] = 138.08, ['h'] = 161.0 },
        [26] = { ['x'] = -1820.12, ['y'] = 794.16, ['z'] = 138.08, ['h'] = 129.0 },
        [27] = { ['x'] = 1392.87, ['y'] = 3606.39, ['z'] = 34.98, ['h'] = 195.0 },
        [28] = { ['x'] = -2966.44, ['y'] = 390.89, ['z'] = 15.04, ['h'] = 84.0 },
        [29] = { ['x'] = -3038.95, ['y'] = 584.55, ['z'] = 7.90, ['h'] = 16.0 },
        [30] = { ['x'] = -3041.19, ['y'] = 583.84, ['z'] = 7.90, ['h'] = 14.0 },
        [31] = { ['x'] = 1134.25, ['y'] = -982.47, ['z'] = 46.41, ['h'] = 273.0 },
        [32] = { ['x'] = 1165.93, ['y'] = 2710.77, ['z'] = 38.15, ['h'] = 177.0 },
        [33] = { ['x'] = -1486.29, ['y'] = -378.02, ['z'] = 40.16, ['h'] = 132.0 },
        [34] = { ['x'] = -1221.99, ['y'] = -908.29, ['z'] = 12.32, ['h'] = 28.0 },
        [35] = { ['x'] = 73.97, ['y'] = -1392.13, ['z'] = 29.37, ['h'] = 267.0 },
        [36] = { ['x'] = 74.86, ['y'] = -1387.70, ['z'] = 29.37, ['h'] = 182.0 },
        [37] = { ['x'] = 78.02, ['y'] = -1387.69, ['z'] = 29.37, ['h'] = 177.0 },
        [38] = { ['x'] = 426.96, ['y'] = -806.99, ['z'] = 29.49, ['h'] = 91.0 },
        [39] = { ['x'] = 426.08, ['y'] = -811.44, ['z'] = 29.49, ['h'] = 358.0 },
        [40] = { ['x'] = 422.91, ['y'] = -811.44, ['z'] = 29.49, ['h'] = 358.0 },
        [41] = { ['x'] = -816.56, ['y'] = -1073.25, ['z'] = 11.32, ['h'] = 122.0 },
        [42] = { ['x'] = -818.14, ['y'] = -1070.52, ['z'] = 11.32, ['h'] = 122.0 },
        [43] = { ['x'] = -822.41, ['y'] = -1071.94, ['z'] = 11.32, ['h'] = 206.0 },
        [44] = { ['x'] = -1195.24, ['y'] = -768.03, ['z'] = 17.31, ['h'] = 215.0 },
        [45] = { ['x'] = -1193.86, ['y'] = -767.00, ['z'] = 17.31, ['h'] = 215.0 },
        [46] = { ['x'] = -1192.44, ['y'] = -765.93, ['z'] = 17.31, ['h'] = 215.0 },
        [47] = { ['x'] = 5.21, ['y'] = 6510.88, ['z'] = 31.87, ['h'] = 41.0 },
        [48] = { ['x'] = 1.34, ['y'] = 6508.52, ['z'] = 31.87, ['h'] = 309.0 },
        [49] = { ['x'] = -0.80, ['y'] = 6510.80, ['z'] = 31.87, ['h'] = 309.0 },
        [50] = { ['x'] = 1695.38, ['y'] = 4822.23, ['z'] = 42.06, ['h'] = 92.0 },
        [51] = { ['x'] = 1695.10, ['y'] = 4817.71, ['z'] = 42.06, ['h'] = 4.0 },
        [52] = { ['x'] = 1691.98, ['y'] = 4817.31, ['z'] = 42.06, ['h'] = 4.0 },
        [53] = { ['x'] = 127.50, ['y'] = -222.58, ['z'] = 54.55, ['h'] = 70.0 },
        [54] = { ['x'] = 126.93, ['y'] = -224.18, ['z'] = 54.55, ['h'] = 70.0 },
        [55] = { ['x'] = 126.30, ['y'] = -225.88, ['z'] = 54.55, ['h'] = 70.0 },
        [56] = { ['x'] = 613.14, ['y'] = 2760.96, ['z'] = 42.08, ['h'] = 273.0 },
        [57] = { ['x'] = 612.99, ['y'] = 2762.69, ['z'] = 42.08, ['h'] = 273.0 },
        [58] = { ['x'] = 612.85, ['y'] = 2764.46, ['z'] = 42.08, ['h'] = 273.0 },
        [59] = { ['x'] = 1197.42, ['y'] = 2711.63, ['z'] = 38.22, ['h'] = 175.0 },
        [60] = { ['x'] = 1201.88, ['y'] = 2710.74, ['z'] = 38.22, ['h'] = 85.0 },
        [61] = { ['x'] = 1201.87, ['y'] = 2707.60, ['z'] = 38.22, ['h'] = 85.0 },
        [62] = { ['x'] = -3168.76, ['y'] = 1044.80, ['z'] = 20.86, ['h'] = 65.0 },
        [63] = { ['x'] = -3169.46, ['y'] = 1043.22, ['z'] = 20.86, ['h'] = 65.0 },
        [64] = { ['x'] = -3170.17, ['y'] = 1041.60, ['z'] = 20.86, ['h'] = 65.0 },
        [65] = { ['x'] = -1101.80, ['y'] = 2712.10, ['z'] = 19.10, ['h'] = 216.0 },
        [66] = { ['x'] = -1097.90, ['y'] = 2714.40, ['z'] = 19.10, ['h'] = 125.0 },
        [67] = { ['x'] = -1095.82, ['y'] = 2712.08, ['z'] = 19.10, ['h'] = 125.0 },
        [68] = { ['x'] = -821.91, ['y'] = -183.32, ['z'] = 37.56, ['h'] = 213.0 },
        [69] = { ['x'] = 134.39, ['y'] = -1707.83, ['z'] = 29.29, ['h'] = 136.0 },
        [70] = { ['x'] = -1284.26, ['y'] = -1115.05, ['z'] = 6.99, ['h'] = 89.0 },
        [71] = { ['x'] = 1930.56, ['y'] = 3727.93, ['z'] = 32.84, ['h'] = 205.0 },
        [72] = { ['x'] = 1211.52, ['y'] = -470.31, ['z'] = 66.20, ['h'] = 72.0 },
        [73] = { ['x'] = -30.42, ['y'] = -151.77, ['z'] = 57.07, ['h'] = 336.0 },
        [74] = { ['x'] = -277.76, ['y'] = 6230.73, ['z'] = 31.69, ['h'] = 38.0 },
        [75] = { ['x'] = 1324.94, ['y'] = -1650.74, ['z'] = 52.28, ['h'] = 124.96 },
        [76] = { ['x'] = -1151.72, ['y'] = -1424.48, ['z'] = 4.96, ['h'] = 124.36 },
        [77] = { ['x'] = 320.0, ['y'] = 181.55, ['z'] = 103.59, ['h'] = 246.68 },
        [78] = { ['x'] = -3171.13, ['y'] = 1073.31, ['z'] = 20.83, ['h'] = 326.21 },
        [79] = { ['x'] = 1861.83, ['y'] = 3748.07, ['z'] = 33.04, ['h'] = 39.39 },
        [80] = { ['x'] = -291.5, ['y'] = 6200.33, ['z'] = 31.49, ['h'] = 236.54 },
        [81] = { ['x'] = 1982.39, ['y'] = 3053.44, ['z'] = 47.22, ['h'] = 49.43 },
    },
}

------------------------------------------
-- [ SALARIOS ]
------------------------------------------

Config.Salarios = {
    cooldown = 60, -- [ ISSO E A QUANTIDADE EM MINUTOS PARA RECEBER SALARIO ]
    webhook = "",
    lista = {
        { title = "Prata", cargo = "VipPrata", valor = 1000 },
        { title = "Ouro", cargo = "VipOuro", valor = 2000 },
        { title = "Ruby", cargo = "VipRuby", valor = 3500 },
        { title = "Esmeralda", cargo = "VipEsmeralda", valor = 4000 },
        { title = "Diamante", cargo = "VipDiamante", valor = 5000 },
        { title = "Mahai", cargo = "VipMaui", valor = 7500 },
        { title = "Kids", cargo = "VipKids", valor = 2000 },
        { title = "Deluxe", cargo = "VipKidsDeluxe", valor = 3000 },
        { title = "Booster", cargo = "Booster", valor = 1000 },
        { title = "Influencer", cargo = "Influencer", valor = 4000 },
        { title = "Streamer", cargo = "Streamer", valor = 6000 },
        { title = "Tiktok", cargo = "Tiktok", valor = 6000 },
    }
}

------------------------------------------
-- [ /STATUS ]
------------------------------------------

-- /mec
-- /ems
-- /ptr
-- /status

Config.ComandoStatus = {
    [1] = { nome = "Hospital", permissao = "Paramedic" },
    [2] = { nome = "Cafe", permissao = "Cafe" },
}

Config.PermissoesBypassStatus = "Moderator"

Config.PermissoesMecanicos = {
    {nome = "OverSpeed", usuarios = {}, quantidade = 0, nomes = ""},
    {nome = "StopCar", usuarios = {}, quantidade = 0, nomes = ""},
}

------------------------------------------
-- [ ROUPA DE PRESIDIO ]
------------------------------------------

Config.RoupaPresidio = {
    ["mp_m_freemode_01"] = {
		["hat"] = { item = 0, texture = 0 }, --chapeu
		["pants"] = { item = 36, texture = 0 },  --calca
		["vest"] = { item = 0, texture = 0 }, --colete
		["bracelet"] = { item = -1, texture = 0 }, --pulseira
		["backpack"] = { item = 0, texture = 0 }, --mochila
		["decals"] = { item = 0, texture = 0 }, --adesivos
		["mask"] = { item = 0, texture = 0 }, --mascara
		["shoes"] = { item = 57, texture = 0 }, --sapatos
		["tshirt"] = { item = 15, texture = 0 }, --camisa
		["torso"] = { item = 438, texture = 0 }, --jaqueta
		["accessory"] = { item = 0, texture = 0 }, --acessorios
		["watch"] = { item = -1, texture = 0 }, --relogio 
		["arms"] = { item = 0, texture = 0 }, --maos
		["glass"] = { item = 0, texture = 0 }, --oculos
		["ear"] = { item = -1, texture = 0 } --brinco
	},
	["mp_f_freemode_01"] = {
		["hat"] = { item = 0, texture = 0 }, --chapeu
		["pants"] = { item = 41, texture = 0 },  --calca
		["vest"] = { item = 0, texture = 0 }, --colete
		["bracelet"] = { item = -1, texture = 0 }, --pulseira
		["backpack"] = { item = 0, texture = 0 }, --mochila
		["decals"] = { item = 0, texture = 0 }, --adesivos
		["mask"] = { item = 0, texture = 0 }, --mascara
		["shoes"] = { item = 88, texture = 0 }, --sapatos
		["tshirt"] = { item = 14, texture = 0 }, --camisa
		["torso"] = { item = 226, texture = 0 }, --jaqueta
		["accessory"] = { item = 0, texture = 0 }, --acessorios
		["watch"] = { item = -1, texture = 0 }, --relogio 
		["arms"] = { item = 185, texture = 0 }, --maos
		["glass"] = { item = 0, texture = 0 }, --oculos
		["ear"] = { item = -1, texture = 0 } --brinco
	}
}

------------------------------------------
-- [ ENTRAR / SAIR (SERVICO)  ]
------------------------------------------

Config.Toggle = {
    ['Paramedic'] = { 
        blip = { x = 1125.04, y = -1534.44, z = 35.37 },
        webhook = "",
        MarcarGPS = { ativo = true, nome = "Hospital", cor = 23 },
        cargos = {
            [1] = { em_servico = "Diretor-Paramedic", fora_de_servico = "waitDiretor-Paramedic" },
            [2] = { em_servico = "Gerente-Paramedic", fora_de_servico = "waitGerente-Paramedic" },
            [3] = { em_servico = "Paramedic", fora_de_servico = "waitParamedic" },
        }
    },
    
    ['Cafe'] = { 
        blip = { x = -593.96, y = -1052.45, z = 22.34 },
        webhook = "",
        cargos = {
            [1] = { em_servico = "Chefe-Cafe", fora_de_servico = "waitChefe-Cafe" },
            [2] = { em_servico = "Gerente-Cafe", fora_de_servico = "waitGerente-Cafe" },
            [3] = { em_servico = "Cafe", fora_de_servico = "waitCafe" },
        }
    },

}

------------------------------------------
-- [ GRUPOS ]
------------------------------------------

-- Inventario (NOME) "Nome que fica no Inventario"
-- Inventario (POSICAO) "Numero numerico para ter uma posicao de ranking no inventario na categoria cargos"
-- Inventario (IMAGEM) "Nome do arquivo da imagem no inventario"

Config.Grupos = {

    ['Dono'] = {
        inventario = { nome = "Dono", imagem = "dono", posicao = 1 },
        perms = { 'Dono','Admin','Moderator','Helper','AcessoRoupas','ItemRoupas','Spotify','Verificado' },
    },

    ['Marketing'] = {
        inventario = { nome = "Marketing", imagem = "Markting", posicao = 2 },
        perms = { 'Marketing','Admin','Moderator','Helper','VipClothing','AcessoRoupas','ItemRoupas','Spotify','Verificado' },
    },
   
    ['Admin'] = {
        inventario = { nome = "Admin", imagem = "admin", posicao = 2 },
        perms = { 'Admin','Moderator','Helper','VipClothing','AcessoRoupas','ItemRoupas','Spotify','Verificado' },
    },

    ['Moderator'] = {
        inventario = { nome = "Moderator", imagem = "moderator", posicao = 3 },
        perms = { 'Moderator','Helper','Attachs','AcessoRoupas','ItemRoupas','Spotify','Verificado' },
    },

    ['Helper'] = {
        inventario = { nome = "Helper", imagem = "helper", posicao = 4 },
        perms = { 'Helper','Camera','Spotify','Verificado','AcessoRoupas','ItemRoupas' },
    },

    ['Police'] = {
        inventario = { nome = "Policia", imagem = "policia", posicao = 999 },
        perms = { 'Police' },
    },

    ------------------------------
    -- [ Hospital ]
    ------------------------------

    ['Diretor-Paramedic'] = {
        inventario = { nome = "Diretor Hospital", imagem = "hospital", posicao = 999 },
        perms = { 'Diretor-Paramedic','Gerente-Paramedic','Paramedic','Doors-Hospital' },
    },

    ['waitDiretor-Paramedic'] = {
        inventario = { nome = "Fora do Hospital", imagem = "hospital", posicao = 999 },
        perms = { 'waitDiretor-Paramedic','Doors-Hospital' },
    },

    ['Gerente-Paramedic'] = {
        inventario = { nome = "Gerente Hospital", imagem = "hospital", posicao = 999 },
        perms = { 'Gerente-Paramedic','Paramedic','Doors-Hospital' },
    },

    ['waitGerente-Paramedic'] = {
        inventario = { nome = "Fora do Hospital", imagem = "hospital", posicao = 999 },
        perms = { 'waitGerente-Paramedic','Doors-Hospital' },
    },

    ['Paramedic'] = {
        inventario = { nome = "Hospital", imagem = "hospital", posicao = 999 },
        perms = { 'Paramedic','Doors-Hospital' },
    },

    ['waitParamedic'] = {
        inventario = { nome = "Fora do Hospital", imagem = "hospital", posicao = 999 },
        perms = { 'waitParamedic','Doors-Hospital' },
    },

    ['Doors-Hospital'] = {
        inventario = { nome = "Portas", imagem = "hospital", posicao = 999 },
        perms = { 'Doors-Hospital' },
    },

    ['PoliciaRE'] = {
        inventario = { nome = "PoliciaRE", imagem = "policia", posicao = 999 },
        perms = { 'PoliciaRE' },
    },

    ------------------------------
    -- [ Policia ]
    ------------------------------

    ['Comando-Policia'] = {
        inventario = { nome = "Comando Policia", imagem = "policia", posicao = 999 },
        perms = { 'Comando-Policia' },
    },

    ['SubComando-Policia'] = {
        inventario = { nome = "SubComando Policia", imagem = "policia", posicao = 999 },
        perms = { 'SubComando-Policia' },
    },

    ------------------------------
    -- [ Speed ]
    ------------------------------
   
    ['Comando-Speed'] = {
        inventario = { nome = "Comando Speed", imagem = "policia", posicao = 999 },
        perms = { 'Comando-Speed','SubComando-Speed','Speed','Police','Comando-Policia' },
    },

    ['waitComando-Speed'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitComando-Speed' },
    },

    ['SubComando-Speed'] = {
        inventario = { nome = "SubComando Speed", imagem = "policia", posicao = 999 },
        perms = { 'SubComando-Speed','Speed','Police','SubComando-Policia' },
    },

    ['waitSubComando-Speed'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitSubComando-Speed' },
    },

    ['Speed'] = {
        inventario = { nome = "Policia Speed", imagem = "policia", posicao = 999 },
        perms = { 'Speed','Police' },
    },

    ['waitSpeed'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitSpeed' },
    },

    ------------------------------
    -- [ Federal ]
    ------------------------------

    ['Comando-Federal'] = {
        inventario = { nome = "Comando Federal", imagem = "policia", posicao = 999 },
        perms = { 'Comando-Federal','SubComando-Federal','Federal','Police','Comando-Policia','Doors-Federal' },
    },
    
    ['waitComando-Federal'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitComando-Federal','Doors-Federal' },
    },
    
    ['SubComando-Federal'] = {
        inventario = { nome = "SubComando Federal", imagem = "policia", posicao = 999 },
        perms = { 'SubComando-Federal','Federal','Police','SubComando-Policia','Doors-Federal' },
    },
    
    ['waitSubComando-Federal'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitSubComando-Federal','Doors-Federal' },
    },
    
    ['Federal'] = {
        inventario = { nome = "Policia Federal", imagem = "policia", posicao = 999 },
        perms = { 'Federal','Police','Doors-Federal' },
    },
    
    ['waitFederal'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitFederal','Doors-Federal' },
    },

    ['Doors-Federal'] = {
        inventario = { nome = "Doors-Federal", imagem = "policia", posicao = 999 },
        perms = { 'Doors-Federal' },
    },

    ------------------------------
    -- [ Militar ]
    ------------------------------

    ['Comando-Militar'] = {
        inventario = { nome = "Comando Militar", imagem = "policia", posicao = 999 },
        perms = { 'Comando-Militar','SubComando-Militar','Militar','Police','Comando-Policia' },
    },
    
    ['waitComando-Militar'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitComando-Militar' },
    },
    
    ['SubComando-Militar'] = {
        inventario = { nome = "SubComando Militar", imagem = "policia", posicao = 999 },
        perms = { 'SubComando-Militar','Militar','Police','SubComando-Policia' },
    },
    
    ['waitSubComando-Militar'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitSubComando-Militar' },
    },
    
    ['Militar'] = {
        inventario = { nome = "Policia Militar", imagem = "policia", posicao = 999 },
        perms = { 'Militar','Police' },
    },
    
    ['waitMilitar'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitMilitar' },
    },

    ------------------------------
    -- [ Core ]
    ------------------------------

    ['Comando-Core'] = {
        inventario = { nome = "Comando Core", imagem = "policia", posicao = 999 },
        perms = { 'Comando-Core','SubComando-Core','Core','Police','Comando-Policia' },
    },
    
    ['waitComando-Core'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitComando-Core' },
    },
    
    ['SubComando-Core'] = {
        inventario = { nome = "SubComando Core", imagem = "policia", posicao = 999 },
        perms = { 'SubComando-Core','Core','Police','SubComando-Policia' },
    },
    
    ['waitSubComando-Core'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitSubComando-Core' },
    },
    
    ['Core'] = {
        inventario = { nome = "Policia Core", imagem = "policia", posicao = 999 },
        perms = { 'Core','Police' },
    },
    
    ['waitCore'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitCore' },
    },

    ------------------------------
    -- [ GTM ]
    ------------------------------

    ['Comando-GTM'] = {
        inventario = { nome = "Comando GTM", imagem = "policia", posicao = 999 },
        perms = { 'Comando-GTM','SubComando-GTM','GTM','Police','Comando-Policia' },
    },
    
    ['waitComando-GTM'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitComando-GTM' },
    },
    
    ['SubComando-GTM'] = {
        inventario = { nome = "SubComando GTM", imagem = "policia", posicao = 999 },
        perms = { 'SubComando-GTM','GTM','Police','SubComando-Policia' },
    },
    
    ['waitSubComando-GTM'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitSubComando-GTM' },
    },

    ['GTM'] = {
        inventario = { nome = "Policia GTM", imagem = "policia", posicao = 999 },
        perms = { 'GTM','Police' },
    },
    
    ['waitGTM'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitGTM' },
    },

    ------------------------------
    -- [ GSA ]
    ------------------------------

    ['Comando-GSA'] = {
        inventario = { nome = "Comando GSA", imagem = "policia", posicao = 999 },
        perms = { 'Comando-GSA','SubComando-GSA','GSA','Police','Comando-Policia' },
    },
    
    ['waitComando-GSA'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitComando-GSA' },
    },
    
    ['SubComando-GSA'] = {
        inventario = { nome = "SubComando GSA", imagem = "policia", posicao = 999 },
        perms = { 'SubComando-GSA','GSA','Police','SubComando-Policia' },
    },
    
    ['waitSubComando-GSA'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitSubComando-GSA' },
    },
    
    ['GSA'] = {
        inventario = { nome = "Policia GSA", imagem = "policia", posicao = 999 },
        perms = { 'GSA','Police' },
    },
    
    ['waitGSA'] = {
        inventario = { nome = "Fora de Serviço", imagem = "policia", posicao = 999 },
        perms = { 'waitGSA' },
    },

    ------------------------------
    -- [ Flamingo ]
    ------------------------------


    ['Chefe-Flamingo'] = {
        inventario = { nome = "Chefe Flamingo", imagem = "Flamingo", posicao = 999 },
        perms = { 'Chefe-Flamingo','Gerente-Flamingo','Flamingo','Doors-Flamingo' },
    },

    ['waitChefe-Flamingo'] = {
        inventario = { nome = "Fora de Serviço", imagem = "Flamingo", posicao = 999 },
        perms = { 'waitChefe-Flamingo','Doors-Flamingo' },
    },

    ['Gerente-Flamingo'] = {
        inventario = { nome = "Gerente Flamingo", imagem = "Flamingo", posicao = 999 },
        perms = { 'Gerente-Flamingo','Flamingo','Doors-Flamingo' },
    },

    ['waitGerente-Flamingo'] = {
        inventario = { nome = "Fora de Serviço", imagem = "Flamingo", posicao = 999 },
        perms = { 'waitGerente-Flamingo','Doors-Flamingo' },
    },

    ['Flamingo'] = {
        inventario = { nome = "Flamingo", imagem = "Flamingo", posicao = 999 },
        perms = { 'Flamingo','Doors-Flamingo' },
    },

    ['waitFlamingo'] = {
        inventario = { nome = "Fora de Serviço", imagem = "Flamingo", posicao = 999 },
        perms = { 'waitFlamingo','Doors-Flamingo' },
    },

    ['Doors-Flamingo'] = {
        inventario = { nome = "Doors-Flamingo", imagem = "Flamingo", posicao = 999 },
        perms = { 'Doors-Flamingo' },
    },
    
    ------------------------------
    -- [ CAFE ]
    ------------------------------

    ['Chefe-Cafe'] = {
        inventario = { nome = "Chefe Cafe", imagem = "cafe", posicao = 999 },
        perms = { 'Chefe-Cafe','Gerente-Cafe','Cafe','Doors-Cafe' },
    },

    ['waitChefe-Cafe'] = {
        inventario = { nome = "Fora de Serviço", imagem = "cafe", posicao = 999 },
        perms = { 'waitChefe-Cafe','Doors-Cafe' },
    },

    ['Gerente-Cafe'] = {
        inventario = { nome = "Gerente Cafe", imagem = "cafe", posicao = 999 },
        perms = { 'Gerente-Cafe','Cafe','Doors-Cafe' },
    },

    ['waitGerente-Cafe'] = {
        inventario = { nome = "Fora de Serviço", imagem = "cafe", posicao = 999 },
        perms = { 'waitGerente-Cafe','Doors-Cafe' },
    },

    ['Cafe'] = {
        inventario = { nome = "Cafe", imagem = "cafe", posicao = 999 },
        perms = { 'Cafe','Doors-Cafe' },
    },

    ['waitCafe'] = {
        inventario = { nome = "Fora de Serviço", imagem = "cafe", posicao = 999 },
        perms = { 'waitCafe','Doors-Cafe' },
    },

    ['Doors-Cafe'] = {
        inventario = { nome = "Doors-Cafe", imagem = "cafe", posicao = 999 },
        perms = { 'Doors-Cafe' },
    },

    ------------------------------
    -- [ MECANICA OVERSPEED ]
    ------------------------------

    ['Chefe-OverSpeed'] = {
        inventario = { nome = "Chefe OverSpeed", imagem = "OverSpeed", posicao = 999 },
        perms = { 'Chefe-OverSpeed','Gerente-OverSpeed','OverSpeed','Doors-OverSpeed','NaoGastarKit-Mecanica' },
    },

    ['waitChefe-OverSpeed'] = {
        inventario = { nome = "Fora de Serviço", imagem = "OverSpeed", posicao = 999 },
        perms = { 'waitChefe-OverSpeed','Doors-OverSpeed' },
    },

    ['Gerente-OverSpeed'] = {
        inventario = { nome = "Gerente OverSpeed", imagem = "OverSpeed", posicao = 999 },
        perms = { 'Gerente-OverSpeed','OverSpeed','Doors-OverSpeed','NaoGastarKit-Mecanica' },
    },

    ['waitGerente-OverSpeed'] = {
        inventario = { nome = "Fora de Serviço", imagem = "OverSpeed", posicao = 999 },
        perms = { 'waitGerente-OverSpeed','Doors-OverSpeed' },
    },

    ['OverSpeed'] = {
        inventario = { nome = "OverSpeed", imagem = "OverSpeed", posicao = 999 },
        perms = { 'OverSpeed','Doors-OverSpeed','NaoGastarKit-Mecanica' },
    },

    ['waitOverSpeed'] = {
        inventario = { nome = "Fora de Serviço", imagem = "OverSpeed", posicao = 999 },
        perms = { 'waitOverSpeed','Doors-OverSpeed' },
    },

    ['Doors-OverSpeed'] = {
        inventario = { nome = "Doors-OverSpeed", imagem = "OverSpeed", posicao = 999 },
        perms = { 'Doors-OverSpeed' },
    },

    ------------------------------
    -- [ MECANICA STOPCAR ]
    ------------------------------

    ['Chefe-StopCar'] = {
        inventario = { nome = "Chefe StopCar", imagem = "StopCar", posicao = 999 },
        perms = { 'Chefe-StopCar','Gerente-StopCar','StopCar','Doors-StopCar','NaoGastarKit-Mecanica' },
    },

    ['waitChefe-StopCar'] = {
        inventario = { nome = "Fora de Serviço", imagem = "StopCar", posicao = 999 },
        perms = { 'waitChefe-StopCar','Doors-StopCar' },
    },

    ['Gerente-StopCar'] = {
        inventario = { nome = "Gerente StopCar", imagem = "StopCar", posicao = 999 },
        perms = { 'Gerente-StopCar','StopCar','Doors-StopCar','NaoGastarKit-Mecanica' },
    },

    ['waitGerente-StopCar'] = {
        inventario = { nome = "Fora de Serviço", imagem = "StopCar", posicao = 999 },
        perms = { 'waitGerente-StopCar','Doors-StopCar' },
    },

    ['StopCar'] = {
        inventario = { nome = "StopCar", imagem = "StopCar", posicao = 999 },
        perms = { 'StopCar','Doors-StopCar','NaoGastarKit-Mecanica' },
    },

    ['waitStopCar'] = {
        inventario = { nome = "Fora de Serviço", imagem = "StopCar", posicao = 999 },
        perms = { 'waitStopCar','Doors-StopCar' },
    },

    ['Doors-StopCar'] = {
        inventario = { nome = "Doors-StopCar", imagem = "StopCar", posicao = 999 },
        perms = { 'Doors-StopCar' },
    },

    ------------------------------
    -- [ MECANICA ALL ]
    ------------------------------

    ['NaoGastarKit-Mecanica'] = {
        inventario = { nome = "NaoGastarKit-Mecanica", imagem = "Mecanica", posicao = 999 },
        perms = { 'NaoGastarKit-Mecanica' },
    },

    -- [ OUTROS ]

    ['Verificado'] = {
        inventario = { nome = "Verificado", imagem = "verificado", posicao = 999 },
        perms = { 'Verificado' },
    },
    
    ['Spotify'] = {
        inventario = { nome = "Spotify", imagem = "spotify", posicao = 999 },
        perms = { 'Spotify' },
    },

    ['Camera'] = {
        inventario = { nome = "Camera", imagem = "camera", posicao = 999 },
        perms = { 'Camera' },
    },

    ['Attachs'] = {
        inventario = { nome = "Attachs", imagem = "attachs", posicao = 999 },
        perms = { 'Attachs' },
    },

    ['Booster'] = {
        inventario = { nome = "Booster", imagem = "vooster", posicao = 999 },
        perms = { 'Booster','Spotify','CorArmas' },
    },

    ['CorArmas'] = {
        inventario = { nome = "CorArmas", imagem = "vooster", posicao = 999 },
        perms = { 'CorArmas' },
    },

    ['Influencer'] = {
        inventario = { nome = "Influencer", imagem = "influencer", posicao = 999 },
        perms = { 'Influencer','Camera','ItemRoupas','Spotify' },
    },

    ['Tiktok'] = {
        inventario = { nome = "Tiktok", imagem = "Tiktok", posicao = 999 },
        perms = { 'Tiktok','Camera','ItemRoupas','Spotify' },
    },

    ['Streamer'] = {
        inventario = { nome = "Streamer", imagem = "Streamer", posicao = 999 },
        perms = { 'Streamer','Spotify','Camera','ItemRoupas' },
    },

    ['CorArma'] = {
        inventario = { nome = "CorArma", imagem = "corarma", posicao = 999 },
        perms = { 'CorArma' },
    },

    ['ItemRoupas'] = {
        inventario = { nome = "ItemRoupas", imagem = "Roupas", posicao = 999 },
        perms = { 'ItemRoupas' },
    },

    ['AcessoRoupas'] = {
        inventario = { nome = "Roupas", imagem = "Roupas", posicao = 999 },
        perms = { 'AcessoRoupas' },
    },

    ------------------------------
    -- [ ILEGAL ]
    ------------------------------

    ['Lider-Barragem'] = {
        inventario = { nome = "Lider Barragem", imagem = "fac", posicao = 999 },
        perms = { 'Lider-Barragem','Gerente-Barragem','Barragem' },
    },

    ['Gerente-Barragem'] = {
        inventario = { nome = "Gerente Barragem", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-Barragem','Barragem' },
    },

    ['Barragem'] = {
        inventario = { nome = "Barragem", imagem = "fac", posicao = 999 },
        perms = { 'Barragem' },
    },    

    ----------------

    ['Lider-Beiramar'] = {
        inventario = { nome = "Lider Beiramar", imagem = "fac", posicao = 999 },
        perms = { 'Lider-Beiramar','Gerente-Beiramar','Beiramar' },
    },

    ['Gerente-Beiramar'] = {
        inventario = { nome = "Gerente Beiramar", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-Beiramar','Beiramar' },
    },

    ['Beiramar'] = {
        inventario = { nome = "Beiramar", imagem = "fac", posicao = 999 },
        perms = { 'Beiramar' },
    },   
    
    ----------------

    ['Lider-Antena'] = {
        inventario = { nome = "Lider Antena", imagem = "fac", posicao = 999 },
        perms = { 'Lider-Antena','Gerente-Antena','Antena' },
    },

    ['Gerente-Antena'] = {
        inventario = { nome = "Gerente Antena", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-Antena','Antena' },
    },

    ['Antena'] = {
        inventario = { nome = "Antena", imagem = "fac", posicao = 999 },
        perms = { 'Antena' },
    },    

    ----------------

    ['Lider-Farol'] = {
        inventario = { nome = "Lider Farol", imagem = "fac", posicao = 999 },
        perms = { 'Lider-Farol','Gerente-Farol','Farol' },
    },

    ['Gerente-Farol'] = {
        inventario = { nome = "Gerente Farol", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-Farol','Farol' },
    },

    ['Farol'] = {
        inventario = { nome = "Farol", imagem = "fac", posicao = 999 },
        perms = { 'Farol' },
    },   

    ----------------

    ['Lider-Club77'] = {
        inventario = { nome = "Lider Club77", imagem = "fac", posicao = 999 },
        perms = { 'Lider-Club77','Gerente-Club77','Club77' },
    },

    ['Gerente-Club77'] = {
        inventario = { nome = "Gerente Club77", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-Club77','Club77' },
    },

    ['Club77'] = {
        inventario = { nome = "Club77", imagem = "fac", posicao = 999 },
        perms = { 'Club77' },
    },   

        ----------------

    ['Lider-Enigma'] = {
        inventario = { nome = "Lider Enigma", imagem = "fac", posicao = 999 },
        perms = { 'Lider-Enigma','Gerente-Enigma','Enigma' },
    },

    ['Gerente-Enigma'] = {
        inventario = { nome = "Gerente Enigma", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-Enigma','Enigma' },
    },

    ['Enigma'] = {
        inventario = { nome = "Enigma", imagem = "fac", posicao = 999 },
        perms = { 'Enigma' },
    },   

     ----------------

    ['Lider-Praia'] = {
        inventario = { nome = "Lider Praia", imagem = "fac", posicao = 999 },
        perms = { 'Lider-Praia','Gerente-Praia','Praia' },
    },

    ['Gerente-Praia'] = {
        inventario = { nome = "Gerente Praia", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-Praia','Praia' },
    },

    ['Praia'] = {
        inventario = { nome = "Praia", imagem = "fac", posicao = 999 },
        perms = { 'Praia' },
    },   

    ----------------

    ['Lider-Mineradora'] = {
        inventario = { nome = "Lider Mineradora", imagem = "fac", posicao = 999 },
        perms = { 'Lider-Mineradora','Gerente-Mineradora','Mineradora' },
    },

    ['Gerente-Mineradora'] = {
        inventario = { nome = "Gerente Mineradora", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-Mineradora','Mineradora' },
    },

    ['Mineradora'] = {
        inventario = { nome = "Mineradora", imagem = "fac", posicao = 999 },
        perms = { 'Mineradora' },
    },   


    ----------------

    ['Lider-Vanilla'] = {
        inventario = { nome = "Lider Vanilla", imagem = "fac", posicao = 999 },
        perms = { 'Lider-Vanilla','Gerente-Vanilla','Vanilla' },
    },

    ['Gerente-Vanilla'] = {
        inventario = { nome = "Gerente Vanilla", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-Vanilla','Vanilla' },
    },

    ['Vanilla'] = {
        inventario = { nome = "Vanilla", imagem = "fac", posicao = 999 },
        perms = { 'Vanilla' },
    },  

   ----------------

   ['Lider-MansaoWL'] = {
        inventario = { nome = "Lider MansaoWL", imagem = "fac", posicao = 999 },
        perms = { 'Lider-MansaoWL','Gerente-MansaoWL','MansaoWL' },
    },

    ['Gerente-MansaoWL'] = {
        inventario = { nome = "Gerente MansaoWL", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-MansaoWL','MansaoWL' },
    },

    ['MansaoWL'] = {
        inventario = { nome = "MansaoWL", imagem = "fac", posicao = 999 },
        perms = { 'MansaoWL' },
    },  

       ----------------

    ['Lider-MansaoN'] = {
        inventario = { nome = "Lider MansaoN", imagem = "fac", posicao = 999 },
        perms = { 'Lider-MansaoN','Gerente-MansaoN','MansaoN' },
    },

    ['Gerente-MansaoN'] = {
        inventario = { nome = "Gerente MansaoN", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-MansaoN','MansaoN' },
    },

    ['MansaoN'] = {
        inventario = { nome = "MansaoN", imagem = "fac", posicao = 999 },
        perms = { 'MansaoN' },
    },  



        ----------------

    ['Lider-Armas3'] = {
        inventario = { nome = "Lider Armas3", imagem = "fac", posicao = 999 },
        perms = { 'Lider-Armas3','Gerente-Armas3','Armas3' },
    },

    ['Gerente-Armas3'] = {
        inventario = { nome = "Gerente Armas3", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-Armas3','Armas3' },
    },

    ['Armas3'] = {
        inventario = { nome = "Armas3", imagem = "fac", posicao = 999 },
        perms = { 'Armas3' },
    }, 

    ----------------

    ['Lider-Municao1'] = {
        inventario = { nome = "Lider Municao1", imagem = "fac", posicao = 999 },
        perms = { 'Lider-Municao1','Gerente-Municao1','Municao1' },
    },

    ['Gerente-Municao1'] = {
        inventario = { nome = "Gerente Municao1", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-Municao1','Municao1' },
    },

    ['Municao1'] = {
        inventario = { nome = "Municao1", imagem = "fac", posicao = 999 },
        perms = { 'Municao1' },
    },   

    ----------------

    ['Lider-Municao2'] = {
        inventario = { nome = "Lider Municao2", imagem = "fac", posicao = 999 },
        perms = { 'Lider-Municao2','Gerente-Municao2','Municao2' },
    },

    ['Gerente-Municao2'] = {
        inventario = { nome = "Gerente Municao2", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-Municao2','Municao2' },
    },

    ['Municao2'] = {
        inventario = { nome = "Municao2", imagem = "fac", posicao = 999 },
        perms = { 'Municao2' },
    },   

    
    ['Lider-Municao3'] = {
        inventario = { nome = "Lider Municao3", imagem = "fac", posicao = 999 },
        perms = { 'Lider-Municao3','Gerente-Municao3','Municao3' },
    },

    ['Gerente-Municao3'] = {
        inventario = { nome = "Gerente Municao3", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-Municao3','Municao3' },
    },

    ['Municao3'] = {
        inventario = { nome = "Municao3", imagem = "fac", posicao = 999 },
        perms = { 'Municao3' },
    },   

    ------------------------------
    -- [ VIPS ]
    ------------------------------

    ['VipPrata'] = { -- PREÇO MEDIO DEVE SER DE ( 39,90 R$ )
        inventario = { nome = "Vip Prata", imagem = "vipprata", posicao = 999 },
        perms = { 'VipPata','Spotify' },
        vip_settings = { 
            dias = 30, -- [ QUANTOS DIAS O VIP VAI DURAR ]
            gemas = 50, -- [ QUANTAS GEMAS O PLAYER VAI GANHAR ]
            dinheiro_ativacao = 50000, -- [ QUANTO DINHEIRO DE ATIVACAO O PLAYER VAI GANHAR ]
            mochila = true, -- [ PERDER MOCHILA AO MORRER true = sim, false = nao ]
            prioridade = 20, -- [ % DE QUANTO PRIORIDADE O PLAYER VAI TER NA FILA ]
        },
    },

    ['VipOuro'] = { -- PREÇO MEDIO DEVE SER DE ( 69,90 R$ )
        inventario = { nome = "Vip Ouro", imagem = "vipouro", posicao = 999 },
        perms = { 'VipOuro','Spotify','Verificado','Camera' },
        vip_settings = { 
            dias = 30, -- [ QUANTOS DIAS O VIP VAI DURAR ]
            gemas = 100, -- [ QUANTAS GEMAS O PLAYER VAI GANHAR ]
            dinheiro_ativacao = 100000, -- [ QUANTO DINHEIRO DE ATIVACAO O PLAYER VAI GANHAR ]
            mochila = true, -- [ PERDER MOCHILA AO MORRER true = sim, false = nao ]
            prioridade = 20, -- [ % DE QUANTO PRIORIDADE O PLAYER VAI TER NA FILA ]
        },
    },

    ['VipRuby'] = { -- PREÇO MEDIO DEVE SER DE ( 139,90 R$ )
        inventario = { nome = "Vip Ruby", imagem = "vipruby", posicao = 999 },
        perms = { 'VipRuby','Verificado','Spotify','ItemRoupas','Camera' },
        vip_settings = { 
            dias = 30, -- [ QUANTOS DIAS O VIP VAI DURAR ]
            gemas = 150, -- [ QUANTAS GEMAS O PLAYER VAI GANHAR ]
            dinheiro_ativacao = 150000, -- [ QUANTO DINHEIRO DE ATIVACAO O PLAYER VAI GANHAR ]
            mochila = true, -- [ PERDER MOCHILA AO MORRER true = sim, false = nao ]
            prioridade = 50, -- [ % DE QUANTO PRIORIDADE O PLAYER VAI TER NA FILA ]
            itens = { -- [ LISTA DE ITENS QUE O VIP IRA GANHAR ]
                [1] = { item = "chip", quantidade = 1 },
                [2] = { item = "premiumplate", quantidade = 1 },
            },
        },
    },

    ['VipEsmeralda'] = { -- PREÇO MEDIO DEVE SER DE ( 249,90 R$ )
        inventario = { nome = "Vip Esmeralda", imagem = "vipdiamond", posicao = 999 },
        perms = { 'VipEsmeralda','Verificado','Spotify','Camera','ItemRoupas' },
        vip_settings = { 
            dias = 30, -- [ QUANTOS DIAS O VIP VAI DURAR ]
            gemas = 300, -- [ QUANTAS GEMAS O PLAYER VAI GANHAR ]
            dinheiro_ativacao = 200000, -- [ QUANTO DINHEIRO DE ATIVACAO O PLAYER VAI GANHAR ]
            mochila = true, -- [ PERDER MOCHILA AO MORRER true = sim, false = nao ]
            prioridade = 50, -- [ % DE QUANTO PRIORIDADE O PLAYER VAI TER NA FILA ]
            itens = { -- [ LISTA DE ITENS QUE O VIP IRA GANHAR ]
                [1] = { item = "chip", quantidade = 1 },
                [2] = { item = "premiumplate", quantidade = 2 },
            },
        },
    },

    ['VipDiamante'] = { -- PREÇO MEDIO DEVE SER DE ( 379,90 R$ )
        inventario = { nome = "Vip Diamante", imagem = "VipDiamante", posicao = 999 },
        perms = { 'VipDiamante','Camera','ItemRoupas','AcessoRoupas' },
        perms_Permanentes = { 'Spotify','Verificado' },
        vip_settings = { 
            dias = 60, -- [ QUANTOS DIAS O VIP VAI DURAR ]
            gemas = 600, -- [ QUANTAS GEMAS O PLAYER VAI GANHAR ]
            dinheiro_ativacao = 300000, -- [ QUANTO DINHEIRO DE ATIVACAO O PLAYER VAI GANHAR ]
            mochila = true, -- [ PERDER MOCHILA AO MORRER true = sim, false = nao ]
            prioridade = 70, -- [ % DE QUANTO PRIORIDADE O PLAYER VAI TER NA FILA ]
            itens = { -- [ LISTA DE ITENS QUE O VIP IRA GANHAR ]
                [1] = { item = "chip", quantidade = 1 },
                [2] = { item = "premiumplate", quantidade = 5 },
            },
        },
    },

    ['VipMaui'] = { -- PREÇO MEDIO DEVE SER DE ( 379,90 R$ )
        inventario = { nome = "Vip Maui", imagem = "VipMaui", posicao = 999 },
        perms = { 'VipMaui','Camera','ItemRoupas','Spotify','Verificado','AcessoRoupas' },
        vip_settings = { 
            dias = 9999, -- [ QUANTOS DIAS O VIP VAI DURAR ]
            gemas = 1300, -- [ QUANTAS GEMAS O PLAYER VAI GANHAR ]
            dinheiro_ativacao = 500000, -- [ QUANTO DINHEIRO DE ATIVACAO O PLAYER VAI GANHAR ]
            mochila = true, -- [ PERDER MOCHILA AO MORRER true = sim, false = nao ]
            prioridade = 100, -- [ % DE QUANTO PRIORIDADE O PLAYER VAI TER NA FILA ]
            itens = { -- [ LISTA DE ITENS QUE O VIP IRA GANHAR ]
                [1] = { item = "chip", quantidade = 5 },
                [2] = { item = "premiumplate", quantidade = 10 },
            },
        },
    },

    ['VipKids'] = { -- PREÇO MEDIO DEVE SER DE ( 379,90 R$ )
        inventario = { nome = "Vip Kids", imagem = "VipKids", posicao = 999 },
        perms = { 'VipKids','Camera','Spotify','Verificado' },
        vip_settings = { 
            dias = 30, -- [ QUANTOS DIAS O VIP VAI DURAR ]
            gemas = 100, -- [ QUANTAS GEMAS O PLAYER VAI GANHAR ]
            dinheiro_ativacao = 60000, -- [ QUANTO DINHEIRO DE ATIVACAO O PLAYER VAI GANHAR ]
            mochila = true, -- [ PERDER MOCHILA AO MORRER true = sim, false = nao ]
            prioridade = 30, -- [ % DE QUANTO PRIORIDADE O PLAYER VAI TER NA FILA ]
            itens = { -- [ LISTA DE ITENS QUE O VIP IRA GANHAR ]
                [1] = { item = "chip", quantidade = 1 },
                [2] = { item = "premiumplate", quantidade = 2 },
            },
        },
    },

    ['VipKidsDeluxe'] = { -- PREÇO MEDIO DEVE SER DE ( 379,90 R$ )
        inventario = { nome = "Vip Deluxe", imagem = "VipMaui", posicao = 999 },
        perms = { 'VipKidsDeluxe','Camera','Spotify','Verificado','AcessoRoupas' },
        vip_settings = { 
            dias = 9999, -- [ QUANTOS DIAS O VIP VAI DURAR ]
            gemas = 200, -- [ QUANTAS GEMAS O PLAYER VAI GANHAR ]
            dinheiro_ativacao = 100000, -- [ QUANTO DINHEIRO DE ATIVACAO O PLAYER VAI GANHAR ]
            mochila = true, -- [ PERDER MOCHILA AO MORRER true = sim, false = nao ]
            prioridade = 70, -- [ % DE QUANTO PRIORIDADE O PLAYER VAI TER NA FILA ]
            itens = { -- [ LISTA DE ITENS QUE O VIP IRA GANHAR ]
                [1] = { item = "chip", quantidade = 1 },
                [2] = { item = "premiumplate", quantidade = 3 },
            },
        },
    },


    -----------------------------------------------------------------------------------------------------
    --------------------------------------- [ Jornal ] --------------------------------------------------
    -----------------------------------------------------------------------------------------------------

    ['Chefe-Jornal'] = {
        inventario = { nome = "Chefe Jornal", imagem = "Jornal", posicao = 999 },
        perms = { 'Chefe-Jornal','Gerente-Jornal','Jornal' },
    },

    ['Gerente-Jornal'] = {
        inventario = { nome = "Gerente Jornal", imagem = "Jornal", posicao = 999 },
        perms = { 'Gerente-Jornal','Jornal' },
    },

    ['Jornal'] = {
        inventario = { nome = "Jornal", imagem = "Jornal", posicao = 999 },
        perms = { 'Jornal' },
    },


    -----------------------------------------------------------------------------------------------------
    --------------------------------------- [ Sushi-Bar ] -----------------------------------------------
    -----------------------------------------------------------------------------------------------------

    ['Chefe-SushiBar'] = {
        inventario = { nome = "Chefe SushiBar", imagem = "SushiBar", posicao = 999 },
        perms = { 'Chefe-SushiBar','Gerente-SushiBar','SushiBar','Doors-SushiBar' },
    },

    ['waitChefe-SushiBar'] = {
        inventario = { nome = "Fora de Serviço", imagem = "SushiBar", posicao = 999 },
        perms = { 'waitChefe-SushiBar','Doors-SushiBar' },
    },

    ['Gerente-SushiBar'] = {
        inventario = { nome = "Gerente SushiBar", imagem = "SushiBar", posicao = 999 },
        perms = { 'Gerente-SushiBar','SushiBar','Doors-SushiBar' },
    },

    ['waitGerente-SushiBar'] = {
        inventario = { nome = "Fora de Serviço", imagem = "SushiBar", posicao = 999 },
        perms = { 'waitGerente-SushiBar','Doors-SushiBar' },
    },

    ['SushiBar'] = {
        inventario = { nome = "SushiBar", imagem = "SushiBar", posicao = 999 },
        perms = { 'SushiBar','Doors-SushiBar','NaoGastarKit-Mecanica' },
    },

    ['waitSushiBar'] = {
        inventario = { nome = "Fora de Serviço", imagem = "SushiBar", posicao = 999 },
        perms = { 'waitSushiBar','Doors-SushiBar' },
    },

    ['Doors-SushiBar'] = {
        inventario = { nome = "Doors-SushiBar", imagem = "SushiBar", posicao = 999 },
        perms = { 'Doors-SushiBar' },
    },

    -----------------------------------------------------------------------------------------------------
    --------------------------------------- [ BAHAMAS ] -------------------------------------------------
    -----------------------------------------------------------------------------------------------------

    ['Lider-Bahamas'] = {
        inventario = { nome = "Lider Bahamas", imagem = "fac", posicao = 999 },
        perms = { 'Lider-Bahamas','Gerente-Bahamas','Bahamas' },
    },

    ['Gerente-Bahamas'] = {
        inventario = { nome = "Gerente Bahamas", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-Bahamas','Bahamas' },
    },

    ['Bahamas'] = {
        inventario = { nome = "Bahamas", imagem = "fac", posicao = 999 },
        perms = { 'Bahamas' },
    }, 

    ['Lider-Pista1'] = {
        inventario = { nome = "Lider Pista1", imagem = "fac", posicao = 999 },
        perms = { 'Lider-Pista1','Gerente-Pista1','Pista1' },
    },

    ['Gerente-Pista1'] = {
        inventario = { nome = "Gerente Pista1", imagem = "fac", posicao = 999 },
        perms = { 'Gerente-Pista1','Pista1' },
    },

    ['Pista1'] = {
        inventario = { nome = "Pista1", imagem = "fac", posicao = 999 },
        perms = { 'Pista1' },
    }, 

}

return Config