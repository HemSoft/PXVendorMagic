---------------------------------------------------------------------------------------------------------
-- S E T T I N G S
---------------------------------------------------------------------------------------------------------
function PXVendorMagicAddon:CreateSettingsWindow()
  local LAM2 = LibStub("LibAddonMenu-2.0")
  local panelData =
  {
    type                = "panel",
    name                = self.Name,
    displayName         = GetString(PXVM_SETTINGS_DISPLAY_NAME),
    author              = GetString(PXVM_SETTINGS_AUTHOR),
    version             = self.Version,
    registerForRefresh  = true,
    registerForDefaults = true
  }

  local cntrlOptionsPanel = LAM2:RegisterAddonPanel(self.Name, panelData)

  local optionsData =
  {
    {
      type = "description",
      text = GetString(PXVM_SETTINGS_HEADER_TEXT),
    },

    -----------------------
    -- Vendor Automation --
    -----------------------
    {
      type = "submenu",
      name = GetString(PXVM_SETTINGS_VENDOR_AUTOMATION),
      controls =
      {
        {
          type    = "description",
          text    = GetString(PXVM_VENDOR_AUTOMATION_DESCRIPTION),
        },
        {
          type    = "checkbox",
          name    = GetString(PXVM_SETTINGS_VENDOR_AUTOMATION_ENABLE),
          tooltip = GetString(PXVM_SETTINGS_VENDOR_AUTOMATION_ENABLE_TOOLTIP),
          getFunc = function() return self.savedVariables.enableVendorAutomation end,
          setFunc = function(e) self.savedVariables.enableVendorAutomation = e end,
          default = self.DefaultSettings.enableVendorAutomation,
        },
        {
          type    = "slider",
          name    = GetString(PXVM_VENDOR_AUTOMATION_INVENTORY_COUNT),
          tooltip = GetString(PXVM_VENDOR_AUTOMATION_INVENTORY_COUNT_TOOLTIP),
          min     = 0, max = 500, step = 1,
          getFunc = function() return self.savedVariables.vendorAutomationInventoryCount end,
          setFunc = function(value) self.savedVariables.vendorAutomationInventoryCount = value end,
          width   = "full",
          default = self.DefaultSettings.vendorAutomationInventoryCount,
          disabled= function(e) return not self.savedVariables.enableVendorAutomation; end,
        },
        {
          type    = "slider",
          name    = GetString(PXVM_VENDOR_AUTOMATION_MAX_GOLD_LIMIT),
          tooltip = GetString(PXVM_VENDOR_AUTOMATION_MAX_GOLD_LIMIT_TOOLTIP),
          min     = 0, max = 100000, step = 1,
          getFunc = function() return self.savedVariables.vendorAutomationMaxGold end,
          setFunc = function(value) self.savedVariables.vendorAutomationMaxGold = value end,
          width   = "full",
          default = self.DefaultSettings.vendorAutomationMaxGold,
          disabled= function(e) return not self.savedVariables.enableVendorAutomation; end,
        },
        {
          type    = "slider",
          name    = GetString(PXVM_VENDOR_AUTOMATION_MAX_UNIT_PRICE),
          tooltip = GetString(PXVM_VENDOR_AUTOMATION_MAX_UNIT_PRICE_TOOLTIP),
          min     = 0, max = 500, step = 1,
          getFunc = function() return self.savedVariables.vendorAutomationMaxUnitPrice end,
          setFunc = function(value) self.savedVariables.vendorAutomationMaxUnitPrice = value end,
          width   = "full",
          default = self.DefaultSettings.vendorAutomationMaxUnitPrice,
          disabled= function(e) return not self.savedVariables.enableVendorAutomation; end,
        },
        {
          type    = "checkbox",
          name    = GetString(PXVM_VENDOR_AUTOMATION_DEBUG),
          getFunc = function() return self.savedVariables.enableVendorAutomationDebugging end,
          setFunc = function(e) self.savedVariables.enableVendorAutomationDebugging = e end,
          default = self.DefaultSettings.enableVendorAutomationDebugging,
        },
      },
    },
  }

  LAM2:RegisterOptionControls(self.Name, optionsData)
end
