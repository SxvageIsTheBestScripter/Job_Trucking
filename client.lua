local ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    src = xPlayer
end)

local amount = 0
local playerCoords = nil
local jobStarted = false
local truck, trailer = nil, nil
local timewait

CreateThread(function()
    local blip = AddBlipForCoord(Config.BlipLocation.x, Config.BlipLocation.y, Config.BlipLocation.z)
    SetBlipSprite(blip, 457)
    SetBlipDisplay(blip, 4)
    SetBlipColour(blip, 21)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Truck Job")
    EndTextCommandSetBlipName(blip)
end)

CreateThread(function()
    while true do
        playerCoords = GetEntityCoords(PlayerPedId())
        Wait(500)
    end
end)

CreateThread(function()
    AddTextEntry("press_start_job", "Press ~INPUT_CONTEXT~ to start your shift")
    while true do
        timewait = 2
        if not jobStarted then
            if #(playerCoords - vector3(Config.BlipLocation.x, Config.BlipLocation.y, Config.BlipLocation.z)) <= 5 then
                DisplayHelpTextThisFrame("press_start_job")
                if IsControlPressed(1, 38) then
                    if IsPedSittingInAnyVehicle(player) then
                        Notify("~r~You can't start the job while you're in a vehicle.")
                    else
                        SpawnVehicle(math.randomchoice(Config.TruckModel), Config.DepotLocation)
                        SetPedIntoVehicle(player, vehicle, -1)
                        TriggerServerEvent("sxvage_jobs:started")
                        StartJob()
                    end
                end
            else
                timewait = 2000
            end
        end
        Wait(timewait)
    end
end)

function StartJob()
    local location = math.randomchoice(Config.TrailerLocations)
    local model = math.randomchoice(Config.TrailerModels)
    local blip = AddBlipForCoord(location.x, location.y, location.z)
    SetBlipSprite(blip, 479)
    SetBlipColour(blip, 26)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 26)
    ClearArea(location.x, location.y, location.z, 50, false, false, false, false, false);
    if trailer then 
        DeleteVehicle(trailer)
    end
    trailer = SpawnTrailer(model, location)
    Notify("~b~New task: ~w~pick up the trailer at the marked location.")
    jobStarted = true
    while true do
        timewait = 2
        if #(playerCoords - vector3(location.x, location.y, location.z)) <= 20 then
            if IsVehicleAttachedToTrailer(vehicle) then
                RemoveBlip(blip)
                DeliverTrailer()
                break
            end
        else
            timewait = 2000
        end
        Wait(timewait)
    end
end

function DeliverTrailer()
    AddTextEntry("press_detach_trailer", "Long press ~INPUT_VEH_HEADLIGHT~ to detach the trailer")
    local location = math.randomchoice(Config.Destinations)
    local blip = AddBlipForCoord(location.x, location.y, location.z)
    SetBlipSprite(blip, 478)
    SetBlipColour(blip, 26)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 26)
    Notify("~b~New task: ~w~deliver the trailer at the marked location.")
    while true do
        timewait = 2
        if #(playerCoords - vector3(location.x, location.y, location.z)) <= 20 then
            DisplayHelpTextThisFrame("press_detach_trailer")
            if not IsVehicleAttachedToTrailer(vehicle) then
                RemoveBlip(blip)
                NewChoice(location)
                break
            end
        else
            timewait = 2000
        end
        Wait(timewait)
    end
end

function NewChoice(location)
    amount = amount + Config.Pay
    TriggerServerEvent("sxvage_jobs:delivered", location)
    Notify("Press ~b~E~w~ to accept another job.\nPress ~r~X~w~ to end your shift.")
    while true do
        Wait(0)
        if IsControlPressed(1, 38) then
            StartJob()
            break         
        elseif IsControlPressed(1, 73) then
            EndJob()
            break
        end
    end
end

function EndJob()
    local blip = AddBlipForCoord(Config.DepotLocation.x, Config.DepotLocation.y, Config.DepotLocation.z)
    AddTextEntry("press_end_job", "Press ~INPUT_CONTEXT~ to end your shift")
    SetBlipSprite(blip, 477)
    SetBlipColour(blip, 26)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 26)
    Notify("~b~New task: ~w~return the truck to the depot to get paid.")
    jobStarted = false
    while true do
        timewait = 2
        if #(playerCoords - vector3(Config.DepotLocation.x, Config.DepotLocation.y, Config.DepotLocation.z)) <= 10 then
            DisplayHelpTextThisFrame("press_end_job")
            if IsControlPressed(1, 38) then
                RemoveBlip(blip)
                local truck = GetVehiclePedIsIn(PlayerPedId(), false)
                for i, name in ipairs(Config.TruckModel) do
                    if GetEntityModel(truck) == GetHashKey(name) then
                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), false))
                        break
                    end
                end
                DeleteVehicle(trailer)
                TriggerServerEvent("sxvage_jobs:finished")
                Notify("You've received ~g~$" .. amount .. " ~w~for completing the job.")
                amount = 0
            end
        else
            timewait = 1000
        end
        Wait(timewait)
    end
end

function SpawnVehicle(model, location)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(500)
    end
    vehicle = CreateVehicle(model, location.x, location.y, location.z, location.h, true, false)
    SetVehicleOnGroundProperly(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetModelAsNoLongerNeeded(model)
end

function SpawnTrailer(model, location)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(500)
    end
    trailer = CreateVehicle(model, location.x, location.y, location.z, location.h, true, false)
    SetVehicleOnGroundProperly(trailer)
    SetEntityAsMissionEntity(trailer, true, true)
    SetModelAsNoLongerNeeded(model)
end

function math.randomchoice(table)
    local keys = {}
    for key, value in pairs(table) do
        keys[#keys + 1] = key
    end
    index = keys[math.random(1, #keys)]
    return table[index]
end

function Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end
