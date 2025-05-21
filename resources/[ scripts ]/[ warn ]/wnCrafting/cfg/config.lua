Config = {}

--- So passando para avisar que caso o item tenha "dinheiro" nao pode remover nenhum outro item

Config.Craft = {

    ["Desmanche"] = {
		blip = {['x'] = 978.55, ['y'] = -92.04, ['z'] = 74.85},
		permissao = "Desmanche",
        log = "https://discord.com/api/webhooks/1119202187545940052/SuHlcPsW-QegeHOPxE3_VWbQM-2n8KKSs4XJI65o52_VBs3K4QXv6-VuBtRcOU_e8E8b",
        crafts = {
            ["ticket"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "leather" , amount = 3 },
                }
            }, 
            ["lockpick"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 10 },
                }
            }, 
        }
	},
    
    ["FacExtra"] = {
		blip = {['x'] = 725.79, ['y'] = -1071.05, ['z'] = 28.31},
		permissao = "FacExtra",
        log = "https://discord.com/api/webhooks/1119220775338135562/W3xMAbRqJX_TGNshqLCWX5RnEcvlk-kpYbq9a-8rDkY-DKbvtPLncv6sm9_y6Uv0hZn4",
        crafts = {
            ["ticket"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "leather" , amount = 3 },
                }
            }, 
            ["lockpick"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 10 },
                }
            }, 
        }
	},

    ["ClubAniita"] = {
		blip = {['x'] = 247.64, ['y'] = -3161.27, ['z'] = -0.195},
		permissao = "ClubAniita",
        crafts = {
            ["cellphone"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 60, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "rose" , amount = 3 },
                }
            }, 
        }
	},
    
	["Beiramar"] = {
		blip = {['x'] = 1464.1, ['y'] = -2492.71, ['z'] = 67.31},
		permissao = "Beiramar",
        log = "https://discord.com/api/webhooks/1119211740832485386/RCU5mwxJz_9YmxPwmwYFAVqCjV9rlncbFcpgNev-7rKIHf7y_ziYUJe6_Z1fDoWmvpDp",
        crafts = {
            ["lsd"] = { 
                quantidade = 3, -- Quantidade feita por Craft
                tempo = 2, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "weedleaf" , amount = 2 },
                    { item = "silk" , amount = 1 },
                }
            }, 
        }
	},

    ["Mineradora"] = {
		blip = {['x'] = 2845.98, ['y'] = 2688.47, ['z'] = 102.11},
		permissao = "Mineradora",
        log = "https://discord.com/api/webhooks/1119233583916253224/Vk_II94h9K0GeoXrhIAjGMqnDL1emqlt8sbQovhPNZdwD_BC1ti8Dc3GWP8jXIFV6jsL",
        crafts = {
            ["cocaine"] = { 
                quantidade = 3, -- Quantidade feita por Craft
                tempo = 2, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "cokeleaf" , amount = 1 },
                    { item = "sulfuric" , amount = 1 },
                }
            }, 
        }
	},

    ["Fazenda"] = {
		blip = {['x'] = 856.38, ['y'] = 1850.18, ['z'] = 144.12},
		permissao = "Fazenda",
        log = "https://discord.com/api/webhooks/1121601563950067742/FbXRCJ5uRNRk_FLfppJauPjNi82CIyhNYQLyB1U1bCpZQU7qeVEZYptwe1Zb4oBxwwtU",
        crafts = {
            ["cocaine"] = { 
                quantidade = 3, -- Quantidade feita por Craft
                tempo = 2, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "cokeleaf" , amount = 1 },
                    { item = "sulfuric" , amount = 1 },
                }
            }, 
        }
	},

    ["Farol"] = {
		blip = {['x'] = 3159.95, ['y'] = 5300.22, ['z'] = 31.68},
		permissao = "Farol",
        log = "https://discord.com/api/webhooks/1119199121182568488/VV87xkqrMEruGeCFwh-axAG4700MmrHLUDWOGsBGYNsd7UO9xsmzHpuFHzF1AKT8qivO",
        crafts = {
            ["meth"] = { 
                quantidade = 3, -- Quantidade feita por Craft
                tempo = 2, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "saline" , amount = 1 },
                    { item = "acetone" , amount = 1 },
                }
            }, 
        }
	},

    ["Flamingo"] = {
		blip = {['x'] = -1792.18, ['y'] = -768.55, ['z'] = 12.45},
		permissao = "Flamingo",
        log = "",
        crafts = {
            ["absolut"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            }, 
            ["chandon"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            }, 
            ["dewars"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            }, 
            ["hennessy"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            }, 
            ["bento"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            }, 
            ["pizzaf"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            }, 

            ["ramenf"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            }, 

            ["rosquinhaf"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            }, 

            ["teaf"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            },
            
            ["sucotropical"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            },

               
            ["toddy"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            },


        }
	},

    ["Noruega"] = {
		blip = {['x'] = -1517.28, ['y'] = 4797.21, ['z'] = 72.52},
		permissao = "Noruega",
        log = "https://discord.com/api/webhooks/1121929176631492678/zkdJgLwJrYr-04PKKU63runYTPkwq0xLHCITVHn81qDH-_ViGaTsnxUuh3URXdPPBF_H",
        crafts = {
            ["meth"] = { 
                quantidade = 3, -- Quantidade feita por Craft
                tempo = 2, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "saline" , amount = 1 },
                    { item = "acetone" , amount = 1 },
                }
            }, 
        }
	},

    ["Combustivel"] = {
		blip = {['x'] = 3173.91, ['y'] = 5590.59, ['z'] = 279.79},
		permissao = "none",
        crafts = {
            ["WEAPON_PETROLCAN"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 1, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 500 },
                }
            }, 
            ["WEAPON_PETROLCAN_AMMO"] = { 
                quantidade = 2000, -- Quantidade feita por Craft
                tempo = 1, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 500 },
                }
            }, 
        }
	},

    ["Municao1"] = {
		blip = {['x'] = -1870.52, ['y'] = 2061.97, ['z'] = 135.44},
		permissao = "Municao1",
        log = "https://discord.com/api/webhooks/1119221537644482580/LBSiHQpW-gZZrgMUgt4Wzusx-ieCGhLAdU2_JlaUPXNlcMMe3oVhAD-bUIO6W8c2HxRr",
        crafts = {
            ["WEAPON_PISTOL_AMMO"] = { 
                quantidade = 12, -- Quantidade feita por Craft
                tempo = 1, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "gunpowder" , amount = 2 },
                    { item = "capsule" , amount = 1 },
                }
            }, 
            ["WEAPON_SMG_AMMO"] = { 
                quantidade = 12, -- Quantidade feita por Craft
                tempo = 2, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "gunpowder" , amount = 3 },
                    { item = "capsule" , amount = 2 },
                }
            }, 
            ["WEAPON_RIFLE_AMMO"] = { 
                quantidade = 12, -- Quantidade feita por Craft
                tempo = 3, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "gunpowder" , amount = 5 },
                    { item = "capsule" , amount = 3 },
                }
            }, 
       
            ["vest"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "leather" , amount = 6 },
                    { item = "aluminum" , amount = 6 },
                }
            }, 
            
        }
	},



    ["Bar"] = {
		blip = {['x'] = 242.25, ['y'] = -3142.03, ['z'] = 3.32},
		permissao = "Bar",
        log = "https://discord.com/api/webhooks/1119232667158851705/NM4ae5LoouSz3Dj5LVy8QvG_c4b7v-5HvubabDCCXuxHlEqoalzCDKNspGiKYVDyeYF7",
        crafts = {
            ["WEAPON_PISTOL_AMMO"] = { 
                quantidade = 12, -- Quantidade feita por Craft
                tempo = 1, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "gunpowder" , amount = 2 },
                    { item = "capsule" , amount = 1 },
                }
            }, 
            ["WEAPON_SMG_AMMO"] = { 
                quantidade = 12, -- Quantidade feita por Craft
                tempo = 2, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "gunpowder" , amount = 3 },
                    { item = "capsule" , amount = 2 },
                }
            }, 
            ["WEAPON_RIFLE_AMMO"] = { 
                quantidade = 12, -- Quantidade feita por Craft
                tempo = 3, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "gunpowder" , amount = 5 },
                    { item = "capsule" , amount = 3 },
                }
            }, 
       
            ["vest"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "leather" , amount = 6 },
                    { item = "aluminum" , amount = 6 },
                }
            }, 
            
        }
	},

    ["Municao2"] = {
		blip = {['x'] = 2985.62, ['y'] = 3487.18, ['z'] = 67.57},
		permissao = "Municao2",
        log = "https://discord.com/api/webhooks/1119225956893216819/8VHuB0ru-T6GZssesSGEeDsc7mKLqGx_7aS-JBmEJYH8PVHEGazfkxoQ-jeSQ1ClT1Cr",
        crafts = {
            ["WEAPON_PISTOL_AMMO"] = { 
                quantidade = 12, -- Quantidade feita por Craft
                tempo = 1, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "gunpowder" , amount = 2 },
                    { item = "capsule" , amount = 1 },
                }
            }, 
            ["WEAPON_SMG_AMMO"] = { 
                quantidade = 12, -- Quantidade feita por Craft
                tempo = 2, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "gunpowder" , amount = 3 },
                    { item = "capsule" , amount = 2 },
                }
            }, 
            ["WEAPON_RIFLE_AMMO"] = { 
                quantidade = 12, -- Quantidade feita por Craft
                tempo = 3, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "gunpowder" , amount = 5 },
                    { item = "capsule" , amount = 3 },
                }
            }, 
            ["vest"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "leather" , amount = 6 },
                    { item = "aluminum" , amount = 6 },
                }
            }, 
        }
	},

    ["Barragem"] = {
		blip = {['x'] = 1367.6, ['y'] = 88.99, ['z'] = 112.12},
		permissao = "Barragem",
        log = "https://discord.com/api/webhooks/1119197023049089035/d9h4Yu7YBLWLuggzSqh8o7lQMbx4V4OueWoxtMwl3IhvmaEjIFrglXuhwVASlo4O4VMb",
        crafts = {
            ["lean"] = { 
                quantidade = 3, -- Quantidade feita por Craft
                tempo = 2, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "codeine" , amount = 2 },
                    { item = "glass" , amount = 1 },
                }
            }, 
        }
	},

    ["Contrabando1"] = {
		blip = {['x'] = -417.66, ['y'] = 276.85, ['z'] = 82.99},
		permissao = "Contrabando1",
        log = "https://discord.com/api/webhooks/1119228025863688242/1uG6fBS6uquMK63kg6WyfuPPiWEf595D-TuRJ7FgHy3Eoo_jg2k1I-bID9QMOCc4hLi6",
        crafts = {
            ["handcuff"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 20 },
                }
            },
            ["hood"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "leather" , amount = 5 },
                }
            },
            ["lockpick"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 20 },
                }
            }, 
            ["card01"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "plastic" , amount = 20 },
                    { item = "aluminum" , amount = 10 },
                }
            },
            ["card02"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "plastic" , amount = 25 },
                    { item = "aluminum" , amount = 10 },
                }
            }, 
            ["card03"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "plastic" , amount = 32 },
                    { item = "aluminum" , amount = 10 },
                }
            }, 
            ["card04"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "plastic" , amount = 40 },
                    { item = "aluminum" , amount = 10 },
                }
            }, 
            ["card05"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "plastic" , amount = 45 },
                    { item = "aluminum" , amount = 10 },
                }
            }, 
            ["floppy"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "plastic" , amount = 5 },
                    { item = "aluminum" , amount = 5 },
                }
            }, 

            ["attachsFlashlight"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 7 },
                }
            }, 

            ["attachsCrosshair"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 7 },
                }
            }, 

            ["attachsSilencer"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 7 },
                }
            }, 

            ["attachsGrip"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 7 },
                }
            }, 

        }
	},

    ["Contrabando2"] = {
		blip = {['x'] = 2521.48, ['y'] = 4106.23, ['z'] = 35.59},
		permissao = "Contrabando2",
        log = "https://discord.com/api/webhooks/1119231543802597407/ezOV2qyapmfHC56D5tqoGUBQewSnedceoK_VSUyKu-eHyMlqTlhJ_7EeYUIIRcBVOgUu",
        crafts = {
            ["handcuff"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 20 },
                }
            },
            ["hood"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "leather" , amount = 5 },
                }
            },
            ["floppy"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "plastic" , amount = 5 },
                    { item = "aluminum" , amount = 5 },
                }
            }, 
            ["lockpick"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 20 },
                }
            }, 
            ["attachsFlashlight"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 7 },
                }
            }, 

            ["attachsCrosshair"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 7 },
                }
            }, 

            ["attachsSilencer"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 7 },
                }
            }, 

            ["attachsGrip"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 7 },
                }
            }, 

            ["card01"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "plastic" , amount = 20 },
                    { item = "aluminum" , amount = 10 },
                }
            },
            ["card02"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "plastic" , amount = 25 },
                    { item = "aluminum" , amount = 10 },
                }
            }, 
            ["card03"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "plastic" , amount = 32 },
                    { item = "aluminum" , amount = 10 },
                }
            }, 
            ["card04"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "plastic" , amount = 40 },
                    { item = "aluminum" , amount = 10 },
                }
            }, 
            ["card05"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "plastic" , amount = 45 },
                    { item = "aluminum" , amount = 10 },
                }
            }, 
        }
	},

	["Cafe"] = {
		blip = {['x'] = -586.25, ['y'] = -1061.94, ['z'] = 22.34},
		permissao = "Cafe",
        log = "https://discord.com/api/webhooks/1125847755978448916/9GWEZwosDihsK56h31OaVUwa9ESdQqM4jZ_b1FKc57aYhj9nCUljfCrsEASc_efw3ZsS",
        crafts = {
            ["mamadeira"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "leite" , amount = 1 },
                }
            }, 
            ["sorvete2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "frutas" , amount = 2 },
                
                    { item = "leite" , amount = 1 },
                }
            }, 
            ["milkuwu"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "frutas" , amount = 2 },
                
                    { item = "leite" , amount = 1 },
                }
            }, 
            ["bolinhodecereja"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "frutas" , amount = 2 },
                
                    { item = "leite" , amount = 1 },
                }
            }, 
            ["bolodecoco"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "farinha" , amount = 1 },
                    { item = "leite" , amount = 1 },
                }
            }, 
            ["bolodemilho"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "farinha" , amount = 1 },
                    { item = "leite" , amount = 1 },
                }
            }, 
            ["chocolatecremoso"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "farinha" , amount = 1 },
                    { item = "leite" , amount = 1 },
                }
            }, 
            ["cupcakedelaranja"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "frutas" , amount = 2 },
                    { item = "leite" , amount = 1 },
                }
            }, 
            ["leitecomcanela"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "leite" , amount = 1 },
                }
            },
            ["capuccino"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "leite" , amount = 1 },
                }
            },
            ["coelhodechocolate"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                  
                    { item = "farinha" , amount = 1 },
                    { item = "leite" , amount = 1 },
                }
            },
            ["cupcakedeabóbora"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "frutas" , amount = 2 },
                 
                    { item = "leite" , amount = 1 },
                }
            },
            ["cupcakerecheado"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "frutas" , amount = 2 },
                    { item = "farinha" , amount = 1 },
                    { item = "leite" , amount = 1 },
                }
            },
            ["cupcakededefranboesa"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "frutas" , amount = 2 },
            
                    { item = "leite" , amount = 1 },
                }
            },
            ["cupcakedemelancia"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "frutas" , amount = 2 },
                    { item = "leite" , amount = 1 },
                }
            },
            ["cupcakedemorango"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "frutas" , amount = 2 },
                    { item = "leite" , amount = 1 },
                }
            },
            ["sucodemelancia"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "frutas" , amount = 2 },
    
                }
            },
            ["catburger"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "farinha" , amount = 1 },
                    { item = "leite" , amount = 1 },
                }
            },
            ["milkcereja"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "frutas" , amount = 2 },
                    { item = "leite" , amount = 1 },
                }
            },
            ["mlkmorango"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "frutas" , amount = 2 },
                    { item = "leite" , amount = 1 },
                }
            },
            ["milkfrutos"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "frutas" , amount = 2 },
                    { item = "leite" , amount = 1 },
                }
            },
            ["milkchocolate"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "farinha" , amount = 1 },
                    { item = "leite" , amount = 1 },
                }
            },
            ["pirulito"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "farinha" , amount = 1 },
                    { item = "leite" , amount = 1 },
                }
            },
            ["torrada"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "farinha" , amount = 1 },
                    { item = "leite" , amount = 1 },
                }
            },

            ["catpanqueca"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "farinha" , amount = 1 },
                    { item = "leite" , amount = 1 },
                }
            },
            ["waffles"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "farinha" , amount = 1 },
                    { item = "leite" , amount = 1 },
                }
            },
            ["sanduiche"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "farinha" , amount = 1 },
                    { item = "leite" , amount = 1 },
                }
            },
            ["ursoburger"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "farinha" , amount = 1 },
                    { item = "leite" , amount = 1 },
                }
            },
            ["redvelvet"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "farinha" , amount = 1 },
                    { item = "leite" , amount = 1 },
                }
            },
            ["melancia"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "frutas" , amount = 2 },
                }
            },
        
            ["sorvete"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "leite" , amount = 1 },
                    { item = "frutas" , amount = 2 },
                }
            },
            ["aguadecoco"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            },
            ["cafe"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            },
            ["sucodelaranja"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "frutas" , amount = 1 },
                }
            },
            ["macarrao"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            },
            ["chaverde"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            },
            ["coxinha"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            },
            ["marshmellow"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "dollars" , amount = 100 },
                }
            },
        }
	},

	["Mecanica"] = {
		blip = {['x'] = 127.17, ['y'] = -3040.31, ['z'] = 7.04},
		permissao = "Mechanic",
        crafts = {
            ["WEAPON_WRENCH"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 3 },
                }
            },
            ["advtoolbox"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 4 },
                    { item = "copper" , amount = 4 },
                    { item = "plastic" , amount = 2 },
                }
            }, 
            ["tyres"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "rubber" , amount = 5 },
                }
            }, 
        }
	},

    ["MecanicaKid"] = {
		blip = {['x'] = -304.28, ['y'] = -725.93, ['z'] = 28.02},
		permissao = "Escola",
        crafts = {
            ["nitro"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 15 },
                }
            },
            ["WEAPON_WRENCH"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 3 },
                }
            },
            ["advtoolbox"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 4 },
                    { item = "copper" , amount = 4 },
                    { item = "plastic" , amount = 2 },
                }
            }, 
            ["tyres"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "rubber" , amount = 5 },
                }
            }, 
        }
	},

    ["MecanicaIlegal"] = {
		blip = {['x'] = -200.43, ['y'] = -1315.25, ['z'] = 31.07},
		permissao = "MecanicaIlegal",
        crafts = {
            ["WEAPON_WRENCH"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 3 },
                }
            },
            ["advtoolbox"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 4 },
                    { item = "copper" , amount = 4 },
                    { item = "plastic" , amount = 2 },
                }
            }, 
            ["tyres"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "rubber" , amount = 5 },
                }
            }, 
            ["ticket"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "leather" , amount = 3 },
                }
            }, 
            ["nitro"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 8 },
                    { item = "copper" , amount = 8 },
                    { item = "techtrash" , amount = 2 },
                }
            }, 
            ["notebook"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 10, -- Tempo de craft por Unidade [ em segundos ]
                anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, 
                requires = {
                    { item = "aluminum" , amount = 8 },
                    { item = "copper" , amount = 8 },
                    { item = "techtrash" , amount = 2 },
                }
            }, 
        }
	},

	["Mafia1"] = {
		blip = {['x'] = -1832.49, ['y'] = 430.75, ['z'] = 118.37},
		permissao = "Mafia1",
        log = "https://discord.com/api/webhooks/1119181342421299210/wdsidXTajOpinOWTh35s0noEGRB1mPoAzWUdI_-6u5jEOmStX1j_dJrQRy7p8Ex4hlA6",
        crafts = {
            ["WEAPON_SNSPISTOL_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "aluminum" , amount = 30 },
                    { item = "copper" , amount = 25 },
                    { item = "pistolbody" , amount = 1 },
                }
            }, 
            ["WEAPON_PISTOL_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "aluminum" , amount = 50 },
                    { item = "copper" , amount = 50 },
                    { item = "pistolbody" , amount = 1 },
                }
            }, 
            ["WEAPON_MACHINEPISTOL"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "aluminum" , amount = 65 },
                    { item = "copper" , amount = 65 },
                    { item = "pistolbody" , amount = 1 },
                }
            },  
            ["WEAPON_ASSAULTSMG"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 1,
                requires = {
                    { item = "aluminum" , amount = 75 },
                    { item = "copper" , amount = 75 },
                    { item = "smgbody" , amount = 1 },
                }
            },
            ["WEAPON_SMG_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 1,
                requires = {
                    { item = "aluminum" , amount = 65 },
                    { item = "copper" , amount = 65 },
                    { item = "smgbody" , amount = 1 },
                }
            }, 
            ["WEAPON_MINISMG"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 1,
                requires = {
                    { item = "aluminum" , amount = 65 },
                    { item = "copper" , amount = 65 },
                    { item = "smgbody" , amount = 1 },
                }
            }, 
            ["WEAPON_BULLPUPRIFLE"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 1,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_ASSAULTRIFLE"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 2,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_ASSAULTRIFLE_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 2,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_SPECIALCARBINE_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 2,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_SPECIALCARBINE"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 2,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_BULLPUPRIFLE_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 2,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
        }
	},

    ["Argentina"] = {
		blip = {['x'] = -455.26, ['y'] = -50.55, ['z'] = 39.66},
		permissao = "Argentina",
        log = "https://discord.com/api/webhooks/1123458181058793582/7_6qWs8sQFrVy-idn4RQfXGls1KDJapH7ur1ESBmyyQBqbfU91e3L1YhBs6h6u6RdQkc",
        crafts = {
            ["WEAPON_SNSPISTOL_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "aluminum" , amount = 30 },
                    { item = "copper" , amount = 25 },
                    { item = "pistolbody" , amount = 1 },
                }
            }, 
            ["WEAPON_PISTOL_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "aluminum" , amount = 50 },
                    { item = "copper" , amount = 50 },
                    { item = "pistolbody" , amount = 1 },
                }
            }, 
            ["WEAPON_MACHINEPISTOL"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "aluminum" , amount = 65 },
                    { item = "copper" , amount = 65 },
                    { item = "pistolbody" , amount = 1 },
                }
            },  
            ["WEAPON_ASSAULTSMG"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 1,
                requires = {
                    { item = "aluminum" , amount = 75 },
                    { item = "copper" , amount = 75 },
                    { item = "smgbody" , amount = 1 },
                }
            },
            ["WEAPON_SMG_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 1,
                requires = {
                    { item = "aluminum" , amount = 65 },
                    { item = "copper" , amount = 65 },
                    { item = "smgbody" , amount = 1 },
                }
            }, 
            ["WEAPON_MINISMG"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 1,
                requires = {
                    { item = "aluminum" , amount = 65 },
                    { item = "copper" , amount = 65 },
                    { item = "smgbody" , amount = 1 },
                }
            }, 
            ["WEAPON_BULLPUPRIFLE"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 1,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_ASSAULTRIFLE"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 2,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_ASSAULTRIFLE_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 2,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_SPECIALCARBINE_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 2,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_SPECIALCARBINE"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 2,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_BULLPUPRIFLE_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 2,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
        }
	},

    ["Mafia2"] = {
		blip = {['x'] = -113.74, ['y'] = -2447.19, ['z'] = 0.62},
		permissao = "Mafia2",
        log = "https://discord.com/api/webhooks/1119195976851279972/kttXvIfgTgV58LIzdX9VEs-0GGrT8vQuaM3qANn52998dS0xxyUS5rLdWCvFLBdJtkEX",
        log2 = "https://discord.com/api/webhooks/1136331075774324737/GkZ8KMi_rJkAHoXMco9944mPOeyFp43jZCYMBKUAVttSaGo8K1Dg7YiSgArkdEMEeL2V",
        crafts = {
            ["WEAPON_SNSPISTOL_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "aluminum" , amount = 30 },
                    { item = "copper" , amount = 25 },
                    { item = "pistolbody" , amount = 1 },
                }
            }, 
            ["WEAPON_PISTOL_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "aluminum" , amount = 50 },
                    { item = "copper" , amount = 50 },
                    { item = "pistolbody" , amount = 1 },
                }
            }, 
            ["WEAPON_MACHINEPISTOL"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "aluminum" , amount = 65 },
                    { item = "copper" , amount = 65 },
                    { item = "pistolbody" , amount = 1 },
                }
            },  
            ["WEAPON_ASSAULTSMG"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 1,
                requires = {
                    { item = "aluminum" , amount = 75 },
                    { item = "copper" , amount = 75 },
                    { item = "smgbody" , amount = 1 },
                }
            },
            ["WEAPON_SMG_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 1,
                requires = {
                    { item = "aluminum" , amount = 65 },
                    { item = "copper" , amount = 65 },
                    { item = "smgbody" , amount = 1 },
                }
            }, 
            ["WEAPON_MINISMG"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 1,
                requires = {
                    { item = "aluminum" , amount = 65 },
                    { item = "copper" , amount = 65 },
                    { item = "smgbody" , amount = 1 },
                }
            }, 
            ["WEAPON_BULLPUPRIFLE"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 1,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_ASSAULTRIFLE"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 2,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_ASSAULTRIFLE_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 2,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_SPECIALCARBINE_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 2,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_SPECIALCARBINE"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 2,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_BULLPUPRIFLE_MK2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                upgrade = 2,
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
        }
	},

    ["Vanilla"] = {
		blip = {['x'] = 93.38, ['y'] = -1295.45, ['z'] = 29.32},
		permissao = "Vanilla",
   
        log = "https://discord.com/api/webhooks/1119215355026473052/ddfCbjNbT1nQAGSMqkAI0VFCtY6GF2NJw3PI78pWsZTgL2Uv3PRI-PmQTuil268midGK",
        crafts = {
            ["dollars"] = { 
                quantidade = 50000, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "dollars2", amount = 50000 },
                    { item = "alvejante" , amount = 5 },
                }
            },  
        }
	},

    ["Bahamas"] = {
		blip = {['x'] = -1369.38, ['y'] = -626.22, ['z'] = 30.362},
		permissao = "Bahamas",
        log = "https://discord.com/api/webhooks/1119213590671528046/kH8mrnJZIrQOki0pFhHCazdhQpccA0ihCLprjIXsXP4x0lAeH3bL_AjplyUs2YkAoqW1",
        crafts = {
            ["dollars"] = { 
                quantidade = 50000, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "dollars2" , amount = 50000 },
                    { item = "alvejante" , amount = 5 },
                }
            },  
            ["bahamas1"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "dollars" , amount = 5 },
                }
            },  
            ["bahamas2"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 0, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "dollars" , amount = 5 },
                }
            }, 
        }
	},

    ["Cupula"] = {
		blip = {['x'] = 518.73, ['y'] = -2757.42, ['z'] = 6.64},
		permissao = "Cupula",
        log = "https://discord.com/api/webhooks/1134634621640912936/eDHLhgK6t3bboLd9JtcTBwvRBBVh_wKkuU4GbdSyvxqBINiQ8JTGRx4t6xGALucRUpC3",
        crafts = {
            ["WEAPON_ASSAULTRIFLE"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "aluminum" , amount = 150 },
                    { item = "copper" , amount = 150 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_FNFAL"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "aluminum" , amount = 200 },
                    { item = "copper" , amount = 200 },
                    { item = "riflebody" , amount = 1 },
                }
            }, 
            ["WEAPON_PARAFAL"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "aluminum" , amount = 200 },
                    { item = "copper" , amount = 200 },
                    { item = "riflebody" , amount = 1 },
                }
            },
            ["WEAPON_M6IC"] = { 
                quantidade = 1, -- Quantidade feita por Craft
                tempo = 15, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "aluminum" , amount = 200 },
                    { item = "copper" , amount = 200 },
                    { item = "riflebody" , amount = 1 },
                }
            },
            ["dollars"] = { 
                quantidade = 50000, -- Quantidade feita por Craft
                tempo = 5, -- Tempo de craft por Unidade [ em segundos ]
                requires = {
                    { item = "dollars2", amount = 50000 },
                    { item = "alvejante" , amount = 10 },
                }
            },  
        }
	},

}

return Config