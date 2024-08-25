local loadShopZoneBlips = function()
    for blipId, blip in pairs(shopList) do
        local b = AddBlipForCoord(blip.position.x, blip.position.y, blip.position.z)
        SetBlipSprite(b, 59)
        SetBlipColour(b, 11)
        SetBlipAsShortRange(b, false)
        SetBlipScale(b, 0.6)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Super Market")
        EndTextCommandSetBlipName(b)
    end

    while true do
        local interval = 500
        local pos = GetEntityCoords(PlayerPedId())
        local closeToMarker = false
        for zoneId, zone in pairs(shopList) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), zone.position.x, zone.position.y, zone.position.z, true) < 8.0 then
                closeToMarker = true
                DrawMarker(25, zone.position.x, zone.position.y, zone.position.z-0.88, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 0, 107, 87, 255, 0, 0, 0, 0, nil, nil, 0)
                if GetDistanceBetweenCoords(pos, zone.position.x, zone.position.y, zone.position.z, true) < 2.0 then
                    ESX.Game.Utils.DrawText3D(zone.position, (("~b~%s\n[E]"):format(zone.label) or "~b~Pour intéragir"), 0.8, 0)
                    if IsControlJustPressed(0, 51) then
                        shopSelect = zone.name
                        shopMain:SetVisible(not shopMain:IsVisible())
                    end
                end
            end
        end
        if closeToMarker then
            interval = 0
        end
        Wait(interval)
    end
end

Citizen.CreateThread(function()
    Wait(5000)
    loadShopZoneBlips()
end)