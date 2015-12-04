require 'rails_helper'

RSpec.describe Game, :type => :model do
  describe "#legal_castle_move?" do
    before :each do
      @game = Game.create
      @board = Board.new
      @board.board[0][4] = King.create(color: false, x_position: 4, y_position: 0, game_id: @game.id)
      @board.board[0][7] = Rook.create(color: false, x_position: 7, y_position: 0, game_id: @game.id)
      @board.board[0][0] = Rook.create(color: false, x_position: 0, y_position: 0, game_id: @game.id)
      @board.refresh(@game.id)
      @king = @board.board[0][4]
    end	

    context "king has not moved before" do
      it "king's movement is a legal castle move" do
	expect(@game.legal_castle_move?(@king.x_position + 2, @king.y_position, @king.color, @game.id)).to be true
	expect(@game.legal_castle_move?(@king.x_position - 2, @king.y_position, @king.color, @game.id)).to be true
      end


      it "king's movement is not a legal castle move" do
	expect(@game.legal_castle_move?(@king.x_position - 3, @king.y_position, @king.color, @game.id)).to be false
	expect(@game.legal_castle_move?(@king.x_position + 2, @king.y_position + 1, @king.color, @game.id)).to be false
      end
    end

  end
end
