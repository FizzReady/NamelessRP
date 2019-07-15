--DO-NOT-EDIT-BELLOW-THIS-LINE--

Key = 201 -- ENTER

vehicleWashStation = {
	{26.5906,  -1392.0261,  29.3634},
	{167.1034,  -1719.4704,  29.2916},
	{-74.5693,  6427.8715,  31.4400},
	{-699.6325,  -932.7043,  20.0139},
	{1362.5385, 3592.1274, 32.9211}
}


Citizen.CreateThread(function ()
	Citizen.Wait(0)
	for i = 1, #vehicleWashStation do
		garageCoords = vehicleWashStation[i]
		stationBlip = AddBlipForCoord(garageCoords[1], garageCoords[2], garageCoords[3])
		SetBlipSprite(stationBlip, 100) -- 100 = carwash
		SetBlipAsShortRange(stationBlip, true)
	end
    return
end)

function es_carwash_DrawSubtitleTimed(m_text, showtime)
	SetTextEntry_2('STRING')
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function es_carwash_DrawNotification(m_text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(m_text)
	DrawNotification(true, false)
end

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			for i = 1, #vehicleWashStation do
				garageCoords2 = vehicleWashStation[i]
				DrawMarker(36, garageCoords2[1], garageCoords2[2], garageCoords2[3], 0, 0, 0, 0, 0, 0, 2.5, 2.5, 2.5, 0, 157, 0, 155, 2, 2, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageCoords2[1], garageCoords2[2], garageCoords2[3], true ) < 5 then
					es_carwash_DrawSubtitleTimed("Press [~g~ENTER~s~] wash your vehicle!")
					if IsControlJustPressed(1, Key) then
						TriggerServerEvent('es_carwash:checkmoney')
						local ped = PlayerPedId()
						local vehicle = GetVehiclePedIsIn(ped, false)
						local engineStatus = GetIsVehicleEngineRunning(vehicle)

				if vehicle ~= 0 then
				if not engineStatus then
				SetVehicleEngineOn(vehicle, true, false, true)
				else 
				SetVehicleEngineOn(vehicle, false, false, true)
			end 
		end
						TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 3000,
        label = "Getting Car Washed",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
        },
        prop = {
            model = "prop_paper_bag_small",
        }
    }, function(status)
        if not status then
            -- Do Something If Event Wasn't Cancelled
        end
    end)
				local ped = PlayerPedId()
				local vehicle = GetVehiclePedIsIn(ped, false)
				local engineStatus = GetIsVehicleEngineRunning(vehicle)

				if vehicle ~= 0 then
				if not engineStatus then
				Citizen.Wait(3000)
				SetVehicleEngineOn(vehicle, true, false, true)
			else 
				SetVehicleEngineOn(vehicle, true, false, true)
			end 
		end
		
					end
				end
			end
		end
	end
end)

RegisterNetEvent('es_carwash:success')
AddEventHandler('es_carwash:success', function (price)
	WashDecalsFromVehicle(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1.0)
	SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
	es_carwash_DrawNotification("Washing your ~y~vehicle~s~ for ~g~-$" .. price .. "~s~!")
	Citizen.Wait(3000)
	es_carwash_DrawNotification("Your ~y~vehicle~s~ was ~y~cleaned~s~ up!")
end)

RegisterNetEvent('es_carwash:notenoughmoney')
AddEventHandler('es_carwash:notenoughmoney', function (moneyleft)
	es_carwash_DrawNotification("~h~~r~You do not have enough money! $" .. moneyleft .. " left!")
end)

RegisterNetEvent('es_carwash:free')
AddEventHandler('es_carwash:free', function ()
	WashDecalsFromVehicle(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1.0)
	SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
	es_carwash_DrawNotification("Your vehicle has been ~y~ cleaned ~s~ free ~!")
end)
