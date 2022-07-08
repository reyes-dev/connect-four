# A Piece object will be created to fill in a spot in the Board each turn
# Colors are ⚪ and ⚫
class Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Board
  attr_accessor :board

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
end