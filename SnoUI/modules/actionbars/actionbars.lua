local T, C, L = unpack(Tukui)

if not C.actionbar.enable == true then return end

---------------------------------------------------------------
-- Action Bars
---------------------------------------------------------------


-- Reset the ActionBarBackground
InvTukuiActionBarBackground:ClearAllPoints()

TukuiBar1:ClearAllPoints()
TukuiBar2:ClearAllPoints()
TukuiBar3:ClearAllPoints()
TukuiBar4:ClearAllPoints()
TukuiBar5:ClearAllPoints()

-- Remove backdrop for Bar2. The Bar2 is in the Bar1's backdrops and set width
TukuiBar2:SetBackdrop(nil)
TukuiBar2:SetWidth((T.buttonsize * 12) + (T.buttonspacing * 11)+10)

TukuiBar1:SetPoint("BOTTOM", UIParent, "BOTTOM", -(((T.buttonsize * 6) + (T.buttonspacing * 7)+10)/2), 7)
TukuiBar2:SetPoint("BOTTOM", TukuiBar1, "BOTTOM")
TukuiBar3:SetPoint("BOTTOMLEFT", TukuiBar1, "BOTTOMRIGHT", 10, 0)



TukuiBar4:SetWidth((T.buttonsize * 1) + (T.buttonspacing * 2))
TukuiBar4:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar4:SetPoint("RIGHT", UIParent, "RIGHT", -8, -14)
TukuiBar4:SetBackdrop(nil)

TukuiBar5:SetWidth((T.buttonsize * 2) + (T.buttonspacing * 3))
TukuiBar5:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar5:SetPoint("RIGHT", UIParent, "RIGHT", -8, -14)

TukuiBar5ButtonTop:SetWidth(TukuiBar5:GetWidth())
TukuiBar5ButtonBottom:SetWidth(TukuiBar5:GetWidth())

TukuiShiftBar:SetPoint("BOTTOMLEFT", UIParent, 6, 160)
InvTukuiActionBarBackground:SetPoint("TOPLEFT", TukuiBar2)
InvTukuiActionBarBackground:SetPoint("BOTTOMRIGHT", TukuiBar3)


if not C.actionbar.hideshapeshift == true then 
	TukuiShiftBar:ClearAllPoints()
	TukuiShiftBar:SetPoint("BOTTOMLEFT", UIParent,"BOTTOMLEFT", 6, 160)
else
	TukuiShiftBar:Hide()
end

-- kill the show/hide button because they doesn't fit my new bar layout
TukuiBar2Button:Kill()
TukuiBar3Button:Kill()
TukuiBar4Button:Kill()
TukuiBar5ButtonTop:Kill()
TukuiBar5ButtonBottom:Kill()

-- Function to hide/show sidebar
local function HideSideBar()
	if not TukuiDataPerChar then TukuiDataPerChar = {} end
	local db = TukuiDataPerChar
	local buttonTop = SnoUISideBarButtonTop
	local buttonBottom = SnoUISideBarButtonBottom
	
	TukuiPetBar:ClearAllPoints()
	TukuiBar4:Hide()
	db.hidebar4 = true
	TukuiBar5:Hide()
	db.hidebar5 = true
	TukuiPetBar:Point("RIGHT", UIParent, "RIGHT", -14, 0)

	-- Move/hide button
	buttonTop:Hide()
	buttonBottom:ClearAllPoints()
	buttonBottom:SetSize(14, TukuiLineToPetActionBarBackground:GetHeight())
	buttonBottom:Point("LEFT", TukuiPetBar, "RIGHT", 2, 0)
	buttonBottom.text:SetText("|cff4BAF4C<|r")
	
