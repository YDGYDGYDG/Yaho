Skills = {}

function Skills:Dash(unit)
    unit.MakeKnockback(-110 - (unit.moveSpeed - 150) / 2, 0.2)
end