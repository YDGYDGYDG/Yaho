
local weaponUIOnOff = false

local UI = Client.LoadPage("WeaponUI")
.visible = false
-- WeaponUI.enabled = false

-- 열닫
function EgoWeaponUIOpen()
    if weaponUIOnOff == false then
        -- Client.LoadPage("WeaponUI")
        WeaponUI.visible = true
        WeaponUI.enabled = true
        print("열려라")
        weaponUIOnOff = true
    elseif weaponUIOnOff == true then
        WeaponUI.visible = false
        WeaponUI.enabled = false
        -- Client.GetPage("WeaponUI").Destroy()
        print("닫혀라")
        weaponUIOnOff = false
    end
end



