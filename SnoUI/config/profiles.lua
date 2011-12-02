local T, C, L = unpack(Tukui)

----------------------------------------------------------------------------
-- Per Class Config (overwrite general)
-- Class need to be UPPERCASE
----------------------------------------------------------------------------

if T.myclass == "PRIEST" then
	-- do some config!
	C.actionbar.hideshapeshift = true
end

if T.myclass == "WARRIOR" then
	-- do some config!
	C.nameplate.enhancethreat = true
	C.datatext.haste = 0
	C.datatext.power = 0
	C.datatext.armor = 7
	C.datatext.avd = 8
end

if T.myclass == "DRUID" then
	-- do some config!
	C.nameplate.enhancethreat = true
	C.datatext.haste = 0
	C.datatext.power = 0
	C.datatext.armor = 7
	C.datatext.avd = 8
end
if T.myclass == "PALADIN" then
	-- do some config!
	C.nameplate.enhancethreat = true
	C.datatext.haste = 0
	C.datatext.power = 0
	C.datatext.armor = 7
	C.datatext.avd = 8
end

if T.myclass == "HUNTER" then
	-- do some config!
	C.datatext.haste = 0
	C.datatext.crit = 8
end