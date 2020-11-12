Server.damageCallback = function(a, b, damage, SkillID)
if b.type == 2 then

local bnn = b.monsterData.name
local bh = b.monsterData.maxHP
local bhh = b.hp

bb = damage - b.defense

eed = bhh - bb

if eed > bhh then
   eed = bhh
end

if eed < 0 then
   eed = 0
end

a.FireEvent("bh", bh,eed,bnn)


end

return damage - b.def

end