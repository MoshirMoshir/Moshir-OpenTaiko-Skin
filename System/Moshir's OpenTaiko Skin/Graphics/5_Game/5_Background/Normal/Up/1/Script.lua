local loopWidth = 492
local loopHeight = 231

local bgScrollX = 0
local bgScrollX_3rd = 0
local bgScrollY = 0
local bgScrollY_3rd = 0
local bg3rdAnime = 0
local bgClearFade = { 0, 0 }
local bgChangeCount = 0

function drawUp1st(x, y, player)
    for i2 = -2, 1 do
        if player == 0 and p1IsBlue == false then
            func:DrawGraph(x, y + (loopHeight * i2) + bgScrollY, "1P_Up_1st.png")
            func:DrawGraph(x, y + (loopHeight * i2) + bgScrollY, "Clear_Up_1st.png")
        else
            func:DrawGraph(x, y + (loopHeight * i2) + bgScrollY, "2P_Up_1st.png")
            func:DrawGraph(x, y + (loopHeight * i2) + bgScrollY, "Clear_Up_1st.png")
        end
    end
end

function drawUp2nd(x, y, player)
    for i2 = -1, 2 do
        if player == 0 and p1IsBlue == false then
            func:DrawGraph(x, y + (loopHeight * i2) - bgScrollY, "1P_Up_2nd.png")
            func:DrawGraph(x, y + (loopHeight * i2) - bgScrollY, "Clear_Up_2nd.png")
        else
            func:DrawGraph(x, y + (loopHeight * i2) - bgScrollY, "2P_Up_2nd.png")
            func:DrawGraph(x, y + (loopHeight * i2) - bgScrollY, "Clear_Up_2nd.png")
        end
    end
end

function drawUp3rd(x, y, player)
    if player == 0 and p1IsBlue == false then
        func:DrawGraph(x - bgScrollX_3rd * 1.5, y - bgScrollY_3rd * 1.5, "1P_Up_3rd.png")
        func:DrawGraph(x - bgScrollX_3rd * 1.5, y - bgScrollY_3rd * 1.5, "Clear_Up_3rd.png")
    else
        func:DrawGraph(x - bgScrollX_3rd * 1.5, y - bgScrollY_3rd * 1.5, "2P_Up_3rd.png")
        func:DrawGraph(x - bgScrollX_3rd * 1.5, y - bgScrollY_3rd * 1.5, "Clear_Up_3rd.png")
    end
end

function drawUp4rd(x, y, player)
    if player == 0 and p1IsBlue == false then
        func:DrawGraph(x - bgScrollX_3rd * 1.5, y - bgScrollY_3rd * 1.5, "1P_Up_4rd.png")
        func:DrawGraph(x - bgScrollX_3rd * 1.5, y - bgScrollY_3rd * 1.5, "Clear_Up_4rd.png")
    else
        func:DrawGraph(x - bgScrollX_3rd * 1.5, y - bgScrollY_3rd * 1.5, "2P_Up_4rd.png")
        func:DrawGraph(x - bgScrollX_3rd * 1.5, y - bgScrollY_3rd * 1.5, "Clear_Up_4rd.png")
    end
end

function drawUp5rd(x, y, player)
    if player == 0 and p1IsBlue == false then
        func:DrawGraph(x - bgScrollX_3rd * 1.5, y - bgScrollY_3rd * 1.5, "1P_Up_5rd.png")
        func:DrawGraph(x - bgScrollX_3rd * 1.5, y - bgScrollY_3rd * 1.5, "Clear_Up_5rd.png")
    else
        func:DrawGraph(x - bgScrollX_3rd * 1.5, y - bgScrollY_3rd * 1.5, "2P_Up_5rd.png")
        func:DrawGraph(x - bgScrollX_3rd * 1.5, y - bgScrollY_3rd * 1.5, "Clear_Up_5rd.png")
    end
end

function drawUp6rd(x, y, player)
    if player == 0 and p1IsBlue == false then
        func:DrawGraph(x - bgScrollX_3rd * 1.5, y - bgScrollY_3rd * 1.5, "1P_Up_6rd.png")
        func:DrawGraph(x - bgScrollX_3rd * 1.5, y - bgScrollY_3rd * 1.5, "Clear_Up_6rd.png")
    else
        func:DrawGraph(x - bgScrollX_3rd * 1.5, y - bgScrollY_3rd * 1.5, "2P_Up_6rd.png")
        func:DrawGraph(x - bgScrollX_3rd * 1.5, y - bgScrollY_3rd * 1.5, "Clear_Up_6rd.png")
    end
