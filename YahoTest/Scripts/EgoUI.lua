
EgoUI = function()
    -- 기존 창 출력 및 닫기
    -- Client.GetPage("무기정보").GetControl("무기정보창패널").visible = not Client.GetPage("무기정보").GetControl("무기정보창패널").visible
    
    EgoUIClose = function()
        Client.GetPage("무기정보").Destroy()
        무공능력치.Destroy()
        무치확능력치.Destroy()
        무치배능력치.Destroy()
        잔스포.Destroy()
    end

    local weaponinfo = Client.LoadPage("무기정보")


    무공능력치 = Text()
    무공능력치.text = "안돼!"
    무공능력치.Rect(Client.width, Client.height, 60, 30)

    무치확능력치 = Text()
    무치확능력치.text = "안돼!"

    무치배능력치 = Text()
    무치배능력치.text = "안돼!"

    잔스포 = Text()
    잔스포.text = "안돼!"

end


-- Image("Pictures/itemCreate_panel.png", Rect(Client.width/2-309, 90, 618, 241)





--Client.GetPage("무기정보").GetControl("검이미지").visible = false
--Client.GetPage("무기정보").GetControl("창이미지").visible = false
--Client.GetPage("무기정보").GetControl("해머이미지").visible = false



--Client.GetTopic("무기이미지")
--    무기이미지.SetTargetSprite(Pictures.001_ewp_sword)
--end

-- 무기 이미지 ID
-- 001_ewp_sword
-- 031_ewp_spear
-- 061_ewp_hammer