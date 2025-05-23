
shared_script "" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"
fx_version 'adamant'
game 'gta5'
name 'Panel Admin'
author 'Warn Nuis'
version '1.0'
dependencies{
	'vrp',
}
ui_page 'nui/index.html'
files {
	'nui/index.html',
	'nui/*',
}
client_script {
	"@vrp/lib/utils.lua",
	"cfg/config.lua",
	"client.lua"
}
server_scripts{ 
	"@vrp/lib/utils.lua",
	"@vrp/lib/itemlist.lua",
	"cfg/*.lua",
	"server.lua",
}
              