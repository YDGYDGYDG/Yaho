

local HPMP = Image("Pictures/HPMP.png", Rect(Client.width/2-104, Client.height-101, 207, 41))
local HUD = Image("Pictures/HUD.png", Rect(0, Client.height-48, 1200, 48))
local BAR_HP = Image("Pictures/BAR_HP.png", Rect(Client.width/2-60, Client.height-95, 146, 10))
local BAR_MP = Image("Pictures/BAR_MP.png", Rect(Client.width/2-60, Client.height-79, 146, 10))
local BAR_EXP = Image("Pictures/BAR_EXP.png", Rect(178, Client.height-16, 531, 10))

local LVTextOut1 = Text()
LVTextOut1.rect = Rect(9, Client.height-48+17, 122, 31)
LVTextOut1.textSize = 20
local LVTextOut2 = Text()
LVTextOut2.rect = Rect(9, Client.height-48+19, 122, 31)
LVTextOut2.textSize = 20
local LVTextOut3 = Text()
LVTextOut3.rect = Rect(11, Client.height-48+17, 122, 31)
LVTextOut3.textSize = 20
local LVTextOut4 = Text()
LVTextOut4.rect = Rect(11, Client.height-48+19, 122, 31)
LVTextOut4.textSize = 20
local LVText = Text()
LVText.rect = Rect(10, Client.height-48+18, 122, 31)
LVText.textSize = 20


local ManaStoneUI = Client.LoadPage("ManaStoneUI")
local ManaStoneText = ManaStoneUI.GetControl("ManaStoneText")

function refreshUI()
	ScreenUI.hpBarVisible  = false
	ScreenUI.mpBarVisible  = false
	ScreenUI.expBarVisible  = false
	ScreenUI.levelVisible = false
	ScreenUI.gameMoneyVisible = false
	
	LVText.text = "LV."..Client.myPlayerUnit.level
	LVTextOut1.text = "<color=#000000>LV."..Client.myPlayerUnit.level.."</color>"
	LVTextOut2.text = "<color=#000000>LV."..Client.myPlayerUnit.level.."</color>"
	LVTextOut3.text = "<color=#000000>LV."..Client.myPlayerUnit.level.."</color>"
	LVTextOut4.text = "<color=#000000>LV."..Client.myPlayerUnit.level.."</color>"

	BAR_HP.DOScale(Point(Client.myPlayerUnit.hp/Client.myPlayerUnit.maxHP, 1), 0.5)
	BAR_MP.DOScale(Point(Client.myPlayerUnit.mp/Client.myPlayerUnit.maxMP, 1), 0.5)
	BAR_EXP.DOScale(Point(Client.myPlayerUnit.exp/Client.myPlayerUnit.maxEXP, 1), 0.5)

	Client.FireEvent("CallServerMana")
end

Client.onTick.Add(refreshUI,1)

function HUDOff()
	HPMP.visible = false
	HUD.visible = false
	LVText.visible = false
	LVTextOut1.visible = false
	LVTextOut2.visible = false
	LVTextOut3.visible = false
	LVTextOut4.visible = false
	BAR_HP.visible = false
	BAR_MP.visible = false
	BAR_EXP.visible = false
end

function HUDOn()
	HPMP.visible = true
	HUD.visible = true
	LVText.visible = true
	LVTextOut1.visible = true
	LVTextOut2.visible = true
	LVTextOut3.visible = true
	LVTextOut4.visible = true
	BAR_HP.visible = true
	BAR_MP.visible = true
	BAR_EXP.visible = true
end

local ViewManaStoneText = function(num)
	-- print("클라 마석 적용 시작")
	ManaStoneText.text = num.." 마석"
	Client.GetTopic("ReplyServerManaStone").Remove(ViewManaStoneText)
	-- print("클라 마석 시퀀스 작동 완료")
end
Client.GetTopic("ReplyServerManaStone").Add(ViewManaStoneText)

