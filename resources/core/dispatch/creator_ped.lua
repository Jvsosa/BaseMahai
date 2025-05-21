-- -----------------------------------------------------------------------------------------------------------------------------------------
-- --[ AGACHAR ]----------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        DisableControlAction(0,36,true)
        if not IsPedInAnyVehicle(ped) then
            RequestAnimSet("move_ped_crouched")
            RequestAnimSet("move_ped_crouched_strafing")
            if IsDisabledControlJustPressed(0,36) then
                if agachar then
                    ResetPedStrafeClipset(ped)
                    ResetPedMovementClipset(ped,0.25)
                    agachar = false
                else
                    SetPedStrafeClipset(ped,"move_ped_crouched_strafing")
                    SetPedMovementClipset(ped,"move_ped_crouched",0.25)
                    agachar = true
                end
            end
        end
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- AGACHAR
-----------------------------------------------------------------------------------------------------------------------------------------
-- local agachar = false
-- local movimento = false


-- RegisterKeyMping('tes:test', 'tes', 'keyboard', 'LCONTROL')

-- RegisterCommand("tes:test",function(source,args,rawCommand)
-- 	if not IsPedInAnyVehicle(PlayerPedId()) then 
-- 		local ped = PlayerPedId()
-- 		if DoesEntityExist(ped) and not IsEntityDead(ped) then 
--             if not IsPauseMenuActive() then 
--                 if IsPedJumping(ped) then
--                     movimento = false
--                 end
--             end
--         end
	
--         if DoesEntityExist(ped) and not IsEntityDead(ped) then 
--             DisableControlAction(0,36,true)
--             if not IsPauseMenuActive() then 
-- 				-- if IsDisabledControlJustPressed(0,36) and not IsPedInAnyVehicle(ped) then
			
-- 					RequestAnimSet("move_ped_crouched")
-- 					RequestAnimSet("move_ped_crouched_strafing")
-- 					if agachar == true then 
-- 						ResetPedMovementClipset(ped,0.30)
-- 						ResetPedStrafeClipset(ped)
-- 						movimento = false
-- 						agachar = false 

-- 					elseif agachar == false then
-- 						SetPedMovementClipset(ped,"move_ped_crouched",0.30)
-- 						SetPedStrafeClipset(ped,"move_ped_crouched_strafing")
-- 						agachar = true 


-- 						Citizen.CreateThread(function()
-- 							while agachar do
-- 								local player = PlayerId()
-- 								DisablePlayerFiring(player, true)
-- 								Citizen.Wait(1)
-- 							end
-- 						end)

-- 					end
--                 -- end
--             end 
-- 		end
-- 	end
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local localPeds = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local pedList = {

	{ -- Concessionária
		distance = 30,
		coords = { -56.76,-1098.79,26.42,17.01 },
		model = { 0x5D71A46F,"s_f_y_airhostess_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

    { -- Loja eletronicos
		distance = 30,
		coords = { -627.34,-275.55,35.57,116.23	 },
		model = { 0x9E80D2CE,"a_m_y_genstreet_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

	{ -- Loja Mecânico2
		distance = 30,
		coords = { 819.1,-988.03,26.64,357.17 },
		model = { 0x9E80D2CE,"s_m_m_lathandy_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Concessionária2
		distance = 30,
		coords = { -32.99,-1100.29,26.42,65.2 },
		model = { 0xAF03DDE1,"ig_molly" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	--{ -- TowDriver Norte
	--	distance = 100,
	--	coords = { -273.96,6121.63,31.41,130.4 },
	--	model = { 0xF1E823A2,"g_m_m_armboss_01" },
	--	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	--},
	--{ -- TowDriver Meio
	--	distance = 100,
	--	coords = { 1737.95,3709.1,34.14,19.85 },
	--	model = { 0xF1E823A2,"g_m_m_armboss_01" },
	--	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	--},
	{ -- TowDriver CitySul
		distance = 30,
		coords = { -1080.76,-860.76,5.04,218.27 },
		model = { 0xF1E823A2,"g_m_m_armboss_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- WeedShop
		distance = 30,
		coords = { -1171.3,-1571.12,4.67,127.56 },
		model = { 0xE83B93B7,"g_m_y_famca_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Coveiro
		distance = 100,
		coords = { -1745.92,-204.83,57.39,320.32 },
		model = { 0xF1E823A2,"g_m_m_armboss_01" },
		anim = { "timetable@trevor@smoking_meth@base","base" }
	},



	
	--{ -- Leiteiro
	--	distance = 100,
	--	coords = { 2440.58,4736.35,34.29,317.50 },
	--	model = { 0xFCFA9E1E,"a_c_cow" }
	--},
	--{ -- Leiteiro
	--	distance = 100,
	--	coords = { 2432.5,4744.58,34.31,317.50 },
	--	model = { 0xFCFA9E1E,"a_c_cow" }
	--},
	--{ -- Leiteiro
	--	distance = 100,
	--	coords = { 2424.47,4752.37,34.31,317.50 },
	--	model = { 0xFCFA9E1E,"a_c_cow" }
	--},
	--{ -- Leiteiro
	--	distance = 100,
	--	coords = { 2416.28,4760.8,34.31,317.50 },
	--	model = { 0xFCFA9E1E,"a_c_cow" }
	--},
	--{ -- Leiteiro
	--	distance = 100,
	--	coords = { 2408.6,4768.88,34.31,317.50 },
	--	model = { 0xFCFA9E1E,"a_c_cow" }
	--},
	--{ -- Leiteiro
	--	distance = 100,
	--	coords = { 2400.32,4777.48,34.53,317.50 },
	--	model = { 0xFCFA9E1E,"a_c_cow" }
	--},
	--{ -- Leiteiro
	--	distance = 100,
	--	coords = { 2432.46,4802.66,34.83,137.50 },
	--	model = { 0xFCFA9E1E,"a_c_cow" }
	--},
	--{ -- Leiteiro
	--	distance = 100,
	--	coords = { 2440.62,4794.22,34.66,137.50 },
	--	model = { 0xFCFA9E1E,"a_c_cow" }
	--},
	--{ -- Leiteiro
	--	distance = 100,
	--	coords = { 2448.65,4786.57,34.64,137.50 },
	--	model = { 0xFCFA9E1E,"a_c_cow" }
	--},
	--{ -- Leiteiro
	--	distance = 100,
	--	coords = { 2456.88,4778.08,34.49,137.50 },
	--	model = { 0xFCFA9E1E,"a_c_cow" }
	--},
	--{ -- Leiteiro
	--	distance = 100,
	--	coords = { 2464.53,4770.04,34.37,137.50 },
	--	model = { 0xFCFA9E1E,"a_c_cow" }
	--},
	--{ -- Leiteiro
	--	distance = 100,
	--	coords = { 2473.38,4760.98,34.31,137.50 },
	--	model = { 0xFCFA9E1E,"a_c_cow" }
	--},
	--{ -- Leiteiro
	--	distance = 100,
	--	coords = { 2495.03,4762.77,34.37,137.50 },
	--	model = { 0xFCFA9E1E,"a_c_cow" }
	--},
	--{ -- Leiteiro
	--	distance = 100,
	--	coords = { 2503.13,4754.08,34.31,137.50 },
	--	model = { 0xFCFA9E1E,"a_c_cow" }
	--},
	--{ -- Leiteiro
	--	distance = 100,
	--	coords = { 2511.34,4746.04,34.31,137.50 },
	--	model = { 0xFCFA9E1E,"a_c_cow" }
	--},
	--{ -- Leiteiro
	--	distance = 100,
	--	coords = { 2519.56,4737.35,34.29,137.50 },
	--	model = { 0xFCFA9E1E,"a_c_cow" }
	--},
	{ -- Agricultor
		distance = 100,
		coords = { 2243.5,5154.31,57.88,144.57 },
		model = { 0x1536D95A,"a_m_o_ktown_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Agricultor vendedor
		distance = 100,
		coords = { 2570.76,4668.03,34.07,136.07 },
		model = { 0x1536D95A,"a_m_o_ktown_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	
	{ -- Imobiliária
		distance = 100,
		coords = { -552.84,-188.74,38.22,223.94 },
		model = { 0xF161D212,"s_m_m_highsec_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Prefeitura
		distance = 30,
		coords = { -554.5,-189.61,38.22,215.44 },
		model = { 0x2F8845A3,"ig_barry" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	
	{ -- Black Market
		distance = 20,
		coords = { 2431.86,4967.66,42.34,133.23 },
		model = { 0xF42EE883,"g_m_y_ballaeast_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2431.09,4970.72,42.34,42.52 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2436.08,4965.39,42.34,226.78 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2434.4,4963.8,42.34,229.61 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2432.44,4964.06,42.34,178.59 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@world_human_bum_wash@male@high@base","base" }
	},
		{ -- Black Market
		distance = 20,
		coords = { 1184.1,2721.68,38.62,2.84 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2431.57,4965.22,42.34,124.73 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@world_human_bum_wash@male@high@base","base" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2428.67,4969.51,42.34,133.23 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "anim@amb@business@coc@coc_packing_hi@","full_cycle_v1_pressoperator" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2437.05,4967.61,42.34,317.49 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "anim@amb@business@coc@coc_packing_hi@","full_cycle_v1_pressoperator" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2433.09,4971.51,42.34,320.32 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "anim@amb@business@coc@coc_packing_hi@","full_cycle_v1_pressoperator" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2432.67,4970.29,42.34,226.78 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2435.28,4969.27,42.34,317.49 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }
	},
	{ -- Taxi
		distance = 50,
		coords = { -1039.34,-2730.8,20.2,235.28 },
		model = { 0x8674D5FC,"a_m_y_stlat_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 301.4,-195.29,61.57,158.75 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 169.28,-1536.23,29.25,311.82 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 487.56,-1456.11,29.28,272.13 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 154.66,-1472.9,29.35,325.99 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 389.69,-942.1,29.42,175.75 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 475.1,3555.28,33.23,263.63 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 112.41,3373.68,35.25,59.53 },
		model = { 0xF42EE883,"g_m_y_ballaeast_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 2013.95,4990.88,41.21,133.23 },
		model = { 0x23B88069,"g_m_y_ballasout_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 186.9,6374.75,32.33,206.93 },
		model = { 0xE83B93B7,"g_m_y_famca_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { -653.2,-1502.18,5.24,201.26 },
		model = { 0xDB729238,"g_m_y_famdnf_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	
		{ -- Ilegal
		distance = 100,
		coords = { 1175.37,2722.04,38.0,11.34 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	
		{ -- Ilegal
		distance = 100,
		coords = { 1164.43,2722.12,38.0,11.34 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	
		{ -- Ilegal
		distance = 100,
		coords = { 1158.91,2722.03,38.0,357.17},
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	--{ -- Police
	--	distance = 100,
	--	coords = { 1851.95,2589.92,45.73,272.13 },
	--	model = { 0x15F8700D,"s_f_y_cop_01" },
	--	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	--},
	--{ -- Police  LSPD    441.38,-974.69,25.7,195.6
	--	distance = 100,
	--	coords = { 441.26,-982.04,30.68,90.71 },
	--	model = { 0x625D6958,"s_m_m_ciasec_01" },
	--	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	--},
	--{ -- Police
	--	distance = 100,
	--	coords = { 1758.39,2513.73,55.44,257.96 },
	--	model = { 0x15F8700D,"s_f_y_cop_01" },
	--	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	--},
	{ -- Paramedic
		distance = 100,
		coords = { -271.7,6321.75,32.42,0.0 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 100,
		coords = { -816.47,-1237.74,7.33,45.36 },
		model = { 0xB353629E,"s_m_m_scientist_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic Heli
		distance = 100,
		coords = { -1856.98,-335.02,58.08,138.9 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedictratamento
		distance = 100,
		coords = { -1851.62,-337.29,49.45,138.9 },
		model = { 0x4117D39B,"s_m_m_scientist_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 1
		distance = 10,
		coords = { 24.1,-1345.92,29.49,272.13 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 2
		distance = 10,
		coords = { 2555.99,380.91,108.61,5.67 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 3
		distance = 10,
		coords = { 1164.82,-323.65,69.2,96.38 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 4
		distance = 10,
		coords = { -706.15,-914.53,19.21,85.04 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 5
		distance = 10,
		coords = { -47.38,-1758.68,29.42,42.52 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 6
		distance = 10,
		coords = { 372.78,327.24,103.56,255.12 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 7
		distance = 6,
		coords = { -3242.7,999.93,12.82,0.0 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 8
		distance = 6,
		coords = { 1728.27,6416.01,35.03,240.95 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 9
		distance = 10,
		coords = { 549.2,2670.59,42.16,93.55 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 10
		distance = 6,
		coords = { 1959.7,3740.75,32.33,294.81 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 11
		distance = 6,
		coords = { 2676.99,3280.0,55.23,320.32 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 12
		distance = 6,
		coords = { 1697.31,4923.49,42.06,325.99 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 13
		distance = 6,
		coords = { -1819.52,793.48,138.08,127.56 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 14
		distance = 6,
		coords = { 1391.69,3605.97,34.98,198.43 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 15
		distance = 10,
		coords = { -2966.41,391.55,15.05,85.04 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 16
		distance = 10,
		coords = { -3039.49,584.27,7.9,14.18},
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 17
		distance = 10,
		coords = { 1134.33,-983.11,46.4,274.97 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 18
		distance = 10,
		coords = { 1165.28,2710.77,38.15,175.75 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 19
		distance = 10,
		coords = { -1486.72,-377.55,40.15,130.4 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 20
		distance = 10,
		coords = { -1220.95,-907.59,12.32,28.35 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 21
		distance = 10,
		coords = { 161.19,6642.24,31.69,221.11},
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store 22
		distance = 10,
		coords = { 291.99,-1272.61,29.52,354.34 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store 1
		distance = 12,
		coords = { 1695.26,3760.94,34.69,130.4},
		model = { 0x441405EC,"s_m_y_xmech_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store 2
		distance = 12,
		coords = { 250.12,-51.56,69.94,28.35 },
		model = { 0x441405EC,"s_m_y_xmech_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store 3
		distance = 12,
		coords = { 840.19,-1032.14,28.19,317.49 },
		model = { 0x441405EC,"s_m_y_xmech_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store 4
		distance = 12,
		coords = { -327.81,6084.3,31.46,175.75 },
		model = { 0x441405EC,"s_m_y_xmech_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store 5
		distance = 12,
		coords = { -660.05,-936.71,21.82,138.9 },
		model = { 0x441405EC,"s_m_y_xmech_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store 6
		distance = 12,
		coords = { -1307.72,-396.02,36.7,34.02},
		model = { 0x441405EC,"s_m_y_xmech_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store 7
		distance = 12,
		coords = { -1115.16,2698.94,18.55,175.75},
		model = { 0x441405EC,"s_m_y_xmech_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

	{ -- Ammu-Nation Store 8
		distance = 12,
		coords = { 2565.72,295.73,108.73,317.49 },
		model = { 0x441405EC,"s_m_y_xmech_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store 9
		distance = 12,
		coords = { -3169.76,1089.16,20.84,204.1 },
		model = { 0x441405EC,"s_m_y_xmech_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store 10
		distance = 12,
		coords = { 22.54,-1105.54,29.79,155.91},
		model = { 0x441405EC,"s_m_y_xmech_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store 11
		distance = 12,
		coords = { 810.26,-2159.02,29.62,354.34 },
		model = { 0x441405EC,"s_m_y_xmech_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Embarcações 01
		distance = 12,
		coords = { -1728.0,-1050.71,1.7,325.99  },
		model = { 0xD1FEB884,"a_m_y_beach_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Embarcações 02
		distance = 12,
		coords = { 1966.61,3976.16,31.49,170.08 },
		model = { 0xD1FEB884,"a_m_y_beach_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Embarcações 03
		distance = 12,
		coords = { -776.65,-1495.0,2.29,280.63 },
		model = { 0xD1FEB884,"a_m_y_beach_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Embarcações 04
		distance = 12,
		coords = { -895.2,5687.33,2.98,286.3 },
		model = { 0xD1FEB884,"a_m_y_beach_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Embarcações 05
		distance = 12,
		coords = { 4971.71,-5170.86,2.27,243.78 },
		model = { 0xD1FEB884,"a_m_y_beach_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Life Invader
		distance = 20,
		coords = { -1083.15,-245.88,37.76,209.77 },
		model = { 0x2F8845A3,"ig_barry" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 30,
		coords = { -172.89,6381.32,31.48,223.94 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

	{ -- Pharmacy Store
		distance = 30,
		coords = { 1136.52,-1557.09,35.03,0.0 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 30,
		coords = { -1255.45,-1434.56,4.36,127.56 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 30,
		coords = { 1690.07,3581.68,35.62,212.6 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 15,
		coords = { 326.5,-1074.43,29.47,0.0 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 15,
		coords = { 114.39,-4.85,67.82,204.1 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 15,
		coords = { -1227.23,-1474.87,4.36,124.73 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	-- { -- Mercado Central Balas
	-- 	distance = 50,
	-- 	coords = { 46.65,-1749.7,29.62,51.03 },
	-- 	model = { 0xE6631195,"ig_cletus" },
	-- 	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	-- },
	--[[{ -- Mercado Crafting Balas
		distance = 50,
		coords = { 47.5,-1748.22,29.64,82.21 },
		model = { 0x3521A8D2,"a_m_y_genstreet_02" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},]]
	{ -- Mercado Central Deserto
		distance = 50,
		coords = { 2749.06,3482.96,55.67,59.53 },
		model = { 0xE6631195,"ig_cletus" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},




	--{ -- Minerador
	--	distance = 30,
	--	coords = { 2964.43,2752.88,43.32,215.44 },
	--	model = { 0xD7DA9E99,"s_m_y_construct_01" },
	--	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	--},
	{ -- Mergulhador
		distance = 20,
		coords = { 1520.56,3780.08,34.46,274.97 },
		model = { 0xC79F6928,"a_f_y_beach_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	--{ -- hospital
	--	distance = 50,
	--	coords = { -816.38,-1237.66,7.33,45.36 },
	--	model = { 0xC79F6928,"ig_casey" },
	--	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	--},
	
	
	---816.43,-1237.63,7.33,48.19

	{ -- Loja de Roupas 1
		distance = 20,
		coords = { 80.43,-1387.68,29.37,172.92 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas 2
		distance = 20,
		coords = { -708.92,-151.85,37.41,116.23 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas 3
		distance = 20,
		coords = { -164.96,-303.08,39.73,246.62 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas 4
		distance = 20,
		coords = { -815.47,-1075.25,11.32,107.72 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas 5
		distance = 20,
		coords = { -1193.16,-766.48,17.3,218.27 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas 6
		distance = 20,
		coords = { -1448.83,-237.87,49.81,51.03 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas 7
		distance = 20,
		coords = { -2.33,6512.48,31.88,306.15 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas 8
		distance = 20,
		coords = { 1689.59,4817.02,42.06},
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas 9
		distance = 20,
		coords = { 126.61,-225.19,54.56,70.87 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas 10
		distance = 20,
		coords = { 612.89,2763.71,42.09,272.13},
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas 11
		distance = 20,
		coords = { 1201.9,2705.06,38.22,87.88 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas 12
		distance = 20,
		coords = { -3169.85,1042.26,20.86,62.37 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas 13
		distance = 20,
		coords = { -1094.34,2710.46,19.11,121.89 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas 14
		distance = 20,
		coords = { 420.74,-811.47,29.49,354.34 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas 15
		distance = 20,
		coords = { 1944.74,3767.12,32.59,294.81},
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas 17
		distance = 20,
		coords = { -804.76,-593.73,30.28,235.28},
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { 1324.38,-1650.09,52.27,127.56 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { -1152.27,-1423.81,4.95,124.73 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { 319.84,180.89,103.58,246.62 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { -3170.41,1073.06,20.83,334.49 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { 1862.58,3748.52,33.03,28.35 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { -292.02,6199.72,31.49,223.94 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},




	{ -- Rota aluminio
		distance = 25,
		coords = { -110.58,-32.5,62.2,24.31 },
		model = { 0x38BAD33B,"a_f_m_fatwhite_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

	{ -- Rota aluminio
		distance = 25,
		coords = { -195.94,-1314.64,34.98,175.75 },
		model = { 0xE11A9FB4,"ig_josef" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},




	{ -- Colheita
		distance = 30,
		coords = { 406.13,6526.22,27.75,82.21 },
		model = { 0x94562DD7,"a_m_m_farmer_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	
	{ -- Colheita
		distance = 30,
		coords = { 2477.53,4445.85,35.33,274.97 },
		model = { 0x94562DD7,"a_m_m_farmer_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Motorista
		distance = 30,
		coords = { 452.97,-607.75,28.59,266.46 },
		model = { 0x2A797197,"u_m_m_edtoh" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lixeiro
		distance = 50,
		coords = { -347.09,-1576.81,25.22,328.82 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},


	

	{ -- Digital den
		distance = 20,
		coords = { -1529.45,-400.07,35.64,229.61 },
		model = { 0xE6631195,"ig_cletus" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

	{ -- Venda de Animais
		distance = 20,
		coords = { 562.26,2752.94,42.87,184.26 },
		model = { 0xC8BB1E52,"u_m_y_mani" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

	{ -- Venda de Frutas
		distance = 20,
		coords = { 649.61,2728.26,41.99,274.97 },
		model = { 0x5389A93C,"ig_lifeinvad_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},


	{ -- NPC Barragem
		distance = 20,
		coords = { 1355.73,86.79,109.0,303.31 },
		model = { 0xCAE9E5D5,"csb_cletus" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

	
	{ -- NPC Barragem
		distance = 20,
		coords = { -1824.72,435.7,118.37,102.05 },
		model = { 0xCAE9E5D5,"csb_cletus" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

		
	{ -- NPC Barragem
		distance = 20,
		coords = { -62.82,821.53,227.78,8.51 },
		model = { 0xCAE9E5D5,"csb_cletus" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

	{ -- NPC Barragem
		distance = 20,
		coords = { -1880.41,2063.95,135.91,249.45 },
		model = { 0xCAE9E5D5,"csb_cletus" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},


	{ -- NPC Barragem
		distance = 20,
		coords = { -593.69,-1068.06,22.34,0.0 },
		model = { 0x41018151,"a_f_m_ktown_02" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

	
	{ -- NPC Barragem
		distance = 20,
		coords = { -1217.85,-1494.96,4.36,34.02 },
		model = { 0x41018151,"a_f_m_ktown_02" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},


	{ -- NPC Barragem
		distance = 20,
		coords = { 2857.01,2686.21,102.14,303.31 },
		model = { 0xCAE9E5D5,"csb_cletus" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

	{ -- NPC Barragem
		distance = 20,
		coords = { 987.88,-95.1,74.85,223.94 },
		model = { 0xCAE9E5D5,"csb_cletus" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},


	{ -- NPC Barragem
		distance = 20,
		coords = { 1468.25,-2489.72,63.98,17.01 },
		model = { 0xCAE9E5D5,"csb_cletus" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},


	{ -- NPC Barragem
		distance = 20,
		coords = { 524.08,-2765.06,6.64,25.52 },
		model = { 0x41018151,"a_f_m_ktown_02" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	
	{ -- NPC Barragem
		distance = 20,
		coords = { 121.65,-3038.28,7.04,269.3 },
		model = { 0x41018151,"a_f_m_ktown_02" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

	{ -- NPC Barragem
	distance = 20,
	coords = { 2578.84,-294.87,93.4,87.88 },
	model = { 0x3E8417BC,"mp_m_execpa_01" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	
	{ -- NPC Barragem
	distance = 20,
	coords = { 3158.79,5305.06,28.34,87.88 },
	model = { 0x3E8417BC,"mp_m_execpa_01" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

	
	{ -- NPC Barragem
	distance = 20,
	coords = { 863.39,1857.92,141.12,198.43 },
	model = { 0x3E8417BC,"mp_m_execpa_01" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

	{ -- NPC Barragem
	distance = 20,
	coords = { -1519.25,4792.84,69.19,232.45 },
	model = { 0x3E8417BC,"mp_m_execpa_01" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},


	{ -- NPC Barragem
	distance = 20,
	coords = { 251.45,-3149.64,3.32,172.92 },
	model = { 0xCAE9E5D5,"csb_cletus" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

	
	{ -- NPC Barragem
	distance = 20,
	coords = { -1732.31,355.75,89.42,311.82 },
	model = { 0xCAE9E5D5,"csb_cletus" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},

	{ -- NPC Barragem
	distance = 20,
	coords = { 728.21,-1063.87,22.16,178.59 },
	model = { 0xCAE9E5D5,"csb_cletus" },
	anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},





}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(pedList) do
			local distance = #(coords - vector3(v["coords"][1],v["coords"][2],v["coords"][3]))
			if distance <= v["distance"] then
				if localPeds[k] == nil then
					local mHash = GetHashKey(v["model"][2])

					RequestModel(mHash)
					while not HasModelLoaded(mHash) do
						Citizen.Wait(1)
					end

					if HasModelLoaded(mHash) then
						localPeds[k] = CreatePed(4,v["model"][1],v["coords"][1],v["coords"][2],v["coords"][3] - 1,v["coords"][4],false,false)
						SetPedArmour(localPeds[k],100)
						SetEntityInvincible(localPeds[k],true)
						FreezeEntityPosition(localPeds[k],true)
						SetBlockingOfNonTemporaryEvents(localPeds[k],true)

						SetModelAsNoLongerNeeded(mHash)

						if v["anim"] ~= nil then
							RequestAnimDict(v["anim"][1])
							while not HasAnimDictLoaded(v["anim"][1]) do
								Citizen.Wait(1)
							end

							TaskPlayAnim(localPeds[k],v["anim"][1],v["anim"][2],8.0,0.0,-1,1,0,0,0,0)
						end
					end
				end
			else
				if localPeds[k] then
					DeleteEntity(localPeds[k])
					localPeds[k] = nil
				end
			end
		end

		Citizen.Wait(1000)
	end
end)



