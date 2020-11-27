-- 확인해보기
-- unit.SendSay()

-- 클라에 줄 정보 모으는 함수
local clientYas = function()
    --현재 장착중인 무기 정보 복사 (캐릭터의 정보를 가져와서 무기의 정보인 척 하는 프로퍼티도 존재함)
    -- 무기 정보 복사 (장착템 중 무기는 2번)
    local EquipedWeapon = unit.GetEquipItem(2)
    if EquipedWeapon == nil then
        unit.SendSay("무기를 가지고 있지 않습니다.")
    end
    -- 무기 정보 복사
    local WeaponType = EquipedWeapon.dataID
    local WeaponLevel = EquipedWeapon.level
    -- 캐릭터 정보 복사 [장비중인 무기 프로퍼티, atk, cri, criPer, SP, heart]
    local WeaponATK = unit.atk
    local WeaponCri = unit.GetStat(101)
    local WeaponCriPer = unit.GetStat(102)
    local WeaponSP = unit.GetStat(103)
    local WeaponHeart = unit.GetStat(104)
    local WeaponExp = unit.GetStat(105)

    -- 클라에게 전달
    Server.FireEvent("ReplyServerValue", WeaponType, WeaponLevel, WeaponATK, WeaponCri, WeaponCriPer, WeaponSP, WeaponHeart, WeaponExp)
    -- unit.SendSay("서버 정상 작동 완료")
end

-- 클라에게서 신호 받기
Server.GetTopic("CallServerValue").Add(clientYas)

-- 무기 강제 장착하기
local ForceEquipWeapon = function(unit)
    -- 공격력 판단해서 0이면 무기가 없는 거임
    if unit.atk < 1 then
        unit.SendSay("무기 해제 감지")
        unit.EquipItem(2, true)
        unit.SendSay("무기 해제 시퀀스 끝")
    end
end
local ForceEquipWeaponFirst = function()
    unit.SendSay("무기 처음 획득 감지")
    unit.EquipItem(2, true)
    unit.SendSay("무기 처음 획득 시퀀스 끝")
end
--스탯이 바뀌면 무기 장착중인지 확인하고 장착하게 하기
Server.onRefreshStats.Add(ForceEquipWeapon)
Server.GetTopic("ForceEquipWeaponFirst").Add(ForceEquipWeaponFirst)
