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