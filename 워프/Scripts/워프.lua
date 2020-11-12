
local map = {name = {}, explain = {}, image = {}}
map.name[1] = "마을이동"
map.explain[1] = ""
map.image[1] = "Pictures/dungeon_0.png"

map.name[2] = "던전1"
map.explain[2] = "권장 방어력 : 4"
map.image[2] = "Pictures/dungeon_1.png"

map.name[3] = "던전2"
map.explain[3] = "권장 방어력 : 33"
map.image[3] = "Pictures/dungeon_2.png"

map.name[4] = "던전3"
map.explain[4] = "권장 방어력 : 55"
map.image[4] = "Pictures/dungeon_3.png"

map.name[5] = "던전4"
map.explain[5] = "권장 방어력 : 97"
map.image[5] = "Pictures/dungeon_4.png"

map.name[6] = "던전5"
map.explain[6] = "권장 방어력 : 180"
map.image[6] = "Pictures/dungeon_5.png"

map.name[7] = "던전6"
map.explain[7] = "권장 방어력 : 237"
map.image[7] = "Pictures/dungeon_6.png"

map.name[8] = "던전7"
map.explain[8] = "권장 방어력 : 290"
map.image[8] = "Pictures/dungeon_7.png"

map.name[9] = "던전8"
map.explain[9] = "권장 방어력 : 347"
map.image[9] = "Pictures/dungeon_8.png"

map.name[10] = "던전9"
map.explain[10] = "권장 방어력 : 436"
map.image[10] = "Pictures/dungeon_9.png"

map.name[11] = "던전10"
map.explain[11] = "권장 방어력 : 509"
map.image[11] = "Pictures/dungeon_10.png"

map.name[12] = "던전11"
map.explain[12] = "권장 방어력 : 577"
map.image[12] = "Pictures/dungeon_11.png"

map.name[13] = "던전12"
map.explain[13] = "권장 방어력 : 644"
map.image[13] = "Pictures/dungeon_12.png"

map.name[14] = "던전13"
map.explain[14] = "권장 방어력 : 722"
map.image[14] = "Pictures/dungeon_13.png"

map.name[15] = "던전14"
map.explain[15] = "권장 방어력 : 886"
map.image[15] = "Pictures/dungeon_14.png"

map.name[16] = "던전15"
map.explain[16] = "권장 방어력 : 1040"
map.image[16] = "Pictures/dungeon_15.png"

map.name[17] = "던전16"
map.explain[17] = "권장 방어력 : 1175"
map.image[17] = "Pictures/dungeon_16.png"

map.name[18] = "던전17"
map.explain[18] = "권장 방어력 : 1369"
map.image[18] = "Pictures/dungeon_17.png"

map.name[19] = "던전18"
map.explain[19] = "권장 방어력 : 1509"
map.image[19] = "Pictures/dungeon_18.png"

map.name[20] = "던전19"
map.explain[20] = "권장 방어력 : 1624"
map.image[20] = "Pictures/dungeon_19.png"

map.name[21] = "던전20"
map.explain[21] = "권장 방어력 : 1745"
map.image[21] = "Pictures/dungeon_20.png"

map.name[22] = "던전21"
map.explain[22] = "권장 방어력 : 1856"
map.image[22] = "Pictures/dungeon_21.png"

map.name[23] = "던전22"
map.explain[23] = "권장 방어력 : 2064"
map.image[23] = "Pictures/dungeon_22.png"

map.name[24] = "던전23"
map.explain[24] = "권장 방어력 : 2228"
map.image[24] = "Pictures/dungeon_23.png"

map.name[25] = "던전24"
map.explain[25] = "권장 방어력 : 2300"
map.image[25] = "Pictures/dungeon_24.png"

map.name[26] = "초월 던전1"
map.explain[26] = "권장 방어력 : 2300\n권장 공격력 : 95,000"
map.image[26] = "Pictures/dungeon_25.png"

map.name[27] = "초월 던전2"
map.explain[27] = "권장 방어력 : 2530\n권장 공격력 : 110,000"
map.image[27] = "Pictures/dungeon_26.png"

map.name[28] = "초월 던전3"
map.explain[28] = "권장 방어력 : 2942\n권장 공격력 : 190,400"
map.image[28] = "Pictures/dungeon_27.png"

function warp_open()
	local mask = Panel(Rect(0, 0, Client.width, Client.height))
	mask.color = Color(0, 0, 0)
	mask.SetOpacity(145)
	mask.showOnTop = true

	local panel = Image("Pictures/warp_scroll_panel.png", Rect(Client.width/2-183, Client.height/2-225, 366, 450))

	local scroll = ScrollPanel(Rect(11, 51, 344, 386))
	scroll.SetOpacity(0)

	local board = Panel(Rect(0, 0, 344, (#map.name*95)+((#map.name-1)*6)))

	local list = {panel = {}, buttonImage = {}, button = {}, nameText = {}, explain = {}, image = {}}
	for i=1, #map.name do
		list.panel[i] = Image("Pictures/warp_panel.png", Rect(0, ((i-1)*95)+((i-1)*6), 344, 95))
		board.AddChild(list.panel[i])

		list.nameText[i] = Text(map.name[i], Rect(92, 11, 167, 18))
		list.nameText[i].color = Color(0, 0, 0)
		list.explain[i] = Text(map.explain[i], Rect(91, 34, 150, 47))
		list.explain[i].textSize = 12
		list.explain[i].color = Color(0, 0, 0)
		list.image[i] = Image(map.image[i], Rect(12, 13, 69, 69))
		list.buttonImage[i] = Image("Pictures/warpButton.png", Rect(242, 44, 94, 43))
		list.button[i] = Button("", Rect(242, 44, 94, 43))
		list.button[i].SetOpacity(0)
		list.button[i].onClick.Add(function()
			list.buttonImage[i].SetImage("Pictures/warpButton_press.png")
			Client.RunLater(function()
				list.buttonImage[i].SetImage("Pictures/warpButton.png")
				Client.FireEvent("Y_warpPost", i)
				mask.Destroy()
			end,0.1)
		end)
		list.panel[i].AddChild(list.nameText[i])
		list.panel[i].AddChild(list.explain[i])
		list.panel[i].AddChild(list.image[i])
		list.panel[i].AddChild(list.buttonImage[i])
		list.panel[i].AddChild(list.button[i])
	end

	scroll.content = board
	scroll.horizontal = false
	scroll.AddChild(board)

	local closeButton = Button("", Rect(366-23-6, 6, 23, 23))
	closeButton.AddChild(Image("Pictures/CloseButton.png", Rect(0, 0, 23, 23)))
	closeButton.SetOpacity(0)
	closeButton.onClick.Add(function()
		mask.Destroy()
	end)

	panel.AddChild(closeButton)
	panel.AddChild(scroll)
	mask.AddChild(panel)
end
