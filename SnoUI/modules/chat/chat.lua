local T, C, L = unpack(Tukui)

if not C.chat.enable == true then return end


-- default position of chat #1 (left) and chat #4 (right)
T.SetDefaultChatPosition = function(frame)
	if frame then
		local id = frame:GetID()
		local name = FCF_GetChatWindowInfo(id)
		
		if id == 1 then
			frame:ClearAllPoints()
			frame:Point("BOTTOMLEFT", TukuiInfoLeft, "TOPLEFT", 0, 6)
			-- lock them if unlocked
			if not frame.isLocked then FCF_SetLocked(frame, 1) end
		elseif id == 3 then
			if not frame.isDocked then
				frame:ClearAllPoints()
				frame:Point("BOTTOMRIGHT", TukuiInfoRight, "TOPRIGHT", 0, 6)
				frame:SetJustifyH("RIGHT")
			end
		end
		
	end
end
hooksecurefunc("FCF_RestorePositionAndDimensions", T.SetDefaultChatPosition)

local function SetupChat( self )
	-- Setup the left chat
	FCF_SetWindowName(ChatFrame1, "General")
	ChatFrame_RemoveAllMessageGroups(ChatFrame1)
	ChatFrame_RemoveChannel(ChatFrame1, L.chat_trade) -- erf, it seem we need to localize this now
	ChatFrame_RemoveChannel(ChatFrame1, L.chat_general) -- erf, it seem we need to localize this now
	ChatFrame_RemoveChannel(ChatFrame1, L.chat_defense) -- erf, it seem we need to localize this now
	ChatFrame_RemoveChannel(ChatFrame1, L.chat_recrutment) -- erf, it seem we need to localize this now
	ChatFrame_RemoveChannel(ChatFrame1, L.chat_lfg) -- erf, it seem we need to localize this now
	ChatFrame_AddMessageGroup(ChatFrame1, "SAY")
	ChatFrame_AddMessageGroup(ChatFrame1, "EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "YELL")
	ChatFrame_AddMessageGroup(ChatFrame1, "GUILD")
	ChatFrame_AddMessageGroup(ChatFrame1, "OFFICER")
	ChatFrame_AddMessageGroup(ChatFrame1, "GUILD_ACHIEVEMENT")
	ChatFrame_AddMessageGroup(ChatFrame1, "PARTY")
	ChatFrame_AddMessageGroup(ChatFrame1, "PARTY_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID_WARNING")
	ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND")
	ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_HORDE")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_ALLIANCE")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_NEUTRAL")
	ChatFrame_AddMessageGroup(ChatFrame1, "SYSTEM")
	ChatFrame_AddMessageGroup(ChatFrame1, "ERRORS")
	ChatFrame_AddMessageGroup(ChatFrame1, "AFK")
	ChatFrame_AddMessageGroup(ChatFrame1, "DND")
	ChatFrame_AddMessageGroup(ChatFrame1, "IGNORED")
	ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")
	ChatFrame_AddMessageGroup(ChatFrame1, "BN_CONVERSATION")
	-- ChatFrame_AddMessageGroup(ChatFrame1, "BN_WHISPER")
	-- ChatFrame_AddMessageGroup(ChatFrame1, "WHISPER")
	
	-- Setup the right chat
	FCF_SetWindowName(ChatFrame3, "Flood")
	ChatFrame_RemoveAllMessageGroups(ChatFrame3)
	ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_XP_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_HONOR_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_FACTION_CHANGE")
	ChatFrame_AddMessageGroup(ChatFrame3, "LOOT")
	ChatFrame_AddMessageGroup(ChatFrame3, "SKILL")
	ChatFrame_AddMessageGroup(ChatFrame3, "TRADESKILLS")
	ChatFrame_AddMessageGroup(ChatFrame3, "CURRENCY")
	ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_GUILD_XP_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONEY")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_SAY")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_YELL")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_BOSS_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_BOSS_WHISPER")
	
	ChatFrame_AddChannel(ChatFrame3, L.chat_trade) -- erf, it seem we need to localize this now
	ChatFrame_AddChannel(ChatFrame3, L.chat_general) -- erf, it seem we need to localize this now
	ChatFrame_AddChannel(ChatFrame3, L.chat_defense) -- erf, it seem we need to localize this now
	ChatFrame_AddChannel(ChatFrame3, L.chat_recrutment) -- erf, it seem we need to localize this now
	ChatFrame_AddChannel(ChatFrame3, L.chat_lfg) -- erf, it seem we need to localize this now

	FCF_UnDockFrame(ChatFrame3)
	-- ChatFrame3:ClearAllPoints()
	-- ChatFrame3:Point("BOTTOMRIGHT", TukuiInfoRight, "TOPRIGHT", -4, 5)
	-- ChatFrame3:Point("BOTTOMLEFT", TukuiInfoRight, "TOPLEFT", 4, 5)
	-- FCF_UnDockFrame(ChatFrame3)
	-- FCF_SetLocked(ChatFrame3, 1)
	-- ChatFrame3:Show()
	-- FCF_SavePositionAndDimensions(ChatFrame3)

	ChatFrame_RemoveAllMessageGroups(ChatFrame4)
	ChatFrame4Tab:Kill()
	ChatFrame4:Kill()
	FCF_RestorePositionAndDimensions(ChatFrame1)
	FCF_RestorePositionAndDimensions(ChatFrame3)
end
TukuiChat:HookScript( "OnEvent", function( self, event, ... )
	local addon = ...
	if( event == "ADDON_LOADED" ) then
		if( addon == "Blizzard_CombatLog" ) then
			self:UnregisterEvent( "ADDON_LOADED" )
			SetupChat( self )
		end
	elseif( event == "PLAYER_ENTERING_WORLD" ) then
		self:UnregisterEvent( "PLAYER_ENTERING_WORLD" )
	end
end )
