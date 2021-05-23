-- blackout v0.0.1
--
-- blacken the grid using 
-- kernel toggling
--
-- ericmoderbacher

local UI = require "ui"
local g = grid.connect()

local SCREEN_FRAMERATE = 15
local screen_refresh_metro
local screen_dirty = true

local pages
local tabs

local slider_l
local slider_r

local board = include("lib/board")


function init()
  print("test 1")
  screen.aa(1) -- enables anti-aliasing (sorry but I forget what aa stands for)
  --setup main menu
  pages = UI.Pages.new(1, 3)
  tabs = UI.Tabs.new(1, {"s", "Start"})
  dial_l = UI.Dial.new(9, 19, 22, 25, 0, 100, 1)
  dial_r = UI.Dial.new(34.5, 34, 22, 0.3, -1, 1, 0.01, 0, {0})

  local g = grid.connect()
  board:construct(g)
  
    -- Start drawing to screen
  screen_refresh_metro = metro.init()
  screen_refresh_metro.event = function()
    if screen_dirty then
      screen_dirty = false
      redraw()
    end
  end
  screen_refresh_metro:start(1 / SCREEN_FRAMERATE)
end


-- Redraw
function redraw()
  screen.clear()
  
  if message then
    message:redraw()
      
  else
    
    pages:redraw()
    
    if pages.index == 1 then
      screen.move(1, 10)
      screen.level(13)
      screen.font_size(16)
      screen.text("BLACKOUT")
      screen.font_size(8)
      screen.fill()
      --tabs:redraw()
      dial_l:redraw()
      dial_r:redraw()
      --slider_l:redraw()
      --slider_r:redraw()
      
    elseif pages.index == 2 then
      scrolling_list:redraw()
      
    elseif pages.index == 3 then
      screen.move(8, 24)
      screen.level(15)
      screen.text("Press KEY3 to")
      screen.move(8, 35)
      screen.text("display a message.")
      screen.move(8, 50)
      screen.level(3)
      screen.text(message_result)
      screen.fill()
      
    end
    
  end
  
  screen.update()
end

-- Encoder input
function enc(n, delta)
  
  if n == 1 then
    -- Page scroll
    pages:set_index_delta(util.clamp(delta, -1, 1), false)
  end
  
  if pages.index == 1 then
      if tabs.index == 1 then
        -- Tab A
        if n == 2 then
          dial_l:set_value_delta(delta * 2)
        elseif n == 3 then
          dial_r:set_value_delta(delta / 20)
        end
      else
        -- Tab B
        if n == 2 then
          slider_l:set_value_delta(delta / 20)
        elseif n == 3 then
          slider_r:set_value_delta(delta / 20)
        end
      end
      
  elseif pages.index == 2 then
    if n == 2 then
      scrolling_list:set_index_delta(util.clamp(delta, -1, 1))
    end
    
  end
  
  screen_dirty = true
end

-- Key input
function key(n, z)
  if z == 1 then
    
    if n == 2 then
      
      if message then
        message = nil
        message_result = "Cancelled."
        
      else
        pages:set_index_delta(1, true)
      end
      
    elseif n == 3 then
      
      if message then
        message = nil
        message_result = "Confirmed!"
      
      elseif pages.index == 1 then
        tabs:set_index_delta(1, true)
        dial_l.active = tabs.index == 1
        dial_r.active = tabs.index == 1
        slider_l.active = tabs.index == 2
        slider_r.active = tabs.index == 2
        
      elseif pages.index == 3 then
        message = UI.Message.new({"This is a message.", "", "KEY2 to cancel", "KEY3 to confirm"})
      end
      
    end
    
    screen_dirty = true
  end
end
