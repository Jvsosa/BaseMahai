Safezone = {
	["Praca"] = PolyZone:Create({
		vector2(205.79,-1024.9),
		vector2(208.78,-1025.24),
		vector2(211.59,-1023.95),
		vector2(213.45,-1021.75),
		vector2(265.77,-877.37),
		vector2(265.96,-872.18),
		vector2(263.66,-867.45),
		vector2(260.59,-865.25),
		vector2(253.69,-862.65),
		vector2(250.3,-863.26),
		vector2(246.89,-864.0),
		vector2(196.15,-845.44),
		vector2(194.17,-843.28),
		vector2(191.79,-840.11),
		vector2(186.61,-840.59),
		vector2(183.84,-843.67),
		vector2(174.82,-866.8),
		vector2(169.77,-877.06),
		vector2(162.94,-886.97),
		vector2(159.76,-893.61),
		vector2(126.22,-985.71),
		vector2(126.45,-990.34),
		vector2(129.62,-993.36),
		vector2(152.5,-1001.3),
		vector2(155.39,-1006.91),
		vector2(157.51,-1008.65),
		vector2(162.7,-1010.22),
		vector2(169.57,-1007.15),
		vector2(192.45,-1014.76),
		vector2(195.25,-1020.51),
		vector2(198.78,-1022.51)
	},{
		["name"] = "Praca",
		["minZ"] = 0.00,
		["maxZ"] = 150.00,
		debugPoly = false
	}),

	-- ["Flamingo"] = PolyZone:Create({
	-- 	vector2(-1777.19,-831.38),
	-- 	vector2(-1704.35,-730.98),
	-- 	vector2(-1770.1,-670.52),
	-- 	vector2(-1844.36,-756.5),
	-- 	vector2(-1777.19,-831.38),
	-- },{
	-- 	["name"] = "Flamingo",
	-- 	["minZ"] = 0,
	-- 	["maxZ"] = 150,
	-- 	debugPoly = false
	-- }),	
	
	["Cafe"] = PolyZone:Create({
		vector2(-569.02,-1167.58),
		vector2(-623.18,-1167.4),
		vector2(-623.76,-1013.47),
		vector2(-618.56,-971.77),
		vector2(-557.51,-975.13),
		vector2(-559.55,-1123.78),
		vector2(-569.02,-1167.58),
	},{
		["name"] = "Cafe",
		["minZ"] = 0,
		["maxZ"] = 150
		--debugPoly = true
	}),

	["Spawn"] = PolyZone:Create({
		vector2(228.89,-1143.5),
		vector2(237.49,-1219.64),
		vector2(294.51,-1218.1),
		vector2(273.49,-1141.39),
		vector2(228.89,-1143.5),
	},{
		["name"] = "Spawn",
		["minZ"] = 0,
		["maxZ"] = 150,
		debugPoly = false
	}),

	["Hospital"] = PolyZone:Create({
		vector2(1097.53,-1455.27),
		vector2(1243.53,-1459.0),
		vector2(1242.6,-1504.99),
		vector2(1195.67,-1574.01),
		vector2(1148.76,-1632.25),
		vector2(1119.38,-1631.63),
		vector2(1094.83,-1531.13),
		vector2(1097.37,-1454.67),
	},{
		["name"] = "Hospital",
		["minZ"] = 0,
		["maxZ"] = 150,
		-- debugPoly = false
	}),

}

SpotifyInfos = {
	["Praca"] = { status = true },
	["StopCar"] = { LocalState = "StopCar" },
	["Hospital"] = { LocalState = "Paramedic" },
	["Cafe"] = { LocalState = "Cafe" },
	["Flamingo"] = { LocalState = "Flamingo" },
	["OverSpeed"] = { LocalState = "OverSpeed" },
}