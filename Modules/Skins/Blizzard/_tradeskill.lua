local Module = SUI:NewModule("Skins.TradeSkill");

function Module:OnEnable()
  if (SUI:Color()) then
    local f = CreateFrame("Frame")
    f:RegisterEvent("ADDON_LOADED")
    f:SetScript("OnEvent", function(self, event, name)
      if name == "Blizzard_TradeSkillUI" then
        for i, v in pairs({ 
          TradeSkillFrameTopEdge,
          TradeSkillFrameRightEdge,
          TradeSkillFrameBottomEdge,
          TradeSkillFrameLeftEdge,
          TradeSkillFrameTopRightCorner,
          TradeSkillFrameTopLeftCorner,
          TradeSkillFrameBottomLeftCorner,
          TradeSkillFrameBottomRightCorner, 
        }) do
            v:SetVertexColor(.15, .15, .15)
        end
        for i, v in pairs({
          TradeSkillFrameBg,
          TradeSkillFrameTitleBg }) do
            v:SetVertexColor(.3, .3, .3)
        end
      end
    end)
  end
end