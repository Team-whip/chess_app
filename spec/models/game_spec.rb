require 'rails_helper'

RSpec.describe Game, :type => :model do
	describe "#in_check?" do
  	before :each do
  		@game = Game.create
  		@board = Board.new.populate(@game.id)
  		@board[4][3] = King.new(color: true, x_position: 4, y_position: 3)
  		@board[4][5] = Rook.new(color: false, x_position: 4, y_position: 5)
  		@board[5][5] = King.new(color: false, x_position: 5, y_position: 5)
  		@king = @board[4][3]
  		@rook = @board[4][5]
  		@king2 = @board[5][5]
  	end

  	it "is in check" do
  		expect(@game.in_check?(@king.color)).to be true
  	end

  	it "is not in check" do
  		expect(@game.in_check?(@king2.color)).to be false
  	end
	end

	describe "#legal_castle_move?" do
  	before :each do
  		@game = Game.create
  		@board = Board.new.populate(@game.id)
  		@board[4][0] = King.new(color: false, x_position: 4, y_position: 0)
  		@king = @board[4][0]
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
