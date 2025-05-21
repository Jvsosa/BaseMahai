Function = {}

Function['config'] = {

    getUserGroupByType = function(user) -- Pegar o Cargo do Jogador
        return vRP.getUserGroupByType(user,"job") 
    end,

	hasPermission = function(user,permissao) -- Verificar se o jogador tem permissao
        return vRP.hasPermission(user,permissao) 
    end,

	addUserGroup = function(user,cargo) -- Adicionra um novo cargo
        return vRP.addUserGroup(user,cargo) 
    end,

	getGroupTitle = function(emprego) -- Pegaro title do Emprego
        return vRP.getGroupTitle(emprego) 
    end,

	getUserGroups = function(user) -- pegar todos os grupos do player
        return vRP.getUserGroups(user) 
    end,

	getUsersByPermission = function(permissao) -- Pegar todos os usuarios da permissao
        return vRP.getUsersByPermission(permissao) 
    end,

}

return Function