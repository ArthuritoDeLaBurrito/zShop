shopMain = zUI.CreateMenu(" ", "Super Market", nil, nil, "https://media.discordapp.net/attachments/1275932606768222400/1277250560776732733/shopui_title_conveniencestore_1.png?ex=66cd2487&is=66cbd307&hm=fbf2b87050e0239e24d0e2b3d241bbdf0fe101f1e055dfa7886676935cb7efec&=&format=webp&quality=lossless")
local shopBasket = zUI.CreateSubMenu(shopMain, " ", "Super Market")

local basketList, basketListIndex = {}, 1
shopSelect = ""

shopMain:SetItems(function(Items)
    Items:AddButton("Mon Panier", 'Accéder à ~g~"Mon Panier"~s~.', { RightBadge = "ARMOUR_ICON_A"},
    nil, shopBasket)
    Items:AddLine({ "#006B57"})
    for itemName, itemData in pairs(shopItems[shopSelect]) do
        if itemData.LeftBadge ~= nil then
            Items:AddButton(("%s"):format(itemData.label), ('Ajouter un / une ~g~"%s"~s~ à votre panier.'):format(itemData.label), { RightLabel = ("~g~%s$"):format(itemData.price), LeftBadge = itemData.LeftBadge},
            function(onSelected, onHovered)
                if onSelected then
                    basketList[itemName] = itemData
                    basketList[itemName].quantity = zUI.KeyboardInput(("%s"):format(itemData.label), "Quantier à Ajouter", "1", 3)
                    basketList[itemName].priceQuantity = tonumber(itemData.price * basketList[itemName].quantity)
                end
            end)
        else
            Items:AddButton(("%s"):format(itemData.label), ('Ajouter un / une ~g~"%s"~s~ à votre panier.'):format(itemData.label), { RightLabel = ("~g~%s$"):format(itemData.price)},
            function(onSelected, onHovered)
                if onSelected then
                    basketList[itemName] = itemData
                    basketList[itemName].quantity = zUI.KeyboardInput(("%s"):format(itemData.label), "Quantier à Ajouter", "1", 3)
                    basketList[itemName].priceQuantity = tonumber(itemData.price * basketList[itemName].quantity)
                end
            end)
        end
    end
end)

shopBasket:SetItems(function(Items)
    Items:AddList("Payer mon panier", "Choix du ~g~Moyen de payement~s~.", { "Liquide", "Carte Bancaire" }, {},
    function(onSelected, onHovered, onListChange, index)
        if onListChange then
            basketListIndex = index
        end
        if onSelected then
            TriggerServerEvent("zShop:buyItem", basketList, basketListIndex)
            basketList = {}
        end
    end)
    Items:AddButton("Vider le panier", "Retirer les ~g~Articles du Panier~s~", { RightBadge = "ALERT_TRIANGLE", Color = "#ff0000"},
    function(onSelected, onHovered)
        if onSelected then
            local confirm = zUI.AlertInput("SuperMarker", "", "Voulez vous supprimer le Panier ?")
            if confirm then basketList = {} end
        end
    end)
    Items:AddSeparator("Mon Panier")
    Items:AddLine({ "#006B57"})
    for itemName, itemData in pairs(basketList) do
        Items:AddButton(("%sx %s"):format(itemData.quantity, itemData.label), ('Modification d\'un / d\'une ~g~"%s"~s~.'):format(itemData.label), { RightLabel = ("~g~%s$"):format(itemData.priceQuantity)},
        function(onSelected, onHovered)
            if onSelected then
                local quantity = zUI.KeyboardInput(("%s"):format(itemData.label), "Quantier à Modifier", itemData.quantity, 3)
                if tonumber(quantity) == 0 then
                    basketList[itemName] = nil
                else
                    basketList[itemName].quantity = quantity
                    basketList[itemName].priceQuantity = tonumber(itemData.price * quantity)
                end
            end
        end)
    end
end)