end
local function ShowSideBar()
	if not TukuiDataPerChar then TukuiDataPerChar = {} end
	local db = TukuiDataPerChar
	local buttonTop = SnoUISideBarButtonTop
	local buttonBottom = SnoUISideBarButtonBottom
	TukuiPetBar:ClearAllPoints()
	db.hidebar4 = false
	TukuiBar4:Show()
	db.hidebar5 = false
	TukuiBar5:Show()
	TukuiPetBar:Point("RIGHT", TukuiBar5, "LEFT", -6, 0)
	buttonTop:ClearAllPoints()
	buttonTop:Size(TukuiBar5:GetWidth(), 17)
	buttonTop:Point("BOTTOM", TukuiBar5, "TOP", 0, 2)
	buttonTop:Show()
	buttonBottom:ClearAllPoints()
	buttonBottom:Size(TukuiBar5:GetWidth(), 17)
	buttonBottom:Point("TOP", TukuiBar5, "BOTTOM", 0, -2)
	buttonBottom.text:SetText("|cff4BAF4C>|r")
end

local function ShowHideSideBar()
	if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
	if TukuiBar4:IsShown() then
		HideSideBar()
	else
		ShowSideBar()
	end
end

-- Create new buttons to hide/show Sidebar
local SnoUISideBarButtonTop = CreateFrame("Button", "SnoUISideBarButtonTop", UIParent)
SnoUISideBarButtonTop:SetWidth(TukuiBar5:GetWidth())
SnoUISideBarButtonTop:Height(17)
SnoUISideBarButtonTop:Point("BOTTOM", TukuiBar5, "TOP", 0, 2)
SnoUISideBarButtonTop:SetTemplate("Default")
SnoUISideBarButtonTop:RegisterForClicks("AnyUp")
SnoUISideBarButtonTop:SetAlpha(0)
SnoUISideBarButtonTop:SetScript("OnClick", function(self) ShowHideSideBar() end)
SnoUISideBarButtonTop:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
SnoUISideBarButtonTop:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
SnoUISideBarButtonTop.text = T.SetFontString(SnoUISideBarButtonTop, C.media.uffont, 20)
SnoUISideBarButtonTop.text:Point("CENTER", 1, 1)
SnoUISideBarButtonTop.text:SetText("|cff4BAF4C>|r")

local SnoUISideBarButtonBottom = CreateFrame("Button", "SnoUISideBarButtonBottom", UIParent)
SnoUISideBarButtonBottom:SetFrameLevel(TukuiBar5ButtonTop:GetFrameLevel() + 1)
SnoUISideBarButtonBottom:SetWidth(TukuiBar5:GetWidth())
SnoUISideBarButtonBottom:Height(17)
SnoUISideBarButtonBottom:Point("TOP", TukuiBar5, "BOTTOM", 0, -2)
SnoUISideBarButtonBottom:SetTemplate("Default")
SnoUISideBarButtonBottom:RegisterForClicks("AnyUp")
SnoUISideBarButtonBottom:SetAlpha(0)
SnoUISideBarButtonBottom:SetScript("OnClick", function(self) ShowHideSideBar() end)
SnoUISideBarButtonBottom:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
SnoUISideBarButtonBottom:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
SnoUISideBarButtonBottom.text = T.SetFontString(SnoUISideBarButtonBottom, C.media.uffont, 20)
SnoUISideBarButtonBottom.text:Point("CENTER", 1, 1)
SnoUISideBarButtonBottom.text:SetText("|cff4BAF4C>|r")

local sidebarHide = CreateFrame("Frame")

sidebarHide:RegisterEvent("PLAYER_REGEN_DISABLED")
sidebarHide:RegisterEvent("UNIT_ENTERING_VEHICLE")
sidebarHide:RegisterEvent("UNIT_ENTERED_VEHICLE")
sidebarHide:SetScript("OnEvent", HideSideBar)

local sidebarShow = CreateFrame("Frame")
sidebarShow:RegisterEvent("PLAYER_REGEN_ENABLED")
sidebarShow:RegisterEvent("UNIT_EXITING_VEHICLE")
sidebarShow:RegisterEvent("UNIT_EXITED_VEHICLE")
sidebarShow:SetScript("OnEvent", ShowSideBar)

