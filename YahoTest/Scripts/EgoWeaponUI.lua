
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

--무기 대사 텍스트
local TalkTexts = WeaponUI.GetChild("WeaponTalk")
local WeaponTalkText = TalkTexts.GetChild("SayResultText")

--무기 레벨 텍스트
local LevelTexts = WeaponUI.GetChild("WeaponLevel")
local WeaponLevelText = LevelTexts.GetChild("LevelResultText")

--무기 호감도 (0 ~ 300 넓이조절)
local HeartPanel = WeaponUI.GetChild("HeartPanel")
HeartResult = HeartPanel.GetChild("HeartResult") -- 지속 변수
HeartResultText = HeartPanel.GetChild("HeartResultText") -- 지속 변수
HeartResult.width = 0
local HeartMAX = 300
-- 호감도 커트라인
local HeartBad = 60
local HeartNormal = 120
local HeartGood = 180
local HeartVeryGood = 240

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
local WeaponImageBG = ReinforcePanel.GetChild("WeaponImageBG")
local W_Image = WeaponImageBG.GetChild("W_Image")
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
local FeedbackRandMax = 4
local AdviceRandMax = 4
local TalkRandMax = 9
local TalkRandMin = 0

-- 호감도 갱신
local RefreshWeaponHeart = function(WeaponHeart)
    HeartResultText.text = math.floor(WeaponHeart / HeartMAX * 100).." %"
    HeartResult.width = WeaponHeart
end

