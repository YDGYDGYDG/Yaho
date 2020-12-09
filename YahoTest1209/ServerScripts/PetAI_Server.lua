function Ego_Sword(pet,ai,event)

    -- 최초 PetAI 등록시 실행
    if(event == AI_INIT) then
        ai.customData.timer = 1;
    end

    --2초마다 실행
    if(event == AI_UPDATE) then
            --200만큼 거리가 멀어지면 주인을 따라감 
            --400만큼 멀어지면 주인의 위치로 순간이동
            --ai.SetFollowMaster(true,200,400)

            --타깃이 없으면 주인을 따라다님
            if(ai.GetTargetUnit() == nil) then
                    ai.SetFollowMaster(true,100,200)
            end

            --기본100,200
            --ai.SetFollowMaster(true)

            --가장 가까운 적유닛 을 타깃으로 지정
            ai.SetNearTarget(2,100)

            --펫의 타깃이 존재한다면 스킬 사용
            --스킬은 기본적으로 타깃을 향해 발사됨
            if(ai.GetTargetUnit() ~=nil) then
                --타깃이 정해지면 따라다니는것을 멈춤
                ai.SetFollowMaster(false)
                ai.StopMove()

                -- 타깃이 정해지면 타깃을 따라다니면서 공격
                ai.MoveToPosition(ai.GetTargetUnit().x,ai.GetTargetUnit().y)
                -- 타깃 방향으로 발사
                ai.UseSkill(101)

                ai.SetFollowMaster(true,140,200)
                -- 주인에게 버프추가
                -- ai.AddMasterBuff(15)
            end

            --커스텀 데이터를 이용한 타이머 10초에 한번씩 주위의 드롭된아이템 획득                        
            ai.customData.timer = ai.customData.timer + 1;
            if(ai.customData.timer == 5) then
                -- 반경 80의 거리 안에 들어오는 드롭 아이템 획득
                ai.AcquireNearDropItem(80)
                ai.customData.timer = 0;
            end
    end

end

function Ego_Staff(pet,ai,event)

    -- 최초 PetAI 등록시 실행
    if(event == AI_INIT) then
        ai.customData.timer = 1;
    end

    --2초마다 실행
    if(event == AI_UPDATE) then
            --200만큼 거리가 멀어지면 주인을 따라감 
            --400만큼 멀어지면 주인의 위치로 순간이동
            --ai.SetFollowMaster(true,200,400)

            --타깃이 없으면 주인을 따라다님
            if(ai.GetTargetUnit() == nil) then
                    ai.SetFollowMaster(true,40,160)
            end

            --기본100,200
            --ai.SetFollowMaster(true)

            --가장 가까운 적유닛 을 타깃으로 지정
            ai.SetNearTarget(2,300)

            --펫의 타깃이 존재한다면 스킬 사용
            --스킬은 기본적으로 타깃을 향해 발사됨
            if(ai.GetTargetUnit() ~=nil) then
                -- 타깃 방향으로 발사
                ai.UseSkill(102)

                ai.SetFollowMaster(true,40,160)
                -- 주인에게 버프추가
                -- ai.AddMasterBuff(15)
            end

            --커스텀 데이터를 이용한 타이머 10초에 한번씩 주위의 드롭된아이템 획득                        
            ai.customData.timer = ai.customData.timer + 1;
            if(ai.customData.timer == 5) then
                -- 반경 80의 거리 안에 들어오는 드롭 아이템 획득
                ai.AcquireNearDropItem(140)
                ai.customData.timer = 0;
            end
    end

end


Server.SetPetAI(16,Ego_Sword) -- 에고소드 AI
Server.SetPetAI(17,Ego_Staff) -- 에고소드 AI