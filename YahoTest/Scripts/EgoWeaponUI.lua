
--init   =====================================================
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
HeartResult.width = 0

--=====================================

-- 열닫, 기능 자동 실행
function EgoWeaponUIOpen()
    WeaponUI.visible = not WeaponUI.visible
    WeaponUI.enabled = not WeaponUI.enabled


    -- 캐릭터의 스탯, 장비는 서버 상에서 가져와야 한다
    -- MyUnit.UseSkill(4)
    Client.FireEvent("GetServerValue")
    Client.GetTopic("GetServerValue").Add(function()
        --가져온 캐릭터 수치 반영


    end)

    print("아잇~~2")
end
-- 닫
function WeaponUIClose()
    WeaponUI.visible = false
    WeaponUI.enabled = false
end

-- 무기와 대화하기
function TalkWithWeapon()

end

-- 무기의 조언 얻기
function AdviceByWeapon()
    
end

-- 무기에게 선물 주기
function GiftToWeapon()
    
end
-- 호감도 num만큼 상승시키기
function HeartUP(num))
    HeartResult.width = HeartResult.width + num
end
