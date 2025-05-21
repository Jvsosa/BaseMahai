
fx_version "bodacious"
game "gta5"
ui_page "web-side/index.html"
shared_scripts {
	"config/geral.lua",
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/vehicles.lua"
}
client_scripts {
	"@vrp/lib/Utils.lua",
	"@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	"@PolyZone/EntityZone.lua",
	"@PolyZone/CircleZone.lua",
	"@PolyZone/ComboZone.lua",
	"config/anim.lua",
	"config/npcs.lua",
	"config/safezone.lua",
	"config/bloquear-roupas.lua",
	"config/blips-mapa.lua",
	"vrp.lua",
	"system-admin/client/*.lua",
	"system-client/*.lua",
}
server_scripts {
	"@vrp/lib/Utils.lua",
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/vehicles.lua",
	"vrp.lua",
	"system-admin/server/*.lua",
	"system-server/*.lua",
}
files {
	"web-side/*",
	"web-side/**/*"
}              