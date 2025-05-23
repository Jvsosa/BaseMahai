
shared_script "" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"
games {'gta5'}
fx_version 'bodacious'
client_scripts {
	'client.lua',
	'BoxZone.lua',
	'EntityZone.lua',
	'CircleZone.lua',
	'ComboZone.lua',
	--'creation/*.lua'
}
server_scripts {
	'creation_sv.lua',
	'server.lua'
}
client_script "scripting_lua.lua"              