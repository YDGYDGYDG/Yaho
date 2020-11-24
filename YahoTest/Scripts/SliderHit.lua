-- 클라이언트 계산 생략
CWidthHalf = Client.width/2
CHeightHalf = Client.height/2

-- 랜덤 사용
math.randomseed(os.time())

--필요값 선언===============================
--속도
local WAY_Slider_Speed = 3
--슬라이더 최소 최대
local WAY_Slider_Min_Gauge = -150
local WAY_Slider_Max_Gauge = 150
--히트바 생성 인터벌
local WAY_Slider_Hitbar_MAX_Interval = 40
local WAY_Slider_Hitbar_MIN_Interval = 15
local WAY_Slider_Hitbar_Interval1 = 0
local WAY_Slider_Hitbar_Interval2 = 0
--각 히트바당 현재 게이지 저장용
local WAY_Slider_Hitbar1_Gauge = 0
local WAY_Slider_Hitbar2_Gauge = 0
local WAY_Slider_Hitbar3_Gauge = 0
-- 히트바 판정 기준값 (너비)
local WAY_Slider_Hitbar_Good_Criteria  = 12.5
local WAY_Slider_Hitbar_Bad_Criteria = 50
--각 히트바당 결과 P/G/B (2/1/0)
local WAY_Slider_Hitbar1_Result = 0
local WAY_Slider_Hitbar2_Result = 0
local WAY_Slider_Hitbar3_Result = 0
-- 히트바 판정 결과 배수
local WAY_Slider_Hitbar_Result_Bad = 0.5
local WAY_Slider_Hitbar_Result_Good = 0.7
local WAY_Slider_Hitbar_Result_Perfect = 1


--히트바 생성===============================
local WAY_Slider_Hitbar1 = Image("Pictures/Slider_Hitbar.png",Rect(WAY_Slider_Min_Gauge, 100, 10, 50))
local WAY_Slider_Hitbar2 = Image("Pictures/Slider_Hitbar.png",Rect(WAY_Slider_Min_Gauge, 100, 10, 50))
local WAY_Slider_Hitbar3 = Image("Pictures/Slider_Hitbar.png",Rect(WAY_Slider_Min_Gauge, 100, 10, 50))

WAY_Slider_Hitbar1.anchor = 4
WAY_Slider_Hitbar2.anchor = 4
WAY_Slider_Hitbar3.anchor = 4

WAY_Slider_Hitbar1.pivotX = 0.5
WAY_Slider_Hitbar1.pivotY = 0.5
WAY_Slider_Hitbar2.pivotX = 0.5
WAY_Slider_Hitbar2.pivotY = 0.5
WAY_Slider_Hitbar3.pivotX = 0.5
WAY_Slider_Hitbar3.pivotY = 0.5

WAY_Slider_Hitbar1.showOnTop = true
WAY_Slider_Hitbar2.showOnTop = true
WAY_Slider_Hitbar3.showOnTop = true

WAY_Slider_Hitbar1.visible = false
WAY_Slider_Hitbar2.visible = false
WAY_Slider_Hitbar3.visible = false

WAY_Slider_Hitbar1.enabled = false
WAY_Slider_Hitbar2.enabled = false
WAY_Slider_Hitbar3.enabled = false

--===============================

--판정 UI 생성
local WAY_Slider_Hitbar_Bad = Image("Pictures/Slider_Result_Bad.png",Rect(0, 60, 100, 30))
local WAY_Slider_Hitbar_Good = Image("Pictures/Slider_Result_Good.png",Rect(0, 60, 100, 30))
local WAY_Slider_Hitbar_Perfect = Image("Pictures/Slider_Result_Perfect.png",Rect(0, 60, 120, 45))

WAY_Slider_Hitbar_Bad.anchor = 4
WAY_Slider_Hitbar_Good.anchor = 4
WAY_Slider_Hitbar_Perfect.anchor = 4

WAY_Slider_Hitbar_Bad.pivotX = 0.5
WAY_Slider_Hitbar_Good.pivotX = 0.5
WAY_Slider_Hitbar_Perfect.pivotX = 0.5
WAY_Slider_Hitbar_Bad.pivotY = 0.5
WAY_Slider_Hitbar_Good.pivotY = 0.5
WAY_Slider_Hitbar_Perfect.pivotY = 0.5

WAY_Slider_Hitbar_Bad.showOnTop = true
WAY_Slider_Hitbar_Good.showOnTop = true
WAY_Slider_Hitbar_Perfect.showOnTop = true

WAY_Slider_Hitbar_Bad.visible = false
WAY_Slider_Hitbar_Good.visible = false
WAY_Slider_Hitbar_Perfect.visible = false

WAY_Slider_Hitbar_Bad.enabled = false
WAY_Slider_Hitbar_Good.enabled = false
WAY_Slider_Hitbar_Perfect.enabled = false

--판정 복사용
local UIresult = WAY_Slider_Hitbar_Bad
local ATKResult = 0

--페이드아웃
local UIresultFadeOut = 255

