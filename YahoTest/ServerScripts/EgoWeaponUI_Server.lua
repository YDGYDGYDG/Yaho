
Server.GetTopic("GetServerValue").Add(function()

    --현재 장착중인 무기 정보 복사 (캐릭터의 정보를 가져와서 무기의 정보인 척 하는 프로퍼티도 존재함)
    -- 장착템 중 무기는 2번
    local EquipedWeapon = unit.GetEquipItem(2)
    if EquipedWeapon == nil then
        unit.SendSay("불러오기 오류")
    end
    -- 무기 정보 복사
    unit.SendSay(EquipedWeapon.id)

    -- 캐릭터 정보 복사 [장비중인 무기 프로퍼티, atk, ]
    local WeaponATK = unit.atk
    unit.SendSay(WeaponATK)

    -- 클라에게 전달
    Server.FireEvent("GetServerValue")
    
end)