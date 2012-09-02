local T, C, L, G= unpack(Tukui)

----------------------------------------------------------------------------
-- Per Class Config (overwrite general)
-- Class need to be UPPERCASE
----------------------------------------------------------------------------

if T.myclass == "PRIEST" then
	C.unitframes.gcd = false
	C.actionbar.hideshapeshift = true
end

if T.myclass == "DEATHKNIGHT" then
	C.nameplate.enhancethreat = true
	C.datatext.haste = 0
	C.datatext.power = 0
	C.datatext.armor = 7
	C.datatext.avd = 8
end

if T.myclass == "WARRIOR" then
	C.nameplate.enhancethreat = true
	C.datatext.haste = 0
	C.datatext.power = 0
	C.datatext.armor = 7
	C.datatext.avd = 8
end

if T.myclass == "DRUID" then
	C.nameplate.enhancethreat = true
	C.unitframes.gcd = false
	C.datatext.haste = 0
	C.datatext.power = 0
	C.datatext.armor = 7
	C.datatext.avd = 8
end
if T.myclass == "PALADIN" then
	C.nameplate.enhancethreat = true
	C.datatext.haste = 0
	C.datatext.power = 0
	C.datatext.armor = 7
	C.datatext.avd = 8
end

if T.myclass == "HUNTER" then
	C.datatext.haste = 0
	C.datatext.crit = 8
end
if T.myclass == "SHAMAN" then
	C.datatext.haste = 0
	C.datatext.crit = 8
end
if T.myclass == "ROGUE" then
	C.actionbar.hideshapeshift = true
end