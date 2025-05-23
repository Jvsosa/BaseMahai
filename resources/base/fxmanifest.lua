
fx_version "bodacious"
game "gta5"
ui_page "web-side/index.html"
shared_scripts {
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
	"mahai-admin/client/*.lua",
	"mahai-client/*.lua",
}
server_scripts {
	"@vrp/lib/Utils.lua",
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/vehicles.lua",
	"mahai-admin/server/*.lua",
	"mahai-server/*.lua",
}
files {
	"web-side/*",
	"web-side/**/*"
}              