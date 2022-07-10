require '../lib/connect_four.rb'

describe UpdateBoard do
  describe '#drop_checker' do
    context 'When given a Board object' do
      subject(:board_update) { described_class.new }

      it 'Replaces the value of the lowest unnocupied spot ' do
        new_board = Board.new
        board_update.choice = :a
        board_update.drop_checker(new_board, 'X')
        changed_board = new_board.board[1][:a]
        expect(changed_board).to eq('X')
      end

      it 'Will not replace an already occupied spot' do
        new_board = Board.new
        board_update.choice = :a
        board_update.drop_checker(new_board, 'X')
        board_update.drop_checker(new_board, 'O')
        changed_x = new_board.board[1][:a]
        changed_o = new_board.board[2][:a]
        expect(changed_x).to eq('X')
        expect(changed_o).to eq('O')
      end
    end
  end
end

describe PlayGame do
  describe '#play' do
    subject(:win_loop) { described_class.new }

    context 'When @game_over is true' do
      it 'Exits the loop' do
        result = win_loop.play
        expect(result).to be_nil
      end
    end
  end

  describe '#full_board?' do
    subject(:full_play) { described_class.new }

    context "When none of the board hash values are still '-'" do
      it 'Returns true' do
        new_board = Board.new
        new_board.board = {
          6 => {a: "X", b: "X", c: "X", d: "X", e: "X", f: "X", g: "X"},
          5 => {a: "X", b: "X", c: "X", d: "X", e: "X", f: "X", g: "X"},
          4 => {a: "X", b: "X", c: "X", d: "X", e: "X", f: "X", g: "X"},
          3 => {a: "X", b: "X", c: "X", d: "X", e: "X", f: "X", g: "X"},
          2 => {a: "X", b: "X", c: "X", d: "X", e: "X", f: "X", g: "X"},
          1 => {a: "X", b: "X", c: "X", d: "X", e: "X", f: "X", g: "X"}
        }
        board = new_board.board
        result = full_play.full_board?(board)
        expect(result).to be true
      end
    end

    context "When at least one of the board hash values are still '-'" do
      it 'Returns false' do
        new_board = Board.new
        new_board.board = {
          6 => {a: "-", b: "X", c: "X", d: "X", e: "X", f: "X", g: "X"},
          5 => {a: "X", b: "X", c: "X", d: "X", e: "X", f: "X", g: "X"},
          4 => {a: "X", b: "X", c: "X", d: "X", e: "X", f: "X", g: "X"},
          3 => {a: "X", b: "X", c: "X", d: "X", e: "X", f: "X", g: "X"},
          2 => {a: "X", b: "X", c: "X", d: "X", e: "X", f: "X", g: "X"},
          1 => {a: "X", b: "X", c: "X", d: "X", e: "X", f: "X", g: "X"}
        }
        board = new_board.board
        result = full_play.full_board?(board)
        expect(result).to be false
      end
    end
  end
end