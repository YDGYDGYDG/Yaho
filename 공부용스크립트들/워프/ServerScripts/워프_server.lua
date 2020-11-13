local map = {mapID = {}, x = {}, y = {}}

map.mapID[1] = 1
map.x[1] = 19
map.y[1] = 17

map.mapID[2] = 2
map.x[2] = 6
map.y[2] = 4

map.mapID[3] = 3
map.x[3] = 6
map.y[3] = 4

map.mapID[4] = 4
map.x[4] = 6
map.y[4] = 4

map.mapID[5] = 5
map.x[5] = 6
map.y[5] = 4

map.mapID[6] = 6
map.x[6] = 6
map.y[6] = 4

map.mapID[7] = 7
map.x[7] = 6
map.y[7] = 4

map.mapID[8] = 8
map.x[8] = 6
map.y[8] = 4

map.mapID[9] = 9
map.x[9] = 6
map.y[9] = 4

map.mapID[10] = 10
map.x[10] = 6
map.y[10] = 4

map.mapID[11] = 11
map.x[11] = 6
map.y[11] = 4

map.mapID[12] = 12
map.x[12] = 6
map.y[12] = 4

map.mapID[13] = 13
map.x[13] = 6
map.y[13] = 4

map.mapID[14] = 14
map.x[14] = 6
map.y[14] = 4

map.mapID[15] = 15
map.x[15] = 6
map.y[15] = 4

map.mapID[16] = 16
map.x[16] = 6
map.y[16] = 4

map.mapID[17] = 17
map.x[17] = 6
map.y[17] = 4

map.mapID[18] = 18
map.x[18] = 6
map.y[18] = 4

map.mapID[19] = 19
map.x[19] = 6
map.y[19] = 4

map.mapID[20] = 20
map.x[20] = 6
map.y[20] = 4

map.mapID[21] = 21
map.x[21] = 6
map.y[21] = 4

map.mapID[22] = 22
map.x[22] = 6
map.y[22] = 4

map.mapID[23] = 23
map.x[23] = 6
map.y[23] = 4

map.mapID[24] = 24
map.x[24] = 6
map.y[24] = 4

map.mapID[25] = 25
map.x[25] = 6
map.y[25] = 4

map.mapID[26] = 31
map.x[26] = 6
map.y[26] = 4

map.mapID[27] = 33
map.x[27] = 6
map.y[27] = 4

map.mapID[28] = 65
map.x[28] = 6
map.y[28] = 4

Server.GetTopic("Y_warpPost").Add(function(text)
	unit.SpawnAtFieldID(map.mapID[text], map.x[text]*32, map.y[text]*-32)
end)
