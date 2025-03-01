local Framework, Callback = nil, nil

if nc_config.framework == 'QB' then
    Framework = exports[nc_config.QB]:GetCoreObject()
    Callback = Framework.Functions.TriggerCallback
elseif nc_config.framework == 'ESX' then
    Framework = exports[nc_config.ESX]:getSharedObject()
    Callback = Framework.TriggerServerCallback
end

-- Disable native fivem pause menu
CreateThread(function()
	while true do
	    Wait(1)
		SetPauseMenuActive(false)
	end
end)

function nc_pausemenu_show()
    local timeout = 0

    while Framework == nil do
        timeout += 1
        Wait(100)

        if timeout > 25 then
            break
        end
    end

    if not Framework then
        return print('Something wrong with the shit so fuck off bitch!')
    end

    local p = promise.new()
    Callback('nc-pausemenu:GetData', function(cb) p:resolve(cb) end)

    local ncData = Citizen.Await(p)

    SendNUIMessage({
        type = 'show',
        config = nc_config,
        jobs = ncData.nc_jobs,
        data = ncData.nc_data
    })
    SetNuiFocus(true, true)
    StartScreenEffect(nc_config.nc_blur, 0, true)
end

RegisterNUICallback('show-maps', function()
    nc_pausemenu_hide()
    TriggerScreenblurFadeOut(1000)
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'),1,-1)

    if ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'),1,-1) then
        nc_pausemenu_hide()
    end
end)

RegisterNUICallback('show-settings', function()
    nc_pausemenu_hide()
    TriggerScreenblurFadeOut(1000)
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'),0,-1)       

    if ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'),0,-1) then
        nc_pausemenu_hide()
    end
end)

RegisterNUICallback('hide', function()
    nc_pausemenu_hide()
end)

RegisterNUICallback('disconnect', function()
    TriggerServerEvent("nc-pausemenu:Disconnect")
end)