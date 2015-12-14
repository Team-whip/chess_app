require 'rails_helper'

RSpec.describe Game, :type => :model do

  describe "#in_check?" do
    before :each do
      @game = Game.create
      @board = Board.new
      @board.board[3][4] = King.create(color: true, x_position: 4, y_position: 3, game_id: @game.id)
      @board.board[5][4] = Rook.create(color: false, x_position: 4, y_position: 5, game_id: @game.id)
      @board.board[5][5] = King.create(color: false, x_position: 5, y_position: 5, game_id: @game.id)
      @board.board[3][6] = Rook.create(color: true, x_position: 6, y_position: 3, game_id: @game.id)
      @board.refresh(@game.id)
      @king = @board.board[3][4]
      @rook = @board.board[5][4]
      @king2 = @board.board[5][5]
      @rook2 = @board.board[3][6]
    end

    context "white king" do
      it "is in check from enemy rook" do
	expect(@game.in_check?(@king.color)).to be true
      end

      it "is not in check from enemy rook" do
	@rook.update_attributes(x_position: 5)
	@board.refresh(@game.id)
	expect(@game.in_check?(@king.color)).to be false
      end

      it "is not in check from pawn in front" do
	@rook.destroy
	@board.board[2][4] = Pawn.create(color: false, x_position: 4, y_position: 2, game_id: @game.id)
	@board.refresh(@game.id)
	expect(@game.in_check?(@king.color)).to be false
      end

      it "is not in check from pawn behind" do
	@rook.destroy
	@board.board[4][4] = Pawn.create(color: false, x_position: 4, y_position: 4, game_id: @game.id)
	@board.refresh(@game.id)
	expect(@game.in_check?(@king.color)).to be false
      end
    end

    context "black king" do
      it "is not in check from own rook" do
	expect(@game.in_check?(@king2.color)).to be false
      end
    
      it "is moving into check" do
	@king2.update_attributes(x_position: 6)
	@board.refresh(@game.id)
	expect(@game.in_check?(@king2.color)).to be true
      end
    end
  end

  describe "#moving_into_check?" do
    before :each do
      @game = Game.create
      @board = Board.new
      @board.board[3][4] = King.create(color: true, x_position: 4, y_position: 3, game_id: @game.id)
      @board.board[5][4] = Rook.create(color: false, x_position: 4, y_position: 5, game_id: @game.id)
      @board.board[5][5] = King.create(color: false, x_position: 5, y_position: 5, game_id: @game.id)
      @board.board[3][6] = Rook.create(color: true, x_position: 6, y_position: 3, game_id: @game.id)
      @board.refresh(@game.id)
      @king = @board.board[3][4]
      @rook = @board.board[5][4]
      @king2 = @board.board[5][5]
      @rook2 = @board.board[3][6]
    end

    context "white king" do
      it "is in check from enemy rook" do
  expect(@game.moving_into_check?(@king.x_position, @king.y_position, @king.color)).to be true
      end

      it "is not in check from enemy rook" do
  @rook.update_attributes(x_position: 5)
  @board.refresh(@game.id)
  expect(@game.moving_into_check?(@king.x_position, @king.y_position, @king.color)).to be false
      end
    end

    context "black king" do
      it "is not in check from own rook" do
  expect(@game.moving_into_check?(@king2.x_position, @king2.y_position, @king2.color)).to be false
      end
    
      it "is moving into check" do
  expect(@game.moving_into_check?(@king2.x_position + 1, @king2.y_position, @king2.color)).to be true
      end
    end
  end

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
	@board.board[0][7].destroy
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position + 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end

      it 'queenside' do
	@board.board[0][0].destroy
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position - 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end
    end

    context 'black king moves out and back, then tries to castle' do
      it 'is illegal kingside' do
	@black_king.update_attributes(y_position: 1, moved: true)
	@board.refresh(@game.id)
	@black_king.update_attributes(y_position: 0)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position + 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end

      it 'is illegal queenside' do
	@black_king.update_attributes(y_position: 1, moved: true)
	@board.refresh(@game.id)
	@black_king.update_attributes(y_position: 0)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position - 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end
    end

    context 'black rook forward and back, then tries to castle' do
      it 'is illegal for queenside rook' do
	@board.board[0][0].update_attributes(y_position: 1, moved: true)
	@board.refresh(@game.id)
	@board.board[0][0].update_attributes(y_position: 0)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position - 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end

      it 'is illegal for kingside rook' do
	@board.board[0][7].update_attributes(y_position: 1, moved: true)
	@board.refresh(@game.id)
	@board.board[0][7].update_attributes(y_position: 0)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position + 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end
    end

    context 'black rook moves in and back, then tries to castle' do
      it 'is illegal for queenside rook' do
	@board.board[0][0].update_attributes(x_position: 1, moved: true)
	@board.refresh(@game.id)
	@board.board[0][0].update_attributes(x_position: 0)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position - 2, @black_king.y_position, @black_king.color, @game.id)).to be false
      end

      it 'is illegal for kingside rook' do
	@board.board[0][7].update_attributes(x_position: 6, moved: true)
	@board.refresh(@game.id)
	@board.board[0][7].update_attributes(x_position: 7)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@black_king.x_position + 2, @black_king.y_position, @black_king.color, @game.id)).to be false
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

	@board.board[7][7].destroy
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position + 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end

      it 'queenside' do
	@board.board[7][0].destroy
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position - 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end
    end

    context 'white king moves out and back, then tries to castle' do
      it 'is illegal kingside' do
	@white_king.update_attributes(y_position: 6, moved: true)
	@board.refresh(@game.id)
	@white_king.update_attributes(y_position: 7)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position + 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end

      it 'is illegal queenside' do
	@white_king.update_attributes(y_position: 6, moved: true)
	@board.refresh(@game.id)
	@white_king.update_attributes(y_position: 7)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position - 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end
    end

    context 'white rook moves forward and back, then tries to castle' do
      it 'is illegal for queenside rook' do
	@board.board[7][0].update_attributes(y_position: 6, moved: true)
	@board.refresh(@game.id)
	@board.board[7][0].update_attributes(y_position: 7)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position - 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end

      it 'is illegal for kingside rook' do
	@board.board[7][7].update_attributes(y_position: 6, moved: true)
	@board.refresh(@game.id)
	@board.board[7][7].update_attributes(y_position: 7)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position + 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end
    end

    context 'white rook moves in and back, then tries to castle' do
      it 'is illegal for queenside rook' do
	@board.board[7][0].update_attributes(x_position: 1, moved: true)
	@board.refresh(@game.id)
	@board.board[7][0].update_attributes(x_position: 0)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position - 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end

      it 'is illegal for kingside rook' do
	@board.board[7][7].update_attributes(x_position: 6, moved: true)
	@board.refresh(@game.id)
	@board.board[7][7].update_attributes(x_position: 7)
	@board.refresh(@game.id)
	expect(@game.legal_castle_move?(@white_king.x_position + 2, @white_king.y_position, @white_king.color, @game.id)).to be false
      end
    end

  end

  describe '#castling_occured' do
    before :each do
      @game = Game.create
      @board = Board.new
      @board.board[7][4] = King.create(color: true, x_position: 4, y_position: 7, game_id: @game.id)
      @board.board[7][7] = Rook.create(color: true, x_position: 7, y_position: 7, game_id: @game.id)
      @board.board[7][0] = Rook.create(color: true, x_position: 0, y_position: 7, game_id: @game.id)
      @board.refresh(@game.id)
      @white_king = @board.board[7][4]
    end	

    context 'white king legally castles' do
      it 'moves kingside rook to the correct castle position' do
	expect(@game.castling_occured(@white_king.x_position + 2, @white_king.y_position, @white_king.color, @game.id)).to be true
      end
    end
  end

  describe "#enemy_can_be_captured?" do
    before :each do
      @game = Game.create
      @board = Board.new
      @black_king = King.create(x_position: 7, y_position: 3, color: false, game_id: @game.id)
      @white_rook = Rook.create(x_position: 7, y_position: 7, color: true, game_id: @game.id)
      @board.board[3][7] = @black_king
      @board.board[7][7] = @white_rook
      @board.refresh(@game.id)
    end

    context "no pieces are available to capture" do
      it "cannot be captured" do
  expect(@game.can_be_captured?(@black_king.color)).to be false
      end
    end

    context "pieces are available to capture" do
      it "can be captured" do
  @black_queen = Queen.create(x_position: 5, y_position: 7, color: false, game_id: @game.id)
  @board.refresh(@game.id)
  expect(@game.can_be_captured?(@black_king.color)).to be true
      end
    end
  end

  describe "#enemy_can_be_blocked?" do
    before :each do
      @game = Game.create
      @board = Board.new
      @black_king = King.create(x_position: 7, y_position: 3, color: false, game_id: @game.id)
      @white_rook = Rook.create(x_position: 7, y_position: 7, color: true, game_id: @game.id)
      @board.board[3][7] = @black_king
      @board.board[7][7] = @white_rook
      @board.refresh(@game.id)
    end

    context "no pieces are available to block" do
      it "cannot be block" do
  pending
  expect(@game.can_be_blocked?(@black_king.color, @board)).to be false
      end
    end

    context "pieces are available to block" do
      it "can be blocked" do
  pending
  @black_rook = Rook.create(x_position: 6, y_position: 5, color: false, game_id: @game.id)
  @board.refresh(@game.id)
  expect(@game.can_be_blocked?(@black_king.color, @board)).to be true
      end
    end
  end

  describe "#is_move_on_board?" do
    before :each do
      @game = Game.create
      @board = Board.new
      @board.board[0][7] = King.create(x_position: 7, y_position: 0, color: false, game_id: @game.id)
      @board.refresh(@game.id)
      @king = @board.board[0][7]
    end

    context "piece" do
      it "is a move on the board" do
  expect(@game.is_move_on_board?(@king.x_position - 1, @king.y_position, @game_id)).to be true
    end

      it "is not a move on the board" do
  expect(@game.is_move_on_board?(@king.x_position + 1, @king.y_position, @game_id)).to be false
    end
   end
  end

  describe "#can_move_out_of_check" do
    before :each do
      @game = Game.create
      @board = Board.new
      @black_king = King.create(x_position: 7, y_position: 3, color: false, game_id: @game.id)
      @white_rook = Rook.create(x_position: 7, y_position: 7, color: true, game_id: @game.id)
      @board.board[7][3] = @black_king
      @board.board[7][7] = @white_rook
      @board.refresh(@game.id)
    end

  context "king is not surrounded" do
      it "can move out of check" do
  pending
  expect(@game.can_move_out_of_check?(@black_king.color, @game.id)).to be true
      end
    end

  context "king is surrounded" do
      it "cannot move out of check" do
  pending
  @white_queen = Queen.create(x_position: 5, y_position: 3, color: true, game_id: @game.id)
  @board.refresh(@game.id)
  expect(@game.can_move_out_of_check?(@black_king.color, @game.id)).to be false     
      end
    end
  end
end
