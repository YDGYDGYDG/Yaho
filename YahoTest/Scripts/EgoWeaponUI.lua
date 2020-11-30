
--init   =====================================================
local EgoWeaponUI = Client.LoadPage("EgoWeaponUIBt")
local EgoWeaponUIBt = EgoWeaponUI.GetControl("EgoWeaponBt")
EgoWeaponUIBt.visible = false

local UI = Client.LoadPage("WeaponUI")

local WeaponUI = UI.GetControl("MainPanel")
WeaponUI.enabled = false
WeaponUI.visible = false


--무기 이미지
local WeaponImageBG = WeaponUI.GetChild("WeaponImageBG")
local WeaponImage = WeaponImageBG.GetChild("W_Image")

--무기 스탯 텍스트
local StatsTexts = WeaponUI.GetChild("WeaponStats")
local WeaponATKText = StatsTexts.GetChild("ATKResultText")
local WeaponCriText = StatsTexts.GetChild("CriResultText")
local WeaponCriPerText = StatsTexts.GetChild("CriPerResultText")
local WeaponSPText = StatsTexts.GetChild("SPResultText")

--무기 대사 텍스트
local TalkTexts = WeaponUI.GetChild("WeaponTalk")
local WeaponTalkText = TalkTexts.GetChild("SayResultText")

--무기 레벨 텍스트
local LevelTexts = WeaponUI.GetChild("WeaponLevel")
local WeaponLevelText = LevelTexts.GetChild("LevelResultText")

--무기 경험치 텍스트
local ExpTexts = WeaponUI.GetChild("WeaponExp")
local WeaponExpText = ExpTexts.GetChild("ExpResultText")

--무기 호감도 (0 ~ 350 넓이조절)
local HeartPanel = WeaponUI.GetChild("HeartPanel")
HeartResult = HeartPanel.GetChild("HeartResult") -- 지속 변수
HeartResultText = HeartPanel.GetChild("HeartResultText") -- 지속 변수
HeartResult.width = 0
-- 호감도 커트라인
local HeartBad = 70
local HeartNormal = 140
local HeartGood = 210
local HeartVeryGood = 280

-- 선물 주기 UI init
local GiftMainUI = Client.LoadPage("GiftToWeaponUI")
local GiftUI = GiftMainUI.GetControl("MainPanel")
local GiftItemPanel = GiftUI.GetChild("ItemPanel")
local HamstoneLeft = GiftItemPanel.GetChild("HamstoneLeft")
local SHamstoneLeft = GiftItemPanel.GetChild("SHamstoneLeft")
GiftUI.visible = false

-- 강화 UI init
local ReinforceMainUI = Client.LoadPage("ReinforceUI")
local ReinforceUI = ReinforceMainUI.GetControl("MainPanel")
local ReinforcePanel = ReinforceUI.GetChild("ReinforcePanel")
local MStoneText = ReinforcePanel.GetChild("MStoneText")
local ReinLevelText = ReinforcePanel.GetChild("ReinLevelText")
local NextLevelText = ReinforcePanel.GetChild("NextLevelText")
local SuccessText = ReinforcePanel.GetChild("SuccessText")
local FailText = ReinforcePanel.GetChild("FailText")
ReinforceUI.visible = false


--=====================================
--무기 대화용 랜덤 시드

-- 랜덤 사용
math.randomseed(os.time())
-- 랜덤 변수
local TalkRandMax = 4
local TalkRandMin = 0


--=====================================
-- 무기정보 버튼을 보이게 하기
function EgoWeaponUIBtOn()
    EgoWeaponUIBt.visible = true
end

-- 호감도 갱신
local RefreshWeaponHeart = function(WeaponHeart)
    HeartResultText.text = math.floor(WeaponHeart / 350 * 100).." %"
    HeartResult.width = WeaponHeart
end

