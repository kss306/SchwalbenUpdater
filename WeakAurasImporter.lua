---@diagnostic disable: undefined-field
local _, SUP = ...

local LibSerialize = LibStub("LibSerialize")
local LibDeflate = LibStub("LibDeflate")

function SUP:InitializeWeakAurasImporter()
    if not SchwalbenUpdaterSaved.WeakAuras then SchwalbenUpdaterSaved.WeakAuras = {} end
    for _, auraData in ipairs(SUP.WeakAuras) do
        local displayName = auraData.displayName
        local version = auraData.version
        local importedVersion = SchwalbenUpdaterSaved.WeakAuras[displayName] and SchwalbenUpdaterSaved.WeakAuras[displayName].d and SchwalbenUpdaterSaved.WeakAuras[displayName].d.version

        if not importedVersion or importedVersion < version then
            local toDecode = auraData.data:match("!WA:2!(.+)")
            local decoded = LibDeflate:DecodeForPrint(toDecode)
            local decompressed = LibDeflate:DecompressDeflate(decoded)
            local success, data = LibSerialize:Deserialize(decompressed)

            if success then
                SchwalbenUpdaterSaved.WeakAuras[displayName] = data
            end
        end
    end
end