-- 서버 통신 함수
local serverYas = function(WeaponType, WeaponLevel, WeaponATK, WeaponCri, WeaponCriPer, WeaponHeart)
    if WeaponType == nil then
        WeaponUIClose()
    end
    --가져온 캐릭터 수치 반영
    if WeaponType == 20 then
        WeaponImage.image = "Pictures/001_ewp_sword.png"
        W_Image.image = "Pictures/001_ewp_sword.png"
    elseif WeaponType == 21 then
        WeaponImage.image = "Pictures/061_ewp_hammer.png"
        W_Image.image = "Pictures/061_ewp_hammer.png"
    elseif WeaponType == 22 then
        WeaponImage.image = "Pictures/031_ewp_spear.png"
        W_Image.image = "Pictures/031_ewp_spear.png"
    end
    WeaponLevelText.text = WeaponLevel
    WeaponATKText.text = WeaponATK
    WeaponCriText.text = WeaponCri
    WeaponCriPerText.text = WeaponCriPer
    RefreshWeaponHeart(WeaponHeart)
    
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
        WeaponTalkText.text = "뭐죠?"
    elseif HeartResult.width >= HeartBad and HeartResult.width < HeartNormal then
        WeaponTalkText.text = "왜요?"
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
            WeaponTalkText.text = "…(싸늘한 기운이 느껴진다. 나를 노려보고 있는 것 같다)"
        elseif rand == 1 then
            WeaponTalkText.text = "…딱히 말하고 싶은 기분이 아니야."
        elseif rand == 2 then
            WeaponTalkText.text = "말 좀 그만 걸면 안돼냐? 쫑알쫑알 시끄럽다고."
        elseif rand == 3 then
            WeaponTalkText.text = "햄스톤이 없으면 힘이 안 나는데, 구해다 줄 순 없는거냐?"
        elseif rand == 4 then
            WeaponTalkText.text = "너..오지랖인가 뭔가 하는 그거야?"
        elseif rand == 5 then
            WeaponTalkText.text = "왜 자꾸 귀찮게 하는거야? 저리 좀 가라고!"
        elseif rand == 6 then
            WeaponTalkText.text = "\N! 그렇게 비리비리해서 날 제대로 들 수나 있겠어?"
        elseif rand == 7 then
            WeaponTalkText.text = "내 강함을 네가 잘 다룰 수 있을지 모르겠군."
        elseif rand == 8 then
            WeaponTalkText.text = "…(말을 걸어도 대답이 없다. 일부로 무시하는 듯 하다.)"
        elseif rand == 9 then
            WeaponTalkText.text = "하아…약한 것들이란."
        end
    elseif HeartResult.width >= HeartBad and HeartResult.width < HeartNormal then
        if rand == 0 then
            WeaponTalkText.text = "이제야 조금씩 마음에 들기 시작하네."
        elseif rand == 1 then
            WeaponTalkText.text = "인간들은 대체 이 맛있는 햄스톤을 왜 싫어하는 거야?"
        elseif rand == 2 then
            WeaponTalkText.text = "딱히 같이 있고 싶어서 있는 건 아니라니깐."
        elseif rand == 3 then
            WeaponTalkText.text = "캠프장 인간들, 도무지 이해가 안가. 대체 왜 뭉쳐다니는거야?
            혼자서 강해지면 되잖아."
        elseif rand == 4 then
            WeaponTalkText.text = "…뭐, 위험해진다면 한 번쯤은 구해주지. 딱 한 번."
        elseif rand == 5 then
            WeaponTalkText.text = "마신에 대해서 아냐고?
            글쎄, 얼마나 강할 지는 모르겠지만 분명 나보다는 약한 놈이겠지 뭐."
        elseif rand == 6 then
            WeaponTalkText.text = "..친구 같은 거 없어. 내가 자아를 가지게 된 이후 줄곧 난 혼자였으니까."
        elseif rand == 7 then
            WeaponTalkText.text = "희승인가 호승인가, 그 놈이 너의 스승인거냐? 꽤나 착실히 따르더군."
        elseif rand == 8 then
            WeaponTalkText.text = "내 정체? 알 것 없어. 나도 사실 내 정체에 대해 확실히 아는 건 아니니까."
        elseif rand == 9 then
            WeaponTalkText.text = "..나는 인간이 싫어. 그것들은 날 도구처럼 여긴다고."
        end
    elseif HeartResult.width >= HeartNormal and HeartResult.width < HeartGood then
        if rand == 0 then
            WeaponTalkText.text = "..세상에는 너 같은 인간들도 있군."
        elseif rand == 1 then
            WeaponTalkText.text = "햄스톤 말이야.. 조금 더 달라구. 그러면 널 더 좋게 봐주지."
        elseif rand == 2 then
            WeaponTalkText.text = "가끔 말이야.. '맥주'라는 것을 마시면 평소 너 답지 않게 변하더군.
            그거, 맛있는거냐?"
        elseif rand == 3 then
            WeaponTalkText.text = "이제야 나를 다루는 방법을 터득한 것 같군."
        elseif rand == 4 then
            WeaponTalkText.text = "이 곳의 날씨는 신기해……
            물방울이 떨어지고, 하얗고 차가운 무언가가 내려온단 말이지."
        elseif rand == 5 then
            WeaponTalkText.text = "왜 그렇게 아둥바둥하는거냐? 무엇을 구하고 싶어하는거야?"
        elseif rand == 6 then
            WeaponTalkText.text = "..평소에 다른 음식들은 잘만 먹으면서.
            햄스톤의 맛은 궁금해하지 않다니 신기하군."
        elseif rand == 7 then
            WeaponTalkText.text = "이름을 물어봐도, 딱히 이름 같은 거 없어.
            네가 정해 준다면 한번쯤 생각해보지."
        elseif rand == 8 then
            WeaponTalkText.text = "난 말이야, 세상에서 가장 강한 검이라고!
            나랑 함께하는 것을 늘 영광으로 생각해라. 하하-!"
        elseif rand == 9 then
            WeaponTalkText.text = "인간들이 부르는 노래는 꽤나 즐거운 기분이 들게 하는군.."
        end
    elseif HeartResult.width >= HeartGood and HeartResult.width < HeartVeryGood then
        if rand == 0 then
            WeaponTalkText.text = "..(기분 좋은 흥얼거림이 들려온다.)
            응? 나 부른 거냐?"
        elseif rand == 1 then
            WeaponTalkText.text = "\N! 햄스톤! 햄스톤이 필요해!
            ..왜 그렇게 급박하게 부르냐고?
            햄스톤이 필요하다니까!"
        elseif rand == 2 then
            WeaponTalkText.text = "\N! 나도 이제 노래를 부를 줄 안다고. 들어볼테냐?
            (불협화음의 노랫소리가 들려온다.)"
        elseif rand == 3 then
            WeaponTalkText.text = "..내 목소리는 너한테만 들린다고.
            허공에 중얼중얼 거려봤자, 너만 미친 놈 취급 받는다?"
        elseif rand == 4 then
            WeaponTalkText.text = "가끔은 네가 내 주인이라는 사실이 마음에 들어."
        elseif rand == 5 then
            WeaponTalkText.text = "슈퍼 햄스톤.. 정말 짜릿한 환상의 맛이었지.
            더 준다면 마다하지 않겠어."
        elseif rand == 6 then
            WeaponTalkText.text = "이제야 너와 제대로 공명하는 기분이야."
        elseif rand == 7 then
            WeaponTalkText.text = "내게 얼굴이 있다면.. 꽤나 미남이었을 것 같은데.
            도대체가 난 모자란 부분이 없군."
        elseif rand == 8 then
            WeaponTalkText.text = "마음에 안 들면, 베어 버리면 돼.
            내가 같이 있으니 아무런 걱정 없어."
        elseif rand == 9 then
            WeaponTalkText.text = "누군가와 함께 있을 때도 즐겁다는 기분이 들다니.."
        end
    elseif HeartResult.width >= HeartVeryGood then
        if rand == 0 then
            WeaponTalkText.text = "만일 나에게도 친구라는 게 있다면..
            그건 아마 네가 아닐까 생각이 드는군."
        elseif rand == 1 then
            WeaponTalkText.text = "가끔 내게도 실체가 있었다면..
            너와 좀 더 즐거운 경험을 쌓았을지도 모르겠어.
            ..웃고, 떠들고, 마시고, 취하고 하는 것들 말이야."
        elseif rand == 2 then
            WeaponTalkText.text = "내가 강하기 때문에 너를 지킬 수 있다는 사실이 만족스러워."
        elseif rand == 3 then
            WeaponTalkText.text = "\N, 최선을 다해서 너를 돕겠다."
        elseif rand == 4 then
            WeaponTalkText.text = "..다 좋은데 말이지. 햄스톤만 있으면 딱일 텐데 말이야.
            뭐, 안 준다고 해서 도망가지는 않을 테니 걱정 말라구."
        elseif rand == 5 then
            WeaponTalkText.text = "\N! 오늘은 어디로 떠나는 거냐? 이 몸이 함께 해주지."
        elseif rand == 6 then
            WeaponTalkText.text = "..나보다 저 희승이란 놈을 더 따르는건 아니지?"
        elseif rand == 7 then
            WeaponTalkText.text = "너, 보면 볼수록 괜찮은 놈 같단 말이지."
        elseif rand == 8 then
            WeaponTalkText.text = "'나'라는 자아를 만든 게 누구냐고? 대장장이 신, 그리고 DK.. 이렇게 알고 있어.
            자세한 건 나도 몰라. 뭐, 고마워 해야 하겠지."
        elseif rand == 9 then
            WeaponTalkText.text = "지금까지도, 앞으로도 내 주인은 너 하나 뿐이야."
        end
    end

