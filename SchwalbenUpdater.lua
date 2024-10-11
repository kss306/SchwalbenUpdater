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

            if addOnName == "SchwalbenUpdater" then
                if not SchwalbenUpdaterSaved then SchwalbenUpdaterSaved = {} end
                if not SchwalbenUpdaterSaved.minimap then SchwalbenUpdaterSaved.minimap = {} end
                if not SchwalbenUpdaterSaved.settings then SchwalbenUpdaterSaved.settings = {} end
                if not SchwalbenUpdaterSaved.settings.frames then SchwalbenUpdaterSaved.settings.frames = {} end

                -- Minimap icon
                LUP.LDB = LDB:NewDataObject(
                    "Schwalben Updater",
                    {
                        type = "data source",
                        text = "Schwalben Updater",
                        icon = [[Interface\Addons\SchwalbenUpdater\Media\Textures\minimap_logo.tga]],
                        OnClick = function() LUP.window:SetShown(not LUP.window:IsShown()) end
                    }
                )

                LDBIcon:Register("Schwalben Updater", LUP.LDB, SchwalbenUpdaterSaved.minimap)
                
                LUP:InitializeWeakAurasImporter()
                LUP:InitializeInterface()
                LUP:InitializeAuraUpdater()
                LUP:InitializeAuraChecker()
            end
        end
    end
)

SLASH_LIQUIDUPDATER1 = "/sup" -- , SLASH_LIQUIDUPDATER2, SLASH_LIQUIDUPDATER3 = "/sup", "/liquidupdate", "/liquidupdater"
function SlashCmdList.LIQUIDUPDATER()
    LUP.window:SetShown(not LUP.window:IsShown())
end