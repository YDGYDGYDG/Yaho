--펫 이름 변경 UI 띄워주기
Client.GetTopic("getPetName").Add(function(petID, characterID)
    --펫 이미지(펫 캐릭터 대표 스프라이트) 세팅
    local character = Client.GetCharacter(tonumber(characterID))
    local petPage = Client.LoadPage("PetAdd")
    petPage.GetControl("PetCharacter").SetTargetSprite(character.imageID)

    --이름을 변경할 펫의 ID를 저장
    petPage.GetControl("PetID").text = petID
end)

--펫 이름 변경(등록) 버튼 눌렀을 시
function SendPetName()
    local thisPage = Client.GetPage("PetAdd")
    local petID = thisPage.GetControl("PetID").text
    local petName = thisPage.GetControl("PetInput").text

    --서버에 변경할 펫ID와 변경할 이름 보내기
    Client.FireEvent("setPetName", petID, petName)

    --서버에 신호를 보낸 후 펫 이름 등록 페이지 제거
    thisPage.Destroy()
end

--현재 소환된 펫 ID를 저장하는 변수
globalCurrentPetID = -1

--펫 소환 UI(레이아웃 관리자 PetList 페이지)가 열려있는지 여부
petListOpened = false

--펫 목록 버튼 클릭시
PetListButton = function()
    if petListOpened then
        PetListClose()
    else
        Client.FireEvent("petList")
        petListOpened = true
    end
end

--펫 소환 UI 닫기
PetListClose = function()
    Client.GetPage("PetList").Destroy()
    petListOpened = false
end

Client.GetTopic("petList").Add(function(petData, currentPetID)
    --복제할 펫 패널 영역의 높이 - 스크롤 패널의 Content(스크롤 영역) 높이 재조정에 사용
    local petPanelHeight = 80

    --서버에서 받은 펫 데이터 목록
    local pets = Utility.JSONParse(petData)    
    
    local petList = Client.LoadPage("PetList")
    local petContent = petList.GetControl("petContent")

    --복제할 펫 패널 영역
    local petPanel = petContent.GetChild("petPanel")
    
    local petCount = 0

    --현재 소환된 펫의 ID 저장
    globalCurrentPetID = tonumber(currentPetID)

    --서버에서 받은 펫 데이터 목록으로 펫 패널을 복제
    for i, pet in ipairs(pets) do
        --레이아웃 관리자에 만들어놓은 펫 영역 복제
        local clonedPanel = petPanel.Clone()
        clonedPanel.y = petCount * petPanelHeight        

        --복제된 펫 영역의 각 자식 컨트롤
        local petImage = clonedPanel.GetChild("petImage")
        local petName = clonedPanel.GetChild("petName")
        local petButton = clonedPanel.GetChild("petButton")
        local cancelButton = clonedPanel.GetChild("cancelButton")

        --펫 이미지(펫 캐릭터 대표 스프라이트) 세팅
        local character = Client.GetCharacter(pet.characterID)
        petImage.SetTargetSprite(character.imageID)

        --펫 이름 세팅
        petName.text = pet.name

        --펫 소환 버튼 세팅
        petButton.onClick.Add(function()
            --이미 펫이 소환된 경우 소환 불가
            if globalCurrentPetID >= 0 then
                print("소환된 펫이 있습니다.")
            else
                Client.FireEvent("spawnPet", pet.id)
                petButton.visible = false
                cancelButton.visible = true
                globalCurrentPetID = pet.id
            end
        end)

        --펫 소환 해제 버튼 세팅
        cancelButton.onClick.Add(function()
            Client.FireEvent("cancelPet")

            cancelButton.visible = false
            petButton.visible = true

            globalCurrentPetID = -1
        end)

        --소환된 펫의 경우 소환버튼 숨기고, 해제 버튼 보여주기
        if pet.id == globalCurrentPetID then
            petButton.visible = false
            cancelButton.visible = true
        else
            petButton.visible = true
            cancelButton.visible = false
        end

        petCount = petCount + 1        
    end

    --원본 펫 영역(프리팹) 삭제
    petPanel.Destroy()

    --등록된 펫 수에 맞게 스크롤 영역 높이 조절
    petContent.height = petCount * petPanelHeight
end)