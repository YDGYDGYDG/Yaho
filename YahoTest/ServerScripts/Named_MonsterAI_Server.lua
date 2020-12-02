-- enemy.field.SendCenterLabel('') : 해당 필드에서만 알림
-- Server.SendCenterLabel('') : 서버 전체에 알림
-- enemy.field.SpawnEnemy(mobID,enemy.x,enemy.y) : 몬스터ID를 통해 현재 보스 몬스터 위치에 몬스터 소환

-- 성심 네임드 : 장승나무
function Named_Wood(enemy,ai,event,data)

    if (event == -1) then
    --커스텀 딜레이랑 스킬 초기화
    ai.customData.delay = 0
    ai.customData.skill = 0
    end

    if (event == 0) then -- 2초마다 실행되는 이벤트

        --맵에 플레이어가 하나도 없으면 null 세팅
        if enemy.field.playerCount <=0 then
            ai.SetTargetUnit(nil)

        -- 타겟이 없거나, 기존 타겟이던 unit이 맵을 나갔거나, x또는y값 차이의 절댓값이 300을 넘어서면
        -- 타겟을 nil로 초기화하고 200 범위 내에서 타겟을 설정
        elseif (ai.GetTargetUnit()==nil)
               or (enemy.field.GetUnit(ai.GetTargetUnitID())==nil)
               or (math.abs(enemy.x-enemy.field.GetUnit(ai.GetTargetUnitID()).x) >= 300) 
               or (math.abs(enemy.y-enemy.field.GetUnit(ai.GetTargetUnitID()).y) >= 300) then
            
            if ai.GetTargetUnit() ~= nil then
                enemy.say('....')
            end
            
            ai.SetFollowTarget(false) --타겟이 사라졌으면 추적을 비활성화 
            ai.SetTargetUnit(nil)
            ai.SetNearTarget(0,200)

            -- 주변을 탐색 후 타겟을 찾았으면(nil이 아니면), 추적을 활성화(true), 메세지출력
            if ai.GetTargetUnit() ~= nil then 
                ai.SetFollowTarget(true) 
                enemy.say('..!!')
            end
        end
        
        --타겟이 있으면 타겟을 향해 스킬사용
        if ai.GetTargetUnit() ~= nil then
            if ai.customData.delay > 0 then
                ai.customData.delay = ai.customData.delay - 1
            end
            
            if ai.customData.skill > 0 and ai.customData.delay <= 0 then
                ai.UseSkill(ai.customData.skill)
                ai.customData.skill = 0
            end
            
            if ai.customData.delay <= 0 then
                local ran = rand(1,101) -- 1부터 100까지 아무 숫자
                if ran <= 40 then -- 40 이하 일 경우
                    ai.customData.skill = 201 -- 스킬 1
                    ai.customData.delay = 1 -- 딜레이 3초 (ai함수 반복이 2초마다 이루어짐 따라서 2*2(4초))
                end
            end
        end
        
        --타겟이 없을경우 예외처리
        if ai.GetTargetUnit() == nil then
            return
        end
        
    end
    
    if (event == 1) then -- 몬스터가 공격을 받을때마다 실행되는 이벤트
        --공격한 유닛이 없을경우 예외처리
        if ai.GetAttackedUnit() == nil then
            return
        else
            --기존타겟유닛과 공격유닛이 같지 않을때, 공격을 한 유닛을 타겟으로 지정 또는 변경하고 추격
            if ai.GetTargetUnit() ~= ai.GetAttackedUnit() then 
                ai.SetTargetUnit(ai.GetAttackedUnit())
                ai.SetFollowTarget(true)
                enemy.say('우드득..!')
            end
            
            -- 몬스터가 공격당할시 10% 확률로 포효
            if math.random(0,99) <= 9 then
                ai.UseSkill(201)
            end
        end
    end

	if (event == 2) then -- 사망 시
		-- 사망 시, 리스폰 시간을 적용해둔 개발자들을 위해 몬스터의 ai 데이터 및 스텟 초기화
		ai.customData.skill = 0
		ai.customData.delay = 0
		enemy.moveSpeed = Server.GetMonster(71).moveSpeed
		enemy.SetStat(0, Server.GetMonster(71).attack)
		enemy.SetStat(1, Server.GetMonster(71).defense)
		enemy.SendUpdated()
	end
        
