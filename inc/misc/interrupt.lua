local CF=CreateFrame("Frame")
CF:RegisterEvent("PLAYER_LOGIN")
CF:SetScript("OnEvent", function(self, event)
 
if not SUIDB.A_INTERRUPT == true then return end 
 
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
 
-- Variables used to prevent flooding on AoE interrupts
local lastTime, lastSpellID
frame:SetScript("OnEvent", function()
    local _, event, _, sourceGUID, _, _, _, _, destName, _, _, _, _, _, spellID = CombatLogGetCurrentEventInfo()
    if not (event == "SPELL_INTERRUPT" and sourceGUID == UnitGUID("player")) then return end
    -- Check if time and ID was same as last
    -- Note: This is to prevent flooding announcements on AoE interrupts.
    if timeStamp == lastTime and spellID == lastSpellID then return end
    local inInstanceGroup = IsInGroup(LE_PARTY_CATEGORY_INSTANCE)
    local inGroup, inRaid = IsInGroup(), IsInRaid()
    local inInstance = IsInInstance()
    
    if (inInstanceGroup) 
    then 
        SendChatMessage("INTERRUPTED".." "..destName..": "..GetSpellLink(spellID), "INSTANCE_CHAT")
    elseif (inRaid)
    then 
        SendChatMessage("INTERRUPTED".." "..destName..": "..GetSpellLink(spellID), "RAID")
    elseif (inGroup)
    then
        SendChatMessage("INTERRUPTED".." "..destName..": "..GetSpellLink(spellID), "PARTY")
    end
    
end)
 
end)