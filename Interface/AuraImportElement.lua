local _, SUP = ...

function SUP:CreateAuraImportElement(parent)
    -- Outer frame
    local frame = CreateFrame("Frame", nil, parent)

    frame.height = 40

    frame:SetHeight(frame.height)

    -- Icon
    frame.icon = CreateFrame("Frame", nil, frame)

    frame.icon:SetSize(24, 24)
    frame.icon:Hide()
    frame.icon:SetPoint("LEFT", frame, "LEFT", 8, 0)

    frame.icon.tex = frame.icon:CreateTexture(nil, "BACKGROUND")
    frame.icon.tex:SetAllPoints(frame.icon)
    frame.icon.tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)

    -- Display name
    frame.displayName = frame:CreateFontString(nil, "OVERLAY")

    frame.displayName:SetFont(SUP.gs.visual.font, 17, SUP.gs.visual.fontFlags)
    frame.displayName:SetPoint("LEFT", frame, "LEFT", 8, 0)
    
    function frame:SetDisplayName(displayName)
        frame.displayName:SetText(string.format("|cff%s%s|r", SUP.gs.visual.colorStrings.white, displayName))

        local auraData = SchwalbenUpdaterSaved.WeakAuras[displayName]

        frame.importButton:SetScript(
            "OnClick",
            function()
                WeakAuras.Import(auraData)
            end
        )

        local icon = auraData.d.groupIcon

        if icon then
            frame.icon.tex:SetTexture(icon)
        end

        frame.icon:SetShown(icon)
        frame.displayName:SetPoint("LEFT", frame, "LEFT", icon and 38 or 8, 0)
    end

    -- Version count
    frame.versionCount = frame:CreateFontString(nil, "OVERLAY")

    frame.versionCount:SetFont(SUP.gs.visual.font, 17, SUP.gs.visual.fontFlags)
    frame.versionCount:SetPoint("CENTER", frame, "CENTER")
    
    function frame:SetVersionsBehind(count)
        frame.versionCount:SetText(string.format("|cff%s%d Version(en)|r", SUP.gs.visual.colorStrings.red, count))
    end

    -- Import button
    frame.importButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")

    frame.importButton:SetPoint("RIGHT", frame, "RIGHT", -8, 0)
    frame.importButton:SetText("Update")
    frame.importButton:GetFontString():SetFont(SUP.gs.visual.font, 13)

    C_Timer.After(0, function() frame.importButton:SetSize(frame.importButton:GetTextWidth() + 20, 32) end)

    -- Requires addon update text
    frame.requiresUpdateText = frame:CreateFontString(nil, "OVERLAY")

    frame.requiresUpdateText:SetFont(SUP.gs.visual.font, 17, SUP.gs.visual.fontFlags)
    frame.requiresUpdateText:SetPoint("RIGHT", frame, "RIGHT", -8, 0)
    frame.requiresUpdateText:SetText(string.format("|cff%sAddon Updaten!|r", SUP.gs.visual.colorStrings.red))
    frame.requiresUpdateText:Hide()

    SUP:AddTooltip(frame.requiresUpdateText, "Eine neuere Version ist verfügbar. Aktuelle dein Addon für die Installation.")

    -- Border
    SUP:AddBorder(frame)

    local borderColor = SUP.gs.visual.borderColor

    frame:SetBorderColor(borderColor.r, borderColor.g, borderColor.b)

    function frame:SetRequiresAddOnUpdate(requiresUpdate)
        frame.importButton:SetShown(not requiresUpdate)
        frame.requiresUpdateText:SetShown(requiresUpdate)
    end

    return frame
end