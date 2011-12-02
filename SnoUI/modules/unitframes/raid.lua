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
-- Setup Base Player and Raid Heal Grid
------------------------------------------------------------------------
local player = TukuiPlayer
local healGrid = TukuiRaidHealerGrid

healGrid:ClearAllPoints()
local AddonLayout = CreateFrame("Frame")
AddonLayout:RegisterEvent("ADDON_LOADED")
AddonLayout:SetScript("OnEvent", function(self, event, addon)
	if addon == "Tukui_Raid" then
		healGrid:SetPoint("TOPLEFT", UIParent,"TOPLEFT", 6, -140)
	elseif addon == "Tukui_Raid_Healing" then
		healGrid:Point("BOTTOMLEFT", player, "BOTTOMRIGHT", 4, 0)
	end
end)

