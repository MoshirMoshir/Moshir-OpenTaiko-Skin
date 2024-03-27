--func:DrawText(x, y, text)
--func:DrawNum(x, y, num)
--func:AddGraph("filename")
--func:DrawGraph(x, y, filename)
--func:DrawRectGraph(x, y, rect_x, rect_y, rect_width, rect_height, filename)
--func:SetOpacity(opacity, "filename")
--func:SetScale(xscale, yscale, "filename")
--func:SetColor(r, g, b, "filename")


local x = { 499, 499, 499, 499, 499 }
local y = { 0, 0, 0, 0, 0 }

local animeCounter = { 0, 0, 0, 0, 0 }
local speed = 1
local chara_states = { 0, 0, 0, 0, 0 }
local charaAnimeValue = { 0, 0, 0, 0, 0 }
local starAnimeValue = { 0, 0, 0, 0, 0 }

local left_origin_offset_x = 544
local left_origin_offset_y = -21
local right_origin_offset_x = 592
local right_origin_offset_y = -21
local chara_clear_move = 313

local clear_text_offset_x = 373
local clear_text_offset_y = -3

function drawClearText(text_x, text_y, value, name)
    scale = 1.0 + (math.sin(math.min(value, 1) * math.pi) / 5.0)

    func:SetOpacity(value * 255 * 2, name)
    func:SetScale(1.0, scale, name)
    func:DrawGraph(text_x, text_y - ((scale - 1.0) * 135), name)
end

function drawStar(star_x, star_y, value)
    if value > 0 then
        opacity = 255 - (math.max(math.min((value / 0.16) - 1.0, 1), 0) * 255)
        scale = math.min(value / 0.16, 1)

        func:SetOpacity(opacity, "Star.png")
        func:SetScale(scale, scale, "Star.png")
        func:DrawGraphCenter(star_x, star_y, "Star.png")
    end
end


function clearIn(player)
end

function clearOut(player)
end

function playEndAnime(player)
    animeCounter = { 0, 0, 0, 0, 0 }
end

function init()

    chara_states = { 0, 0, 0, 0, 0 }
    charaAnimeValue = { 0, 0, 0, 0, 0 }

    if playerCount <= 2 then
        y = { 288, 552, 0, 0, 0 }
    elseif playerCount == 5 then
        y = { 58, 274, 490, 706, 922 }
    else
        y = { 69, 333, 597, 861, 0 }
    end

    func:AddGraph("Clear_Left_0.png")
    func:AddGraph("Clear_Left_1.png")
    func:AddGraph("Clear_Left_2.png")
    func:AddGraph("Clear_Left_3.png")
    func:AddGraph("Clear_Left_4.png")
    func:AddGraph("Clear_Left_5.png")

    func:AddGraph("Clear_Right_0.png")
    func:AddGraph("Clear_Right_1.png")
    func:AddGraph("Clear_Right_2.png")
    func:AddGraph("Clear_Right_3.png")
    func:AddGraph("Clear_Right_4.png")
    func:AddGraph("Clear_Right_5.png")


    func:AddGraph("Clear_Text.png")

    func:AddGraph("Star.png")
    
end

function update(player)
    pos = player + 1

    animeCounter[pos] = animeCounter[pos] + (speed * deltaTime)
    animeValue = animeCounter[pos]
    
    if animeValue < 0.20 then
        chara_states[pos] = 0
        charaAnimeValue[pos] = (animeValue - 0) / (0.20 - 0)
    elseif animeValue < 0.66 then
        chara_states[pos] = 1
        charaAnimeValue[pos] = (animeValue - 0.20) / (0.66 - 0.20)
    elseif animeValue < 0.76 then
        chara_states[pos] = 2
        charaAnimeValue[pos] = (animeValue - 0.66) / (0.76 - 0.66)
    elseif animeValue < 0.83 then
        chara_states[pos] = 3
        charaAnimeValue[pos] = (animeValue - 0.76) / (0.83 - 0.76)
    elseif animeValue < 0.90 then
        chara_states[pos] = 4
        charaAnimeValue[pos] = (animeValue - 0.83) / (0.90 - 0.83)
    else
        chara_states[pos] = 5
        charaAnimeValue[pos] = 0
    end

    if animeCounter[pos] > 1.78 then
        starAnimeValue[pos] = starAnimeValue[pos] + (speed * deltaTime)
        if starAnimeValue[pos] > 1.57 then
            starAnimeValue[pos] = 0
        end
    end
