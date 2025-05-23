shared_script "" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

shared_script ""

fx_version "bodacious"
game "gta5"
ui_page "web-side/index.html"
client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*"
}
files {
	"web-side/*",
	"web-side/**/**"
}              