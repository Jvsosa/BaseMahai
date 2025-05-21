-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("shops",cRP)
vCLIENT = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local shops = {
	["weedShop"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["silk"] = 3
		}
	},
	["Cafe"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["coxinha"] = 500,
			["sucodelaranja"] = 500,
			["milkchocolate"] = 500,
			["waffles"] = 500,
		}
	},
	["Joalheria"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["anelcasamento"] = 500000,
			["anelnoivado"] = 250000,
			["anelnamoro"] = 100000,
		}
	},	
	["imoveisShop"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["contract1"] = 750000,
			["contract2"] = 1500000,
			["contract3"] = 200000,
			["contract4"] = 850000,
			["contract5"] = 550000,
			["contract6"] = 900000,
			["contract7"] = 300000,
			["contract8"] = 1400000,
			["contract9"] = 560000,
			["contract10"] = 100000
		}
	},
	["identityStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["identity"] = 20000
		}
	},
	["fidentityStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["fidentity"] = 100000
		}
	},

	["vanillabebib"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Vanilla",
		["list"] = {
			["absolut"] = 500,
			["chandon"] = 500,
			["dewars"] = 500,
			["hennessy"] = 500,
		}
	},


	["animalStore"] = {
		["mode"] = "Buy",
		["type"] = "Premium",
		["list"] = {
			["rottweiler"] = 8,
			["husky"] = 8,
			["shepherd"] = 8,
			["retriever"] = 8,
			["poodle"] = 8,
			["pug"] = 8,
			["westy"] = 8,
			["cat"] = 8
		}
	},
	
	["bebidas"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["absolut"] = 500,
			["chandon"] = 500,
			["dewars"] = 500,
			["hennessy"] = 500,
		}
	},

	["bebidasbahamas"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Bahamas",
		["list"] = {
			["absolut"] = 500,
			["chandon"] = 500,
			["dewars"] = 500,
			["hennessy"] = 500,
		}
	},

	["departamentStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["backpack"] = 5000,
			["rope"] = 2000,
			["soda"] = 100,
			["cola"] = 100,
			["sandwich"] = 100,
			["donut"] = 100,
			["water"] = 125,
			--["campfire"] = 125,
			["WEAPON_BRICK"] = 150,
			--["postit"] = 125,
			["dices"] = 125,
			["firecracker"] = 125,
			--["catburger"] = 500,
			--["milkcereja"] = 500,
			--["radio"] = 3000,
			--["energetic"] = 10000,
			--["hamburger"] = 600,
			--["water"] = 800,
			--["chocolate"] = 200,
			--["sandwich"] = 300,
			--["chandon"] = 300,
			--["dewars"] = 100,
			--["hennessy"] = 300,
			--["absolut"] = 100,
			--["tacos"] = 50,
			--["cola"] = 300,
			--["soda"] = 50,
			--["coffee"] = 50
		}
	},

	["lojaHP"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["backpack"] = 5000,
			["rope"] = 2000,
			["soda"] = 100,
			["cola"] = 100,
			["sandwich"] = 100,
			["donut"] = 100,
			["water"] = 125,
		}
	},
	--["pier"] = {
	--	["mode"] = "Buy",
	--	["type"] = "Cash",
	--	["list"] = {
	--		["cupcake"] = 100,
	--		["hamburger2"] = 100,
	--		["pizza2"] = 100,
	--		["sushi"] = 100,
	--		["nigirizushi"] = 100,
	--		["applelove"] = 100,	
	--		["cappuccino"] = 100,	
	--		["soda"] = 120,	
	--		["water"] = 120,	
	--		["strawberryjuice"] = 120,	
	--		["orangejuice"] = 120,	
	--		["milkshake"] = 120
	--	}
	--},
	["eletronicos"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
		    ["radio"] = 2500,
			["cellphone"] = 3500,
			["vape"] = 3500,
			["camera"] = 1000,
			["binoculars"] = 1000,
		}
	},
	["fishdepartamentStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["bait"] = 400,
			["fishingrod"] = 725
		}
	},
	["mercadoCentral"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["rose"] = 80,
			["cigarette"] = 75,
			["backpack"] = 5000,
			["lighter"] = 55,
			--["postit"] = 150,
			--["notepad"] = 100,
			["firecracker"] = 3000,
			--["anotacoes"] = 2500,
			["binoculars"] = 2000,
			["camera"] = 2500,
			["vape"] = 2000,
			--["chair01"] = 750,
			["teddy"] = 500,
			["WEAPON_BRICK"] = 550,
			["WEAPON_SHOES"] = 550,
			--["credential"] = 5000,
			["rope"] = 3000   
		}
	},
	["Clothes"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
	--		["teddy"] = 75,
	--		["WEAPON_BRICK"] = 25,
	--		["WEAPON_SHOES"] = 25,
	--		["rope"] = 875
		}
	},
	["mechanicTools"] = { --player
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["tyres"] = 1000,
			["toolbox"] = 3500,
			["WEAPON_WRENCH"] = 2500,
			--["advtoolbox"] = 6000,
		}
	},
	--["ilegalshop"] = { --venda de armas
	--	["mode"] = "Buy",
	--	["type"] = "Cash",
	--	["list"] = {
	--		["WEAPON_PISTOL_MK2"] = 50000,
	--		["WEAPON_COMPACTRIFLE"] = 170000,
	----		["advtoolbox"] = 1425,
	--		["WEAPON_ASSAULTRIFLE"] = 200000
	--	}
	--},
	--["ilegalshop2"] = { --venda de Muni
	--	["mode"] = "Buy",
	--	["type"] = "Cash",
	--	["list"] = {
	--		--["WEAPON_PISTOL_AMMO"] = 100,
	--		--["WEAPON_RIFLE_AMMO"] = 250,
	--		--["WEAPON_CROWBAR"] = 150,
	--		["credential"] = 2500,
	--		["handcuff"] = 10000,
	--		["pendrive"] = 5000,
	--		["hood"] = 15000,
	--		["c4"] = 15000,
	--		["vest"] = 15000,
	--		["card01"] = 3000,
	--		["card02"] = 3000,
	--		["card03"] = 4000,
	--		["card04"] = 3000,
	--		["card05"] = 5000
	--	}
	--},
	["mechanicBuy"] = { --mechanic
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Mechanic",
		["list"] = {
			["tyres"] = 600,
			["toolbox"] = 1000,
	--		["advtoolbox"] = 925,
			["WEAPON_WRENCH"] = 2000
		}
	},
	["venderfrutas"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["tomato"] = 70,
			["banana"] = 70,
			["grape"] = 70,
			["passion"] = 70,
			["tange"] = 70,
			["orange"] = 70,
			["apple"] = 70,
			["strawberry"] = 70,

		}
	},
	["comprarfruta"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Cafe",
		["list"] = {
			["frutas"] = 35,
		}
	},
	["oxyStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["oxy"] = 150
		}
	},
	["pharmacyStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			--["sinkalmy"] = 2500,
			--["analgesic"] = 4000,
			--["ritmoneury"] = 3500,
			["adrenaline"] = 10000,
			--["medkit"] = 3500,
			["gauze"] = 1200,
			["bandage"] = 1200
		}
	},

	["pharmacyStore2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Exercito",
		["list"] = {
			--["sinkalmy"] = 2500,
			--["analgesic"] = 4000,
			--["ritmoneury"] = 3500,
			["adrenaline"] = 150,
			--["medkit"] = 3500,
			["gauze"] = 150,
			["bandage"] = 150
		}
	},

	["HospitalShop"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Paramedic",
		["list"] = {
			--["sinkalmy"] = 2500,
			--["analgesic"] = 4000,
			--["ritmoneury"] = 10,
			["adrenaline"] = 10,
			["medkit"] = 10,
			["gauze"] = 10,
			["bandage"] = 10
		}
	},

	["pharmacyParamedic"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Paramedic",
		["list"] = {
			["badge04"] = 100,
			["syringe"] = 100,
			["gauze"] = 100,
			["adrenaline"] = 100,
			["sinkalmy"] = 100,
			["analgesic"] = 100,
			["ritmoneury"] = 100,
			["wheelchair"] = 100,
			["defibrillator"] = 100,
			["medicbag"] = 100,
			["bandage"] = 100,
			["syringe01"] = 2,
			["syringe02"] = 2,
			["syringe03"] = 2,
			["syringe04"] = 2
		}
	},
	["ammunationStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["GADGET_PARACHUTE"] = 10000,
			["WEAPON_HATCHET"] = 10000,  
			["WEAPON_BAT"] = 10000,
			["WEAPON_BATTLEAXE"] = 10000,
			["WEAPON_GOLFCLUB"] = 10000,
			["WEAPON_HAMMER"] = 10000,
			["WEAPON_MACHETE"] = 10000,
			["WEAPON_POOLCUE"] = 10000,
			["WEAPON_STONE_HATCHET"] = 10000,
			["WEAPON_KNUCKLE"] = 10000,
			["WEAPON_FLASHLIGHT"] = 10000,
			--["switchblade"] = 5000
			
			--["attachsFlashlight"] = 500,
			--["attachsCrosshair"] = 500,
			--["attachsSilencer"] = 500,
			--["attachsGrip"] = 500
		}
	},
	--["premiumStore"] = {
		--["mode"] = "Buy",
		--["type"] = "Premium",
		--["list"] = {
			--["gemstone"] = 1,
			--["premium"] = 30,
			--["premiumplate"] = 15,
			--["newgarage"] = 20,
			--["newchars"] = 20,
			--["namechange"] = 20,
			--["newlocate"] = 20
		--}
	--},

	["fishingSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["octopus"] = 100,
			["shrimp"] = 100,
			["carp"] = 180,
			["horsefish"] = 180,
			["tilapia"] = 200,
			["codfish"] = 220,
			["catfish"] = 220,
			["goldenfish"] = 240,
			["pirarucu"] = 240,
			["pacu"] = 240,
			["tambaqui"] = 240
		}
	},
	["huntingStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			--["switchblade"] = 525,
			["WEAPON_MUSKET"] = 3250,
			["WEAPON_SNIPERRIFLE"] = 7250,
			["WEAPON_MUSKET_AMMO"] = 7
		}
	},
	
	["coffeeMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["coffee"] = 150
		}
	},
	["sodaMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["cola"] = 350,
			["soda"] = 350
		}
	},
	["donutMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["donut"] = 150,
			["chocolate"] = 150
		}
	},
	["burgerMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hamburger"] = 350
		}
	},
	["hotdogMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hotdog"] = 350
		}
	},
	["Chihuahua"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hotdog"] = 350,
			["hamburger"] = 350,
			["coffee"] = 350,
			["cola"] = 350,
			["soda"] = 350
		}
	},
	["waterMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["water"] = 50
		}
	},
	["arsenallspd"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Police",
		["list"] = {
			["vest"] = 300,
			["gsrkit"] = 50,
			["gdtkit"] = 50,
			["barrier"] = 50,
			["handcuff"] = 50,
			["WEAPON_SMG"] = 200,
			["WEAPON_PUMPSHOTGUN"] = 200,
			["WEAPON_CARBINERIFLE"] = 200,
			["WEAPON_STUNGRENADE"] = 1500,
			["WEAPON_SPECIALCARBINE_MK2"] = 200,
			["WEAPON_SPECIALCARBINE"] = 200,
			["WEAPON_CARBINERIFLE_MK2"] = 200,
			["energetic"] = 200,
			["backpack"] = 4000,
			["attachsCrosshair"] = 5,
			["attachsFlashlight"] = 5,
			["attachsSilencer"] = 5,
			["attachsGrip"] = 5,
			["WEAPON_STUNGUN"] = 50,
			["WEAPON_COMBATPISTOL"] = 200,
			["WEAPON_HEAVYPISTOL"] = 200,
			["WEAPON_NIGHTSTICK"] = 200,
			["WEAPON_PISTOL_AMMO"] = 2,
			["WEAPON_SMG_AMMO"] = 2,
			["WEAPON_RIFLE_AMMO"] = 2,
			["WEAPON_SHOTGUN_AMMO"] = 2,
			["badge01"] = 10,
			["badge02"] = 10,
			["badge03"] = 10,
			["badge05"] = 10,
			["badge06"] = 10,
			["badge07"] = 10,
			["badge08"] = 10,
			["badge09"] = 10,
			["badge10"] = 10,
			["radio"] = 10
		}
	},
	["fbi"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Fbi",
		["list"] = {
			["vest"] = 300,
			["WEAPON_PISTOL_MK2"] = 300,
			["WEAPON_SMG_MK2"] = 300,
			["handcuff"] = 50,
			["WEAPON_SMG"] = 200,
			["WEAPON_PUMPSHOTGUN"] = 200,
			["WEAPON_CARBINERIFLE"] = 200,
			["WEAPON_STUNGRENADE"] = 1500,
			["WEAPON_SPECIALCARBINE_MK2"] = 200,
			["WEAPON_SPECIALCARBINE"] = 200,
			["WEAPON_CARBINERIFLE_MK2"] = 200,
			["energetic"] = 200,
			["backpack"] = 4000,
			["attachsCrosshair"] = 5,
			["attachsFlashlight"] = 5,
			["attachsSilencer"] = 5,
			["attachsGrip"] = 5,
			["WEAPON_STUNGUN"] = 50,
			["WEAPON_COMBATPISTOL"] = 200,
			["WEAPON_PISTOL_AMMO"] = 2,
			["WEAPON_SMG_AMMO"] = 2,
			["WEAPON_RIFLE_AMMO"] = 2,
			["WEAPON_SHOTGUN_AMMO"] = 2,
			["radio"] = 10
		}
	},
	["ilegalHouse"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["keyboard"] = 250,
			["mouse"] = 200,
			["playstation"] = 1000,
			["xbox"] = 1000,
			["brick"] = 20,
			["dish"] = 45,
			["pan"] = 180,
			["fan"] = 550,
			["blender"] = 450,
			["switch"] = 90,
			["cup"] = 90,
			["lampshade"] = 300
		}
	},
	["ilegalCosmetics"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["silverring"] = 450,
			["goldring"] = 700,
			["watch"] = 500,
			["bracelet"] = 500,
			["dildo"] = 450,
			["spray01"] = 450,
			["spray02"] = 450,
			["spray03"] = 450,
			["spray04"] = 450,
			["sneakers"] = 600,
			["slipper"] = 400,
			["rimel"] = 450,
			["brush"] = 450,
			["soap"] = 400
		}
	},
	["ilegalToys"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["eraser"] = 80,
			["legos"] = 85,
			["ominitrix"] = 85,
			["dices"] = 40,
			["domino"] = 85,
			["floppy"] = 50,
			["horseshoe"] = 85,
			["deck"] = 50
		}
	},
	["ilegalCriminal"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["goldbar"] = 850,
			["brokenpick"] = 80,
			["pliers"] = 80,
			["pager"] = 110,
			["card01"] = 5000,
			["card02"] = 5000,
			["card03"] = 10000,
			["card04"] = 5000,
			["card05"] = 20000,
			["pendrive"] = 5000
		}
	},
	["woodsell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["woodlog"] = 50
		}
	},
	["wheatsell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["wheat"] = 150
		}
	},
	["vestsell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["tomato"] = 50,
			["banana"] = 50,
			["passion"] = 70,
			["grape"] = 75,
			["tange"] = 40,   
			["orange"] = 40,
			["apple"] = 55,
			["strawberry"] = 70,
			["coffee2"] = 80
		}
	},
	["mcFridge"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["soda"] = 100,
			["cola"] = 100,
			["sandwich"] = 100,
			["donut"] = 100,
			--["catburger"] = 500,
			--["milkcereja"] = 500,
		}
	}
}


