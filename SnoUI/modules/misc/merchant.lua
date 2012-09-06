local T, C, L, G = unpack(Tukui)

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function()
	if not IsShiftKeyDown() then
		if CanMerchantRepair() and C["merchant"].guildrepair then
			local cost, possible = GetRepairAllCost()
			if (IsInGuild()) and (CanGuildBankRepair()) then
				if cost <= GetGuildBankWithdrawMoney() then
					guildRepairFlag = 1
				end
			end
			if cost>0 then
				if possible then
					local c = cost%100
					local s = math.floor((cost%10000)/100)
					local g = math.floor(cost/10000)
					if guildRepairFlag == 1 then
						RepairAllItems(1)
						DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Repaired using guild bank.|r")
					else
						RepairAllItems()
						DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Repaired using personal funds.|r")
					end
					DEFAULT_CHAT_FRAME:AddMessage(L.merchant_repaircost.." |cffffffff"..g..L.goldabbrev.." |cffffffff"..s..L.silverabbrev.." |cffffffff"..c..L.copperabbrev..".",255,255,0)
				else
					DEFAULT_CHAT_FRAME:AddMessage(L.merchant_repairnomoney,255,0,0)
				end
			end
		end
	end
end)
f:RegisterEvent("MERCHANT_SHOW")