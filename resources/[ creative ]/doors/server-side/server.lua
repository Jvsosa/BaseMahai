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
Tunnel.bindInterface("doors",cRP)
vTASKBAR = Tunnel.getInterface("taskbar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Doors"] = {

	[2000] = {x = 2571.79, y = -325.58, z = 92.99, hash = 1185512375, lock = true, text = true, distance = 15, press = 6, perm = "Police"  },
	[2001] = {x = 2563.3, y = -325.83, z = 92.99, hash = 1185512375, lock = true, text = true, distance = 15, press = 6, perm = "Police"  },

	
	[5010] = {x = -1993.42, y = 549.75, z = 111.9, hash = 1183182250, lock = true, text = true, distance = 10, press = 2, perm = "Escola", other = 5011  },
	[5011] = {x = -1993.1, y = 550.96, z = 111.9, hash = -44475594, lock = true, text = true, distance = 10, press = 2, perm = "Escola", other = 5010  },
	[5012] = {x = -2007.98, y = 545.03, z = 111.88, hash = -538477509, lock = true, text = true, distance = 10, press = 2, perm = "Escola"  },
	[5013] = {x = -2009.81, y = 538.12, z = 111.88, hash = -538477509, lock = true, text = true, distance = 10, press = 2, perm = "Escola"  },

	

	[2010] = {x = -205.67, y = -1310.57, z = 31.29, hash = -427498890, lock = true, text = true, distance = 10, press = 10, perm = "MecanicaIlegal"  },

	[2004] = {x = 2518.41, y = -330.64, z = 101.89, hash = -2051651622, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 2005  },
	[2005] = {x = 2517.53, y = -331.5, z = 101.89, hash = -2051651622, lock = true, text = true, distance = 10, press = 2, perm = "Police", other = 2004  },

	[2006] = {x = 2510.1, y = -351.54, z = 105.68, hash = 395979613, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[2007] = {x = 2507.45, y = -348.8, z = 105.68, hash = 395979613, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[2008] = {x = 2504.8, y = -351.7, z = 105.68, hash = 395979613, lock = true, text = true, distance = 10, press = 2, perm = "Police" },
	[2009] = {x = 2507.46, y = -354.43, z = 105.68, hash = 395979613, lock = true, text = true, distance = 10, press = 2, perm = "Police" },

	[501] = {x = -421.43, y = 278.67, z = 82.99, hash = -2023754432 , lock = true, text = true, distance = 10, press = 2, perm = "Contrabando1"  },
	[502] = {x = -424.91, y = 284.22, z = 83.19, hash = -1687047623 , lock = true, text = true, distance = 10, press = 2, perm = "Contrabando1" },
	[503] = {x = -433.55, y = 269.45, z = 82.99, hash = -2023754432 , lock = true, text = true, distance = 10, press = 2, perm = "Contrabando1" },
	[504] = {x = -438.47, y = 269.85, z = 82.99, hash = -2023754432 , lock = true, text = true, distance = 10, press = 2, perm = "Contrabando1" },
	[505] = {x = -439.84, y = 269.91, z = 82.99, hash = -2023754432 , lock = true, text = true, distance = 10, press = 2, perm = "Contrabando1" },
	[506] = {x = -430.64, y = 262.25, z = 83.0, hash = -1687047623 , lock = true, text = true, distance = 10, press = 2, perm = "Contrabando1" },
	[507] = {x = -429.34, y = 262.46, z = 83.0, hash = -1687047623 , lock = true, text = true, distance = 10, press = 2, perm = "Contrabando1" },
	[508] = {x = -418.89, y = 268.2, z = 83.19, hash = -1687047623 , lock = true, text = true, distance = 10, press = 2, perm = "Contrabando1" },
	[509] = {x = -420.29, y = 268.0, z = 83.19, hash = -1687047623 , lock = true, text = true, distance = 10, press = 2, perm = "Contrabando1" },

	[50] = {x = -1980.38, y = -495.99, z = 12.18, hash = 2052512905 , lock = true, text = true, distance = 20, press = 2, perm = "Anitta" },
	[51] = {x = -1987.52, y = -512.24, z = 12.18, hash = 308207762 , lock = true, text = true, distance = 10, press = 2, perm = "Anitta" },

	[52] = {x = 196.15, y = -3168.17, z = 5.81, hash = 279397912, lock = true, text = true, distance = 10, press = 2, perm = "Bar", other = 53 },
	[53] = {x = 196.11, y = -3166.9, z = 5.81, hash = 521593591, lock = true, text = true, distance = 10, press = 2, perm = "Bar", other = 52 },
	[54] = {x = 255.66, y = -3158.91, z = -0.19, hash = -2064844044, lock = true, text = true, distance = 10, press = 2, perm = "Bar" },
	[55] = {x = 253.44, y = -3156.46, z = -0.19, hash = -2064844044, lock = true, text = true, distance = 10, press = 2, perm = "Bar" },
	[56] = {x = 245.7, y = -3156.36, z = 3.34, hash = 1127420746, lock = true, text = true, distance = 10, press = 2, perm = "Bar" },
	[57] = {x = 254.96, y = -3156.46, z = 3.34, hash = 390840000, lock = true, text = true, distance = 10, press = 2, perm = "Bar" },
	[58] = {x = 259.6, y = -3164.45, z = 3.23, hash = -1821777087, lock = true, text = true, distance = 10, press = 2, perm = "Bar" },
	[59] = {x = 263.04, y = -3161.52, z = 5.8, hash = -590422879, lock = true, text = true, distance = 10, press = 2, perm = "Bar" },
	[70] = {x = 259.69, y = -3174.4, z = 3.23, hash = -1821777087, lock = true, text = true, distance = 10, press = 2, perm = "Bar" },
	[71] = {x = 195.72, y = -3163.43, z = 5.75, hash = 288432257, lock = true, text = true, distance = 10, press = 2, perm = "Bar" },
	[72] = {x = 244.55, y = -3147.87, z = 3.32, hash = -337682344, lock = true, text = false, distance = 15, press = 2, perm = "Bar" },
	
	--[50] = { x = -587.26, y = -1052.47, z = 22.36, hash = -1283712428, lock = false, text = true, distance = 10, press = 2, perm = "Anitta" },

	[301] = { x = 1141.18, y = -1537.17, z = 35.03, hash = -1337230745, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[302] = { x = 1141.3, y = -1546.66, z = 35.03, hash = -1108204408, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" },
	[303] = { x = 1134.1, y = -1574.75, z = 35.03, hash = 1379556169, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic", other = 304 },
	[304] = { x = 1134.18, y = -1573.75, z = 35.03, hash = 1379556169, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic", other = 303 },
	[305] = { x = 1129.97, y = -1564.12, z = 39.5, hash = 1029158225, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic", other = 306 },
	[306] = { x = 1129.94, y = -1562.8, z = 39.5, hash = 1029158225, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic", other = 305 },

	[1] = { x = -581.2, y = -1069.54, z = 22.36, hash = 526179188, lock = false, text = true, distance = 10, press = 2, perm =     "Cafe", other = 2 },
	[2] = { x = -580.83, y = -1069.63, z = 22.36, hash = -69331849, lock = false, text = true, distance = 10, press = 2, perm =    "Cafe", other = 1 },
	[3] = { x = -600.14, y = -1055.94, z = 22.34, hash = 1099436502, lock = false, text = true, distance = 10, press = 2, perm =   "Cafe", other = 4 }, -- porta fundo
	[4] = { x = -587.26, y = -1052.47, z = 22.36, hash = -1283712428 , lock = false, text = true, distance = 10, press = 2, perm = "Cafe", other = 3 },

	[10] = { x = 121.22, y = -1294.62, z = 21.11, hash = 401003935, lock = true, text = true, distance = 10, press = 2, perm = "Vanilla"}, 
	[11] = { x = 95.87, y = -1285.6, z = 29.32, hash = 401003935, lock = true, text = true, distance = 10, press = 2, perm = "Vanilla"}, 
	[12] = { x = 100.19, y = -1295.44, z = 29.32, hash = 401003935, lock = true, text = true, distance = 10, press = 2, perm = "Vanilla"}, 
	[13] = { x = 124.26, y = -1299.2, z = 29.28, hash = -884268790, lock = true, text = true, distance = 10, press = 2, perm = "Vanilla"}, 
	 
	 
	[30] = { x = 1463.75, y = -2492.9, z = 63.98, hash = 1173348778, lock = false, text = true, distance = 10, press = 2, perm =   "Beiramar"}, 
	[31] = { x = 1466.85, y = -2487.2, z = 67.31, hash = 1173348778, lock = false, text = true, distance = 10, press = 2, perm =   "Beiramar"}, 
	
	[60] = { x = -1388.62, y = -587.63, z = 30.31, hash = 666905606, lock = true, text = true, distance = 10, press = 2, perm =   "Bahamas" , other = 61 }, 
	[61] = { x = -1387.49, y = -586.95, z = 30.33, hash = -224738884, lock = true, text = true, distance = 10, press = 2, perm =   "Bahamas" , other = 60 }, 
	[62] = { x = -1374.32, y = -627.95, z = 30.31, hash = 134859901, lock = true, text = true, distance = 10, press = 2, perm =   "Bahamas" }, 
	[63] = { x = -1378.21, y = -622.21, z = 30.31, hash = -2102541881, lock = true, text = true, distance = 10, press = 2, perm =   "Bahamas" }, 
	[64] = { x = -1378.43, y = -625.09, z = 30.31, hash = -2102541881, lock = true, text = true, distance = 10, press = 2, perm =   "Bahamas" }, 

	[100] = { x = -1540.52, y = 835.3, z = 181.78, hash = 206972566, lock = true, text = true, distance = 10, press = 2, perm =   "Runway" , other = 101 }, 
	[101] = { x = -1539.19, y = 835.88, z = 181.78, hash = 206972566, lock = true, text = true, distance = 10, press = 2, perm =   "Runway" , other = 100 },  
	[102] = { x = -1500.21, y = 853.57, z = 181.88, hash = -1119680854, lock = true, text = true, distance = 10, press = 2, perm =   "Runway" , other = 103 }, 
	[103] = { x = -1499.49, y = 852.33, z = 181.88, hash = -1119680854, lock = true, text = true, distance = 10, press = 2, perm =   "Runway" , other = 102 }, 
	[104] = { x = -1485.46, y = 849.76, z = 181.78, hash = -88942360, lock = true, text = true, distance = 10, press = 2, perm =   "Runway" , other = 105 }, 
	[105] = { x = -1486.11, y = 851.16, z = 181.78, hash = -88942360, lock = true, text = true, distance = 10, press = 2, perm =   "Runway" , other = 104 },  
	[106] = { x = -1484.12, y = 846.35, z = 181.81, hash = 719388042, lock = true, text = true, distance = 10, press = 2, perm =   "Runway" },  
	[107] = { x = -1480.86, y = 839.91, z = 181.78, hash = -311575617, lock = true, text = true, distance = 10, press = 2, perm =   "Runway" },  
	


	[108] = { x = -600.76, y = -1059.15, z = 22.54, hash = 522844070 , lock = true, text = true, distance = 10, press = 2, perm =   "Cafe" , other = 101 }, 
	
	[109] = { x = 128.76, y = -1298.24, z = 29.28, hash = 401003935, lock = true, text = true, distance = 10, press = 2, perm =   "Vanilla" , other = 100 },  
	[110] = { x = 117.33, y = -1304.96, z = 29.32, hash = 488457389, lock = true, text = true, distance = 10, press = 2, perm =   "Vanilla" , other = 103 }, 
	
	[111] = { x = 1367.41, y = 89.39, z = 108.78, hash = 1173348778, lock = true, text = true, distance = 10, press = 2, perm =   "Barragem" , other = 102 }, 
	[112] = { x = 1371.92, y = 85.09, z = 112.12, hash = 1173348778, lock = true, text = true, distance = 10, press = 2, perm =   "Barragem" , other = 105 }, 
	
	[113] = { x = 2846.73, y = 2690.62, z = 102.11, hash = 1042741067, lock = true, text = true, distance = 10, press = 2, perm =   "Mineradora" , other = 104 },  
	[114] = { x = 2852.73, y = 2697.31, z = 98.86, hash = -1119680854, lock = true, text = true, distance = 10, press = 2, perm =   "Mineradora" },  
	[115] = { x = 2857.8, y = 2700.82, z = 98.86, hash = 62695846, lock = true, text = true, distance = 10, press = 2, perm =   "Mineradora" },  
	
	
	[116] = { x = 3155.69, y = 5304.26, z = 31.68, hash = 1173348778, lock = true, text = true, distance = 10, press = 2, perm =   "Farol" , other = 102 }, 
	[117] = { x = 3160.26, y = 5299.48, z = 28.34, hash = 1173348778, lock = true, text = true, distance = 10, press = 2, perm =   "Farol" , other = 105 }, 
	
	
	[118] = { x = 2507.86, y = 4096.87, z = 38.69, hash = 782767342, lock = true, text = true, distance = 10, press = 2, perm =   "Contrabando2" , other = 104 },  
	[119] = { x = 2520.66, y = 4123.77, z = 38.59, hash = 497665568, lock = true, text = true, distance = 10, press = 2, perm =   "Contrabando2" },   
	[120] = { x = 2512.65, y = 4104.94, z = 38.59, hash = -626684119, lock = true, text = true, distance = 10, press = 2, perm =   "Contrabando2" },  


	[200] = {x = -1828.69, y = 418.8, z = 121.62, hash = -1438552720, lock = true, text = true, distance = 10, press = 2, perm = "Mafia1" },
	[201] = {x = -1804.56, y = 436.25, z = 128.83, hash = 2074032093, lock = true, text = true, distance = 10, press = 2, perm = "Mafia1" },
	[202] = {x = -1804.74, y = 428.63, z = 128.73, z = 128.83, hash = 1826999110, lock = true, text = true, distance = 10, press = 2, perm = "Mafia1" },
	[203] = {x = -1798.21, y = 469.42, z = 133.69, hash = 724862427, lock = true, text = true, distance = 10, press = 2, perm = "Mafia1" },

	[204] = {x = -1799.45, y = 471.84, z = 133.69, hash = 546378757, lock = true, text = true, distance = 10, press = 10, perm = "Mafia1", other = 205 },
	[205] = {x = -1800.71, y = 474.11, z = 133.69, hash = -1249591818, lock = true, text = true, distance = 10, press = 10, perm = "Mafia1", other = 204 },


	[206] = {x = -1786.35, y = 419.81, z = 117.02, hash = -782244720, lock = true, text = true, distance = 10, press = 2, perm = "Mafia1" },
	[207] = {x = -1787.67, y = 412.05, z = 113.57, hash = -8018817937, lock = true, text = true, distance = 10, press = 2, perm = "Mafia1" },
	[208] = {x = -1792.44, y = 411.82, z = 113.45, hash = 149328230, lock = true, text = true, distance = 10, press = 2, perm = "Mafia1" },
	
	[209] = {x = -1815.27, y = 424.16, z = 128.33, hash = 451680698, lock = true, text = true, distance = 10, press = 2, perm = "Mafia1", other = 210 },
	[210] = {x = -1816.76, y = 424.05, z = 128.33, hash = 451680698, lock = true, text = true, distance = 10, press = 2, perm = "Mafia1", other = 209 },

	[300] = {x = -2599.87, y = 1672.53, z = 141.86, hash = 1286535678, lock = true, text = true, distance = 10, press = 10, perm = "Municao2", other = 209 },
	[3001] = {x = -2594.7, y = 1675.15, z = 141.86, hash = 1286535678, lock = true, text = false, distance = 10, press = 2, perm = "Admin", other = 209 },



	[800] = {x = -449.26, y = -52.56, z = 44.6, hash = -684382235, lock = true, text = true, distance = 10, press = 2, perm = "Argentina" },

	[805] = {x = 960.08, y = -140.26, z = 74.49, hash = 741314661, lock = true, text = true, distance = 10, press = 2, perm = "Desmanche" },
	[806] = {x = 981.68, y = -102.79, z = 74.85, hash = 190770132, lock = true, text = true, distance = 10, press = 2, perm = "Desmanche" },	
	[807] = {x = 982.19, y = -135.69, z = 73.09, hash = -190780785, lock = true, text = true, distance = 10, press = 2, perm = "Desmanche" },

	[820] = {x = -85.18, y = 834.85, z = 235.91, hash = 110411286, lock = true, text = true, distance = 10, press = 2, perm = "Mafia2" },
	[821] = {x = -49.71, y = 830.1, z = 235.75, hash = -1119680854, lock = true, text = true, distance = 10, press = 2, perm = "Mafia2" }, 
	[822] = {x = -69.25, y = 824.52, z = 235.73, hash = -1119680854, lock = true, text = true, distance = 10, press = 2, perm = "Mafia2" }, 
	[823] = {x = -81.01, y = 822.39, z = 235.75, hash = -1119680854, lock = true, text = true, distance = 10, press = 2, perm = "Mafia2" }, 
	[824] = {x = -97.55, y = 816.37, z = 235.76, hash = -1119680854, lock = true, text = true, distance = 10, press = 2, perm = "Mafia2" }, 
	[825] = {x = -51.58, y = 828.19, z = 231.4, hash = -1119680854, lock = true, text = true, distance = 10, press = 2, perm = "Mafia2" }, 
	[826] = {x = -70.79, y = 824.38, z = 231.33, hash = -1119680854, lock = true, text = true, distance = 10, press = 2, perm = "Mafia2" }, 
	[827] = {x = -78.42, y = 822.89, z = 227.79, hash = -1119680854, lock = true, text = true, distance = 10, press = 2, perm = "Mafia2" },
	[828] = {x = -90.26, y = 818.31, z = 227.61, hash = 631614199, lock = true, text = true, distance = 10, press = 2, perm = "Mafia2" }, 
	[829] = {x = -91.21, y = 821.64, z = 240.21, hash = -1186396713, lock = true, text = true, distance = 10, press = 2, perm = "Mafia2" }, 
	[830] = {x = -94.68, y = -2463.29, z = 6.17, hash = 949892120, lock = true, text = false, distance = 10, press = 2, perm = "Mafia2", other = 831 }, 
	[831] = {x = -94.68, y = -2463.29, z = 6.17, hash = 1716195189, lock = true, text = true, distance = 10, press = 2, perm = "Mafia2", other = 830 }, 
	[832] = {x = -104.61, y = 850.24, z = 235.63, hash = -1249591818, lock = true, text = false, distance = 10, press = 2, perm = "Mafia2", other = 833 }, 
	[833] = {x = -104.61, y = 850.24, z = 235.63, hash = 546378757, lock = true, text = true, distance = 10, press = 2, perm = "Mafia2", other = 832 }, 

	[990] = {x = -2588.28, y = 1910.62, z = 167.49, hash = 308207762, lock = true, text = true, distance = 10, press = 2, perm =   "weston" }, 
	[991] = {x = -2594.72, y = 1916.85, z = 167.3, hash = -2037125726, lock = true, text = true, distance = 10, press = 2, perm =   "weston" }, 
	[992] = {x = -2599.64, y = 1900.82, z = 167.3, hash = 813813633, lock = true, text = true, distance = 10, press = 2, perm =   "weston" }, 
	[993] = {x = -2600.0, y = 1902.43, z = 163.75, hash = 813813633, lock = true, text = true, distance = 10, press = 2, perm =   "weston" }, 
	[994] = {x = -2558.33, y = 1913.57, z = 168.87, hash = 546378757, lock = true, text = true, distance = 10, press = 10, perm =   "weston", other = 995 }, 
	[995] = {x = -2558.33, y = 1913.57, z = 168.87, hash = -1249591818, lock = true, text = false, distance = 10, press = 10, perm =   "weston", other = 994 }, 


	[996] = {x = 465.28, y = -2743.5, z = 6.07, hash = -626303826, lock = true, text = false, distance = 10, press = 2, perm =   "Cupula" }, 
	[997] = {x = 474.22, y = -2728.93, z = 6.08, hash = 599682771, lock = true, text = false, distance = 10, press = 2, perm =   "Cupula" }, 
	[998] = {x = 577.98, y = -2803.92, z = 6.08, hash = 531616259, lock = true, text = false, distance = 10, press = 2, perm =   "Cupula" }, 

	[10000] = {x = 1134.11, y = -1544.21, z = 39.5, hash = -1337230745, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" }, 
	[10001] = {x = 1135.6, y = -1549.43, z = 39.5, hash = -206212846, lock = true, text = true, distance = 10, press = 2, perm = "Paramedic" }, 
	[10002] = {x = 722.97, y = -1088.37, z = 22.17, hash = 270330101, lock = true, text = true, distance = 10, press = 2, perm = "FacExtra" }, 
	
	[9000] = {x = -2318.99, y = 3395.17, z = 30.77, hash = 741314661, lock = true, text = true, distance = 10, press = 2, perm = "Exercito" }, 
	[9001] = {x = -2315.12, y = 3400.73, z = 30.77, hash = 741314661, lock = true, text = true, distance = 10, press = 2, perm = "Exercito" }, 
	[9002] = {x = -1602.26, y = 2803.53, z = 17.1, hash = 741314661, lock = true, text = true, distance = 10, press = 2, perm = "Exercito" }, 
	[9003] = {x = -1597.27, y = 2808.26, z = 17.14, hash = 741314661, lock = true, text = true, distance = 10, press = 2, perm = "Exercito" }, 

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS 262671971 2023754432
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.doorsStatistics(doorNumber,doorStatus)
	local Doors = GlobalState["Doors"]

	Doors[doorNumber]["lock"] = doorStatus

	if Doors[doorNumber]["other"] ~= nil then
		local doorSecond = Doors[doorNumber]["other"]
		Doors[doorSecond]["lock"] = doorStatus
	end

	GlobalState["Doors"] = Doors
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.doorsPermission(doorNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if GlobalState["Doors"][doorNumber]["perm"] ~= nil then
			if vRP.hasGroup(user_id,GlobalState["Doors"][doorNumber]["perm"]) then
				return true
			else
				local consultItem = vRP.getInventoryItemAmount(user_id,"lockpick2")
				if consultItem[1] >= 1 then
					if math.random(100) >= 50 then
						vRP.removeInventoryItem(user_id,consultItem[2],1,true)
						vRP.generateItem(user_id,"brokenpick",1,false)
					end

					local taskResult = vTASKBAR.taskDoors(source)
					if taskResult then
						return true
					end
				end
			end
		end
	end

	return false
end