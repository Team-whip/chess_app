require 'rails_helper'

RSpec.describe Game, :type => :model do

  describe "#in_check?" do
    before :each do
      @game = Game.create
      @board = Board.new
      @board.board[3][4] = King.create(color: true, x_position: 4, y_position: 3, game_id: @game.id)
      @board.board[5][4] = Rook.create(color: false, x_position: 4, y_position: 5, game_id: @game.id)
      @board.board[5][5] = King.create(color: false, x_position: 5, y_position: 5, game_id: @game.id)
      @board.refresh(@game.id)
      @king = @board.board[3][4]
      @rook = @board.board[5][4]
      @king2 = @board.board[5][5]
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
    end
  end
end
