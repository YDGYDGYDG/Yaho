hpmpbg = Image("Pictures/hpmpbarbg.png", Rect(84, 7, 140, 30)) --hp mp 백그라운드
xpbg = Image("Pictures/xpbg.png", Rect(0, 470, Client.width, 10))  -- xp bg
hpbg = Image("Pictures/hpbg.png", Rect(0, 470, Client.width, 10))  -- hp bg
hpbar = Image("Pictures/hpbar.png", Rect(300, 10, 130, 10)) -- mp bar
mpbar = Image("Pictures/mpbar.png", Rect(89, 22, 130, 10))  -- hp bar
lvbar = Image("Pictures/lvbar.png", Rect(7, 7, 70, 30))  -- lv bar
xpbar = Image("Pictures/xpbar.png", Rect(0, 470, Client.width, 10))  -- xp bar

hpmpbg.showOnTop = true -- 기존 UI위에 덮어 씁니다.
xpbg.showOnTop = true
mpbar.showOnTop = true
hpbar.showOnTop = true
lvbar.showOnTop = true
xpbar.showOnTop = true
hptxt = Text("",Rect(110, 0, 100, 30))
hptxt.textSize = 12
mptxt = Text("",Rect(110, 13, 100, 30))
mptxt.textSize = 12
xptxt = Text("",Rect(Client.width/2-30, 460, 100, 30))
xptxt.textSize = 12
lvtxt = Text("",Rect(12, 6, 100, 30))
lvtxt.textSize = 20
hptxt.showOnTop = true
mptxt.showOnTop = true
xptxt.showOnTop = true
lvtxt.showOnTop = true
function Exps()
	maxhp = math.floor(Client.myPlayerUnit.hp / Client.myPlayerUnit.maxHP * 100) 
	maxmp = math.floor(Client.myPlayerUnit.mp / Client.myPlayerUnit.maxMP * 100)
	maxxp = math.floor(Client.myPlayerUnit.exp / Client.myPlayerUnit.maxEXP * 100)
	maxMhp = math.floor(Client.myPlayerUnit.exp / Client.myPlayerUnit.maxEXP * 100)
	Thp = 130 * maxhp / 100
	Tmp = 130 * maxmp / 100
	Txp = Client.width * maxxp / 100
	hpbar.rect = Rect(89, 10, Thp , 10)
	mpbar.rect = Rect(89, 22, Tmp , 10)
	xpbar.rect = Rect(0, 470, Txp, 10)
	lvtxt.rect = Rect(11, 6, 100, 30)
	hptxt.text = Client.myPlayerUnit.hp.." / "..Client.myPlayerUnit.maxHP
	mptxt.text = Client.myPlayerUnit.mp.." / "..Client.myPlayerUnit.maxMP
	xptxt.text = Client.myPlayerUnit.exp.." / "..Client.myPlayerUnit.maxEXP
	lvtxt.text = "<color=#FFBB00>Lv."..Client.myPlayerUnit.level.."</color>"
end

Client.onTick.Add(Exps,30)
