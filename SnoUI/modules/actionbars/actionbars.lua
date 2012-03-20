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
if not T.lowversion then
	TukuiBar1:SetPoint("BOTTOM", UIParent, "BOTTOM", -(((T.buttonsize * 6) + (T.buttonspacing * 7)+10)/2), 7)
else
	TukuiBar1:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 7)
end
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

if not T.lowversion then
	InvTukuiActionBarBackground:SetPoint("BOTTOMRIGHT", TukuiBar3)
else
	InvTukuiActionBarBackground:SetPoint("BOTTOMRIGHT", TukuiBar1)
	TukuiBar2:Show()
	TukuiBar2:SetAlpha(1)
end
InvTukuiActionBarBackground:SetPoint("TOPLEFT", TukuiBar2)



if not C.actionbar.hideshapeshift == true then 
	TukuiShiftBar:ClearAllPoints()
	TukuiShiftBar:Point("BOTTOMLEFT", UIParent,"BOTTOMLEFT", 6, 160)
else
	TukuiShiftBar:Hide()
end

-- kill the show/hide button because they doesn't fit my new bar layout
TukuiBar2Button:Kill()
TukuiBar3Button:Kill()
TukuiBar4Button:Kill()
TukuiBar5ButtonTop:Kill()
TukuiBar5ButtonBottom:Kill()

-- Move and resize the button to exit vehicle
TukuiExitVehicleButtonLeft:ClearAllPoints()
TukuiExitVehicleButtonLeft:SetSize(14, (T.buttonsize) + (T.buttonspacing * 2))
if T.lowversion then
	TukuiExitVehicleButtonLeft:SetPoint("BOTTOMLEFT", TukuiBar2, "BOTTOMRIGHT", 2, 0)
else
	TukuiExitVehicleButtonLeft:SetPoint("BOTTOMLEFT", TukuiBar3, "BOTTOMRIGHT", 2, 0)
end
TukuiExitVehicleButtonRight:ClearAllPoints()
TukuiExitVehicleButtonRight:SetSize(14, (T.buttonsize) + (T.buttonspacing * 2))
TukuiExitVehicleButtonRight:SetPoint("BOTTOMRIGHT", TukuiBar1, "BOTTOMLEFT", -2, 0)

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
	TukuiBar2:Show()
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


local ButtonStyle = function(self)
	local name = self:GetName()
	local Count = _G[name.."Count"]
	local Icon = _G[name.."Icon"]
	local Hotkey = _G[name.."HotKey"]
	local ButtonBorder = _G[name.."Panel"]

	if ButtonBorder then
		if ButtonBorder.buttongloss then return end
		local buttongloss = CreateFrame("Frame", ButtonBorder:GetName().."_ButtonGloss", ButtonBorder)
		buttongloss:Point("CENTER", ButtonBorder, "CENTER", 0, 0)
		buttongloss:Size(T.buttonsize, T.buttonsize)
		buttongloss:SetFrameStrata(ButtonBorder:GetFrameStrata())
		buttongloss:SetFrameLevel(ButtonBorder:GetFrameLevel() + 2)

		local tex = buttongloss:CreateTexture(nil, "OVERLAY")
		tex:SetTexture(C.media.gloss)
		tex:SetPoint("TOPLEFT", buttongloss, 2, -2)
		tex:SetPoint("BOTTOMRIGHT", buttongloss, -2, 2)
		tex:SetAlpha(.4)
		ButtonBorder.buttongloss = buttongloss
	end
end

hooksecurefunc("ActionButton_Update", ButtonStyle)

local ShiftAndPetButtonStyle = function(normal, button, icon, name, pet)
	local PetButtonBorder = _G[name.."Panel"]

	if PetButtonBorder then
		if PetButtonBorder.petbuttongloss then return end
		local petbuttongloss = CreateFrame("Frame", PetButtonBorder:GetName().."_ButtonGloss", PetButtonBorder)
		petbuttongloss:Point("CENTER", PetButtonBorder, "CENTER", 0, 0)
		petbuttongloss:Size(T.petbuttonsize, T.petbuttonsize)
		petbuttongloss:SetFrameStrata(PetButtonBorder:GetFrameStrata())
		petbuttongloss:SetFrameLevel(PetButtonBorder:GetFrameLevel() + 2)

		local pettex = petbuttongloss:CreateTexture(nil, "OVERLAY")
		pettex:SetTexture(C.media.gloss)
		pettex:SetPoint("TOPLEFT", petbuttongloss, 2, -2)
		pettex:SetPoint("BOTTOMRIGHT", petbuttongloss, -2, 2)
		pettex:SetAlpha(.3)
		PetButtonBorder.petbuttongloss = petbuttongloss
	end
end

hooksecurefunc(T, "StyleActionBarPetAndShiftButton", ShiftAndPetButtonStyle)

