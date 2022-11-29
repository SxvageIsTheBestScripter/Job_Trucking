ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

local deliveries = {}
local playersOnJob = {}

RegisterNetEvent("sxvage_jobs:started")
AddEventHandler("sxvage_jobs:started", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    playersOnJob[source] = true
end)

RegisterNetEvent("sxvage_jobs:delivered")
AddEventHandler("sxvage_jobs:delivered", function(location)
    local xPlayer = ESX.GetPlayerFromId(source)
	deliveries[source] = deliveries[source] + 1
end)
RegisterNetEvent("sxvage_jobs:finished")
    AddEventHandler("sxvage_jobs:finished", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
	local amount = Config.PayPerDelivery * deliveries[src]
	if playersOnJob[src] and not isClientTooFar(Config.DepotLocation) then
        deliveries[src] = 0
        playersOnJob[src] = false
		xPlayer.addMoney(amount)
	end
end)
