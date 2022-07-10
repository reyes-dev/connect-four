# The game will be played over the Board object, which will hold Pieces
# I am currently using a nested hash for the board but this could change
class Board
  attr_accessor :board
  # Each row is a number 1-6
  # Each column is a letter a-g
  def initialize
    @board = {
      6 => {a: "-", b: "-", c: "-", d: "-", e: "-", f: "-", g: "-"},
      5 => {a: "-", b: "-", c: "-", d: "-", e: "-", f: "-", g: "-"},
      4 => {a: "-", b: "-", c: "-", d: "-", e: "-", f: "-", g: "-"},
      3 => {a: "-", b: "-", c: "-", d: "-", e: "-", f: "-", g: "-"},
      2 => {a: "-", b: "-", c: "-", d: "-", e: "-", f: "-", g: "-"},
      1 => {a: "-", b: "-", c: "-", d: "-", e: "-", f: "-", g: "-"}
    }
  end
  # Displays the board in a presentable way
  def display_board
    puts "       CONNECT FOUR"

    @board.each do |k, v|
      puts "| #{v[:a]} | #{v[:b]} | #{v[:c]} | #{v[:d]} | #{v[:e]} | #{v[:f]} | #{v[:g]} |"
      puts "☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩☩"
    end

    puts "  A ☩ B ☩ C ☩ D ☩ E ☩ F ☩ G"
  end
end
# UpdateBoard alters a Board object by first letting one pick a column 'a-g'
# And then replacing the value of the lowest unoccupied row spot
class UpdateBoard
  attr_accessor :choice

  def initialize
    @choice = ""
    @i = 1
  end
# pick_column takes a choice between a-g and stores it for later use
  def pick_column
    loop do
      puts "Enter the letter of the column to drop your checker in:  "
      @choice = gets.chomp.downcase.to_sym
      break if @choice.match?(/^[a-g]$/)
    end
  end
# helper method for drop_checker
  def increment_row(board)
    @i = 1
    @i = @i + 1 until board.board[@i][@choice] == '-' || @i == 6
  end
# drop_checker uses @choice to alter a single slot in the board
  def drop_checker(board, turn)
    increment_row(board)
    board.board[@i][@choice] = turn unless board.board[@i][@choice] != '-'
  end
end
# The PlayGame class starts loop where the game is actually played
# It holds state for whose turn it is and if the game is over or not
class PlayGame
  attr_accessor :turn, :game_over

  def initialize
    @turn = 'X'
    @game_over = false
  end
  # play only stops when there's a consecutive-four or a full board
  # It calls the methods that take input, switch turn, displays board 
  # and alters a board slot
  def play
    until game_over do
      @game_over = true
    end
  end
  # Checks if the board is full
  def full_board?(board)
    arr = []
    board.each { |k, v| v.each { |k, v| arr << v } }
    !arr.any?('-')
  end
end