end

function draw(player)
    pos = player + 1
    animeValue = animeCounter[pos]
    chara_value = charaAnimeValue[pos]

    origin_x = x[pos]
    origin_y = y[pos]

    left_x = origin_x + left_origin_offset_x
    left_y = origin_y + left_origin_offset_y

    right_x = origin_x + right_origin_offset_x
    right_y = origin_y + right_origin_offset_y
    
    if animeValue > 0.31 then
        if animeValue > 1.0 then
        else
            func:SetOpacity((((animeValue - 0.36) / 0.30)) * 255 * 2, "Clear_Text.png")
        end
        func:DrawGraph(origin_x + clear_text_offset_x, origin_y + clear_text_offset_y, "Clear_Text.png")
    end

    if chara_states[pos] == 0 then
        chara_opacity = animeValue * 1500
        func:SetOpacity(chara_opacity, "Clear_Left_0.png")
        func:SetScale(1.0, 1.0, "Clear_Left_0.png")
        func:DrawGraph(left_x, left_y, "Clear_Left_0.png")

        func:SetOpacity(chara_opacity, "Clear_Right_0.png")
        func:SetScale(1.0, 1.0, "Clear_Right_0.png")
        func:DrawGraph(right_x, right_y, "Clear_Right_0.png")
    elseif chara_states[pos] == 1 then
        move_x = math.sin(math.sin(chara_value * math.pi / 2.0) * math.pi / 2.0) * chara_clear_move
        func:DrawGraph(left_x - move_x, left_y, "Clear_Left_1.png")
        func:SetScale(1.0, 1.0, "Clear_Left_1.png")

        func:DrawGraph(right_x + move_x, right_y, "Clear_Right_1.png")
        func:SetScale(1.0, 1.0, "Clear_Right_1.png")
    elseif chara_states[pos] == 2 then
        scale = 1.0 - (math.sin(chara_value * math.pi) / 20.0)
        func:SetScale(scale, 1.0, "Clear_Left_2.png")
        func:DrawGraph(left_x - chara_clear_move, left_y, "Clear_Left_2.png")

        func:SetScale(scale, 1.0, "Clear_Right_2.png")
        func:DrawGraph(right_x + chara_clear_move - ((scale - 1.0) * 270), right_y, "Clear_Right_2.png")
    elseif chara_states[pos] == 3 then
        func:SetScale(1.0, 1.0, "Clear_Left_3.png")
        func:DrawGraph(left_x - chara_clear_move, left_y, "Clear_Left_3.png")

        func:SetScale(1.0, 1.0, "Clear_Right_3.png")
        func:DrawGraph(right_x + chara_clear_move, right_y, "Clear_Right_3.png")
    elseif chara_states[pos] == 4 then
        func:SetScale(1.0, 1.0, "Clear_Left_4.png")
        func:DrawGraph(left_x - chara_clear_move, left_y, "Clear_Left_4.png")
        
        func:SetScale(1.0, 1.0, "Clear_Right_4.png")
        func:DrawGraph(right_x + chara_clear_move, right_y, "Clear_Right_4.png")
    elseif chara_states[pos] == 5 then
        func:SetScale(1.0, 1.0, "Clear_Left_5.png")
        func:DrawGraph(left_x - chara_clear_move, left_y, "Clear_Left_5.png")

        func:SetScale(1.0, 1.0, "Clear_Right_5.png")
        func:DrawGraph(right_x + chara_clear_move, right_y, "Clear_Right_5.png")
    end

    if animeValue > 1.78 then
        drawStar(origin_x + 709, origin_y + 24, starAnimeValue[pos])
        drawStar(origin_x + 893, origin_y + 24, starAnimeValue[pos] - 0.1)
        drawStar(origin_x + 526, origin_y + 24, starAnimeValue[pos] - 0.12)

        drawStar(origin_x + 590, origin_y + 169, starAnimeValue[pos] - 0.28)
        drawStar(origin_x + 948, origin_y + 148, starAnimeValue[pos] - 0.33)
        drawStar(origin_x + 466, origin_y + 143, starAnimeValue[pos] - 0.45)
        drawStar(origin_x + 815, origin_y + 170, starAnimeValue[pos] - 0.5)
    end
end
