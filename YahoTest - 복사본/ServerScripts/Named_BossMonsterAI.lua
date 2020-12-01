-- enemy.field.SendCenterLabel('') : 해당 필드에서만 알림
-- Server.SendCenterLabel('') : 서버 전체에 알림
-- enemy.field.SpawnEnemy(mobID,enemy.x,enemy.y) : 몬스터ID를 통해 현재 보스 몬스터 위치에 몬스터 소환

-- 성심 보스 : 번개왕 고블린
function BlueGobline(enemy,ai,event,data)

    if (event == -1) then
    --처음 0, 체력저하 상태 1
    AngryMode = 0
    --커스텀 딜레이랑 스킬 초기화
    ai.customData.delay = 0
    ai.customData.skill = 0
    end

    if (event == 0) then -- 2초마다 실행되는 이벤트

        enemy.AddHP(enemy.maxHP * 0.01) -- 매 2초마다 몬스터의 전체 HP의 1%씩 회복

        if AngryMode == 0 and enemy.hp <= enemy.maxHP * 0.30 then
            AngryMode = 1
            enemy.say('크아아악!')
            enemy.SetStat(0, enemy.GetStat(0)*1.5) -- 공격력 1.5배 상승
			enemy.SetStat(1, 0) -- 방어력 0으로 하락
            enemy.moveSpeed = enemy.moveSpeed*1.5
            enemy.monsterData.attackTime = 0.5
            enemy.SendUpdated()
        end

        if AngryMode == 1 and enemy.hp >= enemy.maxHP * 0.32 then
            AngryMode = 0
            enemy.say('허억.. 허억..')
            enemy.SetStat(0, Server.GetMonster(101).attack)
            enemy.SetStat(1, Server.GetMonster(101).defense)
            enemy.moveSpeed = 100
            enemy.monsterData.attackTime = 1
            enemy.SendUpdated()
        end

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
                enemy.say('크르르....')
            end
            
            ai.SetFollowTarget(false) --타겟이 사라졌으면 추적을 비활성화 
            ai.SetTargetUnit(nil)
            ai.SetNearTarget(0,200)

            -- 주변을 탐색 후 타겟을 찾았으면(nil이 아니면), 추적을 활성화(true), 메세지출력
            if ai.GetTargetUnit() ~= nil then 
                ai.SetFollowTarget(true) 
                enemy.say('인...간!! \n캬악!!')
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
                if ran <= 20 then -- 20 이하 일 경우
                    ai.customData.skill = 203 -- 스킬 1
                    ai.customData.delay = 1 -- 딜레이 3초 (ai함수 반복이 2초마다 이루어짐 따라서 2*2(4초))
                    enemy.field.SendCenterLabel("<Color=Red>[*]</color> " .. ai.customData.delay+2 .. "초 뒤, 포효합니다.")
                elseif ran <= 40 then -- 20~ 40 이하 일 경우
                    ai.customData.skill = 204 -- 스킬 2
                    ai.customData.delay = 2 -- 딜레이 4초 (ai함수 반복이 2초마다 이루어짐 따라서 2*2(4초))
                    enemy.field.SendCenterLabel("<Color=Red>[*]</color> " .. ai.customData.delay+2 .. "초 뒤, 갈래 번개를 발사합니다.")
                elseif ran <= 50 then -- 40~50 이하 일 경우
                    enemy.field.SpawnEnemy(7,enemy.x,enemy.y)
                    enemy.field.SpawnEnemy(7,enemy.x,enemy.y)
                    enemy.field.SendCenterLabel("<Color=Red>[*]</color> 고블린이 등장합니다.")
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
                ai.UseSkill(203)
                enemy.field.SendCenterLabel('<color=#FF0000>크아아악!!</color>\n번개왕 자보로그가 울부짖습니다!')
            end
        end
    end

	if (event == 2) then -- 사망 시
		-- 사망 시, 리스폰 시간을 적용해둔 개발자들을 위해 몬스터의 ai 데이터 및 스텟 초기화
		ai.customData.skill = 0
		ai.customData.delay = 0
		enemy.moveSpeed = Server.GetMonster(101).moveSpeed
		enemy.SetStat(0, Server.GetMonster(101).attack)
		enemy.SetStat(1, Server.GetMonster(101).defense)
		enemy.SendUpdated()
	end


        
