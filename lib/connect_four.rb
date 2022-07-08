# A Piece object will be created to fill in a spot in the Board each turn
# Colors are ⚪ and ⚫
class Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end
end