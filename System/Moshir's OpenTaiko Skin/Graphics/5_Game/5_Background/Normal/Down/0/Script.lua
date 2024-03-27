

local light_counter = 0

local light_opacity = 0
local clear_back_opacity = 0
local clear_back_x = 0
local clear_header_y = 0
local clear_footer_y = 0
local clear_scroll_up_x = 0
local clear_scroll_down_x = 0
local clear_scroll_up_y = 0
local clear_scroll_down_y = 0
local clear_cloud_scroll_left_x = 0
local clear_cloud_scroll_right_x = 0
local clear_koma_red_y = 0
local clear_koma_left_y = 0
local clear_koma_right_y = 0
local clear_koma_counter = 0

local clearAnimeState = 0
local clearInCounter = 0
local debugCounter = 0

function clearIn(player)
    clearAnimeState = 1
    clearInCounter = 0
    clear_koma_counter = 0
end

function clearOut(player)
    clearAnimeState = 2
    clearInCounter = 0.45
end

function inAnime(value, in1)
    in_base = math.min(value * 5, 1)
    return -in1 + (in_base * in1)
end

function inAnimeBound(value, in1, in2)
    result = inAnime(value, in1)

    if result == 0 then
        in_base2 = math.min((value - 0.2) * 8, 1)
        if in_base2 < 0.75 then
            in_base2 = in_base2 * 1.5
        else
            in_base2 = 1 - ((in_base2 - 0.75) * 4)
        end
        in_base2 = in_base2 * in2

        result = result - in_base2
    end

    return result
end

function init()
    func:AddGraph("Base.png")
    func:AddGraph("Light.png")
    func:SetBlendMode("Add", "Light.png")
    
    func:AddGraph("Clear_Back.png")
    
    func:AddGraph("Clear_Cloud_Header.png")
    func:AddGraph("Clear_Cloud_Footer.png")
    
    func:AddGraph("Clear_Scroll_Up.png")
    func:AddGraph("Clear_Scroll_Down.png")

    func:AddGraph("Clear_Cloud_Scroll_Left.png")
    func:AddGraph("Clear_Cloud_Scroll_Right.png")
    
    func:AddGraph("Clear_Koma_Red.png")
    func:AddGraph("Clear_Koma_Left.png")
    func:AddGraph("Clear_Koma_Right.png")
end