end

-- 무기의 조언 얻기
function AdviceByWeapon()
    local rand = math.random(TalkRandMin, AdviceRandMax)

    if HeartResult.width < HeartBad then
        if rand == 0 then
            WeaponTalkText.text = "좀 더 갈고 닦으세요."
        elseif rand == 1 then
            WeaponTalkText.text = "나를 원한다면 좀 더 성의를 보이세요."
        elseif rand == 2 then
            WeaponTalkText.text = ""
        elseif rand == 3 then
            WeaponTalkText.text = ""
        elseif rand == 4 then
            WeaponTalkText.text = ""
        end
    elseif HeartResult.width >= HeartBad and HeartResult.width < HeartNormal then
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
    -- print("햄스톤 개수 표시 완료")
end
Client.GetTopic("ReplyServerHamstones").Add(HamstoneNumber)

-- 버튼 입력 처리
function GiftToWeapon(n)
    -- print("햄스톤 시퀀스 작동 개시")
    -- 서버에게 요청
    Client.FireEvent("GiftToWeapon", n)
end

-- 무기에게 선물 줄 때마다 대사 바꾸기
local GiftWeaponFeedback = function()
    local rand = math.random(TalkRandMin, FeedbackRandMax)
    if rand == 0 then
        WeaponTalkText.text = "(...허겁지겁 햄스톤을 먹는 소리가 들려온다.)"
    elseif rand == 1 then
        WeaponTalkText.text = "...먹는 데 품위따위 지키는 건 사치라고."
    elseif rand == 2 then
        WeaponTalkText.text = "더 없냐? 더? 더?"
    elseif rand == 3 then
        WeaponTalkText.text = "햄스톤.. 신이 만든 최고의 창조물이야."
    elseif rand == 4 then
        WeaponTalkText.text = "완벽해. 완벽한 맛이야."
    elseif rand == 5 then
        WeaponTalkText.text = "크으.. 온 몸에 퍼지는 햄스톤의 풍부한 향이라니.."
    elseif rand == 6 then
        WeaponTalkText.text = "...슈퍼 햄스톤...그게 제일 좋아."
    elseif rand == 7 then
        WeaponTalkText.text = "백 개라도, 천 개라도 먹을 수 있어."
    elseif rand == 8 then
        WeaponTalkText.text = "한 입 먹어볼 거냐? ..싫으면 됐고."
    elseif rand == 9 then
        WeaponTalkText.text = "햄스톤의 멋짐을 모르는 네 놈이 불쌍하군."

    end

    -- if HeartResult.width < HeartBad then
    --     if rand == 0 then
    --         WeaponTalkText.text = "아직 멀었어요."
    --     elseif rand == 1 then
    --         WeaponTalkText.text = "더 좋은 건 없나요?"
    --     elseif rand == 2 then
    --         WeaponTalkText.text = "나름대로 노력하시나 보네요."
    --     elseif rand == 3 then
    --         WeaponTalkText.text = "칭찬은 해 드리죠."
    --     elseif rand == 4 then
    --         WeaponTalkText.text = "받아는 드리죠."
    --     end
    -- elseif HeartResult.width >= HeartBad and HeartResult.width < HeartNormal then
    --     if rand == 0 then
    --         WeaponTalkText.text = ""
    --     elseif rand == 1 then
    --         WeaponTalkText.text = ""
    --     elseif rand == 2 then
    --         WeaponTalkText.text = ""
    --     elseif rand == 3 then
    --         WeaponTalkText.text = ""
    --     elseif rand == 4 then
    --         WeaponTalkText.text = ""
    --     end
    -- elseif HeartResult.width >= HeartNormal and HeartResult.width < HeartGood then
    --     if rand == 0 then
    --         WeaponTalkText.text = ""
    --     elseif rand == 1 then
    --         WeaponTalkText.text = ""
    --     elseif rand == 2 then
    --         WeaponTalkText.text = ""
    --     elseif rand == 3 then
    --         WeaponTalkText.text = ""
    --     elseif rand == 4 then
    --         WeaponTalkText.text = ""
    --     end
    -- elseif HeartResult.width >= HeartGood and HeartResult.width < HeartVeryGood then
    --     if rand == 0 then
    --         WeaponTalkText.text = ""
    --     elseif rand == 1 then
    --         WeaponTalkText.text = ""
    --     elseif rand == 2 then
    --         WeaponTalkText.text = ""
    --     elseif rand == 3 then
    --         WeaponTalkText.text = ""
    --     elseif rand == 4 then
    --         WeaponTalkText.text = ""
    --     end
    -- elseif HeartResult.width >= HeartVeryGood then
    --     if rand == 0 then
    --         WeaponTalkText.text = ""
    --     elseif rand == 1 then
    --         WeaponTalkText.text = ""
    --     elseif rand == 2 then
    --         WeaponTalkText.text = ""
    --     elseif rand == 3 then
    --         WeaponTalkText.text = ""
    --     elseif rand == 4 then
    --         WeaponTalkText.text = ""
    --     end
    -- end
    GiftUIOff()
