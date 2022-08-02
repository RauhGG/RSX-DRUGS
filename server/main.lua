ESX = exports['es_extended']:getSharedObject()
local isfarming = false
local seedplanted = false
RegisterServerEvent('rsx_drugs:farmweed', function()
    isfarming = true  
end)

RegisterServerEvent('rsx_drugs:harvestweed', function(zone)
    local xPlayer = ESX.GetPlayerFromId(source)
    if zone == vector3(2488.285,4852.121,36.305) or vector3(2541.497,4816.094,33.855) or vector3(2312.978,5126.317,49.632) then
        xPlayer.addInventoryItem('raw_weed', 1)
    end
end)

RegisterServerEvent('rsx_drugs:harvestcoca', function(zone)
    local xPlayer = ESX.GetPlayerFromId(source)
    if zone == vector3(1061.138,4256.263,37.67) then
        xPlayer.addInventoryItem('raw_coca', 1)
    end
end)

RegisterServerEvent('rsx_drugs:processweed', function(crds)
    local c = vector3(crds.x, crds.y, crds.z)
    if #(c - vector3(2193.366,5595.078,53.763)) < 4 then
        local xPlayer = ESX.GetPlayerFromId(source)
        local weed = xPlayer.getInventoryItem('raw_weed')
        if weed.count > 0 then
            xPlayer.removeInventoryItem('raw_weed', 1)
            xPlayer.addInventoryItem('weed', 1)
        end
    else
        DropPlayer(source, 'You are not in the right area to process weed.')
    end
end)

RegisterServerEvent('rsx_drugs:processcoca', function(crds)
    local c = vector3(crds.x, crds.y, crds.z)
    if #(c - vector3(2889.673,4391.291,50.452)) < 2 then
        local xPlayer = ESX.GetPlayerFromId(source)
        local weed = xPlayer.getInventoryItem('purecoke')
        if weed.count > 0 then
            xPlayer.removeInventoryItem('purecoke', 1)
            xPlayer.addInventoryItem('coke', 1)
        end
    else
        DropPlayer(source, 'You are not in the right area to process weed.')
    end
end)

RegisterServerEvent('rsx_drugs:sellcoca', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local coke = xPlayer.getInventoryItem('coke')
    if coke.count > 200 then
        xPlayer.removeInventoryItem('coke', coke.count)
        xPlayer.addAccountMoney('black_money', coke.count * math.random(10, 50))
    else
        TriggerClientEvent('esx:showNotification', source, 'Como me vas a vender esta miseria.')
    end
end)

RegisterServerEvent('rsx_drugs:sellmaria', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local weed = xPlayer.getInventoryItem('weed')
    if weed.count > 200 then
        xPlayer.removeInventoryItem('weed', weed.count)
        xPlayer.addAccountMoney('black_money', weed.count * math.random(10, 50))
    else
        TriggerClientEvent('esx:showNotification', source, 'Como me vas a vender esta miseria.')
    end
end)

ESX.RegisterUsableItem('weedseed', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	print('asada')
	xPlayer.removeInventoryItem('weedseed', 1)
    TriggerClientEvent('rsx_drugs:seedweed', source)
	TriggerClientEvent('esx:showNotification', source, 'Has plantado una semilla de marihuana')
end)

ESX.RegisterUsableItem('cokeseed', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	print('asada')
	xPlayer.removeInventoryItem('cokeseed', 1)
    TriggerClientEvent('rsx_drugs:seedcoca', source)
	TriggerClientEvent('esx:showNotification', source, 'Has plantado una semilla de cocaina')
end)