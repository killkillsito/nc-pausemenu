-- $$\   $$\  $$$$$$\  $$\   $$\ $$\   $$\ $$$$$$$\  
-- $$$\  $$ |$$  __$$\ $$ |  $$ |$$ |  $$ |$$  __$$\ 
-- $$$$\ $$ |$$ /  \__|$$ |  $$ |$$ |  $$ |$$ |  $$ |
-- $$ $$\$$ |$$ |      $$$$$$$$ |$$ |  $$ |$$$$$$$\ |
-- $$ \$$$$ |$$ |      $$  __$$ |$$ |  $$ |$$  __$$\ 
-- $$ |\$$$ |$$ |  $$\ $$ |  $$ |$$ |  $$ |$$ |  $$ |
-- $$ | \$$ |\$$$$$$  |$$ |  $$ |\$$$$$$  |$$$$$$$  |
-- \__|  \__| \______/ \__|  \__| \______/ \_______/  
-- Discord.gg/NCHub & Patreon.com/NCHub
fx_version 'cerulean'
game 'gta5'


lua54 'yes'

shared_scripts {
    'nc-config/nc-config.lua',
}

client_scripts {
    'nc-build/nc-build-c.lua',
    'nc-config/nc-build-c.lua',
}

server_scripts {
    'nc-build/nc-build-s.lua',
}

ui_page 'nc-nui/nc-index.html'

files { 
    'nc-nui/*',
    'nc-nui/nc-assets/*', 
}
