-- 확인해보기
-- unit.SendSay()

-- 랜덤 사용
math.randomseed(os.time())
-- 랜덤 변수
local ReinforceRandMax = 100
local ReinforceRandMin = 0
local ReinforceSucRate = 0

local HeartMax = 300

--======================================================================
-- 무기 장착

-- 클라에 줄 정보 모으는 함수
local clientYas = function()
    --현재 장착중인 무기 정보 복사 (캐릭터의 정보를 가져와서 무기의 정보인 척 하는 프로퍼티도 존재함)
    -- 무기 정보 복사 (장착템 중 무기는 2번)
    local EquipedWeapon = unit.GetEquipItem(2)
    if EquipedWeapon == nil then
        unit.SendSay("무기를 가지고 있지 않습니다.")
    else
        -- 무기 정보 복사
        local WeaponType = EquipedWeapon.dataID
        local WeaponLevel = EquipedWeapon.level
        -- 캐릭터 정보 복사 [장비중인 무기 프로퍼티, atk, cri, criPer, SP, heart]
        local WeaponATK = unit.atk
        local WeaponCri = unit.GetStat(101)
        local WeaponCriPer = unit.GetStat(102)
        local WeaponSP = unit.GetStat(103)
        local WeaponHeart = unit.GetStat(104)
        if WeaponHeart > HeartMax then
            unit.SetStat(104, HeartMax)
        end
        local WeaponExp = unit.GetStat(105)

        -- 클라에게 전달
        Server.FireEvent("ReplyServerValue", WeaponType, WeaponLevel, WeaponATK, WeaponCri, WeaponCriPer, WeaponSP, WeaponHeart, WeaponExp)
    end
    -- unit.SendSay("서버 정상 작동 완료")
end

-- 클라에게서 신호 받기
Server.GetTopic("CallServerValue").Add(clientYas)

-- 무기 강제 장착하기
local ForceEquipWeapon = function(unit)
    -- 공격력 판단해서 0이면 무기가 없는 거임
    if unit.atk < 1 then
        -- unit.SendSay("무기 해제 감지")
        unit.EquipItem(2, true)
        -- unit.SendSay("무기 해제 시퀀스 끝")
    end
end
local ForceEquipWeaponFirst = function()
    -- unit.SendSay("무기 처음 획득 감지")
    unit.EquipItem(2, true)
    -- unit.SendSay("무기 처음 획득 시퀀스 끝")
end
--스탯이 바뀌면 무기 장착중인지 확인하고 장착하게 하기
Server.onRefreshStats.Add(ForceEquipWeapon)
Server.GetTopic("ForceEquipWeaponFirst").Add(ForceEquipWeaponFirst)


--=========================================================================
--호감도

local GiftUIOpen = function()
    local hams = unit.CountItem(8)
    local shams = unit.CountItem(9)
    local WeaponHeart = unit.GetStat(104)
    Server.FireEvent("ReplyServerHamstones", hams, shams, WeaponHeart)
    -- unit.SendSay("햄스톤 개수 정보 전달 완료.")
end

Server.GetTopic("CallServerHamstones").Add(GiftUIOpen)

