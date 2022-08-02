ESX = exports['es_extended']:getSharedObject()

local zonesweed = {
    { crds = vector3(2488.285,4852.121,36.305)},
    { crds = vector3(2541.497,4816.094,33.855)},
    { crds = vector3(2312.978,5126.317,49.632)},
}

local zonescoke = {
    { crds = vector3(1061.138,4256.263,37.67)},
}

local inareaw = false
local inareacoca = false
local area

CreateThread(function()
    while true do 
        local _sleep = 1000
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply)
        for k, v in pairs(zonesweed) do
            local distance = #(plyCoords - v.crds)
            if distance < 40 then
                inareaw = true
                area = v.crds
                break
            else
                inareaw = false
            end
        end
        Wait(_sleep)
    end
end)

CreateThread(function()
    while true do 
        local _sleep = 1000
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply)
        for k, v in pairs(zonescoke) do
            local distance = #(plyCoords - v.crds)
            if distance < 40 then
                inareacoca = true
                area = v.crds
                break
            else
                inareacoca = false
            end
        end
        Wait(_sleep)
    end
end)


-- Maria

RegisterNetEvent('rsx_drugs:seedweed', function()
    if inareaw then
        print('pene')
        plantarmaria()
    end
end)
function plantarmaria()
    if inareaw then
        local v = GetEntityCoords(PlayerPedId())
        local plantgrow = 0

        TaskStartScenarioInPlace(PlayerPedId(), "world_human_gardener_plant", 0, false)
        Wait(3000)
        ClearPedTasks(PlayerPedId())
        Wait(1000)

        local plant = CreateObject(GetHashKey('prop_weed_02'), v.x, v.y, v.z - 1, true, true, false)
        FreezeEntityPosition(plant, true)
        local plantcoords = GetEntityCoords(plant)

        CreateThread(function()
            while plantgrow < 100 do
                plantgrow = plantgrow + 5
                Wait(Config.plantgrow)
            end
        end)


        CreateThread(function()
            while true do 
                local _sleep = 1000
                local ply = PlayerPedId()
                local plyCoords = GetEntityCoords(ply)
                local distance = #(plyCoords - plantcoords)
                if distance < 2 and plantgrow < 100 then
                    _sleep = 0
                    ShowFloatingHelpNotification('Crecimiento: ~g~'..plantgrow.. '~w~%' , vector3(plantcoords.x, plantcoords.y, plantcoords.z))
                elseif plantgrow == 100 and distance < 2 and DoesEntityExist(plant) then
                    _sleep = 0
                    ShowFloatingHelpNotification('~INPUT_CONTEXT~ Recoger planta~' , vector3(plantcoords.x, plantcoords.y, plantcoords.z))
                    if IsControlJustPressed(0, 38) then
                        recogerplanta()
                        DeleteEntity(plant)
                    end
                end
                Wait(_sleep)
            end
        end)
    end
end

CreateThread(function()
    while true do
        local _sleep = 1000
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply)
        local dist = #(plyCoords - vector3(2193.366,5595.078,53.763))
        if dist < 2 then
            _sleep = 0
            ShowFloatingHelpNotification('~INPUT_CONTEXT~ Procesar marihuana' , vector3(2193.366,5595.078,53.763))
            if IsControlJustPressed(0, 38) then
                procesarmaria()
            end
        end
        Wait(_sleep)
    end
end)

function recogerplanta(crds)
    ESX.Streaming.RequestAnimDict('anim@mp_snowball', function()
        TaskPlayAnim(PlayerPedId(), 'anim@mp_snowball', 'pickup_snowball', 8.0, -8.0, -1, 0, 0, false, false, false)
        Wait(1000)
        ClearPedTasks(PlayerPedId())
    end)
    TriggerServerEvent('rsx_drugs:harvestweed', area)
    print('Planta recogida')
end

function procesarmaria()
    TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
    Wait(20000)
    ClearPedTasks(PlayerPedId())
    TriggerServerEvent('rsx_drugs:processweed', GetEntityCoords(PlayerPedId()))
end

-- Maria

