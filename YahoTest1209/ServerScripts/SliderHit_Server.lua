
Server.GetTopic("SlliderHitResult").Add(function(ATKResult)
    Server.damageCallback = function(a, b, damage, SkillID)
        local luck = a.luk -- luck 1당 치명타 확률 1% 올라감.
        local criPer = math.random( 0, 99 )
    
        --'필살기-일섬'이면 이 공식 적용
        if SkillID == 4 then
            if luck > criPer then
                return b.KnockbackFromUnit(a, 50, 0.2) or a.atk * (1 + a.agi*0.01) * ATKResult - b.def, true
            else
                return b.KnockbackFromUnit(a, 50, 0.2) or a.atk * ATKResult - b.def
            end
        -- 필살기-혈난무
        elseif SkillID == 11 then
            if luck > criPer then
                return b.KnockbackFromUnit(a, 20, 0.2) or a.atk * (1 + a.agi*0.01) * ATKResult - b.def, true
            else
                return b.KnockbackFromUnit(a, 20, 0.2) or a.atk * ATKResult - b.def
            end
    
        -- 일반 스킬 공식들
        elseif SkillID == 1 or SkillID == 2 or SkillID == 3 then -- 평타
            if luck > criPer then
                return b.KnockbackFromUnit(a, 15, 0.2) or a.atk * (1 + a.agi*0.01) - b.def, true
            else
                return b.KnockbackFromUnit(a, 15, 0.2) or a.atk - b.def
            end
        elseif SkillID == 6 then -- 화염방사
            if luck > criPer then
                return b.KnockbackFromUnit(a, 10, 0.2) or a.atk * (1 + a.agi*0.01) - b.def, true
            else
                return b.KnockbackFromUnit(a, 10, 0.2) or a.atk - b.def
            end
        elseif SkillID == 7 then -- 난무
            if luck > criPer then
                return b.KnockbackFromUnit(a, 20, 0.2) or a.atk * (1 + a.agi*0.01) - b.def, true
            else
                return b.KnockbackFromUnit(a, 20, 0.2) or a.atk - b.def
            end
        elseif SkillID == 8 then -- 블랙홀
            if luck > criPer then
                return b.MakeKnockback(-15, 0.2) or a.atk * (1 + a.agi*0.01) - b.def, true
            else
                return b.MakeKnockback(-15, 0.2) or a.atk - b.def
            end
        elseif SkillID == 9 then -- 암흑가시
            if luck > criPer then
                return b.MakeKnockback(-20, 0.2) or a.atk * (1 + a.agi*0.01) - b.def, true
            else
                return b.MakeKnockback(-20, 0.2) or a.atk - b.def
            end
        elseif SkillID == 10 then -- 거합도
            if luck > criPer then
                return b.KnockbackFromUnit(a, 50, 0.2) or a.atk * (1 + a.agi*0.01) - b.def, true
            else
                return b.KnockbackFromUnit(a, 50, 0.2) or a.atk - b.def
            end
        end
        return a.atk - b.def
    end
    unit.FireEvent("UseSkill")
end)

Server.damageCallback = function(a, b, damage, SkillID, critical, visible)
    local luck = a.luk -- luck 1당 치명타 확률 1% 올라감.
    local criPer = math.random( 0, 99 )

    if SkillID == 1 or SkillID == 2 or SkillID == 3 then -- 평타
        if luck > criPer then
            return b.KnockbackFromUnit(a, 15, 0.2) or a.atk * (1 + a.agi*0.01) - b.def, true
        else
            return b.KnockbackFromUnit(a, 15, 0.2) or a.atk - b.def
        end
    elseif SkillID == 6 then -- 화염방사
        if luck > criPer then
            return b.KnockbackFromUnit(a, 10, 0.2) or a.atk * (1 + a.agi*0.01) - b.def, true
        else
            return b.KnockbackFromUnit(a, 10, 0.2) or a.atk - b.def
        end
    elseif SkillID == 7 then -- 난무
        if luck > criPer then
            return b.KnockbackFromUnit(a, 20, 0.2) or a.atk * (1 + a.agi*0.01) - b.def, true
        else
            return b.KnockbackFromUnit(a, 20, 0.2) or a.atk - b.def
        end
    elseif SkillID == 8 then -- 블랙홀
        if luck > criPer then
            return b.MakeKnockback(-15, 0.2) or a.atk * (1 + a.agi*0.01) - b.def, true
        else
            return b.MakeKnockback(-15, 0.2) or a.atk - b.def
        end
    elseif SkillID == 9 then -- 암흑가시
        if luck > criPer then
            return b.MakeKnockback(-20, 0.2) or a.atk * (1 + a.agi*0.01) - b.def, true
        else
            return b.MakeKnockback(-20, 0.2) or a.atk - b.def
        end
    elseif SkillID == 10 then -- 거합도
        if luck > criPer then
            return b.KnockbackFromUnit(a, 50, 0.2) or a.atk * (1 + a.agi*0.01) - b.def, true
        else
            return b.KnockbackFromUnit(a, 50, 0.2) or a.atk - b.def
        end

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