--햄스톤 먹였다고 신호 받으면 호감도 스탯 상승시키기
local GiftToWeapon = function(n)
    --init
    local hams = unit.CountItem(8)
    local shams = unit.CountItem(9)
    -- 요청한 버튼이 햄스톤인지 슈퍼햄스톤인지 판단 (n으로)
    -- 가방 안에 해당 햄스톤이 존재하는지 판단
    -- 있으면 1개 제거
    if n == 10 then
        if hams >= 1 then
            -- 무기 호감도 상승 요청
            if unit.GetStat(104) < HeartMax then
                unit.RemoveItem(8, 1, true, true, false)
                unit.SetStat(104, unit.GetStat(104) + n)
                -- unit.SendSay("햄스톤 시퀀스 성공 종료")
                -- 호감도 변경 대사 출력 요청
                Server.FireEvent("GiftWeaponFeedback")
            else
                unit.SetStat(104, HeartMax)
                unit.SendSay("이미 호감도가 최대입니다.")
            end
        else
            unit.SendSay("햄스톤이 부족합니다.")
        end
    elseif n == 20 then
        if shams >= 1 then
                -- 무기 호감도 상승 요청
            if unit.GetStat(104) < HeartMax then
                unit.RemoveItem(9, 1, true, true, false)
                unit.SetStat(104, unit.GetStat(104) + n)
                -- unit.SendSay("햄스톤 시퀀스 성공 종료"")
                Server.FireEvent("GiftWeaponFeedback")
            else
                unit.SetStat(104, HeartMax)
                unit.SendSay("이미 호감도가 최대입니다.")
            end
        else
            unit.SendSay("슈퍼햄스톤이 부족합니다.")
        end
    end
    hams = unit.CountItem(8)
    shams = unit.CountItem(9)
    local WeaponHeart = unit.GetStat(104)
    Server.FireEvent("ReplyServerHamstones", hams, shams, WeaponHeart)
    -- unit.SendSay("햄스톤 시퀀스 종료")
end

Server.GetTopic("GiftToWeapon").Add(GiftToWeapon)

--====================================================
-- 호감도에 의한 스탯 배율 변화
-- 0~300 으로 공격력/치명/치명배율에 추가분 지급
-- local PowerOfLove = function()
--     local WeaponHeart = unit.GetStat(104)
    
-- end
-- -- 능력치가 변할 때마다 콜백되는 함수
-- Server.onRefreshStats.Add(PowerOfLove)



--====================================================
-- 강화 시스템
-- 강화 관련 정보 보내기
local ReinforceUIOpen = function()
    -- unit.SendSay("강화 UI 오픈 요청 받았습니다")
    local MStones = unit.CountItem(1)
    local EquipedWeapon = unit.GetEquipItem(2)
    local ReinLevel = EquipedWeapon.level
    Server.FireEvent("ReplyServerReinforceUI", MStones, ReinLevel)
    -- unit.SendSay("강화 UI 오픈 결과 보냅니다")
end
Server.GetTopic("ReinforceUIOpen").Add(ReinforceUIOpen)

-- 강화 처리
local StartReinforce = function()
    -- unit.SendSay("강화 실행 요청 받았습니다")
    local MStones = unit.CountItem(1)
    local EquipedWeapon = unit.GetEquipItem(2)

    if MStones >= 1 then
        -- 확률 초기화
        ReinforceSucRate = 0
        if EquipedWeapon.level < 10 then
            ReinforceSucRate = (100-(EquipedWeapon.level*8))
        else
            ReinforceSucRate = 20
        end
        -- 무기 레벨 상승 요청
        if EquipedWeapon.level < 100 then
            local rand = math.random(ReinforceRandMin, ReinforceRandMax)
            if ReinforceSucRate >= rand then
                unit.RemoveItem(1, 1, true, true, false)
                EquipedWeapon.level = EquipedWeapon.level + 1
                -- 성공 알림
                unit.StartGlobalEvent(2)
                -- 강화된 무기 수치 반영 요청하기
                unit.UnequipItem(2)
                clientYas()
            else
                unit.RemoveItem(1, 1, true, true, false)
                -- 실패 알림
                unit.StartGlobalEvent(3)
            end
        else
            -- 만렙 알림
            unit.StartGlobalEvent(4)
        end
    else
        -- 재료 부족 알림
        unit.StartGlobalEvent(5)
    end
    MStones = unit.CountItem(1)
    local ReinLevel = EquipedWeapon.level
    Server.FireEvent("ReplyServerReinforceUI", MStones, ReinLevel)
    -- unit.SendSay("서버 강화 시퀀스 종료")
end
Server.GetTopic("StartReinforce").Add(StartReinforce)