--===============================

--슬라이더가 돌고 있는 중인지 판단
local WAY_MovingHitbar_ON = false
--인터벌 카운트
local Func_MoveCount_Hitbar1 = 0
local Func_MoveCount_Hitbar2 = 0


--유저의 필살 발동으로 슬라이더 UI 표시하는 함수
function WAY_SliderHitOn()
    local Page = Client.LoadPage("SliderHit")

    --초기화
    WAY_Slider_Hitbar1.enabled = true
    WAY_Slider_Hitbar1.visible = true
    WAY_Slider_Hitbar2.enabled = true
    WAY_Slider_Hitbar2.visible = true
    WAY_Slider_Hitbar3.enabled = true
    WAY_Slider_Hitbar3.visible = true
    WAY_Slider_Hitbar_Interval1 = math.random(WAY_Slider_Hitbar_MIN_Interval, WAY_Slider_Hitbar_MAX_Interval)
    WAY_Slider_Hitbar_Interval2 = math.random(WAY_Slider_Hitbar_MIN_Interval, WAY_Slider_Hitbar_MAX_Interval)
    ATKResult = 0

    if WAY_MovingHitbar_ON == false then
        WAY_MovingHitbar_ON = true
        Client.onTick.Add(MovingHitbar,1)
    end

end


--히트바 움직이기
function MovingHitbar()
    --1번 간다
    if WAY_Slider_Hitbar1.x < WAY_Slider_Max_Gauge and WAY_Slider_Hitbar1.enabled == true then
        WAY_Slider_Hitbar1.x = WAY_Slider_Hitbar1.x + WAY_Slider_Speed
        Func_MoveCount_Hitbar1 = Func_MoveCount_Hitbar1 + 1
    end
    if WAY_Slider_Hitbar1.x >= WAY_Slider_Max_Gauge then
        WAY_Slider_Hitbar1.visible = false
        WAY_Slider_Hitbar1.enabled = false
        ATKResult = ATKResult + WAY_Slider_Hitbar_Result_Bad
        SliderHitResult(WAY_Slider_Hitbar1.x, 0)
    end
    --2번 간다
    if WAY_Slider_Hitbar2.x < WAY_Slider_Max_Gauge and Func_MoveCount_Hitbar1 >= WAY_Slider_Hitbar_Interval1 and WAY_Slider_Hitbar2.enabled == true then
        WAY_Slider_Hitbar2.x = WAY_Slider_Hitbar2.x + WAY_Slider_Speed
        Func_MoveCount_Hitbar2 = Func_MoveCount_Hitbar2 + 1
    end
    if WAY_Slider_Hitbar2.x >= WAY_Slider_Max_Gauge then
        WAY_Slider_Hitbar2.visible = false
        WAY_Slider_Hitbar2.enabled = false
        ATKResult = ATKResult + WAY_Slider_Hitbar_Result_Bad
        SliderHitResult(WAY_Slider_Hitbar2.x, 0)
    end
    --3번 간다
    if WAY_Slider_Hitbar3.x < WAY_Slider_Max_Gauge and Func_MoveCount_Hitbar2 >= WAY_Slider_Hitbar_Interval2 and WAY_Slider_Hitbar3.enabled == true then
        WAY_Slider_Hitbar3.x = WAY_Slider_Hitbar3.x + WAY_Slider_Speed
    end
    if WAY_Slider_Hitbar3.x >= WAY_Slider_Max_Gauge then
        WAY_Slider_Hitbar3.visible = false
        WAY_Slider_Hitbar3.enabled = false
        ATKResult = ATKResult + WAY_Slider_Hitbar_Result_Bad
        SliderHitResult(WAY_Slider_Hitbar3.x, 0)
        --초기화
        SliderUndertaker()
    end
end


--히트바 종료자
function SliderUndertaker()
    WAY_MovingHitbar_ON = false
    Func_MoveCount_Hitbar1 = 0
    Func_MoveCount_Hitbar2 = 0
    WAY_Slider_Hitbar1.x = WAY_Slider_Min_Gauge
    WAY_Slider_Hitbar2.x = WAY_Slider_Min_Gauge
    WAY_Slider_Hitbar3.x = WAY_Slider_Min_Gauge
    Client.onTick.Remove(MovingHitbar,1)
    Client.GetPage("SliderHit").Destroy()
    -- ATKResult를 서버에 보내기
    Client.FireEvent("SlliderHitResult", ATKResult)
    ATKResult = 0
end


