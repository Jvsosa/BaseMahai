
shared_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"
fx_version "adamant"
game "gta5"
lua54 'yes'
shared_scripts {
	"@vrp/lib/utils.lua",
	'config_server.lua',
	'config_client.lua'
}
 
client_scripts {
	"@vrp/lib/utils.lua",
	"script/client.lua",
	"config_client.lua",
}
server_scripts {
	"@vrp/lib/vehicles.lua",
	"@vrp/lib/utils.lua",
	"@vrp/lib/itemlist.lua",
	"script/server.lua",
	"config_server.lua",
}
ui_page 'nui/index.html'
files {
	"nui/*.html",
	"nui/*.js",
	"nui/*.css",
	'nui/bibs/loading-bar.css',
	'nui/bibs/loading-bar.js',
	"nui/svgs/*.svg",
	"nui/svgs/*.png",
}
escrow_ignore {
	'config_server.lua',
	'config_client.lua'
}
dependency '/assetpacks'              