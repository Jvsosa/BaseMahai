-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {

	----------------------------------
	-- [ Util ]
	----------------------------------

	["pazul"] = { ["index"] = "pazul", ["name"] = "Post-It Azul", ["type"] = "Usável", ["weight"] = 0.05 },
	["pazulclaro"] = { ["index"] = "pazulclaro", ["name"] = "Post-It Azul Claro", ["type"] = "Usável", ["weight"] = 0.05 },
	["pbranco"] = { ["index"] = "pbranco", ["name"] = "Post-It Branco", ["type"] = "Usável", ["weight"] = 0.05 },
	["pciano"] = { ["index"] = "pciano", ["name"] = "Post-It Ciano", ["type"] = "Usável", ["weight"] = 0.05 },
	["pcinza"] = { ["index"] = "pcinza", ["name"] = "Post-It Cinza", ["type"] = "Usável", ["weight"] = 0.05 },
	["pcoral"] = { ["index"] = "pcoral", ["name"] = "Post-It Coral", ["type"] = "Usável", ["weight"] = 0.05 },
	["plaranja"] = { ["index"] = "plaranja", ["name"] = "Post-It Laranja", ["type"] = "Usável", ["weight"] = 0.05 },
	["ppreto"] = { ["index"] = "ppreto", ["name"] = "Post-It Preto", ["type"] = "Usável", ["weight"] = 0.05 },
	["prosa"] = { ["index"] = "prosa", ["name"] = "Post-It Rosa", ["type"] = "Usável", ["weight"] = 0.05 },
	["prosabebe"] = { ["index"] = "prosabebe", ["name"] = "Post-It Rosa bebe", ["type"] = "Usável", ["weight"] = 0.05 },
	["prosachoque"] = { ["index"] = "prosachoque", ["name"] = "Post-It Rosa Choque", ["type"] = "Usável", ["weight"] = 0.05 },
	["proxo"] = { ["index"] = "proxo", ["name"] = "Post-It Roxo", ["type"] = "Usável", ["weight"] = 0.05 },
	["proxo2"] = { ["index"] = "proxo2", ["name"] = "Post-It Roxo 2", ["type"] = "Usável", ["weight"] = 0.05 },
	["pverde"] = { ["index"] = "pverde", ["name"] = "Post-It Verde", ["type"] = "Usável", ["weight"] = 0.05 },
	["pvermelho"] = { ["index"] = "pvermelho", ["name"] = "Post-It Vermelho", ["type"] = "Usável", ["weight"] = 0.05 },

	["cardapio"] = { ["index"] = "cardapio", ["name"] = "Cardapio UwU", ["type"] = "Usável", ["weight"] = 0.05 },

	["backpack"] = { ["index"] = "backpack", ["name"] = "Mochila", ["desc"] = "Utilizada para aumentar inventario.", ["type"] = "Usável", ["weight"] = 0.50 },
	["cellphone"] = { ["index"] = "cellphone", ["name"] = "Celular", ["type"] = "Usável", ["weight"] = 0.75 },
	["binoculars"] = { ["index"] = "binoculars", ["name"] = "Binóculos", ["type"] = "Usável", ["weight"] = 0.75 },
	["camera"] = { ["index"] = "camera", ["name"] = "Câmera", ["type"] = "Usável", ["weight"] = 0.25 },
	["rose"] = { ["index"] = "rose", ["name"] = "Rosa", ["type"] = "Usável", ["weight"] = 0.15 },
	["vape"] = { ["index"] = "vape", ["name"] = "Vape", ["type"] = "Usável", ["durability"] = 7, ["weight"] = 0.75 },
	["radio"] = { ["index"] = "radio", ["name"] = "Rádio", ["type"] = "Usável", ["weight"] = 0.75 },
	["fidentity"] = { ["index"] = "identity", ["name"] = "Passaporte", ["type"] = "Usável", ["weight"] = 0.10 },
	["identity"] = { ["index"] = "identity", ["name"] = "Passaporte", ["type"] = "Usável", ["weight"] = 0.10 },
	["postit"] = { ["index"] = "postit", ["name"] = "Post-It", ["type"] = "Usável", ["weight"] = 0.05 },
	["firecracker"] = { ["index"] = "firecracker", ["name"] = "Fogos de Artificio", ["type"] = "Usável", ["weight"] = 1.25 },
	["dices"] = { ["index"] = "dices", ["name"] = "Dados", ["type"] = "Usável", ["weight"] = 0.25 },

 	["gsrkit"] = {["index"] = "gsrkit",["name"] = "Kit Residual",["type"] = "Usável",["weight"] = 0.75},
	["gdtkit"] = {["index"] = "gdtkit",["name"] = "Kit Químico",["type"] = "Usável",["weight"] = 0.75},
	["WEAPON_SMOKEGRENADE"] = {["index"] = "smokegrenade",["name"] = "Granada de Fumaça",["type"] = "Throwing",["vehicle"] = true,["weight"] = 0.50,["economy"] = 225,["max"] = 3},
	["WEAPON_STUNGRENADE"] = {["index"] = "smokegrenade",["name"] = "Granada de Stun",["type"] = "Throwing",["vehicle"] = true,["weight"] = 0.50,["economy"] = 225,["max"] = 3},

	["brick"] = {["index"] = "brick",["name"] = "Tijolo",["type"] = "Comum",["weight"] = 0.50},
	["campfire"] = { ["index"] = "campfire", ["name"] = "Fogueira", ["type"] = "Usável", ["weight"] = 1.00 },

	["vehkey"] = { ["index"] = "vehkey", ["name"] = "Chave Cópia", ["type"] = "Usável", ["weight"] = 0.75 },

	["divingsuit"] = {["index"] = "divingsuit",["name"] = "Roupa de Mergulho",["type"] = "Usável",["durability"] = 14,["weight"] = 4.75},

	["materialreciclavel"] = { ["index"] = "materialreciclavel", ["name"] = "Material Reciclavel", ["type"] = "Usável", ["weight"] = 0.15 },

	["alvejante"] = { ["index"] = "alvejante", ["name"] = "Alvejante", ["type"] = "Usável", ["weight"] = 0.15 },
	["bahamas1"] = { ["index"] = "bahamas1", ["name"] = "Bahamas VIP", ["type"] = "Usável", ["weight"] = 1 },
	["bahamas2"] = { ["index"] = "bahamas2", ["name"] = "Bahamas Festa", ["type"] = "Usável", ["weight"] = 1 },

	["tomato"] = { ["index"] = "tomato", ["name"] = "Tomate", ["type"] = "Usável", ["weight"] = 0.15 },
	["banana"] = { ["index"] = "banana", ["name"] = "Banana", ["type"] = "Usável", ["weight"] = 0.25 },
	["passion"] = { ["index"] = "passion", ["name"] = "Maracujá", ["type"] = "Usável", ["weight"] = 0.25 },

	["grape"] = { ["index"] = "grape", ["name"] = "Uva", ["type"] = "Usável", ["weight"] = 0.15 },
	["tange"] = { ["index"] = "tange", ["name"] = "Tangerina", ["type"] = "Usável", ["weight"] = 0.25 },
	["apple"] = { ["index"] = "apple", ["name"] = "Maça", ["type"] = "Usável", ["weight"] = 0.25 },
	["orange"] = { ["index"] = "orange", ["name"] = "Laranja", ["type"] = "Usável", ["weight"] = 0.25 },
	["strawberry"] = { ["index"] = "strawberry", ["name"] = "Morango", ["type"] = "Usável", ["weight"] = 0.15 },
	["melancia2"] = { ["index"] = "melancia2", ["name"] = "Melancia", ["type"] = "Usável", ["weight"] = 0.15 },

	["frutas"] = { ["index"] = "frutas", ["name"] = "Frutas", ["type"] = "Usável", ["weight"] = 0.10 },
	----------------------------------
	-- [ Mecanico ]
	----------------------------------

	["toolbox"] = { ["index"] = "toolbox", ["name"] = "Ferrament as Básicas", ["type"] = "Usável", ["charges"] = 1, ["weight"] = 1.75 },
	["tyres"] = { ["index"] = "tyres", ["name"] = "Pneu", ["type"] = "Usável", ["weight"] = 4 },
	["advtoolbox"] = { ["index"] = "toolbox", ["name"] = "Ferramentas Avançadas", ["type"] = "Usável", ["weight"] = 2.25, ["charges"] = 4 },
	["nitro"] = { ["index"] = "nitro", ["name"] = "Nitro", ["type"] = "Usável", ["weight"] = 10.00 },

	----------------------------------
	-- [ Ilegal ]
	----------------------------------

	["vest"] = { ["index"] = "vest", ["name"] = "Colete", ["type"] = "Usável", ["durability"] = 3, ["weight"] = 5 },
	["rope"] = { ["index"] = "rope", ["name"] = "Cordas", ["type"] = "Usável", ["durability"] = 10, ["weight"] = 1.50 },
	["pager"] = { ["index"] = "pager", ["name"] = "Pager", ["type"] = "Usável", ["durability"] = 2, ["weight"] = 1.50 },
	["hood"] = { ["index"] = "hood", ["name"] = "Capuz", ["type"] = "Usável", ["durability"] = 15, ["weight"] = 1.50 },
	["ticket"] = { ["index"] = "ticket", ["name"] = "Ticket", ["type"] = "Usável", ["weight"] = 0.50 },
	["handcuff"] = { ["index"] = "handcuff", ["name"] = "Algemas", ["type"] = "Usável", ["durability"] = 7, ["weight"] = 0.75 },
	["plate"] = { ["index"] = "plate", ["name"] = "Placa", ["type"] = "Comum", ["weight"] = 0.50 },
	["notebook"] = { ["index"] = "notebook", ["name"] = "Notebook", ["type"] = "Usável", ["durability"] = 3, ["weight"] = 1.25 },
	["floppy"] = {["index"] = "floppy",["name"] = "Disquete",["type"] = "Comum",["weight"] = 0.15},
	["lockpick"] = { ["index"] = "lockpick", ["name"] = "Lockpick de Alumínio", ["desc"] = "Utilizada para roubar veículos.", ["type"] = "Usável", ["durability"] = 7, ["weight"] = 1.25 },
	["lockpick2"] = { ["index"] = "lockpick2", ["name"] = "Lockpick de Cobre", ["desc"] = "Utilizada para roubar propriedades.", ["type"] = "Usável", ["durability"] = 7, ["weight"] = 1.25 },
	["card01"] = { ["index"] = "card01", ["name"] = "Cartão Comum", ["desc"] = "Roubar Lojas de departamentStoreo.", ["type"] = "Comum", ["durability"] = 10, ["weight"] = 0.10 },
	["card02"] = { ["index"] = "card02", ["name"] = "Cartão In-Comum", ["desc"] = "Roubar Lojas de Armas.", ["type"] = "Comum", ["durability"] = 7, ["weight"] = 0.10 },
	["card03"] = { ["index"] = "card03", ["name"] = "Cartão Normal", ["desc"] = "Roubar Bancos Fleeca.", ["type"] = "Comum", ["durability"] = 7, ["weight"] = 0.10 },
	["card04"] = { ["index"] = "card04", ["name"] = "Cartão Raro", ["desc"] = "Roubar Barbearias.", ["type"] = "Comum", ["durability"] = 7, ["weight"] = 0.10 },
	["card05"] = { ["index"] = "card05", ["name"] = "Cartão Lendário", ["desc"] = "Roubar Bancos.", ["type"] = "Comum", ["durability"] = 7, ["weight"] = 0.10 },
	["attachsFlashlight"] = { ["index"] = "attachsFlashlight", ["name"] = "Lanterna Tatica", ["type"] = "Usável", ["weight"] = 0.75 },
	["attachsCrosshair"] = { ["index"] = "attachsCrosshair", ["name"] = "Mira Holográfica", ["type"] = "Usável", ["weight"] = 0.75 },
	["attachsSilencer"] = { ["index"] = "attachsSilencer", ["name"] = "Silenciador", ["type"] = "Usável", ["weight"] = 0.75 },
	["attachsGrip"] = { ["index"] = "attachsGrip", ["name"] = "Empunhadura", ["type"] = "Usável", ["weight"] = 0.75 },


	["aluminum"] = { ["index"] = "aluminum", ["name"] = "Aluminio", ["type"] = "Usável", ["weight"] = 0.10 },
	["copper"] = { ["index"] = "copper", ["name"] = "Cobre", ["type"] = "Usável", ["weight"] = 0.10 },
	["rubber"] = { ["index"] = "rubber", ["name"] = "Borracha", ["type"] = "Usável", ["weight"] = 0.10 },
	["plastic"] = { ["index"] = "plastic", ["name"] = "Plastico", ["type"] = "Usável", ["weight"] = 0.10 },
	["techtrash"] = { ["index"] = "techtrash", ["name"] = "Lixo Tecnológico", ["type"] = "Usável", ["weight"] = 0.65 },
	["glass"] = { ["index"] = "glass", ["name"] = "Vidro", ["type"] = "Usável", ["weight"] = 0.10 },
	["leather"] = { ["index"] = "leather", ["name"] = "Couro", ["type"] = "Usável", ["weight"] = 0.10 },
	["trap"] = { ["index"] = "trap", ["name"] = "Lona", ["type"] = "Usável", ["weight"] = 0.10 },
	["explosives"] = { ["index"] = "explosives", ["name"] = "Explosivos", ["type"] = "Usável", ["weight"] = 0.65 },
	["gunpowder"] = { ["index"] = "gunpowder", ["name"] = "Pólvora", ["type"] = "Usável", ["weight"] = 0.15 },
	["capsule"] = { ["index"] = "capsule", ["name"] = "Cápsula", ["type"] = "Usável", ["weight"] = 0.15 },
	["sulfuric"] = { ["index"] = "sulfuric", ["name"] = "Sulfúr", ["type"] = "Usável", ["weight"] = 0.15 },
	["cokeleaf"] = { ["index"] = "cokeleaf", ["name"] = "Folhas de Cocaina", ["type"] = "Usável", ["weight"] = 0.15 },

	["weedleaf"] = { ["index"] = "weedleaf", ["name"] = "Folhas de Erva", ["type"] = "Usável", ["weight"] = 0.15 },


	["water"] = {["index"] = "water",["name"] = "Água",["type"] = "Usável",["weight"] = 0.15,["scape"] = true,["max"] = 5},
	["emptybottle"] = {["index"] = "emptybottle",["name"] = "Garrafa Vazia",["type"] = "Usável",["weight"] = 0.10,["scape"] = true,["max"] = 5},

	["tablemeth"] = { ["index"] = "tablemeth", ["name"] = "Mesa de Metafetamina", ["type"] = "Usável", ["weight"] = 7.50, ["durability"] = 7 },
	["tableweed"] = { ["index"] = "tableweed", ["name"] = "Mesa de LSD", ["type"] = "Usável", ["weight"] = 7.50, ["durability"] = 7 },
	["tablecoke"] = { ["index"] = "tablecoke", ["name"] = "Mesa de Cocaina", ["type"] = "Usável", ["weight"] = 7.50, ["durability"] = 7 },
	["tablelean"] = { ["index"] = "tablelean", ["name"] = "Mesa de Lean", ["type"] = "Usável", ["weight"] = 7.50, ["durability"] = 7 },

	["silk"] = { ["index"] = "silk", ["name"] = "Seda", ["type"] = "Usável", ["weight"] = 0.15 },
	["saline"] = { ["index"] = "saline", ["name"] = "Salino", ["type"] = "Usável", ["weight"] = 0.15 },
	["acetone"] = { ["index"] = "acetone", ["name"] = "Acetona", ["type"] = "Usável", ["weight"] = 0.15 },
	["codeine"] = { ["index"] = "codeine", ["name"] = "Codeine", ["type"] = "Usável", ["weight"] = 0.15 },
	
	["cocaine"] = { ["index"] = "cocaine", ["name"] = "Cocaina", ["type"] = "Usável", ["weight"] = 0.40 },
	["meth"] = { ["index"] = "meth", ["name"] = "Metafetamina", ["type"] = "Usável", ["weight"] =0.40 },
	["lsd"] = { ["index"] = "lsd", ["name"] = "Lsd", ["type"] = "Usável", ["weight"] = 0.40 },
	["lean"] = { ["index"] = "lean", ["name"] = "Lean", ["type"] = "Usável", ["weight"] = 0.40 },

	["pistolbody"] = { ["index"] = "pistolbody", ["name"] = "Corpo de Pistola", ["type"] = "Usável", ["weight"] = 0.40 },
	["smgbody"] = { ["index"] = "smgbody", ["name"] = "Corpo de Sub-Metralhadora", ["type"] = "Usável", ["weight"] = 0.55 },
	["riflebody"] = { ["index"] = "riflebody", ["name"] = "Corpo de Rifle", ["type"] = "Usável", ["weight"] = 0.85 },

	["caixabasica"] = { ["index"] = "caixabasica", ["name"] = "Caixa Basica", ["type"] = "Usável", ["durability"] = 2, ["weight"] = 8 },
	["caixamedia"] = { ["index"] = "caixamedia", ["name"] = "Caixa Media", ["type"] = "Usável", ["durability"] = 2, ["weight"] = 10 },
	["caixagrande"] = { ["index"] = "caixagrande", ["name"] = "Caixa Grande", ["type"] = "Usável", ["durability"] = 2, ["weight"] = 15 },
	["caixalendaria"] = { ["index"] = "caixalendaria", ["name"] = "Caixa Lendaria", ["type"] = "Usável", ["durability"] = 2, ["weight"] = 20 },

	----------------------------------
	-- [ Bichos de pelucia ]
	----------------------------------

	["caixauwu"] = { ["index"] = "caixauwu", ["name"] = "Caixa UwU", ["type"] = "Usável", ["weight"] = 2 },
	["caixauwu2"] = { ["index"] = "caixauwu2", ["name"] = "Caixa Hello Kitty", ["type"] = "Usável", ["weight"] = 2 },

	["teddy"] = { ["index"] = "teddy", ["name"] = "Teddy", ["type"] = "Usável", ["weight"] = 0.75 },
	["stitch"] = { ["index"] = "stitch", ["name"] = "Stitch", ["type"] = "Usável", ["weight"] = 0.75 },
	["dog"] = { ["index"] = "dog", ["name"] = "Cachorro", ["type"] = "Usável", ["weight"] = 0.75 },
	["bunny"] = { ["index"] = "bunny", ["name"] = "Coelho", ["type"] = "Usável", ["weight"] = 0.75 },
	["cat2"] = { ["index"] = "cat2", ["name"] = "Cat", ["type"] = "Usável", ["weight"] = 0.75 },
	["polvo"] = { ["index"] = "polvo", ["name"] = "Polvo", ["type"] = "Usável", ["weight"] = 0.75 },
	["polvo2"] = { ["index"] = "polvo2", ["name"] = "Polvo 2", ["type"] = "Usável", ["weight"] = 0.75 },
	["pony"] = { ["index"] = "pony", ["name"] = "Unicornio", ["type"] = "Usável", ["weight"] = 0.75 },
	["pig"] = { ["index"] = "pig", ["name"] = "Porco", ["type"] = "Usável", ["weight"] = 0.75 },
	["cow"] = { ["index"] = "cow", ["name"] = "Vaca", ["type"] = "Usável", ["weight"] = 0.75 },
	["poopietee"] = { ["index"] = "poopietee", ["name"] = "Poopie Tee", ["type"] = "Usável", ["weight"] = 0.75 },
	["humpytee"] = { ["index"] = "humpytee", ["name"] = "Humpy Tee", ["type"] = "Usável", ["weight"] = 0.75 },
	["sakitee"] = { ["index"] = "sakitee", ["name"] = "Saki Tee", ["type"] = "Usável", ["weight"] = 0.75 },
	["smokertee"] = { ["index"] = "smokertee", ["name"] = "Smoker Tee", ["type"] = "Usável", ["weight"] = 0.75 },
	["princesstee"] = { ["index"] = "princesstee", ["name"] = "Princess Tee", ["type"] = "Usável", ["weight"] = 0.75 },
	["grindytee"] = { ["index"] = "grindytee", ["name"] = "Grindy Tee", ["type"] = "Usável", ["weight"] = 0.75 },
	["wasabitee"] = { ["index"] = "wasabitee", ["name"] = "wasabi Tee", ["type"] = "Usável", ["weight"] = 0.75 },
	["muffytee"] = { ["index"] = "muffytee", ["name"] = "Muffy Tee", ["type"] = "Usável", ["weight"] = 0.75 },
	["mastertee"] = { ["index"] = "mastertee", ["name"] = "Master Tee", ["type"] = "Usável", ["weight"] = 0.75 },

	["bento"] = { ["index"] = "bento", ["name"] = "Bento", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30 },
	["pizzaf"] = { ["index"] = "pizzaf", ["name"] = "Pizza", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30 },
	["ramenf"] = { ["index"] = "ramenf", ["name"] = "Ramen", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30 },
	["rosquinhaf"] = { ["index"] = "rosquinhaf", ["name"] = "Rosquinha", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30 },
	["teaf"] = { ["index"] = "teaf", ["name"] = "Suco de Limao", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30 },
	["sucotropical"] = { ["index"] = "sucotropical", ["name"] = "Suco Tropical", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30 },
	["toddy"] = { ["index"] = "toddy", ["name"] = "Toddy", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30 },

	----------------------------------
	-- [ Cafe ]
	----------------------------------

	["farinha"] = {["index"] = "farinha",["name"] = "Farinha",["type"] = "Usável",["weight"] = 0.10 },
	["leite"] = {["index"] = "leite",["name"] = "Leite",["type"] = "Usável",["weight"] = 0.10 },

	["bolinhodecereja"] = { ["index"] = "bolinhodecereja", ["name"] = "Bolinho de cereja", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["bolodecoco"] = { ["index"] = "bolodecoco", ["name"] = "Bolo de coco", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["bolodemilho"] = { ["index"] = "bolodemilho", ["name"] = "Bolo de milho", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["chocolatecremoso"] = { ["index"] = "chocolatecremoso", ["name"] = "Chocolate cremoso", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["cupcakedelaranja"] = { ["index"] = "cupcakedelaranja", ["name"] = "Cupcake de laranja", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["leitecomcanela"] = { ["index"] = "leitecomcanela", ["name"] = "Leite com canela", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["capuccino"] = { ["index"] = "capuccino", ["name"] = "Capuccino", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["coelhodechocolate"] = { ["index"] = "coelhodechocolate", ["name"] = "Coelho de chocolate", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["cupcakedeabóbora"] = { ["index"] = "cupcakedeabobora", ["name"] = "Cupcake de abóbora", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["cupcakerecheado"] = { ["index"] = "cupcakerecheado", ["name"] = "Cupcake recheado", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["cupcakededefranboesa"] = { ["index"] = "cupcakededefranboesa", ["name"] = "Cupcakede de franboesa", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["cupcakedemelancia"] = { ["index"] = "cupcakedemelancia", ["name"] = "Cupcake de melancia", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["cupcakedemorango"] = { ["index"] = "cupcakedemorango", ["name"] = "Cupcake de morango", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["sucodemelancia"] = { ["index"] = "sucodemelancia", ["name"] = "Suco de melancia", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["torrada"] = { ["index"] = "torrada", ["name"] = "Torrada", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	
	["catburger"] = { ["index"] = "catburger", ["name"] = "Cat burger", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["milkcereja"] = { ["index"] = "milkcereja", ["name"] = "Milkshake Cereja", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["milkfrutos"] = { ["index"] = "milkfrutos", ["name"] = "Milkshake Frutas", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["mlkmorango"] = { ["index"] = "mlkmorango", ["name"] = "Milkshake Morango", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["milkchocolate"] = { ["index"] = "milkchocolate", ["name"] = "Milkshake Chocolate", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["pirulito"] = { ["index"] = "pirulito", ["name"] = "Pirulito", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["sorvete"] = { ["index"] = "sorvete", ["name"] = "Sorvete", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["cafe"] = { ["index"] = "cafe", ["name"] = "Cafe", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },

	["mamadeira"] = { ["index"] = "mamadeira", ["name"] = "Mamadeira", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["sorvete2"] = { ["index"] = "sorvete2", ["name"] = "Napolitano", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["milkuwu"] = { ["index"] = "milkuwu", ["name"] = "Cat Milkshake", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },

	["marshmellow"] = { ["index"] = "marshmellow", ["name"] = "Marshmellow", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["coxinha"] = { ["index"] = "coxinha", ["name"] = "Coxinha", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["chaverde"] = { ["index"] = "chaverde", ["name"] = "Cha verde", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["macarrao"] = { ["index"] = "macarrao", ["name"] = "Macaron", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	--["cupcake"] = { ["index"] = "cupcake", ["name"] = "Cupcake", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30 },
	["melancia"] = { ["index"] = "melancia", ["name"] = "Melancia", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["sucodelaranja"] = { ["index"] = "sucodelaranja", ["name"] = "Suco de Laranja", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },

	["aguadecoco"] = { ["index"] = "aguadecoco", ["name"] = "Agua de coco", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["catpanqueca"] = { ["index"] = "catpanqueca", ["name"] = "Cat panqueca", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["waffles"] = { ["index"] = "waffles", ["name"] = "Waffles", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["sanduiche"] = { ["index"] = "sanduiche", ["name"] = "Sanduiche", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["ursoburger"] = { ["index"] = "ursoburger", ["name"] = "Urso burger", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.30, ["max"] = 15, ["scape"] = true },
	["redvelvet"] = { ["index"] = "redvelvet", ["name"] = "Red Velvet", ["type"] = "Usável", ["durability"] = 1.5, ["weight"] = 0.3, ["max"] = 15, ["scape"] = true },
	----------------------------------
	-- [ Dinheiro ]
	----------------------------------

	["dollars"] = { ["index"] = "dollars", ["name"] = "Dólares", ["type"] = "Comum", ["weight"] = 0.00},
	["dollars2"] = { ["index"] = "dollars2" ,["name"] = "Dólares Marcado", ["type"] = "Comum", ["weight"] = 0.00 },

	----------------------------------
	-- [ Aneis ]
	----------------------------------

	["anelcasamento"] = { ["index"] = "anelcasamento", ["name"] = "Aliança de Casamento", ["type"] = "Usável", ["weight"] = 0.00},
	["anelnamoro"] = { ["index"] = "anelnamoro", ["name"] = "Aliança de Namoro", ["type"] = "Usável", ["weight"] = 0.00},	
	["anelnoivado"] = { ["index"] = "anelnoivado", ["name"] = "Aliança de Noivado", ["type"] = "Usável", ["weight"] = 0.00},		

	["ingressovanilla"] = { ["index"] = "ingressovanilla", ["name"] = "Ingresso Vanilla", ["type"] = "Usável", ["weight"] = 0.20 },

	----------------------------------
	-- [ Hospital ]
	----------------------------------

	["bandage"] = { ["index"] = "bandage", ["name"] = "Bandagem", ["type"] = "Usável", ["durability"] = 2, ["weight"] = 0.10 },
	["medkit"] = { ["index"] = "medkit", ["name"] = "Kit Médico", ["type"] = "Usável", ["durability"] = 2, ["weight"] = 0.45 },
	["adrenaline"] = { ["index"] = "adrenaline", ["name"] = "Adrenalina", ["type"] = "Usável", ["durability"] = 2, ["weight"] = 0.35 },
	["gauze"] = { ["index"] = "gauze", ["name"] = "Gauze", ["type"] = "Usável", ["durability"] = 2, ["weight"] = 0.35 },

	----------------------------------
	-- [ Comidas gratuitas ]
	----------------------------------

	["soda"] = { ["index"] = "soda",["name"] = "Sprunk",["type"] = "Usável",["weight"] = 0.15 },
	["donut"] = { ["index"] = "donut",["name"] = "Rosquinha",["type"] = "Usável",["weight"] = 0.25 },
	["sandwich"] = { ["index"] = "sandwich",["name"] = "Sanduiche",["type"] = "Usável",["weight"] = 0.25 },
	["cola"] = { ["index"] = "cola",["name"] = "Cola",["type"] = "Usável",["weight"] = 0.15 },
	["absolut"] = { ["index"] = "absolut",["name"] = "Absolut",["type"] = "Usável",["weight"] = 0.25 },
	["chandon"] = { ["index"] = "chandon",["name"] = "Chandon",["type"] = "Usável",["weight"] = 0.35 },
	["dewars"] = { ["index"] = "dewars",["name"] = "Dewars",["type"] = "Usável",["weight"] = 0.25 },
	["hennessy"] = { ["index"] = "hennessy",["name"] = "Hennessy",["type"] = "Usável",["weight"] = 0.25 },

	----------------------------------
	-- [ Itens VIPS ]
	----------------------------------

	["gemstone"] = { ["index"] = "gemstone", ["name"] = "Perolas", ["type"] = "Usável", ["weight"] = 0.10 },
	["premium"] = { ["index"] = "premium", ["name"] = "Vip", ["type"] = "Usável", ["weight"] = 0.00 },
	["newgarage"] = { ["index"] = "newgarage", ["name"] = "+1 Garagem", ["type"] = "Usável", ["desc"] = "Limite de garagem em +1.", ["weight"] = 0.00 },
	["premiumplate"] = { ["index"] = "platepremium", ["name"] = "Troca de Placa", ["type"] = "Usável", ["desc"] = "Personaliza a placa do veículo.", ["weight"] = 0.00 },
	["newchars"] = { ["index"] = "newchars", ["name"] = "Personagem Extra", ["type"] = "Usável", ["desc"] = "Limite de personagem em +1.", ["weight"] = 0.00 },
	["chip"] = { ["index"] = "chip", ["name"] = "Chip Telefônico", ["type"] = "Usável", ["desc"] = "Troca o número telefônico.", ["weight"] = 0.00 },
	["namechange"] = { ["index"] = "namechange", ["name"] = "Troca de Nome", ["type"] = "Usável", ["desc"] = "Troca o nome do personagem.", ["weight"] = 0.00},
	["rottweiler"] = { ["index"] = "rottweiler", ["name"] = "Coleira de Rottweiler", ["type"] = "Animal", ["durability"] = 20, ["weight"] = 1.25 },
	["husky"] = { ["index"] = "husky", ["name"] = "Coleira de Husky", ["type"] = "Animal", ["durability"] = 20, ["weight"] = 1.25 },
	["shepherd"] = { ["index"] = "shepherd", ["name"] = "Coleira de Shepherd", ["type"] = "Animal", ["durability"] = 20, ["weight"] = 1.25 },
	["retriever"] = { ["index"] = "retriever", ["name"] = "Coleira de Retriever", ["type"] = "Animal", ["durability"] = 20, ["weight"] = 1.25 },
	["poodle"] = { ["index"] = "poodle", ["name"] = "Coleira de Poodle", ["type"] = "Animal", ["durability"] = 20, ["weight"] = 1.25 },
	["pug"] = { ["index"] = "pug", ["name"] = "Coleira de Pug", ["type"] = "Animal", ["durability"] = 20, ["weight"] = 1.25 },
	["westy"] = { ["index"] = "westy", ["name"] = "Coleira de Westy", ["type"] = "Animal", ["durability"] = 20, ["weight"] = 1.25 },
	["cat"] = { ["index"] = "cat", ["name"] = "Coleira de Gato", ["type"] = "Animal", ["durability"] = 20, ["weight"] = 1.25 },	

	["vipsilver"] = { ["index"] = "vipsilver", ["name"] = "VIP Silver", ["type"] = "Usável", ["weight"] = 0.00 },
	["vipgold"] = { ["index"] = "vipgold", ["name"] = "VIP Gold", ["type"] = "Usável", ["weight"] = 0.00 },
	["vipplatinum"] = { ["index"] = "vipplatinum", ["name"] = "VIP Platinum", ["type"] = "Usável", ["weight"] = 0.00 },
	["vipdiamond"] = { ["index"] = "vipdiamond", ["name"] = "VIP Diamond", ["type"] = "Usável", ["weight"] = 0.00 },
	["vipadvanced"] = { ["index"] = "vipadvanced", ["name"] = "VIP Advanced", ["type"] = "Usável", ["weight"] = 0.00 },
	["vipmaui"] = {["index"] = "vipmaui",["name"] = "VIP Maui",["type"] = "Usável",["weight"] = 0.00 },
	["vipkids"] = {["index"] = "premium7",["name"] = "VIP Kids",["type"] = "Usável",["weight"] = 0.00 },

	----------------------------------
	-- [ Bebidas ]
	----------------------------------

	["energetic"] = { ["index"] = "energetic", ["name"] = "Energético", ["type"] = "Usável", ["weight"] = 0.25 },
	["milkmorango"] = { ["index"] = "milkmorango", ["name"] = "Milk Shake de morango", ["type"] = "Usável", ["durability"] = 2, ["weight"] = 0.55 },
	["milklimao"] = { ["index"] = "milklimao", ["name"] = "Milk Shake de limão", ["type"] = "Usável", ["durability"] = 2, ["weight"] = 0.55 },


	----------------------------------
	-- [ Comidas ]
	----------------------------------

	["catburger"] = { ["index"] = "catburger", ["name"] = "Catburger", ["type"] = "Usável", ["durability"] = 2, ["weight"] = 0.55 },

	----------------------------------
	-- [ Distintivos ]
	----------------------------------

	["badge01"] = { ["index"] = "badge01", ["name"] = "Distintivo", ["desc"] = "<green>Speed Enforcement</green>", ["type"] = "Usável", ["weight"] = 0.0 },
	["badge02"] = { ["index"] = "badge02", ["name"] = "Distintivo", ["desc"] = "<green>Internal Affairs</green>", ["type"] = "Usável", ["weight"] = 0.0 },
	["badge03"] = { ["index"] = "badge03", ["name"] = "Distintivo", ["desc"] = "<green>Special Weapons and Tactics</green>", ["type"] = "Usável", ["weight"] = 0.0 },
	["badge04"] = { ["index"] = "badge04", ["name"] = "Distintivo", ["desc"] = "<green>Emergency Medical Services</green>", ["type"] = "Usável", ["weight"] = 0.0 },
	["badge05"] = { ["index"] = "badge05", ["name"] = "Distintivo", ["desc"] = "<green>Department of Corrections</green>", ["type"] = "Usável", ["weight"] = 0.0 },
	["badge06"] = { ["index"] = "badge06", ["name"] = "Distintivo", ["desc"] = "<green>Field Training Operations</green>", ["type"] = "Usável", ["weight"] = 0.0 },
	["badge07"] = { ["index"] = "badge07", ["name"] = "Distintivo", ["desc"] = "<green>Los Santos Police Department</green>", ["type"] = "Usável", ["weight"] = 0.0 },
	["badge08"] = { ["index"] = "badge08", ["name"] = "Distintivo", ["desc"] = "<green>Patrol Operations</green>", ["type"] = "Usável", ["weight"] = 0.0 },
	["badge09"] = { ["index"] = "badge09", ["name"] = "Distintivo", ["desc"] = "<green>Detectives Bureau</green>", ["type"] = "Usável", ["weight"] = 0.0 },
	["badge10"] = { ["index"] = "badge10", ["name"] = "Distintivo", ["desc"] = "<green>Honorary Council</green>", ["type"] = "Usável", ["weight"] = 0.0 },

	----------------------------------
	-- [ Armas Brancas ]
	----------------------------------

	["WEAPON_HATCHET"] = { ["index"] = "hatchet", ["name"] = "Machado", ["type"] = "Armamento", ["durability"] = 14, ["weight"] = 0.75 },
	["WEAPON_BAT"] = { ["index"] = "bat", ["name"] = "Bastão de Beisebol", ["type"] = "Armamento", ["durability"] = 14, ["weight"] = 0.75 },
	["WEAPON_KATANA"] = { ["index"] = "katana", ["name"] = "Katana", ["type"] = "Armamento", ["repair"] = "repairkit01", ["durability"] = 14, ["weight"] = 0.75, ["economy"] = 1225 },
	["WEAPON_KARAMBIT"] = { ["index"] = "karambit",["name"] = "Karambit", ["type"] = "Armamento", ["repair"] = "repairkit01", ["durability"] = 14, ["weight"] = 0.75, ["economy"] = 1025 },
	["WEAPON_BATTLEAXE"] = { ["index"] = "battleaxe", ["name"] = "Machado de Batalha", ["type"] = "Armamento", ["durability"] = 14, ["weight"] = 0.75 },
	["WEAPON_CROWBAR"] = { ["index"] = "crowbar", ["name"] = "Pé de Cabra", ["type"] = "Armamento", ["durability"] = 14, ["weight"] = 0.75 },
	["WEAPON_GOLFCLUB"] = { ["index"] = "golfclub", ["name"] = "Taco de Golf", ["type"] = "Armamento", ["durability"] = 14,["weight"] = 0.75 },
	["WEAPON_HAMMER"] = { ["index"] = "hammer", ["name"] = "Martelo", ["type"] = "Armamento", ["durability"] = 14, ["weight"] = 0.75 },
	["WEAPON_MACHETE"] = { ["index"] = "machete", ["name"] = "Facão", ["type"] = "Armamento", ["durability"] = 14, ["weight"] = 0.75 },
	["WEAPON_POOLCUE"] = { ["index"] = "poolcue", ["name"] = "Taco de Sinuca", ["type"] = "Armamento", ["durability"] = 14, ["weight"] = 0.75 },
	["WEAPON_STONE_HATCHET"] = { ["index"] = "stonehatchet", ["name"] = "Machado de Pedra", ["type"] = "Armamento", ["durability"] = 14, ["weight"] = 0.75 },
	["WEAPON_WRENCH"] = { ["index"] = "wrench", ["name"] = "Chave Inglesa", ["type"] = "Armamento", ["durability"] = 14, ["weight"] = 0.75 },
	["WEAPON_KNUCKLE"] = { ["index"] = "knuckle", ["name"] = "Soco Inglês", ["type"] = "Armamento", ["durability"] = 14, ["weight"] = 0.75 },
	["WEAPON_FLASHLIGHT"] = { ["index"] = "flashlight", ["name"] = "Lanterna", ["type"] = "Armamento", ["durability"] = 14, ["weight"] = 0.75 },
	["WEAPON_NIGHTSTICK"] = { ["index"] = "nightstick", ["name"] = "Cassetete", ["type"] = "Armamento",	["durability"] = 14, ["weight"] = 0.75 },

	----------------------------------
	-- [ Pistolas ]
	----------------------------------

	["WEAPON_PISTOL"] = { ["index"] = "m1911", ["name"] = "M1911", ["type"] = "Armamento", ["ammo"] = "WEAPON_PISTOL_AMMO", ["durability"] = 24, ["vehicle"] = true, ["weight"] = 1.25 },
	["WEAPON_APPISTOL"] = { ["index"] = "kochvp9", ["name"] = "Koch Vp9", ["type"] = "Armamento", ["ammo"] = "WEAPON_PISTOL_AMMO", ["durability"] = 24, ["vehicle"] = true, ["weight"] = 1.25 },
	["WEAPON_HEAVYPISTOL"] = { ["index"] = "atifx45", ["name"] = "Ati FX45", ["type"] = "Armamento", ["ammo"] = "WEAPON_PISTOL_AMMO", ["durability"] = 24, ["vehicle"] = true, ["weight"] = 1.50 },
	["WEAPON_VINTAGEPISTOL"] = { ["index"] = "m1922", ["name"] = "M1922", ["type"] = "Armamento", ["ammo"] = "WEAPON_PISTOL_AMMO", ["durability"] = 24, ["vehicle"] = true, ["weight"] = 1.25 },
	["WEAPON_PISTOL50"] = { ["index"] = "desert", ["name"] = "Desert Eagle", ["type"] = "Armamento", ["ammo"] = "WEAPON_PISTOL_AMMO", ["durability"] = 24, ["vehicle"] = true, ["weight"] = 1.50 },
	["WEAPON_REVOLVER"] = {	["index"] = "magnum", ["name"] = "Magnum 44", ["type"] = "Armamento", ["ammo"] = "WEAPON_PISTOL_AMMO", ["durability"] = 24, ["vehicle"] = true, ["weight"] = 1.50 },
	["WEAPON_COMBATPISTOL"] = { ["index"] = "glock", ["name"] = "Glock", ["type"] = "Armamento", ["ammo"] = "WEAPON_PISTOL_AMMO", ["durability"] = 24, ["vehicle"] = true, ["weight"] = 1.25 },

	["WEAPON_PISTOL_MK2"] = {["index"] = "fiveseven", ["name"] = "FN Five Seven", ["type"] = "Armamento", ["ammo"] = "WEAPON_PISTOL_AMMO", ["durability"] = 24, ["vehicle"] = true, ["weight"] = 1.50 },
	["WEAPON_SNSPISTOL"] = { ["index"] = "amt380", ["name"] = "AMT 380", ["type"] = "Armamento", ["ammo"] = "WEAPON_PISTOL_AMMO", ["durability"] = 24, ["vehicle"] = true, ["weight"] = 1.00 },
	["WEAPON_SNSPISTOL_MK2"] = { ["index"] = "hkp7m10", ["name"] = "HK P7M10", ["type"] = "Armamento", ["ammo"] = "WEAPON_PISTOL_AMMO", ["durability"] = 24, ["vehicle"] = true, ["weight"] = 1.25 },
	["WEAPON_VINTAGEPISTOL"] = { ["index"] = "m1922", ["name"] = "M1922", ["type"] = "Armamento", ["ammo"] = "WEAPON_PISTOL_AMMO", ["durability"] = 24, ["vehicle"] = true, ["weight"] = 1.25 },
	["WEAPON_MACHINEPISTOL"] = { ["index"] = "tec9", ["name"] = "Tec-9", ["type"] = "Armamento", ["ammo"] = "WEAPON_SMG_AMMO", ["durability"] = 24, ["vehicle"] = true, ["weight"] = 1.75 },

	["WEAPON_RAYPISTOL"] = { ["index"] = "ray", ["name"] = "Ray", ["type"] = "Armamento", ["ammo"] = "WEAPON_PISTOL_AMMO", ["vehicle"] = true, ["weight"] = 150 },

	----------------------------------
	-- [ Smgs ]
	----------------------------------

	["WEAPON_ASSAULTSMG"] = { ["index"] = "steyraug", ["name"] = "Steyr AUG", ["type"] = "Armamento", ["ammo"] = "WEAPON_SMG_AMMO", ["durability"] = 8, ["weight"] = 1.75 },
	["WEAPON_GUSENBERG"] = { ["index"] = "thompson", ["name"] = "Thompson", ["type"] = "Armamento", ["ammo"] = "WEAPON_SMG_AMMO", ["durability"] = 8, ["weight"] = 1.25 },
	["WEAPON_SMG_MK2"] = { ["index"] = "evo3",["name"] = "Evo-3", ["type"] = "Armamento", ["ammo"] = "WEAPON_SMG_AMMO", ["durability"] = 8, ["weight"] = 1.25 },
	["WEAPON_SMG"] = { ["index"] = "mp5", ["name"] = "MP5", ["type"] = "Armamento", ["ammo"] = "WEAPON_SMG_AMMO", ["durability"] = 8, ["weight"] = 1.25 },
	["WEAPON_MINISMG"] = { ["index"] = "skorpionv61", ["name"] = "Skorpion V61", ["type"] = "Armamento", ["ammo"] = "WEAPON_SMG_AMMO", ["durability"] = 24, ["vehicle"] = true, ["weight"] = 1.75 },
	["WEAPON_MICROSMG"] = { ["index"] = "uzi", ["name"] = "Uzi", ["type"] = "Armamento", ["ammo"] = "WEAPON_SMG_AMMO", ["durability"] = 24, ["vehicle"] = true, ["weight"] = 1.25 },

	----------------------------------
	-- [ Fuzil ]
	----------------------------------

	["WEAPON_CARBINERIFLE"] = { ["index"] = "m4a1", ["name"] = "M4A1", ["type"] = "Armamento", ["ammo"] = "WEAPON_RIFLE_AMMO", ["durability"] = 10, ["weight"] = 1.75 },
	["WEAPON_CARBINERIFLE_MK2"] = { ["index"] = "m4a4", ["name"] = "M4A4", ["type"] = "Armamento", ["ammo"] = "WEAPON_RIFLE_AMMO", ["durability"] = 10, ["weight"] = 1.50},
	["WEAPON_ADVANCEDRIFLE"] = { ["index"] = "tar21", ["name"] = "Tar-21", ["type"] = "Armamento", ["ammo"] = "WEAPON_RIFLE_AMMO", ["durability"] = 10, ["weight"] = 1.75},
	["WEAPON_BULLPUPRIFLE"] = { ["index"] = "qbz95", ["name"] = "QBZ-95", ["type"] = "Armamento", ["ammo"] = "WEAPON_RIFLE_AMMO", ["durability"] = 10, ["weight"] = 1.75},
	["WEAPON_BULLPUPRIFLE_MK2"] = { ["index"] = "l85", ["name"] = "L85", ["type"] = "Armamento", ["ammo"] = "WEAPON_RIFLE_AMMO", ["durability"] = 10, ["weight"] = 1.75},
	["WEAPON_ASSAULTRIFLE"] = {["index"] = "ak103",["name"] = "AK-103",["type"] = "Armamento",["ammo"] = "WEAPON_RIFLE_AMMO", ["durability"] = 10,["weight"] = 1.75},
	["WEAPON_ASSAULTRIFLE_MK2"] = { ["index"] = "ak74", ["name"] = "AK-74", ["type"] = "Armamento", ["ammo"] = "WEAPON_RIFLE_AMMO", ["durability"] = 10, ["weight"] = 1.75 },
	["WEAPON_SPECIALCARBINE_MK2"] = { ["index"] = "sigsauer556", ["name"] = "Sig Sauer 556", ["type"] = "Armamento", ["ammo"] = "WEAPON_RIFLE_AMMO", ["durability"] = 10, ["weight"] = 1.25 },
	["WEAPON_SPECIALCARBINE"] = { ["index"] = "g36c", ["name"] = "G36C", ["type"] = "Armamento", ["ammo"] = "WEAPON_RIFLE_AMMO", ["durability"] = 10, ["weight"] = 1.25 },
	["WEAPON_COMPACTRIFLE"] = { ["index"] = "akcompact", ["name"] = "AK Compact", ["type"] = "Armamento", ["ammo"] = "WEAPON_RIFLE_AMMO", ["durability"] = 10, ["weight"] = 2.25 },
	["WEAPON_M6IC"] = { ["index"] = "m6ic", ["name"] = "M6 IC", ["type"] = "Armamento", ["ammo"] = "WEAPON_RIFLE_AMMO", ["durability"] = 15, ["weight"] = 2.25 },
	["WEAPON_PARAFAL"] = { ["index"] = "parafal", ["name"] = "FN FAL", ["type"] = "Armamento", ["ammo"] = "WEAPON_RIFLE_AMMO", ["durability"] = 15, ["weight"] = 2.25 },
	["WEAPON_FNFAL"] = { ["index"] = "fnfal", ["name"] = "FN FAL", ["type"] = "Armamento", ["ammo"] = "WEAPON_RIFLE_AMMO", ["durability"] = 15, ["weight"] = 2.25 },


	----------------------------------
	-- [ Shotguns ]
	----------------------------------

	["WEAPON_SAWNOFFSHOTGUN"] = { ["index"] = "mossberg500", ["name"] = "Mossberg 500", ["type"] = "Armamento", ["ammo"] = "WEAPON_SHOTGUN_AMMO", ["durability"] = 9, ["weight"] = 10 },
	["WEAPON_SNIPERRIFLE"] = { ["index"] = "sauer101", ["name"] = "Sauer 101", ["type"] = "Armamento", ["ammo"] = "WEAPON_MUSKET_AMMO", ["durability"] = 9, ["weight"] = 10 },
	["WEAPON_MUSKET"] = { ["index"] = "winchester", ["name"] = "Winchester 1892", ["type"] = "Armamento", ["ammo"] = "WEAPON_MUSKET_AMMO", ["durability"] = 9, ["weight"] = 10 },
	["WEAPON_PUMPSHOTGUN_MK2"] = { ["index"] = "mossberg590a1", ["name"] = "Mossberg 590A1", ["type"] = "Armamento", ["ammo"] = "WEAPON_SHOTGUN_AMMO", ["durability"] = 9, ["weight"] = 10 },
	["WEAPON_PUMPSHOTGUN"] = { ["index"] = "mossberg590", ["name"] = "Mossberg 590", ["type"] = "Armamento", ["ammo"] = "WEAPON_SHOTGUN_AMMO", ["durability"] = 9, ["weight"] = 10 },

	----------------------------------
	-- [ Outros ]
	----------------------------------

	["WEAPON_PISTOL_AMMO"] = { ["index"] = "pistolammo", ["name"] = "Munição de Pistola", ["type"] = "Munição", ["weight"] = 0.02 },
	["WEAPON_SMG_AMMO"] = { ["index"] = "smgammo", ["name"] = "Munição de Sub", ["type"] = "Munição", ["weight"] = 0.03 },
	["WEAPON_RIFLE_AMMO"] = { ["index"] = "rifleammo", ["name"] = "Munição de Rifle", ["type"] = "Munição", ["weight"] = 0.04 },
	["WEAPON_SHOTGUN_AMMO"] = { ["index"] = "shotgunammo", ["name"] = "Munição de Escopeta" ,["type"] = "Munição", ["weight"] = 0.05 },
	["WEAPON_MUSKET_AMMO"] = { ["index"] = "musketammo", ["name"] = "Munição de Mosquete", ["type"] = "Munição", ["weight"] = 0.05 },
	["WEAPON_PETROLCAN_AMMO"] = { ["index"] = "fuel", ["name"] = "Combustível", ["type"] = "Munição", ["weight"] = 0.0 },
	["WEAPON_PETROLCAN"] = { ["index"] = "gallon", ["name"] = "Galão", ["type"] = "Armamento", ["ammo"] = "WEAPON_PETROLCAN_AMMO", ["weight"] = 1.25 },
	["WEAPON_BRICK"] = { ["index"] = "brick", ["name"] = "Tijolo", ["type"] = "Throwing", ["vehicle"] = true, ["weight"] = 0.50,["economy"] = 20 },
	["WEAPON_SNOWBALL"] = { ["index"] = "snowball", ["name"] = "Bola de Neve", ["type"] = "Throwing", ["vehicle"] = true, ["weight"] = 0.25, ["economy"] = 6 },
	["WEAPON_SHOES"] = { ["index"] = "shoes", ["name"] = "Tênis", ["type"] = "Throwing", ["vehicle"] = true, ["weight"] = 0.50, ["economy"] = 20 },
	["GADGET_PARACHUTE"] = { ["index"] = "parachute", ["name"] = "Paraquedas", ["type"] = "Usável", ["weight"] = 2.25 },
	["WEAPON_STUNGUN"] = { ["index"] = "stungun", ["name"] = "Tazer", ["type"] = "Armamento", ["durability"] = 7, ["weight"] = 0.75, ["max"] = 2 },
	["WEAPON_BALL"] = { ["index"] = "bola", ["name"] = "Bola", ["type"] = "Throwing", ["vehicle"] = true, ["weight"] = 0.50, ["economy"] = 20 },
	

	["contract1"] = {["index"] = "contract",["name"] = "Contrato de Propriedade",["type"] = "Usável",["desc"] = "Assinatura de contrato do interior 1.",["weight"] = 0.00},
	["contract2"] = {["index"] = "contract",["name"] = "Contrato de Propriedade",["type"] = "Usável",["desc"] = "Assinatura de contrato do interior 2.",["weight"] = 0.00},
	["contract3"] = {["index"] = "contract",["name"] = "Contrato de Propriedade",["type"] = "Usável",["desc"] = "Assinatura de contrato do interior 3.",["weight"] = 0.00},
	["contract4"] = {["index"] = "contract",["name"] = "Contrato de Propriedade",["type"] = "Usável",["desc"] = "Assinatura de contrato do interior 4.",["weight"] = 0.00},
	["contract5"] = {["index"] = "contract",["name"] = "Contrato de Propriedade",["type"] = "Usável",["desc"] = "Assinatura de contrato do interior 5.",["weight"] = 0.00},
	["contract6"] = {["index"] = "contract",["name"] = "Contrato de Propriedade",["type"] = "Usável",["desc"] = "Assinatura de contrato do interior 6.",["weight"] = 0.00},
	["contract7"] = {["index"] = "contract",["name"] = "Contrato de Propriedade",["type"] = "Usável",["desc"] = "Assinatura de contrato do interior 7.",["weight"] = 0.00},
	["contract8"] = {["index"] = "contract",["name"] = "Contrato de Propriedade",["type"] = "Usável",["desc"] = "Assinatura de contrato do interior 8.",["weight"] = 0.00},
	["contract9"] = {["index"] = "contract",["name"] = "Contrato de Propriedade",["type"] = "Usável",["desc"] = "Assinatura de contrato do interior 9.",["weight"] = 0.00},
	["contract10"] = {["index"] = "contract",["name"] = "Contrato de Propriedade",["type"] = "Usável",["desc"] = "Assinatura de contrato do container.",["weight"] = 0.00},

}

function returnLista()
	return itemlist
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMBODY
-----------------------------------------------------------------------------------------------------------------------------------------
function itemBody(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMINDEX
-----------------------------------------------------------------------------------------------------------------------------------------
function itemIndex(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["index"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMNAME
-----------------------------------------------------------------------------------------------------------------------------------------
function itemName(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["name"]
	end

	return "Deletado"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function itemType(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["type"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMAMMO
-----------------------------------------------------------------------------------------------------------------------------------------
function itemAmmo(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["ammo"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function itemVehicle(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["vehicle"] or false
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function itemWeight(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["weight"] or 0.0
	end

	return 0.0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMMAXAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function itemMaxAmount(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["max"] or nil
	end

	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMSCAPE
-----------------------------------------------------------------------------------------------------------------------------------------
function itemScape(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["scape"] or nil
	end

	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDESCRIPTION
-----------------------------------------------------------------------------------------------------------------------------------------
function itemDescription(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["desc"] or nil
	end

	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDURABILITY
-----------------------------------------------------------------------------------------------------------------------------------------
function itemDurability(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["durability"] or false
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMCHARGES
-----------------------------------------------------------------------------------------------------------------------------------------
function itemCharges(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["charges"] or nil
	end

	return nil
end