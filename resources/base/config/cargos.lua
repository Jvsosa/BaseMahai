-- 🚀 MAHAI CREATIVE - CONFIGURAÇÃO DE CARGOS
Config = Config or {}

Config.Cargos = {
    -------------------------------
    -- [ ADMINISTRAÇÃO ]
    -------------------------------
    ["Dono"] = {
        ["Dono"] = true,
        ["Admin"] = true,
    },
    ["Admin"] = {
        ["Admin"] = true,
    },
    ["Suporte"] = {
        ["Suporte"] = true
    },
    ["Moderator"] = {
        ["Admin"] = true,
        ["Moderator"] = true
    },
    ["StreamerVip"] = {
        ["StreamerVip"] = true,
    },

    -------------------------------
    -- [ FORÇAS DE SEGURANÇA ]
    -------------------------------
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
    -------------------------------
    -- [ SAÚDE E EMERGÊNCIA ]
    -------------------------------
    ["Paramedic"] = {
        ["Paramedic"] = true,
    },
    ["Hospital"] = {
        ["Hospital"] = true,
        ["Paramedic"] = true,
    },


    -------------------------------
    -- [ SERVIÇOS ]
    -------------------------------
    ["Mechanic"] = {
        ["Mechanic"] = true,
    },
    ["Juridico"] = {
        ["Juridico"] = true,
    },
    ["Weazel"] = {
        ["Weazel"] = true,
    },
    ["Cafe"] = {
        ["Cafe"] = true,
    },

    -------------------------------
    -- [ VIP SYSTEM ]
    -------------------------------
    ["vipsilver"] = {
        ["vipsilver"] = true		
    },
    ["vipgold"] = {
        ["vipgold"] = true				
    },	
    ["vipplatinum"] = {
        ["vipplatinum"] = true				
    },
    ["vipdiamond"] = {
        ["vipdiamond"] = true				
    },
    ["vipadvanced"] = {
        ["vipadvanced"] = true				
    },
    ["vipmaui"] = {
        ["vipmaui"] = true
    },
    ["vipkids"] = {
        ["vipkids"] = true
    },
    ["vipfac"] = {
        ["vipfac"] = true
    },

    -------------------------------
    -- [ MANSÕES ]
    -------------------------------
    ["malibu"] = {
        ["malibu"] = true
    },	
    ["weston"] = {
        ["weston"] = true		
    },
    ["Richers"] = {
        ["Richers"] = true
    },

    -------------------------------
    -- [ UTILITÁRIOS ]
    -------------------------------
    ["cam"] = {
        ["cam"] = true
    },	
    ["roupas"] = {
        ["roupas"] = true		
    },
    ["spotify"] = {
        ["spotify"] = true		
    },	
    ["wecolor"] = {
        ["wecolor"] = true		
    },
    ["Streamer"] = {
        ["Streamer"] = true
    },

    -------------------------------
    -- [ ORGANIZAÇÕES LEGAIS ]
    -------------------------------
    ["ClubAnitta"] = {
        ["ClubAnitta"] = true,	
    },
    ["Flamingo"] = {
        ["Flamingo"] = true,	
    },
    ["Escola"] = {
        ["Escola"] = true,	
    },
    ["Runway"] = {
        ["Runway"] = true,	
    },
    ["Anitta"] = {
        ["Anitta"] = true,	
    },
    ["Bar"] = {
        ["Bar"] = true
    },
}

-- ✅ FUNÇÃO CORRIGIDA PARA CONTAR CARGOS
local function countCargos()
    local count = 0
    for k,v in pairs(Config.Cargos) do
        count = count + 1
    end
    return count
end

print('^7[^2CONFIG^7] Cargos carregados: ^2'..countCargos()..'^7 cargos disponíveis!')

-- Helper function
function table.keys(t)
    local keys = {}
    for k,v in pairs(t) do
        table.insert(keys, k)
    end
    return keys
end