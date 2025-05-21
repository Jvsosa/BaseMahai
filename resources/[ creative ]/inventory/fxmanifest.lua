
shared_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"
fx_version "bodacious"
game "gta5"
ui_page "web-side/index.html"
client_scripts {
	"@PolyZone/client.lua",
	"@vrp/lib/utils.lua",
	"client-side/*",
	-- "config_client.lua".
}
server_scripts {
	"@vrp/lib/vehicles.lua",
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/utils.lua",
	"server-side/*",
	"config_server.lua",
}
files {
	"web-side/*",
	"web-side/**/*"
}              