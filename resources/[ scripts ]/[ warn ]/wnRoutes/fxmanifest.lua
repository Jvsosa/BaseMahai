
shared_script "" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"
fx_version 'adamant'
game 'gta5'
client_scripts{
    "@vrp/lib/utils.lua",
    "cfg/config.lua",
    "client.lua",
}
server_scripts{
    "@vrp/lib/utils.lua",
    "@vrp/lib/itemlist.lua",
    "server.lua",
}
ui_page "web-side/index.html"
files{
    "web-side/**",
    "web-side/**/*"
}              