end

-- 논산 보스 : 골렘
function Golem(enemy,ai,event,data)

    if (event == -1) then
    --처음 0, 체력저하 상태 1
    AngryMode = 0
    --커스텀 딜레이랑 스킬 초기화
    ai.customData.delay = 0
    ai.customData.skill = 0
    end

    if (event == 0) then -- 2초마다 실행되는 이벤트

        enemy.AddHP(enemy.maxHP * 0.01) -- 매 2초마다 몬스터의 전체 HP의 1%씩 회복

        if AngryMode == 0 and enemy.hp <= enemy.maxHP * 0.30 then
            AngryMode = 1
            enemy.say('....!')
            enemy.SetStat(0, enemy.GetStat(0)*1.5) -- 공격력 1.5배 상승
			enemy.SetStat(1, 0) -- 방어력 0으로 하락
            enemy.moveSpeed = enemy.moveSpeed*1.5
            enemy.monsterData.attackTime = 0.5
            enemy.SendUpdated()
        end

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
                enemy.say('....?')
            end
            
            ai.SetFollowTarget(false) --타겟이 사라졌으면 추적을 비활성화 
            ai.SetTargetUnit(nil)
            ai.SetNearTarget(0,200)

            -- 주변을 탐색 후 타겟을 찾았으면(nil이 아니면), 추적을 활성화(true), 메세지출력
            if ai.GetTargetUnit() ~= nil then 
                ai.SetFollowTarget(true) 
                enemy.say('!! \n!!!!')
            end
        end
        
        --타겟이 있으면 스킬 발사
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
                if ran <= 20 then -- 20 이하 일 경우
                    ai.customData.skill = 223 -- 스킬 1
                    ai.customData.delay = 1 -- 딜레이 3초 (ai함수 반복이 2초마다 이루어짐 따라서 2*2(4초))
                    enemy.field.SendCenterLabel("<Color=Red>[*]</color> " .. ai.customData.delay+2 .. "초 뒤, 쾅쾅합니다.")
                elseif ran <= 40 then -- 20~ 40 이하 일 경우
                    ai.customData.skill = 224 -- 스킬 2
                    ai.customData.delay = 2 -- 딜레이 4초 (ai함수 반복이 2초마다 이루어짐 따라서 2*2(4초))
                    enemy.field.SendCenterLabel("<Color=Red>[*]</color> " .. ai.customData.delay+2 .. "초 뒤, 슝슝합니다.")
                elseif ran <= 50 then -- 40~50 이하 일 경우
                    enemy.field.SpawnEnemy(10,enemy.x,enemy.y)
                    enemy.field.SpawnEnemy(10,enemy.x,enemy.y)
                    enemy.field.SendCenterLabel("<Color=Red>[*]</color> 깜돌더미가 등장합니다.")
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
                enemy.say('....!?')
            end
            
            -- 몬스터가 공격당할시 10% 확률로 짱짱쌘 5번 공격 기술을 시전하고 서버전체에 메세지 출력
            if math.random(0,99) <= 9 then
                ai.UseSkill(223)
                enemy.field.SendCenterLabel('<color=#FF0000>!!</color>\n마기를 흡수한 골렘이 쿵쾅거립니다!')
            end
        end
    end

	if (event == 2) then -- 사망 시
		-- 사망 시, 리스폰 시간을 적용해둔 개발자들을 위해 몬스터의 ai 데이터 및 스텟 초기화
		ai.customData.skill = 0
		ai.customData.delay = 0
		enemy.moveSpeed = Server.GetMonster(102).moveSpeed
		enemy.SetStat(0, Server.GetMonster(102).attack)
		enemy.SetStat(1, Server.GetMonster(102).defense)
		enemy.SendUpdated()
	end


        
end



Server.SetMonsterAI(101, BlueGobline) -- 101번 몬스터에게 BlueGobline 적용
Server.SetMonsterAI(102, Golem) -- 102번 몬스터에게 Golem 적용