function update()
    debugCounter = debugCounter + (1 * deltaTime)

    if debugCounter > 3 then

        if clearAnimeState == 0 then
            --clearIn(0)
        else
            --clearOut(0)
        end

        debugCounter = 0
    end


    light_counter = light_counter + (5 * deltaTime)
    if light_counter > 1 then 
        light_counter = 0
    end

    if light_counter < 0.5 then 
        light_opacity = light_counter * 2
    else 
        light_opacity = 1.0 - ((light_counter - 0.5) * 2)
    end
    light_opacity = (0.8 + (light_opacity / 5.0)) * 255

    if clearAnimeState == 0 then
        
    elseif clearAnimeState == 1 then 

        --clearInCounter = clearInCounter + (0.25 * deltaTime)
        clearInCounter = clearInCounter + (1 * deltaTime)
        
        in_base = math.min(clearInCounter * 5, 1)

        clear_back_opacity = math.min(clearInCounter * 1800, 255)
        clear_back_x = 0
        clear_header_y = inAnime(clearInCounter, 120)
        clear_footer_y = inAnime(clearInCounter, -120)
        clear_scroll_up_x = 0
        clear_scroll_down_x = 0
        clear_scroll_up_y = inAnimeBound(clearInCounter, 240, 25)
        clear_scroll_down_y = inAnimeBound(clearInCounter, -240, -25)

        clear_cloud_scroll_left_x = -960 + (math.min(clearInCounter * 3, 1) * 960)
        clear_cloud_scroll_right_x = 960 - (math.min(clearInCounter * 3, 1) * 960)

        clear_koma_red_y = inAnimeBound((clearInCounter * 1.5) - 0.23, -380, -25)
        clear_koma_right_y = inAnimeBound((clearInCounter * 1.5) - 0.33, 380, 25)
        clear_koma_left_y = inAnimeBound((clearInCounter * 1.5) - 0.33, -380, -25)

        if clearInCounter > 0.45 then 
            clearAnimeState = 3
        end

    elseif clearAnimeState == 2 then

        clearInCounter = clearInCounter - (1 * deltaTime)
        
        in_base = math.min(clearInCounter * 5, 1)

        clear_back_opacity = math.min(clearInCounter * 1800, 255)
        --clear_back_x = 0
        clear_header_y = inAnime(clearInCounter, 120)
        clear_footer_y = inAnime(clearInCounter, -120)
        --clear_scroll_up_x = 0
        --clear_scroll_down_x = 0
        clear_scroll_up_y = inAnimeBound(clearInCounter, 240, 25)
        clear_scroll_down_y = inAnimeBound(clearInCounter, -240, -25)

        clear_cloud_scroll_left_x = -960 + (math.min(clearInCounter * 3, 1) * 960)
        clear_cloud_scroll_right_x = 960 - (math.min(clearInCounter * 3, 1) * 960)

        clear_koma_red_y = inAnimeBound((clearInCounter * 1.5) - 0.23, -380, -25)
        clear_koma_right_y = inAnimeBound((clearInCounter * 1.5) - 0.33, 380, 25)
        clear_koma_left_y = inAnimeBound((clearInCounter * 1.5) - 0.33, -380, -25)

        if clearInCounter < 0 then 
            clearAnimeState = 0
        end

    elseif clearAnimeState == 3 then
        
        clear_back_opacity = 255

        clear_back_x = clear_back_x - (52 * deltaTime)
        if clear_back_x < -1920 then
            clear_back_x = 0 
        end
        
        clear_scroll_up_x = clear_scroll_up_x - (90 * deltaTime)
        if clear_scroll_up_x < -1920 then
            clear_scroll_up_x = 0 
        end
        clear_scroll_down_x = clear_scroll_down_x - (90 * deltaTime)
        if clear_scroll_down_x < -1920 then
            clear_scroll_down_x = 0 
        end

        clear_cloud_scroll_left_x = clear_cloud_scroll_left_x - (55 * deltaTime)
        if clear_cloud_scroll_left_x < -1920 then
            clear_cloud_scroll_left_x = 0 
        end
        clear_cloud_scroll_right_x = clear_cloud_scroll_right_x - (55 * deltaTime)
        if clear_cloud_scroll_right_x < -1920 then
            clear_cloud_scroll_right_x = 0 
        end

        clear_koma_counter = clear_koma_counter + (deltaTime * 0.9)
        if clear_koma_counter > 1 then
            clear_koma_counter = 0
        end

        komaValue = 0
        if clear_koma_counter < 0.75 then
            komaValue = (clear_koma_counter / 0.75)
        else 
            komaValue = (1 - ((clear_koma_counter - 0.75) * 4))
        end
        clear_koma_red_y = komaValue * -45
        clear_koma_left_y = komaValue * -45
        clear_koma_right_y = komaValue * -45

    end
end

function draw()
    func:DrawGraph(0, 540, "Base.png")

    func:SetOpacity(light_opacity, "Light.png")
    func:DrawGraph(0, 540, "Light.png")

    loopCount = 1
    if clearAnimeState == 1 or clearAnimeState == 2 then
        loopCount = 0
    end

    if clearAnimeState == 0 then--Normal

    else
        func:SetOpacity(clear_back_opacity, "Clear_Back.png")
        for i = 0 , loopCount do
            func:DrawGraph(clear_back_x + (1920 * i), 540, "Clear_Back.png")
        end

        func:SetOpacity(clear_back_opacity, "Clear_Cloud_Header.png")
        func:DrawGraph(0, 540 + clear_header_y, "Clear_Cloud_Header.png")
        func:SetOpacity(clear_back_opacity, "Clear_Cloud_Footer.png")
        func:DrawGraph(0, 540 + clear_footer_y, "Clear_Cloud_Footer.png")

        for i = 0 , loopCount do
            func:DrawGraph(clear_scroll_up_x + (1920 * i), 540 + clear_scroll_up_y, "Clear_Scroll_Up.png")
            func:DrawGraph(clear_scroll_down_x + (1920 * i), 540 + clear_scroll_down_y, "Clear_Scroll_Down.png")

            func:DrawGraph(clear_cloud_scroll_left_x + (1920 * i), 540, "Clear_Cloud_Scroll_Left.png")
            func:DrawGraph(clear_cloud_scroll_right_x + (1920 * i), 540, "Clear_Cloud_Scroll_Right.png")
        end

        func:DrawGraph(0, 540 + clear_koma_red_y, "Clear_Koma_Red.png")
        func:DrawGraph(0, 540 + clear_koma_left_y, "Clear_Koma_Left.png")
        if clear_koma_red_y < 180 then
            func:DrawGraph(0, 540 + clear_koma_right_y, "Clear_Koma_Right.png")
        end
    end
end
