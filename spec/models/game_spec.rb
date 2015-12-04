require 'rails_helper'

RSpec.describe Game, :type => :model do
  describe '#legal_castle_move?' do
    before :each do
      @game = Game.create
      @board = Board.new
      @board.board[0][4] = King.create(color: false, x_position: 4, y_position: 0, game_id: @game.id)
      @board.board[0][7] = Rook.create(color: false, x_position: 7, y_position: 0, game_id: @game.id)
      @board.board[0][0] = Rook.create(color: false, x_position: 0, y_position: 0, game_id: @game.id)
      @board.board[7][4] = King.create(color: true, x_position: 4, y_position: 7, game_id: @game.id)
      @board.board[7][7] = Rook.create(color: true, x_position: 7, y_position: 7, game_id: @game.id)
      @board.board[7][0] = Rook.create(color: true, x_position: 0, y_position: 7, game_id: @game.id)
      @board.refresh(@game.id)
      @black_king = @board.board[0][4]
      @white_king = @board.board[7][4]
    end	

    context 'black king legally castles' do
      it 'kingside' do
	expect(@game.legal_castle_move?(@black_king.x_position + 2, @black_king.y_position, @black_king.color, @game.id)).to be true
      end

      it 'queenside' do
	expect(@game.legal_castle_move?(@black_king.x_position - 2, @black_king.y_position, @black_king.color, @game.id)).to be true
      end
    end

    context 'black king illegally castles' do
      it 'three spaces left' do
	expect(@game.legal_castle_move?(@black_king.x_position - 3, @black_king.y_position, @black_king.color, @game.id)).to be false
      end

      it 'two spaces right and one space down' do
	expect(@game.legal_castle_move?(@black_king.x_position + 2, @black_king.y_position + 1, @black_king.color, @game.id)).to be false
      end
    end

    context 'black king castles without a rook' do
      it 'kingside' do
	pending
	@board.board[0][7] = nil
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position + 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end

      it 'queenside' do
	pending
	@board.board[0][0] = nil
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position - 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end
    end

    context 'black king moves out and back, then tries to castle' do
      it 'is illegal kingside' do
	pending
	@black_king.update_attributes(y_position: 1)
	@board.refresh(@game.id)
	@black_king.update_attributes(y_position: 0)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position + 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end

      it 'is illegal queenside' do
	pending
	@black_king.update_attributes(y_position: 1)
	@board.refresh(@game.id)
	@black_king.update_attributes(y_position: 0)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position - 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end
    end

    context 'black rook forward and back, then tries to castle' do
      it 'is illegal for queenside rook' do
	pending
	@board.board[0][0].update_attributes(y_position: 1)
	@board.refresh(@game.id)
	@board.board[0][0].update_attributes(y_position: 0)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position - 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end

      it 'is illegal for kingside rook' do
	pending
	@board.board[0][7].update_attributes(y_position: 1)
	@board.refresh(@game.id)
	@board.board[0][7].update_attributes(y_position: 0)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position + 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end
    end

    context 'black rook moves in and back, then tries to castle' do
      it 'is illegal for queenside rook' do
	pending
	@board.board[0][0].update_attributes(x_position: 1)
	@board.refresh(@game.id)
	@board.board[0][0].update_attributes(x_position: 0)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position - 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end

      it 'is illegal for kingside rook' do
	pending
	@board.board[0][7].update_attributes(x_position: 6)
	@board.refresh(@game.id)
	@board.board[0][7].update_attributes(x_position: 7)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position + 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end
    end

    context 'black king tries to castle with pieces in the way' do
      it 'fails kingside' do
	pending
	@board.board[0][5] = Bishop.create(x_position: 5, y_position: 0, color: false, game_id: @game.id)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position + 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end

      it 'fails queenside' do
	pending
	@board.board[0][2] = Bishop.create(x_position: 2, y_position: 0, color: false, game_id: @game.id)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position - 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end
    end

    context 'white king legally castles' do
      it 'kingside' do
	expect(@game.legal_castle_move?(@white_king.x_position + 2, @white_king.y_position, @white_king.color, @game.id)).to be true
      end

      it 'queenside' do
	expect(@game.legal_castle_move?(@white_king.x_position - 2, @white_king.y_position, @white_king.color, @game.id)).to be true
      end
    end

    context 'white king illegally castles' do
      it 'three spaces left' do
	expect(@game.legal_castle_move?(@white_king.x_position - 3, @white_king.y_position, @white_king.color, @game.id)).to be false
      end

      it 'two spaces right and one space down' do
	expect(@game.legal_castle_move?(@white_king.x_position + 2, @white_king.y_position + 1, @white_king.color, @game.id)).to be false
      end
    end

    context 'white king castles without a rook' do
      it 'kingside' do
	pending
	@board.board[7][7] = nil
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position + 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end

      it 'queenside' do
	pending
	@board.board[7][0] = nil
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position - 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end
    end

    context 'white king moves out and back, then tries to castle' do
      it 'is illegal kingside' do
	pending
	@white_king.update_attributes(y_position: 6)
	@board.refresh(@game.id)
	@white_king.update_attributes(y_position: 7)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position + 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end

      it 'is illegal queenside' do
	pending
	@white_king.update_attributes(y_position: 6)
	@board.refresh(@game.id)
	@white_king.update_attributes(y_position: 7)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position - 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end
    end

    context 'white rook moves forward and back, then tries to castle' do
      it 'is illegal for queenside rook' do
	pending
	@board.board[7][0].update_attributes(y_position: 6)
	@board.refresh(@game.id)
	@board.board[7][0].update_attributes(y_position: 7)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position - 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end

      it 'is illegal for kingside rook' do
	pending
	@board.board[7][7].update_attributes(y_position: 6)
	@board.refresh(@game.id)
	@board.board[7][7].update_attributes(y_position: 7)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position + 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end
    end

    context 'white rook moves in and back, then tries to castle' do
      it 'is illegal for queenside rook' do
	pending
	@board.board[7][0].update_attributes(x_position: 1)
	@board.refresh(@game.id)
	@board.board[7][0].update_attributes(x_position: 0)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position - 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end

      it 'is illegal for kingside rook' do
	pending
	@board.board[7][7].update_attributes(x_position: 6)
	@board.refresh(@game.id)
	@board.board[7][7].update_attributes(x_position: 7)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position + 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end
    end

    context 'white king tries to castle with pieces in the way' do
      it 'fails kingside' do
	pending
	@board.board[7][5] = Bishop.create(x_position: 5, y_position: 7, color: true, game_id: @game.id)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position + 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end

      it 'fails queenside' do
	pending
	@board.board[7][2] = Bishop.create(x_position: 2, y_position: 7, color: true, game_id: @game.id)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position - 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end
    end

  end
end
