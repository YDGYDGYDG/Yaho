
Server.GetTopic("SlliderHitResult").Add(function(ATKResult)
    Server.damageCallback = function(a, b, damage, SkillID)
        local thisSkillID = SkillID
        --'필살기'이면 이 공식 적용
        if thisSkillID == 4 or thisSkillID == 11 then
            -- return ATKResult
            return a.atk * ATKResult - b.def
        end
        return a.atk - b.def
    end

    Server.FireEvent("UseSkill")
end)

Server.damageCallback = function(a, b, damage, SkillID)
    return a.atk - b.def
end