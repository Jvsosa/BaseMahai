Config = {}

------------------------------------------
-- [ Ddiretorios ]
------------------------------------------

Config.Imagens_Inventario = "nui://inventory/web-side/images"
Config.Imagens_InventarioXamp = "http://localhost/itens/"
Config.Imagens_Garagem = "http://localhost/cars/"
Config.Imagens_Skins = "http://localhost/skins/"
Config.Banner = "https://media.discordapp.net/attachments/913250396363972649/1022196772266835998/a_d4b844c948a4031ad19ff7b5f3ed1eb4.gif"

------------------------------------------
-- [ Permissoes ]
------------------------------------------

Config.Perms = {
    teleport = "Admin",
    pegar_itens = "Admin",
    pegar_carros = "Admin",
}

------------------------------------------
-- [ Logs ]
------------------------------------------

Config.Webhooks = {
    skins = "https://discord.com/api/webhooks/1101693326916325386/H457ChrMYBdyWS8JH4ZFzX45ZDKDjFua7KoJmEuRBT3tZHH2lKwhUypvH_XWoRLUyQTQ",
    control_inventario = "https://discord.com/api/webhooks/1101703473285840967/QwfwEfImWKYDcreLBKdF4-HwY6c9PfQoh6xC1f-x9tbOEyJVKOLbYN-hF0ZPN7IDzc1I",
    control_garagem = "https://discord.com/api/webhooks/1101708501807550505/3RFIQi4QO8UA2iFjl6s-T0Od2_qkB625i5cFyAPHD_m7UFJrl4CgjMowOesglZSV9gQ4",
    spawnDinheiro = "https://discord.com/api/webhooks/1101760835854008403/AASVRvcBLpFYjC5MUB_lk7-pZhmZ_dOWKYYyKw6DDzrs_4fli7i-guyQAANuHXDAZVC7",
    trocarCelular = "https://discord.com/api/webhooks/1101763414017191936/JLQreLqAkPhUkxD1MFZFNlRZUeW7npWaxhCroZRFb4br-FRny0xe2bxh1zhjgW-_cZr3",
    trocarNome = "https://discord.com/api/webhooks/1101765096839073792/q7lXQYaEzkKSLaLqPgg19Hmb9JswA4A_JI73a3-yl9P4dFfuL5Tl5n2opYerJPCUe4pW"
}

------------------------------------------
-- [ Skins ]
------------------------------------------

Config.Skins = { -- 1100 x 900
    [1] = { nome = "Default M", set = "mp_m_freemode_01", sexo = "Default" },
    [2] = { nome = "Default F", set = "mp_f_freemode_01" , sexo = "Default" },
    [3] = { nome = "Tomy", set = "CS_GambozBaby", sexo = "M" },
    [4] = { nome = "Mia", set = "DKS_ADULTAMiaO", sexo = "F" },
    [5] = { nome = "Britt", set = "CS_HikAdultaFixx2", sexo = "F" },
    [6] = { nome = "Lukinho", set = "ss_closetluke", sexo = "M" },
    [8] = { nome = "Bruninho", set = "CS_Bruninho", sexo = "M" },
    [9] = { nome = "Hugo", set = "Hugojeca", sexo = "M" },
    [10] = { nome = "Jade", set = "ss_closetjadesete", sexo = "F" },
    [11] = { nome = "Duda (Player)", set = "BBSHOP_DudaMenina", sexo = "F" },
    [12] = { nome = "Flor (Player)", set = "babyflor_oc", sexo = "F" },
    [13] = { nome = "Fernando", set = "baby_fernando", sexo = "M" },
    [14] = { nome = "Lunna (Player)", set = "LUNNA_BLUESTORE", sexo = "F" },
}

Config.Ignorar_Blacklist = "Dono"

Config.Cargos_blacklist = {
    "Dono",
    "Admin",
    "Mod"
}


Config["baus"] = {
    [1] = { bau = "mecanico", tipo = "Facção" }, 
    [2] = { bau = "policia", tipo = "Policia" }, 
}

--------------------------------
-- [ SISTEMA DE GROUPS ] --
--------------------------------

Config["groups"] = {
    ["Policia"] = {
        permissao = "policia.perm",
        cargos = {
            [1] = "Policia10",
            [2] = "Policia9",
            [3] = "Policia8",
            [4] = "Policia7",
            [5] = "Policia6",
            [6] = "Policia5",
            [7] = "Policia4",
            [8] = "Policia3",
            [9] = "Policia2",
            [10] = "Policia1",
        }
    },
}

--------------------------------
-- [ SISTEMA DE CARGOS ] --
--------------------------------

Config["discord-guild"] = {
    discord_normal = "952756530648842280",
    discord_ilegal = "952756530648842280",
    discord_policia = "952756530648842280",
}

Config["cargosAdd"] = { -- Cargos disponiveis para add lembrando o sistema de blacklist elimina
    [1] = { tag = "Dono" , id_discord = "787785524290519071", tipo = "discord_normal" },
    [2] = { tag = "Farol" , id_discord = "1031933959354990683" , tipo = "discord_ilegal" },
    [3] = { tag = "Farol1" , id_discord = "1031933964664963122", tipo = "discord_ilegal" },
    [4] = { tag = "Farol2" , id_discord = "1029632980320260148", tipo = "discord_ilegal" },
    [5] = { tag = "Farol3" , id_discord = "1031933965470269570", tipo = "discord_ilegal" },
    [6] = { tag = "Policia10" , id_discord = "1033564979414188052", tipo = "discord_normal" },
}

Config["igoreBlacklist"] = "dono.perm" -- Cargo que podera ignorar a blacklist
Config["blacklist"] = { -- Cargos que os staff normais nao vao conseguir setar nem retirar !
    "Dono",
}

--------------------------------
-- [ SISTEMA DE PUNICOES ] --
--------------------------------

Config["ban"] = {
    banir_do_discord = false, -- True [Sim] / False [Nao] (Caso for nao ele vai aplicar o cargo Banido)
    id_cargo = "1035624796500799520",
}

return Config