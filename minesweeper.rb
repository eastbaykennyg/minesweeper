require "debugger"
class MineSweeper
  NEIGHBORS = [
    [-1, 1],
    [ 0, 1],
    [ 1, 1],
    [ 1, 0],
    [ 1,-1],
    [ 0,-1],
    [-1,-1],
    [-1, 0]
  ]

  def initialize

    @board_arr = [
      [0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0]
    ]

    @user_board = [
      ["*","*","*","*","*","*","*","*","*"],
      ["*","*","*","*","*","*","*","*","*"],
      ["*","*","*","*","*","*","*","*","*"],
      ["*","*","*","*","*","*","*","*","*"],
      ["*","*","*","*","*","*","*","*","*"],
      ["*","*","*","*","*","*","*","*","*"],
      ["*","*","*","*","*","*","*","*","*"],
      ["*","*","*","*","*","*","*","*","*"],
      ["*","*","*","*","*","*","*","*","*"]
    ]

    ## generating random bombs
    10.times do
      x = rand(9)
      y = rand(9)
      @board_arr[x][y] = "b"
      NEIGHBORS.each do |space|
        if in_bounds? (x+space[0]),(y+space[1])
          @board_arr[x+space[0]][y+space[1]] += 1 unless @board_arr[x+space[0]][y+space[1]] == "b"
        end
      end
    end


  end

  def in_bounds?(x,y)
    return true if x <9 && x >= 0 && y <9 && y >= 0
  end

  def print_board(choice)
    if choice == "b"
      for i in (0...@board_arr.length)
        p @board_arr[i]
      end
    else
      for i in (0...@user_board.length)
        p @user_board[i]
      end
    end
  end

  # def reveal(x, y)
  #   if @board_arr[x][y] == "b"
  #     puts "Game Over"
  #     print_board("b")
  #   elsif            ## check adjacent cells if they contain bomb
  #     print_board("u") if reveal_neighbors(x,y)
  #   else             ## display # of adjacent bombs
  #   end
  # end

  def reveal_neighbors(x, y)    ## recursive until false
    #debugger
    if @board_arr[x][y] == 0
      @user_board[x][y] = "0"
      NEIGHBORS.each do |space|
        new_x = x+space[0]
        new_y = y+space[1]
        if in_bounds?(new_x, new_y) && @board_arr[new_x][new_y] != "b"
          @user_board[new_x][new_y] = @board_arr[new_x][new_y].to_s
          if @board_arr[new_x][new_y] == 0
            reveal_neighbors(new_x,new_y)
          else
            puts "test"
          end
        end
      end
    end
  end



end