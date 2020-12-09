
function SpUp()
    -- unit.SendSay("이속증가")
    unit.moveSpeed = 250
    unit.SendUpdated()
    -- unit.SendSay(unit.moveSpeed)
end


function SpDown()
    -- unit.SendSay("이속감소")
    unit.moveSpeed = 150
    unit.SendUpdated()
    -- unit.SendSay(unit.moveSpeed)
end