local BancadaOn = false

RegisterNetEvent("shops:lojacafe")
AddEventHandler("shops:lojacafe",function(source)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		print(user_id)
		if BancadaOn then
			vCLIENT.StatusBancada(source,true)
		else
			vCLIENT.StatusBancada(source,false)
		end
	end
end)

-- cRP.VerificarBancada = function()
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		local users_cafe = vRP.getUsersByPermission("Cafe")
-- 		local cafe = 0
-- 		for k,v in ipairs(users_cafe) do
-- 			cafe = cafe + 1
-- 		end
	
-- 		if BancadaOn or parseInt(cafe) < 1 then
-- 			return true
-- 		else
-- 			return false
-- 		end
-- 	end
-- end

RegisterCommand("cafeloja",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Cafe") then
			if BancadaOn then
				BancadaOn = false
				vCLIENT.StatusBancada(-1,false)
				TriggerClientEvent("Notify",source,"amarelo","Loja <b>Fechada</b>.",5000)
			else
				BancadaOn = true
				vCLIENT.StatusBancada(-1,true)
				TriggerClientEvent("Notify",source,"amarelo","Loja <b>Aberta</b>.",5000)
				--TriggerClientEvent("Notify",-1,"cafe","O <b>Cafe UwU</b> esta com atendente 24h, basta chegar no balcão e mentalizar <b>E</b>.",15000)
			end
		end
	end
end)




