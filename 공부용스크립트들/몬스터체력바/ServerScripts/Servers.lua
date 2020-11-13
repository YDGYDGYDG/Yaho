--클라이언트 스크립트에서도 설정할게 있습니다

------------------------------------------------
--사용법

--사용법은 클라이언트 스크립트에 있습니다

-------------------------------------------------
--설정

--특정몬스터만 감지여부, 1=모든몬스터, 2=특정몬스터(2를 선택시 다음선택도 진행해주세요)

htm = 1

--특정몬스터 감지여부가 2라면 감지할 몬스터 ID를 작성해주세요
--예) htmid = {1,2,5,12,42} 이런식으로 추가해주세요

htmid = {1}

--------------------------------------------------

Server.damageCallback = function(a, b, damage, SkillID)
	if b.type == 2 then
		if htm == 2 then
			for i = 0, #htmid do
				if b.monsterID == htmid[i] then

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
			end
		else

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

	end

return damage - b.def

end