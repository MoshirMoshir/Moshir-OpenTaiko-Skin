--func:DrawText(x, y, text)
--func:DrawNum(x, y, num)
--func:AddGraph("filename")
--func:DrawGraph(x, y, filename)
--func:DrawRectGraph(x, y, rect_x, rect_y, rect_width, rect_height, filename)
--func:DrawGraphCenter(x, y, filename)
--func:DrawGraphRectCenter(x, y, rect_x, rect_y, rect_width, rect_height, filename)
--func:SetOpacity(opacity, "filename")
--func:SetRotation(angle, "fileName")
--func:SetScale(xscale, yscale, "filename")
--func:SetColor(r, g, b, "filename")

local x = 0
local y = { 0, 804 }
local width = 492
local animeCounter = 0
local animeCounter2 = 0
local animeValue2 = 0
local scroll_y = 0
local clearOpacity = { 0, 0 }

function clearIn(player)
end

function clearOut(player)
end

function init()
    for player = 1, playerCount do
        side = player
        if p1IsBlue then
            side = 2
        end
        func:AddGraph("1st_"..tostring(side).."P.png")
        func:AddGraph("2nd_"..tostring(side).."P.png")
        func:AddGraph("3rd_0_"..tostring(side).."P.png")
        
        for i = 0, 2 do
            func:AddGraph("3rd_1_"..tostring(i).."_"..tostring(side).."P.png")
            func:AddGraph("3rd_2_"..tostring(i).."_"..tostring(side).."P.png")
            func:AddGraph("3rd_2_"..tostring(i).."_Alt_"..tostring(side).."P.png")
            func:AddGraph("3rd_3_"..tostring(i).."_"..tostring(side).."P.png")
        end
    end
    func:AddGraph("1st_Clear.png")
    func:AddGraph("2nd_Clear.png")
    func:AddGraph("3rd_0_Clear.png")
    for i = 0, 2 do
        func:AddGraph("3rd_1_"..tostring(i).."_Clear.png")
        func:AddGraph("3rd_2_"..tostring(i).."_Clear.png")
        func:AddGraph("3rd_2_"..tostring(i).."_Alt_Clear.png")
        func:AddGraph("3rd_3_"..tostring(i).."_Clear.png")
    end
end

function update()
    x = x - (90 * deltaTime)
    if x < -width * 3 then 
        x = 0
    end

    animeCounter = animeCounter + (0.85 * deltaTime)
    animeCounter = animeCounter % 2
    if animeCounter < 1 then 
        scroll_y = animeCounter
    else 
        scroll_y = 2.0 - animeCounter
    end

    animeCounter2 = animeCounter2 + (0.45 * deltaTime)
    animeCounter2 = animeCounter2 % 2
    if animeCounter2 < 1 then 
        animeValue2 = animeCounter2
    else 
        animeValue2 = math.max(1.5 - animeCounter2, 0)
    end


    for player = 1, playerCount do
        if isClear[player - 1] then 
            clearOpacity[player] = math.min(clearOpacity[player] + (1000 * deltaTime), 255)
        else 
            clearOpacity[player] = math.max(clearOpacity[player] - (1000 * deltaTime), 0)
        end
    end
end

