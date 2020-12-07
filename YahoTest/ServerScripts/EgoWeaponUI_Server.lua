-- 확인해보기
-- unit.SendSay()

-- 랜덤 사용
math.randomseed(os.time())
-- 랜덤 변수
local ReinforceRandMax = 100
local ReinforceRandMin = 0

local HeartMax = 300

local WP_Atk_List = {3, 6, 9, 12,	16,	21,	27,	32,	39,	46,	53,	86,	98,	111,	124,	138,	153,	168,	184,	201,	219,	237,	256,	276,	297,	318,	340,	363,	386,	410,	435,	461,	487,	514,	542,	570,	599,	629,	660,	691,	723,	756,	789,	823,	858,	894,	930,	967,	1005,	1044,	1083,	1237,	1284,	1332,	1381,	1431,	1481,	1533,	1585,	1638,	1693,	1748,	1803,	1860,	1918,	1976,	2036,	2096,	2157,	2219,	2282,	2469,	2537,	2605,	2675,	2746,	2817,	2890,	2963,	3037,	3113,	3189,	3266,	3344,	3423,	3502,	3583,	3665,	3747,	3831,	3915,	4196,	4287,	4378,	4470,	4563,	4657,	4752,	4848,	4945
}


-- 무기 정보 버튼 활성 ==============================
local ViewWeaponBt = function()
    local WEOnOff = false
    local EquipedWeapon = unit.GetEquipItem(2) -- 무기 란에 장착중인 장비
    -- 장착하고 있지 않으면...
    if EquipedWeapon == nil then
        WEOnOff = false
        -- 겸사겸사 무기도 무한 장착하기
        -- 가방에서 무기 찾기
        local unitItems = unit.player.GetItems()
        for i, v in pairs(unitItems) do
            -- local thisItemID = unit.GetItem(unitItems[i])
            if Server.GetItem(unitItems[i].dataID).type == 2 then
                unit.EquipItem(unitItems[i].id, true)
                -- unit.SendSay("무기 강제 장착했습니다")
            -- else
            --     unit.SendSay("무기 없습니다")
            end
        end
    else
        -- unit.SendSay("당신의 무기 번호는"..EquipedWeapon.dataID)
        WEOnOff = true

        -- 겸사겸사 무기 공격력에 호감도 반영하기
        -- 무기 레벨에 맞는 공격력 추출 (루아 리스트는 index가 1부터임)
        local WpAtk = WP_Atk_List[EquipedWeapon.level + 1]
        -- 호감도 계산 : 30마다 공격력 3%가 오르는 계단식 그래프
        local PowerOfLove = math.floor(unit.GetStat(104)/30) * 0.03
        local LastAtk = WpAtk * (1 + PowerOfLove)
        unit.SetStat(0, LastAtk)
    end
    -- unit.SendSay("test")
    unit.FireEvent("ReplyServerWeaponBt", WEOnOff)

end
Server.GetTopic("CallServerWeaponBt").Add(ViewWeaponBt)

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
        -- 캐릭터 정보 복사 [장비중인 무기 프로퍼티, atk, cri, criPer, heart]
        local WeaponATK = unit.atk
        local WeaponCri = unit.luk
        local WeaponCriPer = unit.agi
        local WeaponHeart = unit.GetStat(104)
        if WeaponHeart > HeartMax then
            unit.SetStat(104, HeartMax)
        end
        -- 클라에게 전달
        unit.FireEvent("ReplyServerValue", WeaponType, WeaponLevel, WeaponATK, WeaponCri, WeaponCriPer, WeaponHeart)
    end
    -- unit.SendSay("서버 정상 작동 완료")
end

-- 클라에게서 신호 받기
Server.GetTopic("CallServerValue").Add(clientYas)


--=========================================================================
--호감도

local GiftUIOpen = function()
    local hams = unit.CountItem(8)
    local shams = unit.CountItem(9)
    local WeaponHeart = unit.GetStat(104)
    unit.FireEvent("ReplyServerHamstones", hams, shams, WeaponHeart)
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
                unit.FireEvent("GiftWeaponFeedback")
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
                unit.FireEvent("GiftWeaponFeedback")
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
    unit.FireEvent("ReplyServerHamstones", hams, shams, WeaponHeart)
    -- unit.SendSay("햄스톤 시퀀스 종료")
end

Server.GetTopic("GiftToWeapon").Add(GiftToWeapon)


--====================================================
-- 강화 시스템
-- 강화 관련 정보 보내기
local ReinforceUIOpen = function()
    -- unit.SendSay("강화 UI 오픈 요청 받았습니다")
    local MStones = unit.CountItem(1)
    local EquipedWeapon = unit.GetEquipItem(2)
    local ReinLevel = EquipedWeapon.level
    -- 확률 초기화
    local ReinforceSucRate = 0
    if EquipedWeapon.level < 10 then
        ReinforceSucRate = (100-(EquipedWeapon.level*8))
    else
        ReinforceSucRate = 20
    end
    unit.FireEvent("ReplyServerReinforceUI", MStones, ReinLevel, ReinforceSucRate)
    -- unit.SendSay("강화 UI 오픈 결과 보냅니다")
end
Server.GetTopic("ReinforceUIOpen").Add(ReinforceUIOpen)

-- 강화 처리
local StartReinforce = function()
    -- unit.SendSay("강화 실행 요청 받았습니다")
    local MStones = unit.CountItem(1)
    local EquipedWeapon = unit.GetEquipItem(2)
    -- 확률 초기화
    local ReinforceSucRate = 0
    if EquipedWeapon.level < 10 then
        ReinforceSucRate = (100-(EquipedWeapon.level*8))
    else
        ReinforceSucRate = 20
    end
    if MStones >= 1 then
        -- 무기 레벨 상승 요청
        if EquipedWeapon.level < 99 then
            local rand = math.random(ReinforceRandMin, ReinforceRandMax)
            if ReinforceSucRate >= rand then
                unit.RemoveItem(1, 1, true, true, false)
                EquipedWeapon.level = EquipedWeapon.level + 1
                -- 성공 알림
                unit.StartGlobalEvent(2)
                -- 강화된 무기 수치 반영 요청하기
                unit.UnequipItem(2)
                ViewWeaponBt()
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
    if EquipedWeapon.level < 10 then
        ReinforceSucRate = (100-(EquipedWeapon.level*8))
    else
        ReinforceSucRate = 20
    end
    unit.FireEvent("ReplyServerReinforceUI", MStones, ReinLevel, ReinforceSucRate)
    -- unit.SendSay("서버 강화 시퀀스 종료")
end
Server.GetTopic("StartReinforce").Add(StartReinforce)


