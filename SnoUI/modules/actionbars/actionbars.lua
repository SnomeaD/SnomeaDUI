local T, C, L = unpack(Tukui)

if not C.actionbar.enable == true then return end

---------------------------------------------------------------
-- Action Bars
---------------------------------------------------------------

-- I want to hide action bars background
for i = 1, 5 do
	local backdrop = _G["TukuiBar"..i]
	-- backdrop:SetBackdrop(nil)
end

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
TukuiBar3Button:Kill()
TukuiBar5ButtonTop:Kill()
TukuiBar5ButtonBottom:Kill()

-- move the pet bar

TukuiPetBar:ClearAllPoints()
TukuiPetBar:SetPoint("BOTTOMLEFT", UIParent,"BOTTOMLEFT", 6, 220)


-- Auto-hide sidebar when entering in combat
local function HideSideBar(self, event)
	if (UnitAffectingCombat("player") and not UnitInVehicle("player")) then
		TukuiBar4:Hide()
		TukuiBar5:Hide()
	else
		TukuiBar4:Show()
		TukuiBar5:Show()
	end
end

TukuiBar4:RegisterEvent("PLAYER_REGEN_ENABLED")
TukuiBar4:RegisterEvent("PLAYER_REGEN_DISABLED")
TukuiBar4:RegisterEvent("UNIT_ENTERING_VEHICLE")
TukuiBar4:RegisterEvent("UNIT_ENTERED_VEHICLE")
TukuiBar4:RegisterEvent("UNIT_EXITING_VEHICLE")
TukuiBar4:RegisterEvent("UNIT_EXITED_VEHICLE")

TukuiBar4:SetScript("OnEvent", HideSideBar)



