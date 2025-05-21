Config = {}

-------------------- Comandos --------------------
-- /eadm (empresa) -- Acessa a empresa que deseja Sem os ()
-- /removeblacklist (passaporte) -- Remove a blacklist do passaporte desejado Sem os ()
-- /elistar -- Lista todas as empresas criadas no script
-- /empresa -- Acessa a empresa que esta registrado
-------------------------------------------------

Config.ChatNotify = true -- [ Mandar notify caso tenha uma mensagem no grupo ]
Config.NotifyMessagem = "Uma nova mensagem foi enviada na empresa" -- [ Menssagem enviada no painel ]

Config.CheckItem = false -- [ Pedir item ou nao ]
Config.Item = "tablet" -- [ Item necessario para abrir o tablet ]

Config.wnInventory = false -- [ Caso use o inventario da warn coloque "true" caso nao use coloque "false" ]
Config.Imagens = "nui://wnInventory/nui/imgs" -- [ Local dos itens do inventario ]

Config.PermAdmin = "admin.perm" -- [ Permissao do Admin para acessar os comandos ]
Config.DiasBlacklist = 3

Config.Empresas = {



	["Desmanche"] = {
		Permissao = "Desmanche",
		Limite_Membros = 60,
		Cargo_Default = "Desmanche",
		PaginaUpgrades = false,
		Cargo_Discord = "1119178173758840963",
	
		cargos = {
			[3] = { Set = "Desmanche", Acesso = "Membro" },
			[2] = { Set = "Desmanche", Acesso = "Gerente" },
			[1] = { Set = "Desmanche", Acesso = "Lider" },
		}
	},

	["Cupula"] = {
		Permissao = "Cupula",
		Limite_Membros = 60,
		Cargo_Default = "Cupula",
		PaginaUpgrades = false,
		Cargo_Discord = "",
	
		cargos = {
			[3] = { Set = "Cupula", Acesso = "Membro" },
			[2] = { Set = "Cupula", Acesso = "Gerente" },
			[1] = { Set = "Cupula", Acesso = "Lider" },
		}
	},



	
	["Noruega"] = {
		Permissao = "Noruega",
		Limite_Membros = 60,
		Cargo_Default = "Noruega",
		PaginaUpgrades = false,
		Cargo_Discord = "1121600322381565974",
	
		cargos = {
			[3] = { Set = "Noruega", Acesso = "Membro" },
			[2] = { Set = "Noruega", Acesso = "Gerente" },
			[1] = { Set = "Noruega", Acesso = "Lider" },
		}
	},


	["Exercito"] = {
		Permissao = "Police",
		Limite_Membros = 150,
		Cargo_Default = "Police",
		PaginaUpgrades = false,
		cargos = {
			[18] = { Set = "Police", Acesso = "Recruta", Salario = 5000 },
			[17] = { Set = "Police", Acesso = "Soldado", Salario = 5000 },
			[16] = { Set = "Police", Acesso = "Cabo", Salario = 5000 },
			[15] = { Set = "Police", Acesso = "3° Sargento", Salario = 5000 },
			[14] = { Set = "Police", Acesso = "2° Sargento", Salario = 5000 },
			[13] = { Set = "Police", Acesso = "1° Sargento", Salario = 5000 },
			[12] = { Set = "Police", Acesso = "Sub-Tenente", Salario = 5000 },
			[11] = { Set = "Police", Acesso = "Aspirante", Salario = 5000 },
			[10] = { Set = "Police", Acesso = "1° Tenente", Salario = 5000 },
			[9] = { Set = "Police", Acesso = "Capitão", Salario = 5000 },
			[8] = { Set = "Police", Acesso = "Major", Salario = 5000 },
			[7] = { Set = "Police", Acesso = "Tenente-Coronel", Salario = 6000 },
			[6] = { Set = "Police", Acesso = "Coronel", Salario = 7000 },
			[5] = { Set = "Police", Acesso = "Adjunto de Comando", Salario = 9000 },
			[4] = { Set = "Police", Acesso = "General de Brigada", Salario = 10000 },
			[3] = { Set = "Police", Acesso = "General de Divisão", Salario = 11000 },
			[2] = { Set = "Police", Acesso = "General de Exército", Salario = 12000 },
			[1] = { Set = "Police", Acesso = "Marechal", Salario = 13000 },
		}
	},


	["Runway"] = {
		Permissao = "Runway",
		Limite_Membros = 60,
		Cargo_Default = "Runway",
		PaginaUpgrades = false,
		cargos = {
			[3] = { Set = "Runway", Acesso = "Membro" },
			[2] = { Set = "Runway", Acesso = "Gerente" },
			[1] = { Set = "Runway", Acesso = "Lider" },
		}
	},

	["MecanicaIlegal"] = {
		Permissao = "MecanicaIlegal",
		Limite_Membros = 60,
		Cargo_Default = "MecanicaIlegal",
		PaginaUpgrades = false,
		Cargo_Discord = "1119233040263172236",
		cargos = {
			[3] = { Set = "MecanicaIlegal", Acesso = "Membro" },
			[2] = { Set = "MecanicaIlegal", Acesso = "Gerente" },
			[1] = { Set = "MecanicaIlegal", Acesso = "Lider" },
		}
	},

	["Bar"] = {
		Permissao = "Bar",
		Limite_Membros = 60,
		Cargo_Default = "Bar",
		PaginaUpgrades = false,
		Cargo_Discord = "1119229454829494302",
		cargos = {
			[3] = { Set = "Bar", Acesso = "Membro" },
			[2] = { Set = "Bar", Acesso = "Gerente" },
			[1] = { Set = "Bar", Acesso = "Lider" },
		}
	},

	["Fazenda"] = {
		Permissao = "Fazenda",
		Limite_Membros = 60,
		Cargo_Default = "Fazenda",
		PaginaUpgrades = false,
		Cargo_Discord = "1119404561803772037",
		cargos = {
			[3] = { Set = "Fazenda", Acesso = "Membro" },
			[2] = { Set = "Fazenda", Acesso = "Gerente" },
			[1] = { Set = "Fazenda", Acesso = "Lider" },
		}
	},

	["FacExtra"] = {
		Permissao = "FacExtra",
		Limite_Membros = 60,
		Cargo_Default = "FacExtra",
		PaginaUpgrades = false,
		Cargo_Discord = "1119220101883908107",
		cargos = {
			[3] = { Set = "FacExtra", Acesso = "Membro" },
			[2] = { Set = "FacExtra", Acesso = "Gerente" },
			[1] = { Set = "FacExtra", Acesso = "Lider" },
		}
	},

	["Hospital"] = {
		Permissao = "Paramedic",
		Limite_Membros = 150,
		Cargo_Default = "Paramedic",
		PaginaUpgrades = false,
		cargos = {
			[5] = { Set = "Paramedic", Acesso = "Interno", Salario = 5500 },
			[4] = { Set = "Paramedic", Acesso = "Residente", Salario = 5500 },
			[3] = { Set = "Paramedic", Acesso = "Medico", Salario = 5500 },
			[2] = { Set = "Paramedic", Acesso = "Vice Diretor", Salario = 6500 },
			[1] = { Set = "Paramedic", Acesso = "Diretor", Salario = 8500 },
		}
	},

	["Mechanic"] = {
		Permissao = "Mechanic",
		Limite_Membros = 60,
		Cargo_Default = "Mechanic",
		PaginaUpgrades = false,
		cargos = {
			[3] = { Set = "Mechanic", Acesso = "Membro" },
			[2] = { Set = "Mechanic", Acesso = "Gerente" },
			[1] = { Set = "Mechanic", Acesso = "Lider" },
		}
	},

	["Beiramar"] = {
		Permissao = "Beiramar",
		Limite_Membros = 60,
		Cargo_Default = "Beiramar",
		PaginaUpgrades = false,
		Cargo_Discord = "1119211151474044969",
		cargos = {
			[3] = { Set = "Beiramar", Acesso = "Membro" },
			[2] = { Set = "Beiramar", Acesso = "Gerente" },
			[1] = { Set = "Beiramar", Acesso = "Lider" },
		}
	},

	["Cafe"] = {
		Permissao = "Cafe",
		Limite_Membros = 60,
		Cargo_Default = "Cafe",
		PaginaUpgrades = false,
		cargos = {
			[5] = { Set = "Cafe", Acesso = "Repositor", Salario = 2500 },
			[4] = { Set = "Cafe", Acesso = "Astagiario", Salario = 3500 },
			[3] = { Set = "Cafe", Acesso = "Atendente", Salario = 4000 },
			[2] = { Set = "Cafe", Acesso = "Gerente", Salario = 5000 },
			[1] = { Set = "Cafe", Acesso = "Dona", Salario = 6000 },
		}
	},

	["Escola"] = {
		Permissao = "Escola",
		Limite_Membros = 60,
		Cargo_Default = "Escola",
		PaginaUpgrades = false,
		cargos = {
			[4] = { Set = "Escola", Acesso = "Aluno" },
			[3] = { Set = "Escola", Acesso = "Professora", Salario = 3000 },
			[2] = { Set = "Escola", Acesso = "Coordenadora", Salario = 4000 },
			[1] = { Set = "Escola", Acesso = "Diretora", Salario = 5000 },
		}
	},

	["Flamingo"] = {
		Permissao = "Flamingo",
		Limite_Membros = 60,
		Cargo_Default = "Flamingo",
		PaginaUpgrades = false,
		cargos = {
			[5] = { Set = "Flamingo", Acesso = "Repositor" },
			[4] = { Set = "Flamingo", Acesso = "Astagiario" },
			[3] = { Set = "Flamingo", Acesso = "Atendente" },
			[2] = { Set = "Flamingo", Acesso = "Gerente" },
			[1] = { Set = "Flamingo", Acesso = "Dona" },
		}
	},

	["Mineradora"] = {
		Permissao = "Mineradora",
		Limite_Membros = 60,
		Cargo_Default = "Mineradora",
		PaginaUpgrades = false,
		cargos = {
			[3] = { Set = "Mineradora", Acesso = "Membro" },
			[2] = { Set = "Mineradora", Acesso = "Gerente" },
			[1] = { Set = "Mineradora", Acesso = "Lider" },
		}
	},
	
	["Lavagem2"] = {
		Permissao = "Lavagem2",
		Limite_Membros = 60,
		Cargo_Default = "Lavagem2",
		PaginaUpgrades = false,
		cargos = {
			[3] = { Set = "Lavagem2", Acesso = "Membro" },
			[2] = { Set = "Lavagem2", Acesso = "Gerente" },
			[1] = { Set = "Lavagem2", Acesso = "Lider" },
		}
	},
	["Vanilla"] = {
		Permissao = "Vanilla",
		Limite_Membros = 60,
		Cargo_Default = "Vanilla",
		PaginaUpgrades = false,
		cargos = {
			[3] = { Set = "Vanilla", Acesso = "Membro" },
			[2] = { Set = "Vanilla", Acesso = "Gerente" },
			[1] = { Set = "Vanilla", Acesso = "Lider" },
		}
	},
	["Barragem"] = {
		Permissao = "Barragem",
		Limite_Membros = 60,
		Cargo_Default = "Barragem",
		PaginaUpgrades = false,
		
		cargos = {
			[3] = { Set = "Barragem", Acesso = "Membro" },
			[2] = { Set = "Barragem", Acesso = "Gerente" },
			[1] = { Set = "Barragem", Acesso = "Lider" },
		}
	},
	["Bahamas"] = {
		Permissao = "Bahamas",
		Limite_Membros = 60,
		Cargo_Default = "Bahamas",
		PaginaUpgrades = false,
		Cargo_Discord = "1119178166125215754",
		cargos = {
			[3] = { Set = "Bahamas", Acesso = "Membro" },
			[2] = { Set = "Bahamas", Acesso = "Gerente" },
			[1] = { Set = "Bahamas", Acesso = "Lider" },
		}
	},
	["Farol"] = {
		Permissao = "Farol",
		Limite_Membros = 60,
		Cargo_Default = "Farol",
		PaginaUpgrades = false,
		Cargo_Discord = "1119178171640725524",
		cargos = {
			[3] = { Set = "Farol", Acesso = "Membro" },
			[2] = { Set = "Farol", Acesso = "Gerente" },
			[1] = { Set = "Farol", Acesso = "Lider" },
		}
	},
	["Mafia1"] = {
		Permissao = "Mafia1",
		Limite_Membros = 60,
		Cargo_Default = "Mafia1",
		PaginaUpgrades = true,
		Cargo_Discord = "1119177781465591829",
		cargos = {
			[3] = { Set = "Mafia1", Acesso = "Membro" },
			[2] = { Set = "Mafia1", Acesso = "Gerente" },
			[1] = { Set = "Mafia1", Acesso = "Lider" },
		},
		upgrades = {
			[1] = { nome = "Updrade SMG", valor = 320000 },
			[2] = { nome = "Updrade Rifle", valor = 750000 },
		}
	},

	["Argentina"] = {
		Permissao = "Argentina",
		Limite_Membros = 60,
		Cargo_Default = "Argentina",
		PaginaUpgrades = true,
		Cargo_Discord = "1123455861369614439",
	
		cargos = {
			[3] = { Set = "Argentina", Acesso = "Membro" },
			[2] = { Set = "Argentina", Acesso = "Gerente" },
			[1] = { Set = "Argentina", Acesso = "Lider" },
		},
		upgrades = {
			[1] = { nome = "Updrade SMG", valor = 320000 },
			[2] = { nome = "Updrade Rifle", valor = 750000 },
		}
	},


	["Mafia2"] = {
		Permissao = "Mafia2",
		Limite_Membros = 60,
		Cargo_Default = "Mafia2",
		PaginaUpgrades = true,
		Cargo_Discord = "1119178161960276069",
		cargos = {
			[3] = { Set = "Mafia2", Acesso = "Membro" },
			[2] = { Set = "Mafia2", Acesso = "Gerente" },
			[1] = { Set = "Mafia2", Acesso = "Lider" },
		},
		upgrades = {
			[1] = { nome = "Updrade SMG", valor = 320000 },
			[2] = { nome = "Updrade Rifle", valor = 750000 },
		}
	},
	["Contrabando1"] = {
		Permissao = "Contrabando1",
		Limite_Membros = 60,
		Cargo_Default = "Contrabando1",
		PaginaUpgrades = false,
		Cargo_Discord = "1119226289832865824",
		cargos = {
			[3] = { Set = "Contrabando1", Acesso = "Membro" },
			[2] = { Set = "Contrabando1", Acesso = "Gerente" },
			[1] = { Set = "Contrabando1", Acesso = "Lider" },
		}
	},
	["Contrabando2"] = {
		Permissao = "Contrabando2",
		Limite_Membros = 60,
		Cargo_Default = "Contrabando2",
		PaginaUpgrades = false,
		Cargo_Discord = "1119228552391446598",
		cargos = {
			[3] = { Set = "Contrabando2", Acesso = "Membro" },
			[2] = { Set = "Contrabando2", Acesso = "Gerente" },
			[1] = { Set = "Contrabando2", Acesso = "Lider" },
		}
	},
	["Municao1"] = {
		Permissao = "Municao1",
		Limite_Membros = 60,
		Cargo_Default = "Municao1",
		PaginaUpgrades = false,
		Cargo_Discord = "1119220983421751386",
		cargos = {
			[3] = { Set = "Municao1", Acesso = "Membro" },
			[2] = { Set = "Municao1", Acesso = "Gerente" },
			[1] = { Set = "Municao1", Acesso = "Lider" },
		}
	},
	["Municao2"] = {
		Permissao = "Municao2",
		Limite_Membros = 60,
		Cargo_Default = "Municao2",
		PaginaUpgrades = false,
		Cargo_Discord = "1119225490008457296",
		cargos = {
			[3] = { Set = "Municao2", Acesso = "Membro" },
			[2] = { Set = "Municao2", Acesso = "Gerente" },
			[1] = { Set = "Municao2", Acesso = "Lider" },
		}
	},
	-- ["ClubAnitta"] = {
	-- 	Permissao = "ClubAnitta",
	-- 	Limite_Membros = 60,
	-- 	Cargo_Default = "ClubAnitta",
	-- 	PaginaUpgrades = false,
	-- 	cargos = {
	-- 		[3] = { Set = "ClubAnitta", Acesso = "Membro" },
	-- 		[2] = { Set = "ClubAnitta", Acesso = "Gerente" },
	-- 		[1] = { Set = "ClubAnitta", Acesso = "Lider" },
	-- 	}
	-- },
	["Juridico"] = {
		Permissao = "Juridico",
		Limite_Membros = 60,
		Cargo_Default = "Juridico",
		PaginaUpgrades = false,
		cargos = {
			[8] = { Set = "Juridico", Acesso = "Advogado(a)" },
			[7] = { Set = "Juridico", Acesso = "Advogado(a) Sênior" },
			[6] = { Set = "Juridico", Acesso = "Promotor(a) de Justiça" },
			[5] = { Set = "Juridico", Acesso = "Procurador(a)-Geral" },
			[4] = { Set = "Juridico", Acesso = "Juiz(a) de Direito" },
			[3] = { Set = "Juridico", Acesso = "Desembargador(a)" },
			[2] = { Set = "Juridico", Acesso = "Ministro(a) STF" },
			[1] = { Set = "Juridico", Acesso = "Ministro Presidente STF" },
		}
	},
	["Police"] = {
		Permissao = "Police",
		Limite_Membros = 150,
		Cargo_Default = "Police",
		PaginaUpgrades = false,
		cargos = {
            [15] = { Set = "Police", Acesso = "Aluno", Salario = 2500 },
            [14] = { Set = "Police", Acesso = "Soldado 2ª Classe", Salario = 3000 },
            [13] = { Set = "Police", Acesso = "Soldado 1ª Classe", Salario = 3500 },
            [12] = { Set = "Police", Acesso = "Cabo", Salario = 3700 },
            [11] = { Set = "Police", Acesso = "3º Sargento", Salario = 4000 },
            [10] = { Set = "Police", Acesso = "2º Sargento", Salario = 4500 },
            [9] = { Set = "Police", Acesso = "1º Sargento", Salario = 5000 },
            [8] = { Set = "Police", Acesso = "Subtenente", Salario = 6000 },
            [7] = { Set = "Police", Acesso = "Aspirante a Oficial", Salario = 7000 },
            [6] = { Set = "Police", Acesso = "2º Tenente", Salario = 8000 },
            [5] = { Set = "Police", Acesso = "1º Tenente", Salario = 9000 },
			[4] = { Set = "Police", Acesso = "Major", Salario = 10000 },
			[3] = { Set = "Police", Acesso = "Tenente-Coronel", Salario = 11000 },
			[2] = { Set = "Police", Acesso = "Coronel", Salario = 12000 },
			[1] = { Set = "Police", Acesso = "Comando Geral", Salario = 13000 },
		}
	},
}

Config.Functions = {

	getUserIdentity = function(user_id) -- [ Função para puxar nome do players ]
        return vRP.userIdentity(user_id)
    end,

}

return Config