-- 서버 통신 함수
local serverYas = function(WeaponType, WeaponLevel, WeaponATK, WeaponCri, WeaponCriPer, WeaponSP, WeaponHeart, WeaponExp)
    if WeaponType == nil then
        WeaponUIClose()
    end
    --가져온 캐릭터 수치 반영
    if WeaponType == 20 then
        WeaponImage.image = "Pictures/001_ewp_sword.png"
    elseif WeaponType == 21 then
        WeaponImage.image = "Pictures/061_ewp_hammer.png"
    elseif WeaponType == 22 then
        WeaponImage.image = "Pictures/031_ewp_spear.png"
    end
    WeaponLevelText.text = WeaponLevel
    WeaponATKText.text = WeaponATK
    WeaponCriText.text = WeaponCri
    WeaponCriPerText.text = WeaponCriPer
    WeaponSPText.text = WeaponSP
    RefreshWeaponHeart(WeaponHeart)
    WeaponExpText.text = WeaponExp
    
    -- print("클라 정상 작동 완료")
end


-- 열기, 기능 자동 실행
function EgoWeaponUIOpen()
    if WeaponUI.visible == false then
        WeaponUI.visible = true
        WeaponUI.enabled = true
        TalkDefaultWeapon()
        
        -- 서버 상에서 캐릭터의 스탯, 장비 가져오기
        Client.FireEvent("CallServerValue")
        Client.GetTopic("ReplyServerValue").Add(serverYas)
    else 
        WeaponUIClose()
    end
end

-- 닫기
function WeaponUIClose()
    WeaponUI.visible = false
    WeaponUI.enabled = false
    GiftUI.visible = false

    Client.GetTopic("ReplyServerValue").Remove(serverYas)
end

--무기 최초 대사 0 ~ 350
function TalkDefaultWeapon()
    if HeartResult.width < HeartBad then
        WeaponTalkText.text = "눈 깔아."
    elseif HeartResult.width >= HeartBad and HeartResult.width < HeartNormal then
        WeaponTalkText.text = "뭘 봐. 말하는 무기 처음 봐?"
    elseif HeartResult.width >= HeartNormal and HeartResult.width < HeartGood then
        WeaponTalkText.text = "그래."
    elseif HeartResult.width >= HeartGood and HeartResult.width < HeartVeryGood then
        WeaponTalkText.text = "왔어?"
    elseif HeartResult.width >= HeartVeryGood then
        WeaponTalkText.text = "기다리고 있었어!"
    end
end

-- 무기와 대화하기
function TalkWithWeapon()
    local rand = math.random(TalkRandMin, TalkRandMax)

    if HeartResult.width < HeartBad then
        if rand == 0 then
            WeaponTalkText.text = "꺼져."
        elseif rand == 1 then
            WeaponTalkText.text = "반으로 갈라져서 죽어."
        elseif rand == 2 then
            WeaponTalkText.text = "뭘 봐?"
        elseif rand == 3 then
            WeaponTalkText.text = "인생 왜사니?"
        elseif rand == 4 then
            WeaponTalkText.text = "즐."
        end
    elseif HeartResult.width >= HeartBad and HeartResult.width < HeartNormal then
        if rand == 0 then
            WeaponTalkText.text = "너 싫어."
        elseif rand == 1 then
            WeaponTalkText.text = "..."
        elseif rand == 2 then
            WeaponTalkText.text = ""
        elseif rand == 3 then
            WeaponTalkText.text = ""
        elseif rand == 4 then
            WeaponTalkText.text = ""
        end
    elseif HeartResult.width >= HeartNormal and HeartResult.width < HeartGood then
        if rand == 0 then
            WeaponTalkText.text = ""
        elseif rand == 1 then
            WeaponTalkText.text = ""
        elseif rand == 2 then
            WeaponTalkText.text = ""
        elseif rand == 3 then
            WeaponTalkText.text = ""
        elseif rand == 4 then
            WeaponTalkText.text = ""
        end
    elseif HeartResult.width >= HeartGood and HeartResult.width < HeartVeryGood then
        if rand == 0 then
            WeaponTalkText.text = ""
        elseif rand == 1 then
            WeaponTalkText.text = ""
        elseif rand == 2 then
            WeaponTalkText.text = ""
        elseif rand == 3 then
            WeaponTalkText.text = ""
        elseif rand == 4 then
            WeaponTalkText.text = ""
        end
    elseif HeartResult.width >= HeartVeryGood then
        if rand == 0 then
            WeaponTalkText.text = ""
        elseif rand == 1 then
            WeaponTalkText.text = ""
        elseif rand == 2 then
            WeaponTalkText.text = ""
        elseif rand == 3 then
            WeaponTalkText.text = ""
        elseif rand == 4 then
            WeaponTalkText.text = ""
        end
    end

