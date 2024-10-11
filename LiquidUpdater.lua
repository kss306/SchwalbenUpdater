local _, LUP = ...

local LDB = LibStub("LibDataBroker-1.1")
local LDBIcon = LibStub("LibDBIcon-1.0")
local eventFrame = CreateFrame("Frame")

eventFrame:RegisterEvent("ADDON_LOADED")

eventFrame:SetScript(
    "OnEvent",
    function(_, event, ...)
        if event == "ADDON_LOADED" then
            local addOnName = ...

            if addOnName == "LiquidUpdater" then
                if not LiquidUpdaterSaved then LiquidUpdaterSaved = {} end
                if not LiquidUpdaterSaved.minimap then LiquidUpdaterSaved.minimap = {} end
                if not LiquidUpdaterSaved.settings then LiquidUpdaterSaved.settings = {} end
                if not LiquidUpdaterSaved.settings.frames then LiquidUpdaterSaved.settings.frames = {} end

                -- Minimap icon
                LUP.LDB = LDB:NewDataObject(
                    "Liquid Updater",
                    {
                        type = "data source",
                        text = "Liquid Updater",
                        icon = [[Interface\Addons\LiquidUpdater\Media\Textures\minimap_logo.tga]],
                        OnClick = function() LUP.window:SetShown(not LUP.window:IsShown()) end
                    }
                )

                LDBIcon:Register("Liquid Updater", LUP.LDB, LiquidUpdaterSaved.minimap)

                LUP:InitializeWeakAurasImporter()
                LUP:InitializeInterface()
                LUP:InitializeAuraUpdater()
                LUP:InitializeAuraChecker()
            end
        end
    end
)

SLASH_LIQUIDUPDATER1, SLASH_LIQUIDUPDATER2, SLASH_LIQUIDUPDATER3 = "/lu", "/liquidupdate", "/liquidupdater"
function SlashCmdList.LIQUIDUPDATER()
    LUP.window:SetShown(not LUP.window:IsShown())
end