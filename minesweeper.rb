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

    @flag_arr = []
    @user_choice = ""
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

  def play
    @user_choice = ""
    print_board("u")
    until @user_choice == "q" || flag_check == true
      puts "[R]eveal,[F]lag, or [Q]uit?"
      @user_choice = gets.chomp.downcase
      if @user_choice == "f" || @user_choice == "r"
        puts "Enter your coordinates as (Row, Column):"
        user_coor = gets.chomp.split(',')
        x, y = user_coor[0].to_i, user_coor[1].to_i

        if @user_choice == "f"
          self.flag_set(x, y)
        else @user_choice == "r"
          self.reveal(x, y)
        end
      elsif @user_choice == "q"
        puts "Thanks for playing"
      else
        puts "Invalid entry"
      end
    end
    if flag_check == true
      puts "You da bomb!"
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

  def reveal(x, y)
    if @board_arr[x][y] == "b"
      puts "GAME OVER\n\n"
      print_board("b")
      @user_choice = "q"
    elsif @board_arr[x][y] == 0  ## check adjacent cells if they contain bomb
      reveal_neighbors(x,y)
      print_board("u")
    else
      @user_board[x][y] = @board_arr[x][y].to_s
      print_board("u")
    end
  end

  def reveal_neighbors(x, y)    ## recursive until false
    #debugger
    if @board_arr[x][y] == 0
      @user_board[x][y] = "0"
      NEIGHBORS.each do |space|
        new_x = x+space[0]
        new_y = y+space[1]
        if in_bounds?(new_x, new_y) && @board_arr[new_x][new_y] != "b"
          if @user_board[new_x][new_y] == @board_arr[new_x][new_y].to_s
            next
          else
            @user_board[new_x][new_y] = @board_arr[new_x][new_y].to_s
            reveal_neighbors(new_x,new_y)
          end
        end
      end
    end
  end

  def flag_set(x, y)
    if @user_board[x][y] != "F"
      @user_board[x][y] = "F"
      @flag_arr << [x, y]
    else
      @user_board[x][y] = "*"
      @flag_arr.delete([x, y])
    end
    print_board("u")
  end

  ## checks user's flags when user has set all 10 of his/her flags
  def flag_check
    @flag_arr.each do |flag|

      x, y = flag[0], flag[1]
      if @board_arr[x][y] != "b"
        return false
      end
    end
    if @flag_arr.length == 10
      true
    else
      false
    end
  end


end
