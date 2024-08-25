shopMain = zUI.CreateMenu(" ", "Super Market", "F1", " ", "https://media.discordapp.net/attachments/1275932606768222400/1277250561003098203/shopui_title_gunclub_1.png?ex=66cc7bc7&is=66cb2a47&hm=1be2344120cb9c5b2c1509d53aa77966cb5745a788725a326ffdc0e14fe23045&=&format=webp&quality=lossless")
local shopBasket = zUI.CreateSubMenu(shopMain, " ", "Super Market")

local basketList, basketListIndex = {}, 1
shopSelect = ""

shopMain:SetItems(function(Items)
    Items:AddButton("Mon Panier", 'Accéder à ~g~"Mon Panier"~s~.', { RightBadge = "ARMOUR_ICON_A"},
    nil, shopBasket)
    Items:AddLine({ "#f34747", "#ff0000"})
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
            basketList = {}
        end
    end)
    Items:AddSeparator("Mon Panier")
    Items:AddLine({ "#f34747", "#ff0000"})
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
