local ViewManaStoneText = function()
    local num = unit.gameMoney
    unit.FireEvent("ReplyServerManaStone", num)
    -- unit.SendSay("마석"..num.." 개 클라로 전달")
end
Server.GetTopic("CallServerMana").Add(ViewManaStoneText)