end

-- 무기의 조언 얻기
function AdviceByWeapon()
    local rand = math.random(TalkRandMin, TalkRandMax)

    if HeartResult.width < HeartBad then
        if rand == 0 then
            WeaponTalkText.text = "% 게임 접어~"
        elseif rand == 1 then
            WeaponTalkText.text = "Alt + f4를 눌러봐. 마법의 주문이야."
        elseif rand == 2 then
            WeaponTalkText.text = "너 따위한테 해 줄 조언은 없어."
        elseif rand == 3 then
            WeaponTalkText.text = "부모님께 효도해라. 아...맞다. 미안?"
        elseif rand == 4 then
            WeaponTalkText.text = "ㅗ"
        end
    elseif HeartResult.width >= HeartBad and HeartResult.width < HeartNormal then
        if rand == 0 then
            WeaponTalkText.text = "너 싫어."
        elseif rand == 1 then
            WeaponTalkText.text = "..."
        elseif rand == 2 then
            WeaponTalkText.text = ""
        elseif rand == 3 then
            WeaponTalkText.text = ""
        elseif rand == 4 then
            WeaponTalkText.text = ""
        end
    elseif HeartResult.width >= HeartNormal and HeartResult.width < HeartGood then
        if rand == 0 then
            WeaponTalkText.text = ""
        elseif rand == 1 then
            WeaponTalkText.text = ""
        elseif rand == 2 then
            WeaponTalkText.text = ""
        elseif rand == 3 then
            WeaponTalkText.text = ""
        elseif rand == 4 then
            WeaponTalkText.text = ""
        end
    elseif HeartResult.width >= HeartGood and HeartResult.width < HeartVeryGood then
        if rand == 0 then
            WeaponTalkText.text = ""
        elseif rand == 1 then
            WeaponTalkText.text = ""
        elseif rand == 2 then
            WeaponTalkText.text = ""
        elseif rand == 3 then
            WeaponTalkText.text = ""
        elseif rand == 4 then
            WeaponTalkText.text = ""
        end
    elseif HeartResult.width >= HeartVeryGood then
        if rand == 0 then
            WeaponTalkText.text = ""
        elseif rand == 1 then
            WeaponTalkText.text = ""
        elseif rand == 2 then
            WeaponTalkText.text = ""
        elseif rand == 3 then
            WeaponTalkText.text = ""
        elseif rand == 4 then
            WeaponTalkText.text = ""
        end
    end

end

-- 무기 장착하기
function ForceEquipWeapon()
    -- print("최초 무기 장착 시퀀스 작동 개시")
    Client.FireEvent("ForceEquipWeaponFirst")
end


--======================================================================
-- 무기에게 선물 주기

-- UI 닫기
function GiftUIOff()
    GiftUI.visible = false
    -- 토픽 제거하기
    Client.GetTopic("ReplyServerHamstones").Remove(HamstoneNumber)
end

-- UI 열기
function GiftUIOn()
    -- print("호감도 아이템 UI 오픈")
    if GiftUI.visible == false then
        GiftUI.visible = true
        -- 남아 있는 햄스톤, 슈퍼햄스톤 개수 서버에 요청
        Client.FireEvent("CallServerHamstones")
    else 
        GiftUIOff()
    end
end

--햄스톤 개수 표시하기
local HamstoneNumber = function(hams, shams, WeaponHeart)
    HamstoneLeft.text = "개수: "..hams
    SHamstoneLeft.text = "개수: "..shams
    RefreshWeaponHeart(WeaponHeart)
    print("햄스톤 개수 표시 완료")
end
Client.GetTopic("ReplyServerHamstones").Add(HamstoneNumber)

-- 버튼 입력 처리
function GiftToWeapon(n)
    -- print("햄스톤 시퀀스 작동 개시")
    -- 서버에게 요청
    Client.FireEvent("GiftToWeapon", n)
end


--====================================================
-- 강화 시스템

-- 강화 UI 오픈
function ReinforceUIOpen()
    -- 강화 관련 정보 요청
    Client.FireEvent("ReinforceUIOpen")
    

    -- 강화 관련 정보 표시

end


-- 강화 요청
function StartReinforce()
    Client.FireEvent("StartReinforce")
end

