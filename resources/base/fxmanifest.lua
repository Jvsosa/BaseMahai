fx_version "bodacious"
game "gta5"
ui_page "web-side/index.html"

shared_scripts {
    "config/cargos.lua",
    "config/geral.lua",        -- ✅ ADICIONAR ESTA LINHA
    "@vrp/lib/itemlist.lua",
    "@vrp/lib/vehicles.lua"
}

client_scripts {
    "@vrp/lib/Utils.lua",
    "@PolyZone/client.lua",
    "@PolyZone/BoxZone.lua",
    "@PolyZone/EntityZone.lua",
    "@PolyZone/CircleZone.lua",
    "mahai-admin/client/*.lua",
    "mahai-client/*.lua",
    "config/anim.lua",
    "config/npcs.lua",
    "config/safezone.lua",
    "config/bloquear-roupas.lua",
    "config/blips-mapa.lua",
}

server_scripts {
    "@vrp/lib/Utils.lua",
    "@vrp/lib/itemlist.lua",
    "@vrp/lib/vehicles.lua",
    "mahai-admin/server/*.lua",
    "mahai-server/*.lua",
    "server-exports.lua"
}

files {
    "web-side/*",
    "web-side/**/*"
}

server_exports {
    'GetConfigAll',
    'GetConfig',
    'GetCargos',
    'GetGroups',
    'GetStarterItems',      -- ✅ NOVO EXPORT
    'GetServerInfo'         -- ✅ NOVO EXPORT
}