function draw()
    for player = 1, playerCount do
        side = player
        if p1IsBlue then
            side = 2
        end
        
        for i = 0, 15 do
            y_1st = y[player]
            y_2nd = y[player] - 26 + (scroll_y * 20)
            y_3rd = y[player] - 26 + (scroll_y * 15)
            
            move_3rd = 0
            move_3rd_r = 0
            if animeCounter2 < 1 then
                move_3rd = math.min(animeValue2 * 10, 1) * 150
                move_3rd_r = (1.0 - math.min(animeValue2 * 4, 1)) * 150
            else
                move_3rd = math.min(animeValue2 * 10, 1) * 150
                move_3rd_r = (1.0 - math.min(animeValue2 * 5, 1)) * 150
            end

            func:DrawGraph(x + (width * i), y_1st, "1st_"..tostring(side).."P.png")
            func:DrawGraph(x + (width * i), y_2nd, "2nd_"..tostring(side).."P.png")

            if move_3rd_r == 150 then 
                func:DrawGraph(x + (width * i), y_3rd, "3rd_0_"..tostring(side).."P.png")
            else 
                if i % 3 == 0 then
                    if move_3rd_r <= 120 then 
                        func:DrawGraph(x + (width * i) - move_3rd_r, y_3rd, "3rd_1_2_"..tostring(side).."P.png")
                    end

                    if move_3rd <= 80 then 
                        func:DrawGraph(x + (width * i) - move_3rd, y_3rd, "3rd_1_1_"..tostring(side).."P.png")
                    end

                    func:DrawGraph(x + (width * i), y_3rd, "3rd_1_0_"..tostring(side).."P.png")
                elseif i % 3 == 1 then
                    if move_3rd_r <= 80 then 
                        func:DrawGraph(x + (width * i), y_3rd + move_3rd_r, "3rd_2_2_"..tostring(side).."P.png")
                    elseif move_3rd_r <= 120 then 
                        func:DrawGraph(x + (width * i), y_3rd + move_3rd_r, "3rd_2_2_Alt_"..tostring(side).."P.png")
                    end

                    if move_3rd <= 80 then 
                        func:DrawGraph(x + (width * i), y_3rd + move_3rd, "3rd_2_1_"..tostring(side).."P.png")
                    end

                    func:DrawGraph(x + (width * i), y_3rd, "3rd_2_0_"..tostring(side).."P.png")
                elseif i % 3 == 2 then
                    if move_3rd_r <= 120 then 
                        func:DrawGraph(x + (width * i) + move_3rd_r, y_3rd, "3rd_3_2_"..tostring(side).."P.png")
                    end

                    if move_3rd <= 80 then 
                        func:DrawGraph(x + (width * i) + move_3rd, y_3rd, "3rd_3_1_"..tostring(side).."P.png")
                    end

                    func:DrawGraph(x + (width * i), y_3rd, "3rd_3_0_"..tostring(side).."P.png")
                end
            end


            func:SetOpacity(clearOpacity[player], "1st_Clear.png")
            func:DrawGraph(x + (width * i), y_1st, "1st_Clear.png")

            func:SetOpacity(clearOpacity[player], "2nd_Clear.png")
            func:DrawGraph(x + (width * i), y_2nd, "2nd_Clear.png")

            if move_3rd_r == 150 then 
                func:SetOpacity(clearOpacity[player], "3rd_0_Clear.png")
                func:DrawGraph(x + (width * i), y_3rd, "3rd_0_Clear.png")
            else 
                if i % 3 == 0 then
                    if move_3rd_r <= 120 then 
                        func:SetOpacity(clearOpacity[player], "3rd_1_2_Clear.png")
                        func:DrawGraph(x + (width * i) - move_3rd_r, y_3rd, "3rd_1_2_Clear.png")
                    end

                    if move_3rd <= 80 then 
                        func:SetOpacity(clearOpacity[player], "3rd_1_1_Clear.png")
                        func:DrawGraph(x + (width * i) - move_3rd, y_3rd, "3rd_1_1_Clear.png")
                    end

                    func:SetOpacity(clearOpacity[player], "3rd_1_0_Clear.png")
                    func:DrawGraph(x + (width * i), y_3rd, "3rd_1_0_Clear.png")
                elseif i % 3 == 1 then
                    if move_3rd_r <= 80 then 
                        func:SetOpacity(clearOpacity[player], "3rd_2_2_Clear.png")
                        func:DrawGraph(x + (width * i), y_3rd + move_3rd_r, "3rd_2_2_Clear.png")
                    elseif move_3rd_r <= 120 then 
                        func:SetOpacity(clearOpacity[player], "3rd_2_2_Alt_Clear.png")
                        func:DrawGraph(x + (width * i), y_3rd + move_3rd_r, "3rd_2_2_Alt_Clear.png")
                    end

                    if move_3rd <= 80 then 
                        func:SetOpacity(clearOpacity[player], "3rd_2_1_Clear.png")
                        func:DrawGraph(x + (width * i), y_3rd + move_3rd, "3rd_2_1_Clear.png")
                    end

                    func:SetOpacity(clearOpacity[player], "3rd_2_0_Clear.png")
                    func:DrawGraph(x + (width * i), y_3rd, "3rd_2_0_Clear.png")
                elseif i % 3 == 2 then
                    if move_3rd_r <= 120 then 
                        func:SetOpacity(clearOpacity[player], "3rd_3_2_Clear.png")
                        func:DrawGraph(x + (width * i) + move_3rd_r, y_3rd, "3rd_3_2_Clear.png")
                    end

                    if move_3rd <= 80 then 
                        func:SetOpacity(clearOpacity[player], "3rd_3_1_Clear.png")
                        func:DrawGraph(x + (width * i) + move_3rd, y_3rd, "3rd_3_1_Clear.png")
                    end

                    func:SetOpacity(clearOpacity[player], "3rd_3_0_Clear.png")
                    func:DrawGraph(x + (width * i), y_3rd, "3rd_3_0_Clear.png")
                end
            end
        end
    end
end
