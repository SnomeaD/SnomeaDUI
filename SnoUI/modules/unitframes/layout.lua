local T, C, L, G = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales
------------------------------------------------------------------------
--	local variables
------------------------------------------------------------------------



------------------------------------------------------------------------
-- Setup Base Player and Target Frames
------------------------------------------------------------------------
local player = G.UnitFrames.Player
local target = G.UnitFrames.Target
local pet = G.UnitFrames.Pet
local tot = G.UnitFrames.TargetTarget

if T.lowversion then
	pet:Size( 86, 14 )
	tot:Size( 86, 14 )
	tot.Health:SetHeight( 14 )
end

player:ClearAllPoints()
target:ClearAllPoints()
pet:ClearAllPoints()
tot:ClearAllPoints()


if T.lowversion then
	player:Point("BOTTOMLEFT", InvTukuiActionBarBackground, "TOPLEFT", -44, 34)
	target:Point("BOTTOMRIGHT", InvTukuiActionBarBackground, "TOPRIGHT", 44, 34)
	if C.general.nostromo == true then
		tot:Point("BOTTOMRIGHT", TukuiTarget, "BOTTOMLEFT", -10, 0)
	else
		tot:Point("BOTTOMRIGHT", TukuiTarget, "BOTTOMLEFT", -4, 0)
	end
	pet:Point("BOTTOM", TukuiTargetTarget, "TOP", 0, 6)
else
	player:Point("BOTTOMLEFT", InvTukuiActionBarBackground, "TOPLEFT", -140, 34)
	target:Point("BOTTOMRIGHT", InvTukuiActionBarBackground, "TOPRIGHT", 140, 34)
	tot:Point("TOPRIGHT", TukuiTarget, "BOTTOMRIGHT", 0, -8)
	pet:Point("TOPLEFT", TukuiPlayer, "BOTTOMLEFT", 0, -8)
end