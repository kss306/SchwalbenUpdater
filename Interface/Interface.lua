local addOnName, SUP = ...

CreateFrame("GameTooltip", "LRTooltip", UIParent, "GameTooltipTemplate")

SUP.Tooltip = _G["LRTooltip"]
SUP.Tooltip.TextLeft1:SetFont(SUP.gs.visual.font, 13)

local windowWidth = 600
local windowHeight = 400

function SUP:InitializeInterface()
    local screenWidth, screenHeight = GetPhysicalScreenSize()

    -- Window
    SUP.window = SUP:CreateWindow("Main", true, true, true)
    SUP.window:SetFrameStrata("HIGH")
    SUP.window:SetResizeBounds(windowWidth, windowHeight)
    SUP.window:Hide()

    local buttonFrame = CreateFrame("Frame", nil, SUP.window)

    buttonFrame:SetPoint("TOPLEFT", SUP.window.moverFrame, "BOTTOMLEFT")
    buttonFrame:SetPoint("TOPRIGHT", SUP.window.moverFrame, "BOTTOMRIGHT")

    buttonFrame:SetHeight(32)

    local updateButton = CreateFrame("Frame", nil, SUP.window)

    updateButton:SetPoint("TOPLEFT", buttonFrame, "TOPLEFT", 4, -4)
    updateButton:SetPoint("BOTTOMRIGHT", buttonFrame, "BOTTOM", -2, 0)
    updateButton:EnableMouse(true)

    updateButton.highlight = updateButton:CreateTexture(nil, "HIGHLIGHT")
    updateButton.highlight:SetColorTexture(1, 1, 1, 0.05)
    updateButton.highlight:SetAllPoints()

    updateButton.text = updateButton:CreateFontString(nil, "OVERLAY")
    updateButton.text:SetFont(SUP.gs.visual.font, 17, SUP.gs.visual.fontFlags)
    updateButton.text:SetPoint("CENTER", updateButton, "CENTER")
    updateButton.text:SetText(string.format("|cff%sUpdate|r", SUP.gs.visual.colorStrings.white))

    updateButton:SetScript(
        "OnMouseDown",
        function()
            SUP.updateWindow:Show()
            SUP.checkWindow:Hide()
        end
    )

    local borderColor = SUP.gs.visual.borderColor
    SUP:AddBorder(updateButton)
    updateButton:SetBorderColor(borderColor.r, borderColor.g, borderColor.b)

    local checkButton = CreateFrame("Frame", nil, SUP.window)

    checkButton:SetPoint("TOPRIGHT", buttonFrame, "TOPRIGHT", -4, -4)
    checkButton:SetPoint("BOTTOMLEFT", buttonFrame, "BOTTOM", 2, 0)
    checkButton:EnableMouse(true)

    checkButton.highlight = checkButton:CreateTexture(nil, "HIGHLIGHT")
    checkButton.highlight:SetColorTexture(1, 1, 1, 0.05)
    checkButton.highlight:SetAllPoints()

    checkButton.text = checkButton:CreateFontString(nil, "OVERLAY")
    checkButton.text:SetFont(SUP.gs.visual.font, 17, SUP.gs.visual.fontFlags)
    checkButton.text:SetPoint("CENTER", checkButton, "CENTER")
    checkButton.text:SetText(string.format("|cff%sCheck|r", SUP.gs.visual.colorStrings.white))

    checkButton:SetScript(
        "OnMouseDown",
        function()
            SUP.updateWindow:Hide()
            SUP.checkWindow:Show()
        end
    )

    SUP:AddBorder(checkButton)
    checkButton:SetBorderColor(borderColor.r, borderColor.g, borderColor.b)

    -- Sub windows
    SUP.updateWindow = CreateFrame("Frame", nil, SUP.window)
    SUP.updateWindow:SetPoint("TOPLEFT", buttonFrame, "BOTTOMLEFT")
    SUP.updateWindow:SetPoint("BOTTOMRIGHT", SUP.window, "BOTTOMRIGHT")

    SUP.checkWindow = CreateFrame("Frame", nil, SUP.window)
    SUP.checkWindow:SetPoint("TOPLEFT", buttonFrame, "BOTTOMLEFT")
    SUP.checkWindow:SetPoint("BOTTOMRIGHT", SUP.window, "BOTTOMRIGHT")

    SUP.checkWindow:Hide()

    local windowSettings = SchwalbenUpdaterSaved.settings.frames["Main"]

    if not windowSettings or not windowSettings.points then
        SUP.window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", (screenWidth - windowWidth) / 2, -(screenHeight - windowHeight) / 2)
    end

    if not windowSettings or not windowSettings.width then
        SUP.window:SetSize(windowWidth, windowHeight)
    end
end