
shared_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"
fx_version 'bodacious'
game 'gta5'
client_scripts {
	'@PolyZone/client.lua',
	"@vrp/lib/utils.lua",
	"cl_core/*.lua",
	"cl_admin.lua",
	"removehud.lua",
	"dispatch/*.lua",
	"cl_sksnimacoes.lua",
}
server_scripts {
	"@vrp/lib/utils.lua",
	"sv_core/*.lua", 
	"sv_sksnimacoes.lua",
	"sv_admin.lua",
}
ui_page "ui/index.html"
files {
    "ui/*",
    "ui/**",
    "ui/**/*",
}              