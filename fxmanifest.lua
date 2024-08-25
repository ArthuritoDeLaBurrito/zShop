fx_version "cerulean"
game "gta5"
lua54 "yes"

author "zSquad - Soren & Jules"
description "Un exemple de menu utilisant zUI | An example menu using zUI."
version "1.0.3"

ui_page "zUI/web/build/index.html"

files {
    "zUI/web/build/index.html",
    "zUI/web/build/**/*"
}

shared_scripts {
	'@es_extended/imports.lua',
}


client_scripts {
    "zUI/config.lua",
    "zUI/functions/*.lua",
    "zUI/menu.lua",
    "zUI/menuController.lua",
    "zUI/utils/*.lua",
    "zUI/items/*.lua",
    "client/*.lua"
}

server_scripts {
    "server/*.lua"
}