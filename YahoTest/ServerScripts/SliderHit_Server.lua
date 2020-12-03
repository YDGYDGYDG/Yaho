
Server.GetTopic("SlliderHitResult").Add(function(ATKResult)
    Server.damageCallback = function(a, b, damage, SkillID)
        --'필살기'이면 이 공식 적용
        if SkillID == 4 or SkillID == 11 then
            return b.KnockbackFromUnit(a, 50, 0.2) or a.atk * ATKResult - b.def
        end
        return a.atk - b.def
    end
    Server.FireEvent("UseSkill")
end)

Server.damageCallback = function(a, b, damage, SkillID)
    if SkillID == 1 or SkillID == 2 or SkillID == 3 then -- 평타
        return b.KnockbackFromUnit(a, 15, 0.2) or a.atk - b.def
    elseif SkillID == 6 then -- 화염방사
        return b.KnockbackFromUnit(a, 10, 0.2) or a.atk - b.def
    elseif SkillID == 7 then -- 난무
        return b.KnockbackFromUnit(a, 20, 0.2) or a.atk - b.def
    elseif SkillID == 8 then -- 블랙홀
        return b.MakeKnockback(-15, 0.2) or a.atk - b.def
    elseif SkillID == 9 then -- 암흑가시
        return b.MakeKnockback(-20, 0.2) or a.atk - b.def
    elseif SkillID == 10 then -- 거합도
        return b.KnockbackFromUnit(a, 50, 0.2) or a.atk - b.def
    elseif SkillID == 11 then -- 혈난무
        return b.KnockbackFromUnit(a, 20, 0.2) or a.atk - b.def
    -- elseif SkillID == 12 then
    -- elseif SkillID == 13 then
    -- elseif SkillID == 14 then
    -- elseif SkillID == 15 then
    -- elseif SkillID == 16 then
    -- elseif SkillID == 17 then
    -- elseif SkillID == 18 then
    -- elseif SkillID == 19 then
    -- elseif SkillID == 20 then
    -- elseif SkillID == 21 then

    end

    return a.atk - b.def
end