end

function clearIn(player)
end

function clearOut(player)
end

function init()
    func:AddGraph("1P_Up_1st.png")
    func:AddGraph("2P_Up_1st.png")
    func:AddGraph("1P_Up_2nd.png")
    func:AddGraph("2P_Up_2nd.png")
    func:AddGraph("1P_Up_3rd.png")
    func:AddGraph("2P_Up_3rd.png")
    func:AddGraph("1P_Up_4rd.png")
    func:AddGraph("2P_Up_4rd.png")
    func:AddGraph("1P_Up_5rd.png")
    func:AddGraph("2P_Up_5rd.png")
    func:AddGraph("1P_Up_6rd.png")
    func:AddGraph("2P_Up_6rd.png")
    
    func:AddGraph("Clear_Up_1st.png")
    func:AddGraph("Clear_Up_2nd.png")
    func:AddGraph("Clear_Up_3rd.png")
    func:AddGraph("Clear_Up_4rd.png")
    func:AddGraph("Clear_Up_5rd.png")
    func:AddGraph("Clear_Up_6rd.png")
end

function update()
    bgScrollX = bgScrollX - (90 * deltaTime)
    bgScrollY = bgScrollY + (14 * deltaTime)
    bg3rdAnime = bg3rdAnime + (300 * deltaTime)

    for player = 0, playerCount - 1 do
        if isClear[player] then
            bgClearFade[player + 1] = bgClearFade[player + 1] + (2000 * deltaTime)
        else
            bgClearFade[player + 1] = bgClearFade[player + 1] - (2000 * deltaTime)
        end
    
        if bgClearFade[player + 1] > 255 then
            bgClearFade[player + 1] = 255
        end
        if bgClearFade[player + 1] < 0 then
            bgClearFade[player + 1] = 0
        end
    end

    if bgScrollX < -loopWidth then
        bgScrollX = 0
    end
    if bgScrollY > loopHeight then
        bgScrollY = 0
    end
    if bg3rdAnime > 600 then
        bg3rdAnime = 0
        bgChangeCount = (bgChangeCount + 1) % 4
    end

    if bg3rdAnime < 270 then
        bgScrollX_3rd = bg3rdAnime * 0.9258
        bgScrollY_3rd = math.sin(bg3rdAnime * (math.pi / 270.0)) * 40.0
    else
        bgScrollX_3rd = 250 + (bg3rdAnime - 270) * 0.24
        if bg3rdAnime < 490 then
            bgScrollY_3rd = -math.sin((bg3rdAnime - 270) * (math.pi / 170.0)) * 15.0
        else
            bgScrollY_3rd = -(math.sin(220 * (math.pi / 170.0)) * 15.0) + (((bg3rdAnime - 490) / 110) * (math.sin(220 * (math.pi / 170)) * 15.0))
        end
    end
end


function draw()
    for player = 0, playerCount - 1 do
    
        func:SetOpacity(bgClearFade[player + 1], "Clear_Up_1st.png")
        func:SetOpacity(bgClearFade[player + 1], "Clear_Up_2nd.png")
        func:SetOpacity(bgClearFade[player + 1], "Clear_Up_3rd.png")
        func:SetOpacity(bgClearFade[player + 1], "Clear_Up_4rd.png")
        func:SetOpacity(bgClearFade[player + 1], "Clear_Up_5rd.png")
        func:SetOpacity(bgClearFade[player + 1], "Clear_Up_6rd.png")
        
        y = 0
        if player == 1 then
            y = 804
        end
        for i = 0, 5 do
            drawUp1st(bgScrollX + (loopWidth * i), y, player)
            drawUp2nd(bgScrollX + (loopWidth * i), y, player)
        end
        for i = 0, 5 do
            index = (i + bgChangeCount) % 4
            if index == 0 then
                drawUp3rd((loopWidth * i), y, player)
            elseif index == 1 then
                drawUp4rd((loopWidth * i), y, player)
            elseif index == 2 then
                drawUp5rd((loopWidth * i), y, player)
            elseif index == 3 then
                drawUp6rd((loopWidth * i), y, player)
            end
        end
    end
end
