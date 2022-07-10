class CheckWin
  attr_accessor :checkers

  def initialize
    @checkers = []
  end
  # Starting from the coordinates of the last placed checker
  # It stores each value one spot downwards three times
  # Then checks that array for matching values
  def check_down(x, y, turn)
    if x > 3 && x < 7
      @checkers << @board[x][y]
      @checkers << @board[x - 1][y]
      @checkers << @board[x - 2][y]
      @checkers << @board[x - 3][y]
      result = @checkers.all?(turn)
    end
  end

  def check_side
  end

  def check_diag
  end

  def check_reverse_diag
  end
end
# The game will be played over the Board object, which will hold Pieces
# I am currently using a nested hash for the board but this could change
class Board < CheckWin
  attr_accessor :board
  # Each row is a number 1-6
  # Each column is a letter a-g
  def initialize
    super
    @board = {
      6 => {1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
      5 => {1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
      4 => {1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
      3 => {1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
      2 => {1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
      1 => {1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"}
    }
  end
  # Displays the board in a presentable way
  def display_board
    puts "       CONNECT FOUR"

    @board.each do |k, v|
      puts "| #{v[1]} | #{v[2]} | #{v[3]} | #{v[4]} | #{v[5]} | #{v[6]} | #{v[7]} |"
      puts "☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩"
    end

    puts "  1 ☩ 2 ☩ 3 ☩ 4 ☩ 5 ☩ 6 ☩ 7"
  end
end
# UpdateBoard alters a Board object by first letting one pick a column 'a-g'
# And then replacing the value of the lowest unoccupied row spot
class UpdateBoard
  attr_accessor :choice, :i

  def initialize
    @choice = ""
    @i = 1
  end
# pick_column takes a choice between a-g and stores it for later use
  def pick_column
    loop do
      puts "Enter the letter of the column to drop your checker in:  "
      @choice = gets.chomp.to_i
      break if @choice.to_s.match?(/^[1-7]$/)
    end
  end
# helper method for drop_checker
  def increment_row(board)
    @i = 1
    until board.board[@i][@choice] == '-' do
      @i = @i + 1
      break if @i > 6
    end
  end
# drop_checker uses @choice to alter a single slot in the board
  def drop_checker(board, turn)
    increment_row(board)
    if @i <= 6
      board.board[@i][@choice] = turn unless board.board[@i][@choice] != '-'
    end
  end
end
# The PlayGame class starts loop where the game is actually played
# It holds state for whose turn it is and if the game is over or not
class PlayGame
  attr_accessor :turn, :game_over

  def initialize
    @turn = 'X'
    @next_turn = 'O'
    @game_over = false
  end
  # Checks if the board is full
  def full_board?(board)
    arr = []
    board.each { |k, v| v.each { |k, v| arr << v } }
    !arr.any?('-')
  end
  # Switches checker from 'X' to 'O' and vice versa
  def switch_turn
    @turn, @next_turn = @next_turn, @turn
  end
  # play only stops when there's a consecutive-four or a full board
  # It calls the methods that take input, switch turn, displays board 
  # and alters a board slot
  def play(board, updater)
    until game_over || full_board?(board.board) do
      board.display_board
      updater.pick_column
      updater.drop_checker(board, @turn)
      @game_over = true if board.check_down(updater.i, updater.choice, @turn)
      board.checkers.clear
      switch_turn unless updater.i > 6
    end
    board.display_board
  end
end
# game = PlayGame.new.play(Board.new, UpdateBoard.new)