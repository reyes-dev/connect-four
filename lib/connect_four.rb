# A Piece object will be created to fill in a spot in the Board each turn
# Checkers are X and O
class Piece
  attr_reader :checker

  def initialize(checker)
    @checker = checker
  end
end
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
  def initialize
    @choice = ""
  end
# pick_column takes a choice between a-g and stores it for later use
  def pick_column
    loop do
      puts "Enter the letter of the column to drop your checker in:  "
      @choice = gets.chomp.downcase.to_sym
      break if @choice.match?(/^[a-g]$/)
    end
  end
end