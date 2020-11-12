--스크립트 초보라 쓸때없는 문장이 많습니다

--------------------------------------------------------------------------

--사용법 : 1. 서버스크립트와 클라이언트스크립트, pictures 폴더 안에있는 자료를 모두 게임파일 내로 이동시켜주세요
--          2. 데미지콜백은 하나만 사용가능함으로 다른 스크립트에서 데미지콜백을 사용중이라면 합쳐주세요
--          3. 패널 이름이 같은게 존재한다면 오류가 날수도 있습니다. 패널이름을 바꿔주세요. 스크립트를 하나하나 빼가면서 어떤 파일과 충돌인지 찾아보세요
--          4. 밑쪽에 설정을 마치시고 서버스크립트도 설정이 있습니다. 더..최대한 최적화를 위해 서버스크립트에서 추가로 설정합니다

---------------------------------------------------------------------------
--경고

--문제 발생 시 책임은 사용자에게 있습니다.

----------------------------------------------------------------------------
--설정

--첫타격후 체력바가 사라질시간(단위 : 초)

bt = 10

--몬스터의 체력 표시방법, 1 = 100/100(수치표시화) , 2 = 100%(백분율)

htp = 2

--체력 표시방법이 2번이라면 소수점 표기방법, -1=10단위절삭,0=소수점없음, 1=소수점 1자리, 2=소수점 2자리...(이런식으로 늘어납니다)

hts = 2

--몬스터 이름 글자 크기

nts = 18

--서버스크립트도 설정이 있습니다. 더..최대한 최적화를 위해 추가로 서버스크립트에서 설정합니다
----------------------------------------------------------------------------

function rug()

if bp == nil then

bp = Image("Pictures/hppenal.png", Rect(Client.width*0.30, Client.height*0.03, 250, 150))
bp.showOnTop = true

hpbar = Image("Pictures/hpbar5.png", Rect(bp.width*0.04, bp.height*0.44, 230, 17.5))
bp.AddChild(hpbar)

hpText = Text()
hpText.rect = Rect(bp.width*0.04, bp.height*0.44, 218, 17.5)
hpText.textAlign = 5
hpText.textSize = 12
hpText.text = "100%"
bp.AddChild(hpText)

bpw = bp.width*0.2
bph = bp.height*0.3


nn1Text = Text()
nn1Text.rect = Rect(bpw+1, bph+1, 150, 30)
nn1Text.textAlign = 4
nn1Text.color = Color(0,0,0)
nn1Text.textSize = nts
bp.AddChild(nn1Text)

nn2Text = Text()
nn2Text.rect = Rect(bpw+1, bph-1, 150, 30)
nn2Text.textAlign = 4
nn2Text.color = Color(0,0,0)
nn2Text.textSize = nts
bp.AddChild(nn2Text)

nn3Text = Text()
nn3Text.rect = Rect(bpw-1, bph-1, 150, 30)
nn3Text.textAlign = 4
nn3Text.color = Color(0,0,0)
nn3Text.textSize = nts
bp.AddChild(nn3Text)

nn4Text = Text()
nn4Text.rect = Rect(bpw-1, bph-1, 150, 30)
nn4Text.textAlign = 4
nn4Text.color = Color(0,0,0)
nn4Text.textSize = nts
bp.AddChild(nn4Text)

nnText = Text()
nnText.rect = Rect(bpw, bph, 150, 30)
nnText.textAlign = 4
nnText.textSize = nts
bp.AddChild(nnText)

ru()
Client.RunLater(ruu, bt)

else

ru()

end

end

Client.GetTopic("bh").Add(function(bha,bhha,bnna)
   bhb = bha
   bhhb = bhha
   bnnb = bnna
   rug()
end)

function ru()

if htp == 2 then

   local hpt = bhhb/bhb * 100
   hpt = hpt * (10 ^ hts)
   hpt = math.floor(hpt)
   hpt = hpt / (10 ^ hts)

  hpText.text = hpt .. "%"

else

   hpText.text = bhhb.."/"..bhb

end

   nnText.text =  bnnb
   nn1Text.text =  bnnb
   nn2Text.text =  bnnb
   nn3Text.text =  bnnb
   nn4Text.text =  bnnb

   hpbar.DOScale(Point(bhhb/bhb, 1), 0.5)

   if bhhb <= 0 then
ruu()
end
end

function ruu()

   bp.Destroy()
   hpText.Destroy()
   bp = nil

end