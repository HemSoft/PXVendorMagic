PXVendorMagicAddon = {
  Name = "PXVendorMagic",
  Version = "1.0.4",

  DefaultSettings = {
    enableVendorAutomation = false,
    vendorAutomationMaxGold = 100,
    vendorAutomationMaxUnitPrice = 10,
    vendorAutomationInventoryCount = 10,
    enableVendorAutomationDebugging = false,
  },
}

PXVendorMagicAddon.savedVariables = PXVendorMagicAddon.DefaultSettings

---------------------------------------------------------------------------------------------------------
-- Initialize:
---------------------------------------------------------------------------------------------------------
function PXVendorMagicAddon:Initialize()
  PXVendorMagicAddon:CreateSettingsWindow()

  ------------
  -- EVENTS --
  ------------
  EVENT_MANAGER:RegisterForEvent(PXVendorMagicAddon.Name, EVENT_OPEN_STORE,
    function(eventCode)
      if (PXVendorMagicAddon.savedVariables.enableVendorAutomationDebugging) then
        d('PXVM -- EVENT_OPEN_TRADING_HOUSE')
      end
      if (PXVendorMagicAddon.savedVariables.enableVendorAutomation) then
        if (PXVendorMagicAddon.savedVariables.enableVendorAutomationDebugging) then
          d('PXVM -- Vendor automation enabled.')
        end
        local goldSpent = 0
        local storeItems = GetNumStoreItems()
        if (PXVendorMagicAddon.savedVariables.enableVendorAutomationDebugging) then
          d('PXVM -- Store Items = ' .. storeItems)
        end

        local notifiedAboutSpendingExceeded = false
        for x = 1, storeItems do
          local itemFilterType = GetStoreEntryTypeInfo(x)
          local icon, name, stack, price, sellPrice, meetsRequirementsToBuy, meetsRequirementsToUse, quality, questNameColor, currencyType1, currencyQuantity1, currencyType2, currencyQuantity2, storeEntryType = GetStoreEntryInfo(x)
          local storeItemLink =  GetStoreItemLink(x, LINK_STYLE_DEFAULT)

          -- ITEMFILTERTYPE_CRAFTING = 4
          -- CURT_MONEY = 1
          if (itemFilterType == ITEMFILTERTYPE_CRAFTING and (currencyType1 == CURT_MONEY or currencyType1 == CURT_NONE)) then
            local stackCountBackpack, stackCountBank, stackCountCraftBag = GetItemLinkStacks(storeItemLink)
            local totalStackSize = stackCountBackpack + stackCountBank + stackCountCraftBag

            if (PXVendorMagicAddon.savedVariables.enableVendorAutomationDebugging) then
              d('PXVM -- Looking at ' .. name .. ', my stack is ' .. totalStackSize .. ' and my goal is ' .. PXVendorMagicAddon.savedVariables.vendorAutomationInventoryCount)
            end

            if (totalStackSize < PXVendorMagicAddon.savedVariables.vendorAutomationInventoryCount) then
              local toBuy = PXVendorMagicAddon.savedVariables.vendorAutomationInventoryCount - totalStackSize
              local maxBuyable = GetStoreEntryMaxBuyable(x)

              if (goldSpent >  PXVendorMagicAddon.savedVariables.vendorAutomationMaxGold and notifiedAboutSpendingExceeded == false) then
                if (PXVendorMagicAddon.savedVariables.enableVendorAutomationDebugging) then
                  d('PXVM -- Spending limit hit. Not buying ' .. toBuy .. ' of ' .. name .. ' @' .. self:MoneyString(price) .. ' = ' .. self:MoneyString(toBuy * price))
                  notifiedAboutSpendingExceeded = true
                end
              else
                if (price <= PXVendorMagicAddon.savedVariables.vendorAutomationMaxUnitPrice) then
                  if (PXVendorMagicAddon.savedVariables.enableVendorAutomationDebugging) then
                    d('PXVM -- Buying ' .. toBuy .. ' of ' .. name .. ' @' .. self:MoneyString(price) .. ' = ' .. self:MoneyString(toBuy * price))
                  end
                  BuyStoreItem(x, toBuy)
                  goldSpent = goldSpent + (toBuy * price)
                else
                  if (PXVendorMagicAddon.savedVariables.enableVendorAutomationDebugging) then
                    d('PXVM -- Price per unit ' .. price .. ' exceeds ' .. PXVendorMagicAddon.savedVariables.vendorAutomationMaxUnitPrice .. '. Not buying ' .. toBuy .. ' of ' .. name .. ' @' .. self:MoneyString(price) .. ' = ' .. self:MoneyString(toBuy * price))
                  end
                end
              end
            else
              if (PXVendorMagicAddon.savedVariables.enableVendorAutomationDebugging) then
                d('PXVM -- Already have enough ' .. name .. ' (' .. totalStackSize .. ') -- So not buying...')
                notifiedAboutSpendingExceeded = true
              end
            end
          end
        end

        if (goldSpent > 0) then
          if (PXVendorMagicAddon.savedVariables.enableVendorAutomationDebugging) then
            d('PXIP -- Spent a total of ' .. self:MoneyString(goldSpent))
          end
        end
      end
    end
  )

  PXVendorMagicAddon.savedVariables = ZO_SavedVars:New("PXVendorMagicSavedVariables", 1, nil, PXVendorMagicAddon.DefaultSettings)
  if (PXVendorMagicAddon.savedVariables == nil) then  
    PXVendorMagicAddon.savedVariables = PXVendorMagicAddon.DefaultSettings
  end

end

---------------------------------------------------------------------------------------------------------
-- E V E N T S
---------------------------------------------------------------------------------------------------------
function PXVendorMagicAddon.OnAddOnLoaded(event, addonName)
  if addonName == PXVendorMagicAddon.Name then
    EVENT_MANAGER:UnregisterForEvent(addonName, event)
    PXVendorMagicAddon:Initialize()
  end
end

---------------------------------------------------------------------------------------------------------
-- H E L P E R    F U N C T I O N S
---------------------------------------------------------------------------------------------------------
function PXVendorMagicAddon:MoneyString(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

-- Finally, we'll register our event handler function to be called when the proper event occurs.
EVENT_MANAGER:RegisterForEvent(PXVendorMagicAddon.Name, EVENT_ADD_ON_LOADED, PXVendorMagicAddon.OnAddOnLoaded)
