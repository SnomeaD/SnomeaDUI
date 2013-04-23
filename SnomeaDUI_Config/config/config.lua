local C = {}

C["general"] = {
	["blizzardreskin"] = true,
	["nostromo"] = true
}

C["unitframes"] = {
	["gcd"] = false,
	["unicolor"] = true,
	["charportrait"] = false,
	["cbicons"] = true,
	["cblatency"] = true,
	["classbar"] = true,
	["classiccombo"] = true,
	["gridonly"] = true,
	["gridvertical"] = false,
	["healcomm"] = true,
	["showplayerinparty"] = true,
	["weakenedsoulbar"] = false,
	["gridhealthvertical"] = false,
	["showraidpets"] = false,
	["raidalphaoor"] = 0.5,
}
C["auras"] = {
	["classictimer"] = true,
	["consolidate"] = false,
}

C["merchant"] = {
	["autorepair"] = false,                           -- Need to be set false if you want to guild repair.
	["guildrepair"] = true,                           -- Will auto guild repair is possible otherwise it'll use your personal funds
}
C["actionbar"] = {
	["hideshapeshift"] = false,
	["hotkey"] = false,
}
C["error"] = {
	["enable"] = true,
}
C["chat"] = {
	["background"] = false,
}
C["datatext"] = {
	["fps_ms"] = 5,
	["system"] = 0,
	["bags"] = 0,
	["gold"] = 6,
	["wowtime"] = 1,
	["guild"] = 3,
	["dur"] = 4,
	["friends"] = 2,
	["dps_text"] = 0,
	["hps_text"] = 0,
	["power"] = 7,
	["haste"] = 8,
	["crit"] = 0,
	["avd"] = 0,
	["armor"] = 0,
	["currency"] = 0,
	["hit"] = 0,
	["mastery"] = 0,
	["micromenu"] = 0,
	["regen"] = 0,
	["talent"] = 0,
	["calltoarms"] = 0,

	["battleground"] = true,
	["time24"] = true,
	["localtime"] = true,
	["fontsize"] = 12, 
}
C["chat"] = {
	["enable"] = true,
	["background"] = false,
}
C["bags"] = {
	["enable"] = false,
}

C["media"] = {
	-- ["normTex"] = [[Interface\AddOns\SnomeaDUI\medias\textures\Minimalist]],
	["normTex"] = [[Interface\AddOns\SnomeaDUI\medias\textures\Smooth]],
	-- ["normTex"] = [[Interface\AddOns\SnomeaDUI\medias\textures\sinaris]],
	-- ["normTex"] = [[Interface\AddOns\SnomeaDUI\medias\textures\statusbar256]],
	-- ["normTex"] = [[Interface\AddOns\SnomeaDUI\medias\textures\button_gloss]],
	["DPSTex"] = [[Interface\AddOns\SnomeaDUI\medias\textures\switch_layout_dd]],
	["HealingTex"] = [[Interface\AddOns\SnomeaDUI\medias\textures\switch_layout_heal]],
	["gloss"] = [[Interface\AddOns\SnomeaDUI\medias\textures\button_gloss]],
	["backdropcolor"] = { .1,.1,.1 },                   -- default backdrop color of panels
	["bordercolor"] = { .2,.2,.2 },                     -- default border color of panels
}

TukuiEditedDefaultConfig = C