--유저의 히트바 입력 처리
function HitTheBar()
    -- 슬라이더가 돌고 있는지 판단
    if WAY_MovingHitbar_ON == true then
        -- 1번이 켜져 있으면
        if WAY_Slider_Hitbar1.enabled == true then
            -- 1번 끄기
            WAY_Slider_Hitbar1.visible = false
            WAY_Slider_Hitbar1.enabled = false
            -- 1번 위치 저장하기
            WAY_Slider_Hitbar1_Gauge = WAY_Slider_Hitbar1.x
            WAY_Slider_Hitbar1_Gauge = math.abs(WAY_Slider_Hitbar1_Gauge)
            -- 1번 판정 저장하기
            if WAY_Slider_Hitbar1_Gauge > WAY_Slider_Hitbar_Bad_Criteria then
                WAY_Slider_Hitbar1_Result = 0
                ATKResult = ATKResult + WAY_Slider_Hitbar_Result_Bad
            elseif WAY_Slider_Hitbar1_Gauge > WAY_Slider_Hitbar_Good_Criteria and WAY_Slider_Hitbar1_Gauge <= WAY_Slider_Hitbar_Bad_Criteria then
                WAY_Slider_Hitbar1_Result = 1
                ATKResult = ATKResult + WAY_Slider_Hitbar_Result_Good
            else 
                ATKResult = ATKResult + WAY_Slider_Hitbar_Result_Perfect
                WAY_Slider_Hitbar1_Result = 2
            end
            SliderHitResult(WAY_Slider_Hitbar1.x, WAY_Slider_Hitbar1_Result)
        
        -- 아니면 1번이 꺼져 있고 2번이 켜져 있으면
        elseif WAY_Slider_Hitbar1.enabled == false and WAY_Slider_Hitbar2.enabled == true then
            -- 2번 끄기
            WAY_Slider_Hitbar2.visible = false
            WAY_Slider_Hitbar2.enabled = false
            -- 2번 위치 저장하기
            WAY_Slider_Hitbar2_Gauge = WAY_Slider_Hitbar2.x
            WAY_Slider_Hitbar2_Gauge = math.abs(WAY_Slider_Hitbar2_Gauge)
            -- 2번 판정 저장하기
            if WAY_Slider_Hitbar2_Gauge > WAY_Slider_Hitbar_Bad_Criteria then
                WAY_Slider_Hitbar2_Result = 0
                ATKResult = ATKResult + WAY_Slider_Hitbar_Result_Bad
            elseif WAY_Slider_Hitbar2_Gauge > WAY_Slider_Hitbar_Good_Criteria and WAY_Slider_Hitbar2_Gauge <= WAY_Slider_Hitbar_Bad_Criteria then
                WAY_Slider_Hitbar2_Result = 1
                ATKResult = ATKResult + WAY_Slider_Hitbar_Result_Good
            else 
                WAY_Slider_Hitbar2_Result = 2
                ATKResult = ATKResult + WAY_Slider_Hitbar_Result_Perfect
            end
            SliderHitResult(WAY_Slider_Hitbar2.x, WAY_Slider_Hitbar2_Result)

        -- 아니면 2번이 꺼져 있고 3번이 켜져 있으면
        elseif WAY_Slider_Hitbar2.enabled == false and WAY_Slider_Hitbar3.enabled == true then
            -- 3번 끄기
            WAY_Slider_Hitbar3.visible = false
            WAY_Slider_Hitbar3.enabled = false
            -- 3번 위치 저장하기
            WAY_Slider_Hitbar3_Gauge = WAY_Slider_Hitbar3.x
            WAY_Slider_Hitbar3_Gauge = math.abs(WAY_Slider_Hitbar3_Gauge)
            -- 3번 판정 저장하기
            if WAY_Slider_Hitbar3_Gauge > WAY_Slider_Hitbar_Bad_Criteria then
                WAY_Slider_Hitbar3_Result = 0
                ATKResult = ATKResult + WAY_Slider_Hitbar_Result_Bad
            elseif WAY_Slider_Hitbar3_Gauge > WAY_Slider_Hitbar_Good_Criteria and WAY_Slider_Hitbar3_Gauge <= WAY_Slider_Hitbar_Bad_Criteria then
                WAY_Slider_Hitbar3_Result = 1
                ATKResult = ATKResult + WAY_Slider_Hitbar_Result_Good
            else 
                WAY_Slider_Hitbar3_Result = 2
                ATKResult = ATKResult + WAY_Slider_Hitbar_Result_Perfect
            end
            SliderHitResult(WAY_Slider_Hitbar3.x, WAY_Slider_Hitbar3_Result)
            -- 슬라이더 히트 종료하기 
            SliderUndertaker()
        end
    end
end


--판정을 보여주는 UI : 히트 바 제거 시 발동!
function SliderHitResult(resultX, resultGauge)
    UIresultFadeOut = 255
    if resultGauge == 0 then
        UIresult.image = "Pictures/Slider_Result_Bad.png"
        UIresult.x = resultX
        UIresult.visible = true
    elseif resultGauge == 1 then
        UIresult.image = "Pictures/Slider_Result_Good.png"
        UIresult.visible = true
        UIresult.x = resultX
    else
        UIresult.image = "Pictures/Slider_Result_Perfect.png"
        UIresult.visible = true
        UIresult.x = resultX
    end
end

function SliderHitResultFadeOut()
    UIresultFadeOut = UIresultFadeOut - 2
    UIresult.SetOpacity(UIresultFadeOut)
end

Client.onTick.Add(SliderHitResultFadeOut)
