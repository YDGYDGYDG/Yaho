
Server.GetTopic("SlliderHitResult").Add(function(ATKResult)
    Server.damageCallback = function(a, b, damage, SkillID)
        local thisSkillID = SkillID
        --'일섬'이면 이 공식 적용
        if thisSkillID == 4 then
            -- return ATKResult
            return a.atk * ATKResult - b.def
        end
    end
    -- unit.SendSay(ATKResult)
    Server.FireEvent("UseSkill", 4)
end)

