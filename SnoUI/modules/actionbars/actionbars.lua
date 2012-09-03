local T, C, L, G = unpack(Tukui)

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

-- Force to show bottoms bars
TukuiBar1:Show()
TukuiBar2:Show()
TukuiBar3:Show()

UnregisterStateDriver(TukuiBar4, "visibility")
UnregisterStateDriver(TukuiBar5, "visibility")
RegisterStateDriver( TukuiBar4, "visibility", "[vehicleui][petbattle][overridebar][combat] hide; show" )
RegisterStateDriver( TukuiBar5, "visibility", "[vehicleui][petbattle][overridebar][combat] hide; show" )


if not C.actionbar.hideshapeshift then
	G.ActionBars.Stance:ClearAllPoints()
	G.ActionBars.Stance:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 4, 160)
else
	G.ActionBars.Stance:SetAlpha(0)
end

-- Remove backdrop for Bar1. The Bar1 is in the Bar2's backdrops and set width
TukuiBar2:SetWidth((T.buttonsize * 12) + (T.buttonspacing * 11)+10)
TukuiBar2:SetHeight((T.buttonsize * 2) + (T.buttonspacing * 3))
TukuiBar1:SetHeight((T.buttonsize * 1) + (T.buttonspacing * 2))


if not T.lowversion then
	TukuiBar1:SetPoint("BOTTOM", UIParent, "BOTTOM", -(((T.buttonsize * 6) + (T.buttonspacing * 7)+10)/2), 7)
	TukuiBar3:SetPoint("BOTTOMLEFT", TukuiBar1, "BOTTOMRIGHT", 10, 0)
else
	TukuiBar1:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 7)
	TukuiBar2:SetAlpha(1)
end
TukuiBar2:SetPoint("BOTTOM", TukuiBar1, "BOTTOM",0,0)

TukuiBar4:SetWidth((T.buttonsize * 1) + (T.buttonspacing * 2))
TukuiBar4:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar4:SetPoint("LEFT", TukuiBar5, "RIGHT", -((T.buttonsize * 1) + (T.buttonspacing * 2)),0)
TukuiBar4:SetFrameLevel(1)

TukuiBar5:SetWidth((T.buttonsize * 2) + (T.buttonspacing * 4))
TukuiBar5:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar5:SetPoint("RIGHT", UIParent, "RIGHT", -8, -14)
TukuiBar5:SetFrameLevel(3)

TukuiBar5ButtonTop:SetWidth(TukuiBar5:GetWidth())
TukuiBar5ButtonBottom:SetWidth(TukuiBar5:GetWidth())

if not T.lowversion then
	InvTukuiActionBarBackground:SetPoint("BOTTOMRIGHT", TukuiBar3)
else
	InvTukuiActionBarBackground:SetPoint("BOTTOMRIGHT", TukuiBar1)
end
InvTukuiActionBarBackground:SetPoint("TOPLEFT", TukuiBar2)
InvTukuiActionBarBackground:SetAlpha(0)

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
	TukuiBar5:Hide()

	TukuiPetBar:Point("RIGHT", UIParent, "RIGHT", -14, 0)
	UnregisterStateDriver(TukuiBar4, "visibility")
	UnregisterStateDriver(TukuiBar5, "visibility")

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

	TukuiBar4:Show()
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

