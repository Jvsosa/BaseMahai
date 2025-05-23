
shared_script "" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"
fx_version 'adamant'
game 'gta5'
description 'Jumpscare utility for admins.'
client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}
server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}
ui_page('html/index.html')
files {
    'html/listener.js',
    'html/style.css',
    'html/reset.css',
    'html/index.html',
    'html/yeet.ogg'
}
              