function UsePetCaller(unit, characterID, jobID)
    local petID = unit.AddPet(characterID, jobID)     
    unit.FireEvent("getPetName", petID, characterID)
end

Server.GetTopic("petList").Add(function()
    --현재 플레이어에 등록된 펫 데이터 목록 가져오기
    local pets = unit.GetAllRegistedPetData()

    --가져온 펫 데이터를 직렬화
    local t = {}
    for i, pet in ipairs(pets) do
        local data = {}
        data["id"] = pet.id
        data["name"]= pet.name
        data["level"] = pet.level
        data["jobID"] = pet.jobID
        data["characterID"] = pet.characterID
        table.insert(t, data)
    end
    local tstr = Utility.JSONSerialize(t)
    
    --현재 소환된 펫이 있을경우 소환된 펫의 ID 클라이언트에 알려주는 용도
    local currentPetID = -1
    local currentPet = unit.GetSingleSummonedPet()
    if currentPet != nil then
        currentPetID = currentPet.petID
    end

    unit.FireEvent("petList", tstr, currentPetID) --클라이언트에 이 이름을 가진 topic이 발생했음을 전달
end)

--펫 이름 등록 서버처리
Server.GetTopic("setPetName").Add(function(petID, petName)
    local pet = unit.GetRegistedPetDataByPetID(tonumber(petID))
    unit.SendCenterLabel("펫 '"..pet.name.."'의 이름을 '"..petName.."'으로 변경하였습니다.")
    pet.name = petName
end)

--펫 목록 UI에서 소환버튼을 눌렀을 시
Server.GetTopic("spawnPet").Add(function(petID)
    if not unit.spawnPet(tonumber(petID), unit.x, unit.y) then            
        unit.SendCenterLabel("이미 소환된 펫이 있습니다.")        
    end
end)

--펫 목록 UI에서 해제버튼을 눌렀을 시
Server.GetTopic("cancelPet").Add(function(petID, petName)        
    unit.CancelPetSummon()
end)