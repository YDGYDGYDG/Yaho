function onSay(unit, text)
		if (text == ("/공지 업데이트") and unit.player.name == "TEST_1") then
			Server.FireEvent("업데이트", "업데이트")
		end
	
		if (text == ("/공지 즐") and unit.player.name == "TEST_1") then
			Server.SendCenterLabel("다크 온라인을 즐겁게 플레이 해주시는 분들께 정말 감사드립니다.")
		end
	
		if (text == ("/공지 사칭") and unit.player.name == "TEST_1") then
			Server.SendCenterLabel("제작자 사칭에 주의해주세요! 제작자의 닉네임은 천학, 스우입니다!")
		end
		
	end
  
Server.onSay.Add(onSay)