end


-- 성심 네임드 : 고블린
function Named_Gobline(enemy,ai,event,data)

    if (event == -1) then
    --커스텀 딜레이랑 스킬 초기화
    ai.customData.delay = 0
    ai.customData.skill = 0
    end

    if (event == 0) then -- 2초마다 실행되는 이벤트

        --맵에 플레이어가 하나도 없으면 null 세팅
        if enemy.field.playerCount <=0 then
            ai.SetTargetUnit(nil)

        -- 타겟이 없거나, 기존 타겟이던 unit이 맵을 나갔거나, x또는y값 차이의 절댓값이 300을 넘어서면
        -- 타겟을 nil로 초기화하고 200 범위 내에서 타겟을 설정
        elseif (ai.GetTargetUnit()==nil)
               or (enemy.field.GetUnit(ai.GetTargetUnitID())==nil)
               or (math.abs(enemy.x-enemy.field.GetUnit(ai.GetTargetUnitID()).x) >= 300) 
               or (math.abs(enemy.y-enemy.field.GetUnit(ai.GetTargetUnitID()).y) >= 300) then
            
            if ai.GetTargetUnit() ~= nil then
                enemy.say('캬르....')
            end
            
            ai.SetFollowTarget(false) --타겟이 사라졌으면 추적을 비활성화 
            ai.SetTargetUnit(nil)
            ai.SetNearTarget(0,200)

            -- 주변을 탐색 후 타겟을 찾았으면(nil이 아니면), 추적을 활성화(true), 메세지출력
            if ai.GetTargetUnit() ~= nil then 
                ai.SetFollowTarget(true) 
                enemy.say('캭..!!')
            end
        end
        
        --타겟이 있으면 타겟을 향해 스킬사용
        if ai.GetTargetUnit() ~= nil then
            if ai.customData.delay > 0 then
                ai.customData.delay = ai.customData.delay - 1
            end
            
            if ai.customData.skill > 0 and ai.customData.delay <= 0 then
                ai.UseSkill(ai.customData.skill)
                ai.customData.skill = 0
            end
            
            if ai.customData.delay <= 0 then
                local ran = rand(1,101) -- 1부터 100까지 아무 숫자
                if ran <= 40 then -- 40 이하 일 경우
                    ai.customData.skill = 202 -- 스킬 1
                    ai.customData.delay = 1 -- 딜레이 3초 (ai함수 반복이 2초마다 이루어짐 따라서 2*2(4초))
                end
            end
        end
        
        --타겟이 없을경우 예외처리
        if ai.GetTargetUnit() == nil then
            return
        end
        
    end
    
    if (event == 1) then -- 몬스터가 공격을 받을때마다 실행되는 이벤트
        --공격한 유닛이 없을경우 예외처리
        if ai.GetAttackedUnit() == nil then
            return
        else
            --기존타겟유닛과 공격유닛이 같지 않을때, 공격을 한 유닛을 타겟으로 지정 또는 변경하고 추격
            if ai.GetTargetUnit() ~= ai.GetAttackedUnit() then 
                ai.SetTargetUnit(ai.GetAttackedUnit())
                ai.SetFollowTarget(true)
                enemy.say('크륵..!')
            end
            
            -- 몬스터가 공격당할시 10% 확률로 포효
            if math.random(0,99) <= 9 then
                ai.UseSkill(202)
            end
        end
    end

	if (event == 2) then -- 사망 시
		-- 사망 시, 리스폰 시간을 적용해둔 개발자들을 위해 몬스터의 ai 데이터 및 스텟 초기화
		ai.customData.skill = 0
		ai.customData.delay = 0
		enemy.moveSpeed = Server.GetMonster(72).moveSpeed
		enemy.SetStat(0, Server.GetMonster(72).attack)
		enemy.SetStat(1, Server.GetMonster(72).defense)
		enemy.SendUpdated()
	end
        
end





Server.SetMonsterAI(71, Named_Wood) -- 101번 몬스터에게 BlueGobline 적용
Server.SetMonsterAI(72, Named_Gobline) -- 102번 몬스터에게 Golem 적용