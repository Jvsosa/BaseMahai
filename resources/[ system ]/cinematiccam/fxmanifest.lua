
shared_script "" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"
fx_version 'bodacious'
games { 'gta5' }
author 'Kiminaze'
client_scripts {
	--'@NativeUILua-Reloaded/src/NativeUIReloaded.lua',
	'@NativeUI/NativeUI.lua',
	'@vrp/lib/utils.lua',
	'config.lua',
	'client.lua'
}
server_script {
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/utils.lua",
	"server.lua",
}               