local nc_menu_enabled = true

RegisterKeyMapping("nc-pausemenu:show", "", "keyboard", "ESCAPE")
RegisterCommand('nc-pausemenu:show', function ()
	if not IsPauseMenuActive() and not IsNuiFocused() then
		if not IsEntityDead(GetPlayerPed(-1)) then
			if (nc_menu_enabled) then
				nc_pausemenu_show()
			end
		end
	end
end, false)

function nc_pausemenu_hide()
    StopScreenEffect(nc_config.nc_blur)
 --   DisableIdleCamera(false)
	SetNuiFocus(false, false)
	SetNuiFocusKeepInput(false)
	SendNUIMessage({
		type = "hide",
		toggle = false,
	});
end

RegisterNetEvent('nc-pausemenu:hide')
AddEventHandler('nc-pausemenu:hide', function()
	nc_pausemenu_hide()
end)

RegisterNetEvent('nc-pausemenu:disable')
AddEventHandler('nc-pausemenu:disable', function()
	nc_menu_enabled = false
end)

RegisterNetEvent('nc-pausemenu:enable')
AddEventHandler('nc-pausemenu:enable', function()
	nc_menu_enabled = true
end)

function nc_call_logout()
	TriggerEvent('qb-multicharacter:start')
end