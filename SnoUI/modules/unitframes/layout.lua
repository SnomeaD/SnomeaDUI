local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales
if C.unitframes.enable ~= true then return end
------------------------------------------------------------------------
--	local variables
------------------------------------------------------------------------

-- if T.lowversion then
-- 	T.Player, T.Target, T.ToT, T.Pet, T.Focus, T.Boss = 182, 182, 182, 182, 130, 200
-- else
-- 	T.Player, T.Target, T.ToT, T.Pet, T.Focus, T.Boss = 225, 225, 130, 130, 115, 200
-- end

------------------------------------------------------------------------
-- Setup Base Player and Target Frames
------------------------------------------------------------------------
local player = TukuiPlayer
local target = TukuiTarget
local pet = TukuiPet
local tot = TukuiTargetTarget


player:ClearAllPoints()
target:ClearAllPoints()
pet:ClearAllPoints()
tot:ClearAllPoints()
local AddonLayout = CreateFrame("Frame")
AddonLayout:RegisterEvent("ADDON_LOADED")
AddonLayout:SetScript("OnEvent", function(self, event, addon)
	if addon == "Tukui_Raid" then
			player:Point("BOTTOMLEFT", InvTukuiActionBarBackground, "TOPLEFT", -44, 34)
			target:Point("BOTTOMRIGHT", InvTukuiActionBarBackground, "TOPRIGHT", 44, 34)
			tot:Point("BOTTOMRIGHT", TukuiTarget, "BOTTOMLEFT", -17, 0)
			pet:Point("BOTTOM", TukuiTargetTarget, "TOP", 0, 6)
	elseif addon == "Tukui_Raid_Healing" then
			player:Point("BOTTOMLEFT", InvTukuiActionBarBackground, "TOPLEFT", -140, 34)
			target:Point("BOTTOMRIGHT", InvTukuiActionBarBackground, "TOPRIGHT", 140, 34)
			tot:Point("TOPRIGHT", TukuiTarget, "BOTTOMRIGHT", 0, -6)
			pet:Point("TOPLEFT", TukuiPlayer, "BOTTOMLEFT", 0, -6)
	end
end)

