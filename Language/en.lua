-- EN Language file, made by PhaeroX
local strings = {
  -- V1.0.0 -- New strings:
  PXVM_SETTINGS_DISPLAY_NAME                         = "PhaeroX Vendor Magic",
  PXVM_SETTINGS_AUTHOR                               = "|c28b712PhaeroX|r",
  PXVM_SETTINGS_HEADER_TEXT                          = "PhaeroX Vendor Magic Settings:",
  PXVM_SETTINGS_VENDOR_AUTOMATION                    = "Vendor Automation",
  PXVM_SETTINGS_VENDOR_AUTOMATION_ENABLE             = "Enable Vendor Automation",
  PXVM_SETTINGS_VENDOR_AUTOMATION_ENABLE_TOOLTIP     = "Enable automatic purchasing from vendor as defined below.",
  PXVM_VENDOR_AUTOMATION_MAX_GOLD_LIMIT              = "Do not spend more than",
  PXVM_VENDOR_AUTOMATION_MAX_GOLD_LIMIT_TOOLTIP      = "When talking to a vendor, purchasing will not exceed this gold amount.",
  PXVM_VENDOR_AUTOMATION_MAX_UNIT_PRICE              = "Max unit price",
  PXVM_VENDOR_AUTOMATION_MAX_UNIT_PRICE_TOOLTIP      = "Will not buy any items with a unit price exceeding this value.",
  PXVM_VENDOR_AUTOMATION_INVENTORY_COUNT             = "Inventory count you want",
  PXVM_VENDOR_AUTOMATION_INVENTORY_COUNT_TOOLTIP     = "This is the inventory you want to have. I you want 200 and have 190, 10 will be purchased.",
  PXVM_VENDOR_AUTOMATION_DEBUG                       = "Show chat debugging information.",
  PXVM_VENDOR_AUTOMATION_DESCRIPTION                 = "This section is intended to automate the purchasing of style items such as Molybdenum, Bone, etc. and runes from the ESO ingame vendor. You set the amount you want of each in your inventory, the price per unit max, the max gold you want to spend in total per session, and the addon will take care of the rest. Let's say you want to always have 25 of each inventory. Then lets say you have 21 Molybdenum, this addon will buy 4 Molybdenum and move on to the next. It will not go above the set spending limits per visit. Use this with caution and at your own risk. This was made to avoid the tedious task of buying a couple hundred style materials manually.",
}

for stringId, stringValue in pairs(strings) do
  ZO_CreateStringId(stringId, stringValue)
  SafeAddVersion(stringId, 1)
end