require '../lib/connect_four.rb'

describe UpdateBoard do
  describe '#drop_checker' do
    context 'When given a Board object' do
      subject(:board_update) { described_class.new }

      it 'Replaces the value of the lowest unnocupied spot ' do
        new_board = Board.new
        board_update.choice = 1
        board_update.drop_checker(new_board, 'X')
        changed_board = new_board.board[1][1]
        expect(changed_board).to eq('X')
      end

      it 'Will not replace an already occupied spot' do
        new_board = Board.new
        board_update.choice = 1
        board_update.drop_checker(new_board, 'X')
        board_update.drop_checker(new_board, 'O')
        changed_x = new_board.board[1][1]
        changed_o = new_board.board[2][1]
        expect(changed_x).to eq('X')
        expect(changed_o).to eq('O')
      end

      context 'When a board column is full' do
        subject(:column_is_full) { described_class.new }

        it 'Will not change the board' do
          new_board = Board.new
          new_board.board = {
            6 => {1 => "X", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
            5 => {1 => "X", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
            4 => {1 => "X", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
            3 => {1 => "X", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
            2 => {1 => "X", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
            1 => {1 => "X", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"}
          }
          column_is_full.choice = 1
          column_is_full.drop_checker(new_board, 'O')
          changed_to_o = new_board.board[6][1]
          expect(changed_to_o).not_to eq('O')
          expect(changed_to_o).to eq('X')
        end
      end
    end
  end
end

describe PlayGame do
  describe '#play' do
    subject(:win_loop) { described_class.new }

    context 'When @game_over is true' do
      it 'Exits the loop' do
        win_loop.game_over = true
        result = win_loop.play(Board.new, UpdateBoard.new)
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
          6 => {1 => "X", 2 => "X", 3 => "X", 4 => "X", 5 => "X", 6 => "X", 7 => "X"},
          5 => {1 => "X", 2 => "X", 3 => "X", 4 => "X", 5 => "X", 6 => "X", 7 => "X"},
          4 => {1 => "X", 2 => "X", 3 => "X", 4 => "X", 5 => "X", 6 => "X", 7 => "X"},
          3 => {1 => "X", 2 => "X", 3 => "X", 4 => "X", 5 => "X", 6 => "X", 7 => "X"},
          2 => {1 => "X", 2 => "X", 3 => "X", 4 => "X", 5 => "X", 6 => "X", 7 => "X"},
          1 => {1 => "X", 2 => "X", 3 => "X", 4 => "X", 5 => "X", 6 => "X", 7 => "X"}
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
          6 => {1 => "-", 2 => "X", 3 => "X", 4 => "X", 5 => "X", 6 => "X", 7 => "X"},
          5 => {1 => "X", 2 => "X", 3 => "X", 4 => "X", 5 => "X", 6 => "X", 7 => "X"},
          4 => {1 => "X", 2 => "X", 3 => "X", 4 => "X", 5 => "X", 6 => "X", 7 => "X"},
          3 => {1 => "X", 2 => "X", 3 => "X", 4 => "X", 5 => "X", 6 => "X", 7 => "X"},
          2 => {1 => "X", 2 => "X", 3 => "X", 4 => "X", 5 => "X", 6 => "X", 7 => "X"},
          1 => {1 => "X", 2 => "X", 3 => "X", 4 => "X", 5 => "X", 6 => "X", 7 => "X"}
        }
        board = new_board.board
        result = full_play.full_board?(board)
        expect(result).to be false
      end
    end
  end
end

describe CheckWin do
  describe '#check_down' do
    context 'When the board has a four-in-a-row downward' do
      subject(:board) { Board.new }

      it 'Returns true' do
        board.board = {
          6 => {1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
          5 => {1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
          4 => {1 => "X", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
          3 => {1 => "X", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
          2 => {1 => "X", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
          1 => {1 => "X", 2 => "O", 3 => "O", 4 => "O", 5 => "-", 6 => "-", 7 => "-"}
        }
        result = board.check_down
        expect(result).to be true
      end
    end
  end

  describe '#check_side' do
    context 'When the board has a four-in-a-row sideways' do
      subject(:board) { Board.new }

      it 'Returns true' do
        board.board = {
          6 => {1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
          5 => {1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
          4 => {1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
          3 => {1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
          2 => {1 => "O", 2 => "O", 3 => "O", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
          1 => {1 => "X", 2 => "X", 3 => "X", 4 => "X", 5 => "-", 6 => "-", 7 => "-"}
        }
        result = board.check_down
        expect(result).to be true
      end
    end
  end

  describe '#check_diag' do
    context 'When the board has a four-in-a-row diagonally' do
      subject(:board) { Board.new }
      
      it 'Returns true' do
        board.board = {
          6 => {1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
          5 => {1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
          4 => {1 => "-", 2 => "-", 3 => "-", 4 => "X", 5 => "-", 6 => "-", 7 => "-"},
          3 => {1 => "-", 2 => "-", 3 => "X", 4 => "O", 5 => "-", 6 => "-", 7 => "-"},
          2 => {1 => "O", 2 => "X", 3 => "O", 4 => "X", 5 => "-", 6 => "-", 7 => "-"},
          1 => {1 => "X", 2 => "X", 3 => "O", 4 => "O", 5 => "-", 6 => "-", 7 => "-"}
        }
        result = board.check_down
        expect(result).to be true
      end
    end
  end

  describe '#check_reverse_diag' do
    context' When the board has a four-in-a-row reverse diag' do
      subject(:board) { Board.new }

      it 'Returns true' do
        board.board = {
          6 => {1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
          5 => {1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 6 => "-", 7 => "-"},
          4 => {1 => "-", 2 => "-", 3 => "-", 4 => "X", 5 => "-", 6 => "-", 7 => "-"},
          3 => {1 => "-", 2 => "-", 3 => "-", 4 => "X", 5 => "X", 6 => "-", 7 => "-"},
          2 => {1 => "-", 2 => "-", 3 => "-", 4 => "O", 5 => "X", 6 => "X", 7 => "-"},
          1 => {1 => "-", 2 => "-", 3 => "O", 4 => "O", 5 => "O", 6 => "O", 7 => "X"}
        }
        result = board.check_down
        expect(result).to be true
      end
    end
  end
end