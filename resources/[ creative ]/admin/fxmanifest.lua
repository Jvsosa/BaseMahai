shared_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

shared_script "@ThnAC/natives.lua"
fx_version "bodacious"
game "gta5"

client_scripts {
	"@vrp/lib/utils.lua",
	"@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	"@PolyZone/EntityZone.lua",
	"@PolyZone/CircleZone.lua",
	"@PolyZone/ComboZone.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/utils.lua",
	"server-side/*"
}              