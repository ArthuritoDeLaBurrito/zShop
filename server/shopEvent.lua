RegisterServerEvent("zShop:buyItem")
AddEventHandler("zShop:buyItem", function(basketList, basketIndex)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local account = ""
    if basketIndex == 1 then account = "money" elseif basketIndex == 2 then account = "bank" end
    for itemName, itemData in pairs(basketList) do
        if xPlayer.getAccount(account).money >= itemData.priceQuantity then
            xPlayer.removeAccountMoney(account, itemData.priceQuantity)
            xPlayer.addInventoryItem(itemData.name, itemData.quantity)
        else
            xPlayer.showNotification(("Vous n'avez pas assez d'Argent pour acheter x%s %s"):format(itemData.quantity, itemData.label))
        end
    end
end)