-----------------------------------------------------------------------------------------------------------------------------------------
-- NAMES
-----------------------------------------------------------------------------------------------------------------------------------------
local nameMale = { "James","John","Robert","Michael","William","David","Richard","Charles","Joseph","Thomas","Christopher","Daniel","Paul","Mark","Donald","George","Kenneth","Steven","Edward","Brian","Ronald","Anthony","Kevin","Jason","Matthew","Gary","Timothy","Jose","Larry","Jeffrey","Frank","Scott","Eric","Stephen","Andrew","Raymond","Gregory","Joshua","Jerry","Dennis","Walter","Patrick","Peter","Harold","Douglas","Henry","Carl","Arthur","Ryan","Roger","Joe","Juan","Jack","Albert","Jonathan","Justin","Terry","Gerald","Keith","Samuel","Willie","Ralph","Lawrence","Nicholas","Roy","Benjamin","Bruce","Brandon","Adam","Harry","Fred","Wayne","Billy","Steve","Louis","Jeremy","Aaron","Randy","Howard","Eugene","Carlos","Russell","Bobby","Victor","Martin","Ernest","Phillip","Todd","Jesse","Craig","Alan","Shawn","Clarence","Sean","Philip","Chris","Johnny","Earl","Jimmy","Antonio" }
local nameFemale = { "Mary","Patricia","Linda","Barbara","Elizabeth","Jennifer","Maria","Susan","Margaret","Dorothy","Lisa","Nancy","Karen","Betty","Helen","Sandra","Donna","Carol","Ruth","Sharon","Michelle","Laura","Sarah","Kimberly","Deborah","Jessica","Shirley","Cynthia","Angela","Melissa","Brenda","Amy","Anna","Rebecca","Virginia","Kathleen","Pamela","Martha","Debra","Amanda","Stephanie","Carolyn","Christine","Marie","Janet","Catherine","Frances","Ann","Joyce","Diane","Alice","Julie","Heather","Teresa","Doris","Gloria","Evelyn","Jean","Cheryl","Mildred","Katherine","Joan","Ashley","Judith","Rose","Janice","Kelly","Nicole","Judy","Christina","Kathy","Theresa","Beverly","Denise","Tammy","Irene","Jane","Lori","Rachel","Marilyn","Andrea","Kathryn","Louise","Sara","Anne","Jacqueline","Wanda","Bonnie","Julia","Ruby","Lois","Tina","Phyllis","Norma","Paula","Diana","Annie","Lillian","Emily","Robin" }
local userName2 = { "Smith","Johnson","Williams","Jones","Brown","Davis","Miller","Wilson","Moore","Taylor","Anderson","Thomas","Jackson","White","Harris","Martin","Thompson","Garcia","Martinez","Robinson","Clark","Rodriguez","Lewis","Lee","Walker","Hall","Allen","Young","Hernandez","King","Wright","Lopez","Hill","Scott","Green","Adams","Baker","Gonzalez","Nelson","Carter","Mitchell","Perez","Roberts","Turner","Phillips","Campbell","Parker","Evans","Edwards","Collins","Stewart","Sanchez","Morris","Rogers","Reed","Cook","Morgan","Bell","Murphy","Bailey","Rivera","Cooper","Richardson","Cox","Howard","Ward","Torres","Peterson","Gray","Ramirez","James","Watson","Brooks","Kelly","Sanders","Price","Bennett","Wood","Barnes","Ross","Henderson","Coleman","Jenkins","Perry","Powell","Long","Patterson","Hughes","Flores","Washington","Butler","Simmons","Foster","Gonzales","Bryant","Alexander","Russell","Griffin","Diaz","Hayes" }
local userLocate = { "Sul","Norte" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestPerm(shopType)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getFines(user_id) > 0 then
			TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
			return false
		end

		if exports["hud"]:Wanted(user_id,source) then
			return false
		end

		if shops[shopType]["perm"] ~= nil then
			if not vRP.hasGroup(user_id,shops[shopType]["perm"]) then
				return false
			end
		end
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestShop(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local shopSlots = 20
		local inventoryShop = {}
		for k,v in pairs(shops[name]["list"]) do
			table.insert(inventoryShop,{ key = k, price = parseInt(v), name = itemName(k), index = itemIndex(k), peso = itemWeight(k), type = itemType(k), max = itemMaxAmount(k), desc = itemDescription(k) })
		end

		local inventoryUser = {}
		local inventory = vRP.userInventory(user_id)
		for k,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["type"] = itemType(v["item"])
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			inventoryUser[k] = v
		end

		if parseInt(#inventoryShop) > 20 then
			shopSlots = parseInt(#inventoryShop)
		end

		return inventoryShop,inventoryUser,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),shopSlots
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getShopType(name)
    return shops[name]["mode"]
end---------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionShops(shopType,shopItem,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shops[shopType] then
			if shopAmount == nil then shopAmount = 1 end
			if shopAmount <= 0 then shopAmount = 1 end

			local inventory = vRP.userInventory(user_id)
			if (inventory[tostring(slot)] and inventory[tostring(slot)]["item"] == shopItem) or inventory[tostring(slot)] == nil then
				if shops[shopType]["mode"] == "Buy" then
				

					if (vRP.inventoryWeight(user_id) + (itemWeight(shopItem) * parseInt(shopAmount))) <= vRP.getWeight(user_id) then
						if shops[shopType]["type"] == "Cash" then
							if shops[shopType]["list"][shopItem] then
								if shopType == "mechanicTools" then
									local mecAmount = vRP.getUsersByPermission("Mechanic")
									if parseInt(#mecAmount) > 0 then
										TriggerClientEvent("Notify",source,"vermelho","Existem mecanicos em serviço!",5000)
										return
									end
								end
								if vRP.paymentFull(user_id,shops[shopType]["list"][shopItem] * shopAmount) then
									if shopItem == "identity" or string.sub(shopItem,1,5) == "badge" then
										vRP.generateItem(user_id,shopItem.."-"..user_id,parseInt(shopAmount),false,slot)
									elseif shopItem == "fidentity" then
										local identity = vRP.userIdentity(user_id)
										if identity then
											if identity["sex"] == "M" then
												vRP.execute("fidentity/newIdentity",{ name = nameMale[math.random(#nameMale)], name2 = userName2[math.random(#userName2)], locate = userLocate[math.random(#userLocate)], blood = math.random(4) })
											else
												vRP.execute("fidentity/newIdentity",{ name = nameFemale[math.random(#nameFemale)], name2 = userName2[math.random(#userName2)], locate = userLocate[math.random(#userLocate)], blood = math.random(4) })
											end

											local identity = vRP.userIdentity(user_id)
											local consult = vRP.query("fidentity/lastIdentity")
											if consult[1] then
												vRP.generateItem(user_id,shopItem.."-"..consult[1]["id"],parseInt(shopAmount),false,slot)
											end
										end
									else
										vRP.generateItem(user_id,shopItem,parseInt(shopAmount),false,slot)
									end

									TriggerClientEvent("sounds:source",source,"cash",0.1)
								else
									TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
								end
							end
						elseif shops[shopType]["type"] == "Consume" then
							if vRP.tryGetInventoryItem(user_id,shops[shopType]["item"],parseInt(shops[shopType]["list"][shopItem] * shopAmount)) then
								vRP.generateItem(user_id,shopItem,parseInt(shopAmount),false,slot)
								TriggerClientEvent("sounds:source",source,"cash",0.1)
							else
								TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(shops[shopType]["item"]).."</b> insuficiente.",5000)
							end
						elseif shops[shopType]["type"] == "Premium" then
							if vRP.paymentGems(user_id,shops[shopType]["list"][shopItem] * shopAmount) then
								TriggerClientEvent("sounds:source",source,"cash",0.1)
								vRP.generateItem(user_id,shopItem,parseInt(shopAmount),false,slot)
								TriggerClientEvent("Notify",source,"verde","Comprou <b>"..parseFormat(shopAmount).."x "..itemName(shopItem).."</b> por <b>"..parseFormat(shops[shopType]["list"][shopItem] * shopAmount).." Miami Coins</b>.",5000)
							else
								TriggerClientEvent("Notify",source,"vermelho","<b>Miami Coins</b> insuficientes.",5000)
							end
						end
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					end
				elseif shops[shopType]["mode"] == "Sell" then
					local splitName = splitString(shopItem,"-")

					if shops[shopType]["list"][splitName[1]] then
						local itemPrice = shops[shopType]["list"][splitName[1]]

						if itemPrice > 0 then
							if vRP.checkBroken(shopItem) then
								TriggerClientEvent("Notify",source,"vermelho","Itens quebrados não podem ser vendidos.",5000)
								vCLIENT.updateShops(source,"requestShop")
								return
							end
						end

						if shops[shopType]["type"] == "Cash" then
							if vRP.tryGetInventoryItem(user_id,shopItem,parseInt(shopAmount),true,slot) then
								if itemPrice > 0 then
									vRP.generateItem(user_id,"dollars",parseInt(itemPrice * shopAmount),false)
									TriggerClientEvent("sounds:source",source,"cash",0.1)
								end
							end
						elseif shops[shopType]["type"] == "Consume" then
							if vRP.tryGetInventoryItem(user_id,shopItem,parseInt(shopAmount),true,slot) then
								if itemPrice > 0 then
									vRP.generateItem(user_id,shops[shopType]["item"],parseInt(itemPrice * shopAmount),false)
									TriggerClientEvent("sounds:source",source,"cash",0.1)
								end
							end
						end
					end
				end
			end
		else
			print(shopType,shopItem,shopAmount,slot)
		end

		vCLIENT.updateShops(source,"requestShop")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:populateSlot")
AddEventHandler("shops:populateSlot",function(nameItem,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,nameItem,amount,false,slot) then
			vRP.giveInventoryItem(user_id,nameItem,amount,false,target)
			vCLIENT.updateShops(source,"requestShop")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:updateSlot")
AddEventHandler("shops:updateSlot",function(nameItem,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		local inventory = vRP.userInventory(user_id)
		if inventory[tostring(slot)] and inventory[tostring(target)] and inventory[tostring(slot)]["item"] == inventory[tostring(target)]["item"] then
			if vRP.tryGetInventoryItem(user_id,nameItem,amount,false,slot) then
				vRP.giveInventoryItem(user_id,nameItem,amount,false,target)
			end
		else
			vRP.swapSlot(user_id,slot,target)
		end

		vCLIENT.updateShops(source,"requestShop")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DIVINGSUIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:divingSuit")
AddEventHandler("shops:divingSuit",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.request(source,"Comprar <b>Roupa de Mergulho</b> por <b>$2000</b>?") then
			if vRP.paymentFull(user_id,2000) then
				vRP.generateItem(user_id,"divingsuit",1,true)
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
			end
		end
	end
end)