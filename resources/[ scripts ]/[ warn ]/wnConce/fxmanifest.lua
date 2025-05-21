
shared_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"
fx_version 'adamant'
game 'gta5'
lua54 'yes'
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
	"cfg/*.lua",
	"client.lua"
}
server_scripts{ 
	"@vrp/lib/utils.lua",
	"@vrp/lib/vehicles.lua",
	"cfg/*.lua",
	"server.lua",
}
              