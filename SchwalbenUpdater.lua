local _, SUP = ...

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
                SUP.LDB = LDB:NewDataObject(
                    "Schwalben Updater",
                    {
                        type = "data source",
                        text = "Schwalben Updater",
                        icon = [[Interface\Addons\SchwalbenUpdater\Media\Textures\minimap_logo.tga]],
                        OnClick = function() SUP.window:SetShown(not SUP.window:IsShown()) end
                    }
                )

                LDBIcon:Register("Schwalben Updater", SUP.LDB, SchwalbenUpdaterSaved.minimap)
                
                SUP:InitializeWeakAurasImporter()
                SUP:InitializeInterface()
                SUP:InitializeAuraUpdater()
                SUP:InitializeAuraChecker()
            end
        end
    end
)

SLASH_SCHWALBENUPDATER1, SLASH_SCHWALBENUPDATER2 = "/sup" , "/schwalbenupdate"
function SlashCmdList.SCHWALBENUPDATER()
    SUP.window:SetShown(not SUP.window:IsShown())
end