-- Coca
function plantarcoca()
    if inareacoca then
        local v = GetEntityCoords(PlayerPedId())
        local plantgrow = 0

        TaskStartScenarioInPlace(PlayerPedId(), "world_human_gardener_plant", 0, false)
        Wait(3000)
        ClearPedTasks(PlayerPedId())
        Wait(1000)

        local plant = CreateObject(GetHashKey('prop_plant_01a'), v.x, v.y, v.z - 1, true, true, false)
        FreezeEntityPosition(plant, true)
        local plantcoords = GetEntityCoords(plant)

        CreateThread(function()
            while plantgrow < 100 do
                plantgrow = plantgrow + 5
                Wait(Config.plantgrow)
            end
        end)


        CreateThread(function()
            while true do 
                local _sleep = 1000
                local ply = PlayerPedId()
                local plyCoords = GetEntityCoords(ply)
                local distance = #(plyCoords - plantcoords)
                if distance < 2 and plantgrow < 100 then
                    _sleep = 0
                    ShowFloatingHelpNotification('Crecimiento: ~g~'..plantgrow.. '~w~%' , vector3(plantcoords.x, plantcoords.y, plantcoords.z))
                elseif plantgrow == 100 and distance < 2 and DoesEntityExist(plant) then
                    _sleep = 0
                    ShowFloatingHelpNotification('~INPUT_CONTEXT~ Recoger planta~' , vector3(plantcoords.x, plantcoords.y, plantcoords.z))
                    if IsControlJustPressed(0, 38) then
                        recogercoca(GetEntityCoords(PlayerPedId()))
                        DeleteEntity(plant)
                    end
                end
                Wait(_sleep)
            end
        end)
    end
end

CreateThread(function()
    while true do
        local _sleep = 1000
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply)
        local dist = #(plyCoords - vector3(2889.673,4391.291,50.452))
        if dist < 2 then
            _sleep = 0
            ShowFloatingHelpNotification('~INPUT_CONTEXT~ Procesar cocaina' , vector3(2889.673,4391.291,50.452))
            if IsControlJustPressed(0, 38) then
                procesacoca()
            end
        end
        Wait(_sleep)
    end
end)

CreateThread(function()
    while true do
        local _sleep = 1000
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply)
        local dist = #(plyCoords - vector3(-789.701,-202.742,37.284))
        if dist < 2 then
            _sleep = 0
            ShowFloatingHelpNotification('~INPUT_CONTEXT~ Vender cocaina' , vector3(-789.701,-202.742,37.284))
            if IsControlJustPressed(0, 38) then
                vendercoca()
            end
        end
        Wait(_sleep)
    end
end)

CreateThread(function()
    while true do
        local _sleep = 1000
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply)
        local dist = #(plyCoords - vector3(203.851,-1874.179,24.721))
        if dist < 2 then
            _sleep = 0
            ShowFloatingHelpNotification('~INPUT_CONTEXT~ Vender maria' , vector3(203.851,-1874.179,24.721))
            if IsControlJustPressed(0, 38) then
                vendermaria()
            end
        end
        Wait(_sleep)
    end
end)



function recogercoca(crds)
    ESX.Streaming.RequestAnimDict('anim@mp_snowball', function()
        TaskPlayAnim(PlayerPedId(), 'anim@mp_snowball', 'pickup_snowball', 8.0, -8.0, -1, 0, 0, false, false, false)
        Wait(1000)
        ClearPedTasks(PlayerPedId())
    end)
    TriggerServerEvent('rsx_drugs:harvestcoca', crds)
    print('Planta recogida')
end

function createped(model, x, y, z, h)
    local spawned = false
    ESX.Streaming.RequestModel(model, function()
        local ped
        if not spawned then
            ped = CreatePed(4, model, x, y, z, 0.0, true, true)
            spawned = true
        end
        print(DoesEntityExist(ped))
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
     end)
end
createped('a_f_y_business_01', -789.701,-202.742,36.284, 40.3)
createped('s_m_m_strperf_01', 203.851,-1874.179,23.721, 10.3)

RegisterNetEvent('rsx_drugs:seedcoca', function()
    if inareacoca then
        print('pene')
        plantarcoca()
    end
end)

function procesacoca()
    TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
    Wait(20000)
    ClearPedTasks(PlayerPedId())
    TriggerServerEvent('rsx_drugs:processcoca', GetEntityCoords(PlayerPedId()))
end

function vendercoca()
    TriggerServerEvent('rsx_drugs:sellcoca')
    ExecuteCommand('entorno Hola? Policía?, estoy viendo a una chica arrinconada junto a un extraño, creo que la quiere violar o estan trapicheando')
end

function vendermaria()
    TriggerServerEvent('rsx_drugs:sellmaria')
    ExecuteCommand('entorno Hola? Policía?, hay gente trapicheando por aqui')
end

-- Coca

ShowFloatingHelpNotification = function(msg, coords)
	AddTextEntry('dFloatingHelpNotification', msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('dFloatingHelpNotification')
	EndTextCommandDisplayHelp(2, false, false, -1)
end