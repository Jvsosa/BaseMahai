-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS CDS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local zoneactions = {
    { name = "Banco Central", 
        poly = nil, 
        tableCds = {
            vec2(187.73,294.82),
            vec2(137.95,151.64),
            vec2(354.98,79.55),
            vec2(406.7,219.79),
            vec2(187.73,294.82),
        }, 
        tableOption = {
            name="Banco Central",
            minZ=80.18,
            maxZ=150.0,
            debugPoly=true,
        }
    },

    { name = "Niobio", 
        poly = nil, 
        tableCds = {

            vec2(3610.99,3594.25),
            vec2(3583.46,3600.18),
            vec2(3585.03,3608.34),
            vec2(3403.36,3641.02),
            vec2(3409.11,3676.98),
            vec2(3429.78,3748.52),
            vec2(3418.2,3769.51),
            vec2(3435.75,3778.25),
            vec2(3455.52,3786.01),
            vec2(3462.7,3802.42),
            vec2(3477.95,3815.44),
            vec2(3501.12,3822.27),
            vec2(3587.5,3820.46),
            vec2(3610.31,3817.68),
            vec2(3628.53,3804.84),
            vec2(3641.87,3784.0),
            vec2(3931.11,3696.01),
            vec2(3947.4,3631.03),
            vec2(3878.97,3601.39),
            vec2(3668.16,3577.99),
            vec2(3610.99,3594.25),

        }, 
        tableOption = {
            name="Niobio",
            minZ=-60.18,
            maxZ=80.0,
            debugPoly=true,
        }
    },


    { name = "Banco Paleto", 
        poly = nil, 
        tableCds = {

            vec2(-213.43,6439.84),
            vec2(-77.13,6591.57),
            vec2(18.84,6494.96),
            vec2(-115.33,6350.2),
            vec2(-213.43,6439.84),

        }, 
        tableOption = {
            name="Banco Paleto",
            minZ=30.18,
            maxZ=67.0,
            debugPoly=true,
        }
    },

	{ name = "Joalheria", 
        poly = nil, 
        tableCds = {
            
            vec2(-470.79, -246.44),
            vec2(-467.02, -240.34),
            vec2(-467.33, -230.28),
            vec2(-545.3, -94.47),
            vec2(-557.72, -83.24),
            vec2(-594.05, -67.03),
            vec2(-615.41, -62.85),
            vec2(-654.81, -63.86),
            vec2(-668.84, -66.14),
            vec2(-846.84, -158.05),
            vec2(-846.74, -160.46),
            vec2(-782.11, -271.8),
            vec2(-778.99, -280.34),
            vec2(-777.74, -293.14),
            vec2(-780.1, -301.95),
            vec2(-781.19, -307.11),
            vec2(-777.77, -309.45),
            vec2(-662.89, -355.26),
            vec2(-657.05, -351.81),
            vec2(-541.79, -276.71),
            vec2(-482.16, -251.56),
            vec2(-470.84, -246.57),
            vec2(-470.79, -246.44),

        }, 
        tableOption = {
            name="Joalheria",
            minZ=30.18,
            maxZ=67.0,
            debugPoly=true,
        }
    },

	{ name = "Galinheiro", 
        poly = nil, 
        tableCds = {
            
            vec2(-41.19,6350.14),
            vec2(32.3,6218.84),
            vec2(-170.03,6033.85),
            vec2(-267.22,6121.36),
            vec2(-41.19,6350.14),

        }, 
        tableOption = {
            name="Galinheiro",
            minZ=30.18,
            maxZ=67.0,
            debugPoly=true,
        }
    },

	{ name = "Açougue", 
        poly = nil, 
        tableCds = {
            
            vec2(938.32,-2094.73),
            vec2(1043.91,-2097.59),
            vec2(1051.99,-2104.85),
            vec2(1055.65,-2115.26),
            vec2(1047.44,-2205.06),
            vec2(927.19,-2198.65),
            vec2(938.32,-2094.73),

        }, 
        tableOption = {
            name="Açougue",
            minZ=30.18,
            maxZ=67.0,
            debugPoly=true,
        }
    },

}

local once_safezone = true
local inCommand = false
local inZone = false
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAIN THREAD
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

infoZone = function()
    CreateThread(function()
        while true do
            local wait_safezone = 1000
            if inCommand then
                local ply = PlayerPedId()
                local pos = GetEntityCoords(ply)
                if IsPedInAnyVehicle(ply) then pos = GetEntityCoords(GetVehiclePedIsIn(ply, false)) end
                
                for k,v in next, zoneactions do
                    wait_safezone = 500
                    if v.poly:isPointInside(pos) then
                        if once_safezone and not inZone then
                            once_safezone = false
                            SendNUIMessage({ show = true, text = "<i style='color: green;' class='fa fa-check'></i> AÇÃO: "..v.name })
                            Citizen.Wait(1000)
                            inZone = v.poly
                        end
                    else
                        if not once_safezone and v.poly == inZone then
                            once_safezone = true
                            inZone = false
                            SendNUIMessage({ show = true, text = "<i style='color: red;' class='fa fa-times'></i> AÇÃO: NENHUM PERIMETRO" })
                        end
                    end
                end
            else
                SendNUIMessage({ show = false})
                break
            end
            Citizen.Wait(wait_safezone)
        end
    end)
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("acoes", function()
    inCommand = not inCommand
    if inCommand then
        local pos = GetEntityCoords(PlayerPedId())

        TriggerEvent("Notify","MODO AÇÃO","O modo ação foi ativado.",7000)
        for k,v in next, zoneactions do
            v.poly = PolyZone:Create(v.tableCds, v.tableOption)
        end
        infoZone()
    else
        TriggerEvent("Notify","MODO AÇÃO","O modo ação foi desativado.",7000)
        for k,v in next, zoneactions do
            v.poly:destroy()
        end
        inZone = false
        once_safezone = true
    end
end)