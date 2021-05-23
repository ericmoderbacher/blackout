--
-- Created by IntelliJ IDEA.
-- User: eric
-- Date: 5/23/2021
-- Time: 12:49 PM
-- To change this template use File | Settings | File Templates.
--

local board =
{
    n_rows, n_cols, board, g_local
}
function board.toggle(x,y)
    if (x <= 16) and (x > 0) then
    if (y <= 8 and y > 0) then
    if board.board[x][y] == 1
    then board.board[x][y] = 0
        else board.board[x][y] = 1
    end
    end end

end
function board.press(x,y)
    print("press")
    -- apply the kernal
    --north
    print("y test " .. (y+1))
    print("y test 2 " .. y+1)
    local dumbThing = y + 1

    board.toggle(x,y + 1)
--
--    --south
    board.toggle(x,(y-1))
--    --east
    board.toggle((x+1),y)
--    --west
    board.toggle((x-1),y)
    --center
    board.toggle(x,y)
end

function board:construct(g)
    g_local = g
    print("test 2")
    self.n_rows = g_local.rows
    self.n_cols = g_local.cols
    print("n_rows" .. self.n_rows)
    print("n_cols" .. self.n_cols)
    self.board = {}

    -- initiallize the board to the correct size and set the states of the "lights" to off "0"
    for x=1,self.n_cols do
        self.board[x] = {}
        for y=1,self.n_rows do
            self.board[x][y] = 0
        end
    end


    g.key = function(x, y, z)
        print(x .. " " .. y .. " " .. z)
        print("board test " .. board.n_rows)
        print("board test 2 " .. board.board[x][y])
        --board.board[x][y] = z
        if (z == 1) then
            board.press(x,y)
        end

        board.grid_redraw()

--        if (z == 1) then
--            if (is_active(x, y)) then
--                state.board.current[x][y] = config.GRID.LEVEL.DEAD
--            else
--                state.board.current[x][y] = config.GRID.LEVEL.ALIVE
--            end
--        end
--        grid_redraw()
    end
end



-- grid UI
function board.grid_redraw()
    g_local:all(0)
    print("board test c " .. board.n_cols)
    for x=1,board.n_cols do
        for y=1,board.n_rows do
            if (board.board[x][y] == 1) then
                g_local:led(x, y, 15)
            else
                g_local:led(x, y, 0)
            end
        end
    end
    g_local:refresh()
end




return board