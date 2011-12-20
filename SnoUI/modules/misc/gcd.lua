--[[
	Copyright (C) 2006-2007 Nymbia
	Copyright (C) 2010 Hendrik "Nevcairiel" Leppkes < h.leppkes@gmail.com >

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License along
	with this program; if not, write to the Free Software Foundation, Inc.,
	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
]]

local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales
if C.unitframes.enable ~= true and C.unitframes.gcd ~= true then return end

local gcdbar, gcdspark
local starttime, castDuration, warned

local player = TukuiPlayer


local function OnUpdate()
	if not starttime then return gcdbar:SetScript("OnUpdate", nil) end
	local perc = (GetTime() - starttime) / castDuration
	if perc > 1 then
		gcdspark:Hide()
		return gcdbar:SetScript("OnUpdate", nil)
	else
		gcdspark:ClearAllPoints()
		gcdspark:SetPoint("CENTER", gcdbar, "LEFT", 250 * perc, 0)
	end

end

local function CheckGCD(self, event, unit, spell)
	if unit == "player" then
		local start, duration = GetSpellCooldown(spell)
		if duration and duration > 0 and duration <= 1.5 then
			starttime = start
			castDuration = duration
			gcdspark:Show()
			gcdbar:SetScript("OnUpdate", OnUpdate)
		end
	end
end

if not gcdbar then
	gcdbar = CreateFrame("Frame", "SnoGCDBar", UIParent)
	gcdbar:SetFrameStrata("HIGH")
	gcdbar:SetClampedToScreen(true)
	gcdbar:SetHeight(10)
	gcdbar:SetWidth(250)
	gcdbar:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16})
	gcdbar:SetBackdropColor(.1,.1,.1)
	gcdbar:SetAlpha(0.8)
	gcdbar:SetScale(1)
	gcdbar:SetPoint("BOTTOMLEFT", player, "TOPLEFT", 0, 30)

	gcdspark = gcdbar:CreateTexture(nil, "DIALOG")	
	gcdspark:SetWidth(4)
	gcdspark:SetHeight(10)
	gcdspark:SetTexture(C["media"].blank)
	gcdspark:SetVertexColor(1,1,1)
	
	gcdbar.bg = CreateFrame("Frame", nil, gcdbar)
	gcdbar.bg:SetTemplate("Default")
	gcdbar.bg:SetBorder()
	gcdbar.bg:SetPoint("TOPLEFT", -2, 2)
	gcdbar.bg:SetPoint("BOTTOMRIGHT", 2, -2)
	gcdbar.bg:SetFrameLevel(gcdbar:GetFrameLevel() - 1)
end

local gcd = CreateFrame("Frame")
gcd:RegisterEvent("UNIT_SPELLCAST_START")
gcd:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
gcd:SetScript("OnEvent", CheckGCD)