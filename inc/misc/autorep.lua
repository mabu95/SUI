local SUI=CreateFrame("Frame")
SUI:RegisterEvent("PLAYER_LOGIN")
SUI:SetScript("OnEvent", function(self, event)

local g = CreateFrame("Frame")
g:RegisterEvent("MERCHANT_SHOW")
g:SetScript("OnEvent",function()
	if (SUIDB.A_AUTOSELL) then
		local bag, slot
		for bag = 0, 4 do
			for slot = 0, GetContainerNumSlots(bag) do
				local link = GetContainerItemLink(bag, slot)
				if link and (select(3, GetItemInfo(link)) == 0) then
					UseContainerItem(bag, slot)
				end
			end
		end
	end
	if (SUIDB.A_AUTOREP) then
		if (CanMerchantRepair()) then
			local cost = GetRepairAllCost()
			if cost > 0 then
				local money = GetMoney()
				if money > cost then
					RepairAllItems()
					print(format("|cffead000Repair cost: %.1fg|r", cost * 0.0001))
				else
					print("Not enough gold to cover the repair cost.")
				end
			end
		end
	end
end)

local NEW_ITEM_VENDOR_STACK_BUY = ITEM_VENDOR_STACK_BUY
ITEM_VENDOR_STACK_BUY = "|cffa9ff00" .. NEW_ITEM_VENDOR_STACK_BUY .. "|r"

local origMerchantItemButton_OnModifiedClick = _G.MerchantItemButton_OnModifiedClick
local function MerchantItemButton_OnModifiedClickHook(self, ...)
	origMerchantItemButton_OnModifiedClick(self, ...)

	if (IsAltKeyDown()) then
		local maxStack = select(8, GetItemInfo(GetMerchantItemLink(self:GetID())))
		local _, _, _, quantity = GetMerchantItemInfo(self:GetID())

		if (maxStack and maxStack > 1) then
			BuyMerchantItem(self:GetID(), floor(maxStack / quantity))
		end
	end
end
MerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClickHook
end)