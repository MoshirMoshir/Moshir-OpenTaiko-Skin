--func:DrawText(x, y, text)
--func:DrawNum(x, y, num)
--func:AddGraph("filename")
--func:DrawGraph(x, y, filename)
--func:DrawRectGraph(x, y, rect_x, rect_y, rect_width, rect_height, filename)
--func:SetOpacity(opacity, "filename")
--func:SetScale(xscale, yscale, "filename")
--func:SetColor(r, g, b, "filename")


local x = { 499, 499, 499, 499, 499 }
local y = { 315, 579, 0, 0, 0 }

local animeCounter = { 0, 0, 0, 0, 0 }



function clearIn(player)
end

function clearOut(player)
end

function playEndAnime(player)
    animeCounter = { 0, 0, 0, 0, 0 }
end

function init()

    if playerCount <= 2 then
        y = { 288, 552, 0, 0, 0 }
    elseif playerCount == 5 then
        y = { 58, 274, 490, 706, 922 }
    else
        y = { 69, 333, 597, 861, 0 }
    end

    func:AddGraph("Test.png")
    
end

function update(player)
    pos = player + 1

    animeCounter[pos] = animeCounter[pos] + (1 * deltaTime)
    
end

function draw(player)
    pos = player + 1
    
    xcenter = x[pos] + 710

    func:DrawGraph(x[pos], y[pos], "Test.png")

end
