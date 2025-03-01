if nc_config.framework == 'QB' then
    local QBCore = exports[nc_config.QB]:GetCoreObject()

    CreateThread(function()
        while true do
            local players = QBCore.Functions.GetQBPlayers()
    
            if #players > 0 then
                for _, job in pairs(nc_config.jobs) do
                    job.count = 0
    
                    for _, player in pairs(players) do
                        if player.PlayerData.job.name == job.name and player.PlayerData.job.onduty then
                            job.count = job.count + 1
                        end
                    end
                end
            end
    
            Wait(10000)
        end
    end)

    QBCore.Functions.CreateCallback('nc-pausemenu:GetData', function(source, cb)
        local Player = QBCore.Functions.GetPlayer(source)
        cb({
            nc_data = {
                nc_firstName = Player.PlayerData.charinfo.firstname,
                nc_lastName = Player.PlayerData.charinfo.lastname,
                nc_birthdate = Player.PlayerData.charinfo.birthdate,
                nc_job = Player.PlayerData.job.label,
                nc_grade = Player.PlayerData.job.grade.name,
                nc_gender = Player.PlayerData.charinfo.gender,
                nc_cash = Player.PlayerData.money['cash'],
                nc_bank = Player.PlayerData.money['bank']
            },
            nc_jobs = nc_config.jobs
        })
    end)
elseif nc_config.framework == 'ESX' then
    local ESX = exports[nc_config.ESX]:getSharedObject()

    CreateThread(function()
        while true do
            local players = ESX.GetExtendedPlayers()
    
            if #players > 0 then
                for _, job in pairs(nc_config.jobs) do
                    job.count = 0
    
                    for _, player in pairs(players) do
                        if player.job.name == job.name and player.job.onduty then
                            job.count = job.count + 1
                        end
                    end
                end
            end
    
            Wait(10000)
        end
    end)

    ESX.RegisterServerCallback('nc-pausemenu:GetData', function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)

        cb({
            nc_data = {
                nc_firstName = xPlayer.get('firstName'),
                nc_lastName = xPlayer.get('lastName'),
                nc_birthdate = xPlayer.get('dateofbirth'),
                nc_job = xPlayer.job.label,
                nc_grade = xPlayer.job.grade_label,
                nc_gender = xPlayer.get('sex'),
                nc_cash = xPlayer.getAccount('money').money,
                nc_bank = xPlayer.getAccount('bank').money
            },
            nc_jobs = nc_config.jobs
        })
    end)
end

RegisterNetEvent('nc-pausemenu:Disconnect', function()
    local src = source
    DropPlayer(src, nc_config.disconnect)
end)

