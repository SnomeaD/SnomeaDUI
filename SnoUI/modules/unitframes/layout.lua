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
-- local S, C, L = unpack( Tukui )
-- 
-- if( C["unitframes"].enable ~= true ) then return end


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

-- Testui Command
local testui = TestUI or function() end
TestUI = function(msg)
	if msg == "a" or msg == "arena" then
		TukuiArena1:Show(); TukuiArena1.Hide = function() end; TukuiArena1.unit = "player"
		TukuiArena2:Show(); TukuiArena2.Hide = function() end; TukuiArena2.unit = "player"
		TukuiArena3:Show(); TukuiArena3.Hide = function() end; TukuiArena3.unit = "player"
		TukuiArena4:Show(); TukuiArena4.Hide = function() end; TukuiArena4.unit = "player"
		TukuiArena5:Show(); TukuiArena5.Hide = function() end; TukuiArena5.unit = "player"
	elseif msg == "boss" or msg == "b" then
		TukuiBoss1:Show(); TukuiBoss1.Hide = function() end; TukuiBoss1.unit = "player"
		TukuiBoss2:Show(); TukuiBoss2.Hide = function() end; TukuiBoss2.unit = "player"
		TukuiBoss3:Show(); TukuiBoss3.Hide = function() end; TukuiBoss3.unit = "player"
	elseif msg == "buffs" then -- better dont test it ^^
		UnitAura = function()
			-- name, rank, texture, count, dtype, duration, timeLeft, caster
			return 139, 'Rank 1', 'Interface\\Icons\\Spell_Holy_Penance', 1, 'Magic', 0, 0, "player"
		end
		if(oUF) then
			for i, v in pairs(oUF.units) do
				if(v.UNIT_AURA) then
					v:UNIT_AURA("UNIT_AURA", v.unit)
				end
			end
		end
	end
end
SlashCmdList.TestUI = TestUI
SLASH_TestUI1 = "/testui"