end
Client.GetTopic("GiftWeaponFeedback").Add(GiftWeaponFeedback)

--====================================================
-- 강화 시스템

-- 강화 UI 열기
function ReinforceUIOpen()
    -- 강화 관련 정보 요청
    -- print("강화 UI 오픈 요청합니다")
    ReinforceUI.visible = true
    Client.FireEvent("ReinforceUIOpen")
end
-- 새로고침
local ReplyServerReinforceUI = function(MStones, ReinLevel, ReinforceSucRate)
    -- print("강화 UI 새로고침합니다")
    -- 강화 관련 정보 표시
    WeaponLevelText.text = ReinLevel
    MStoneText.text = MStones.."개"
    ReinLevelText.text = ReinLevel
    NextLevelText.text = ReinLevel + 1
    SuccessText.text = ReinforceSucRate.."%"
    FailText.text = 100 - ReinforceSucRate.."%"
end
Client.GetTopic("ReplyServerReinforceUI").Add(ReplyServerReinforceUI)


-- 닫기
function ReinforceUIClose()
    ReinforceUI.visible = false
    -- Client.GetTopic("ReplyServerReinforceUI").Remove(ReplyServerReinforceUI)
    -- print("강화 UI 종료합니다")
end

-- -- 강화 요청
function StartReinforce()
    -- print("강화 실행 요청합니다")
    Client.FireEvent("StartReinforce")
    -- Client.GetTopic("ReplyServerReinforceUI").Remove(ReplyServerReinforceUI)
end

