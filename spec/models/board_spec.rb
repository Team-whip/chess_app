require 'rails_helper'

RSpec.describe Board, :type => :model do
  describe "#populate the board" do
    game = Game.create
    @player_one = Player.create
    @player_two = Player.create
    board = Board.new.populate(game.id, @player_one.id, @player_two.id)

    describe "create the black pieces" do
      context "the black rook" do
	it "is a rook" do
	  expect(board[0][0]).to be_a Rook
	  expect(board[0][7]).to be_a Rook
	end

	it "is black" do
	  expect(board[0][0].color).to eql(false)
	  expect(board[0][7].color).to eql(false)
	end

	it "is saving the right position" do
	  expect(board[0][0].x_position).to eql(0)
	  expect(board[0][0].y_position).to eql(0)
	  expect(board[0][7].x_position).to eql(7)
	  expect(board[0][7].y_position).to eql(0)
	end

	it "belongs to the correct game" do
	  expect(board[0][0].game_id).to eql(game.id)
	  expect(board[0][7].game_id).to eql(game.id)
	end
      end

      context "the black knight" do
	it "is a knight" do
	  expect(board[0][1]).to be_a Knight
	  expect(board[0][6]).to be_a Knight
	end

	it "is black" do
	  expect(board[0][1].color).to eql(false)
	  expect(board[0][6].color).to eql(false)
	end

	it "is saving the right position" do
	  expect(board[0][1].x_position).to eql(1)
	  expect(board[0][1].y_position).to eql(0)
	  expect(board[0][6].x_position).to eql(6)
	  expect(board[0][6].y_position).to eql(0)
	end

	it "belongs to the correct game" do
	  expect(board[0][1].game_id).to eql(game.id)
	  expect(board[0][6].game_id).to eql(game.id)
	end
      end

      context "the black bishop" do
	it "is a bishop" do
	  expect(board[0][2]).to be_a Bishop
	  expect(board[0][5]).to be_a Bishop
	end

	it "is black" do
	  expect(board[0][2].color).to eql(false)
	  expect(board[0][5].color).to eql(false)
	end

	it "is saving the right position" do
	  expect(board[0][2].x_position).to eql(2)
	  expect(board[0][2].y_position).to eql(0)
	  expect(board[0][5].x_position).to eql(5)
	  expect(board[0][5].y_position).to eql(0)
	end

	it "belongs to the correct game" do
	  expect(board[0][2].game_id).to eql(game.id)
	  expect(board[0][5].game_id).to eql(game.id)
	end
      end

      context "the black queen" do
	it "is a queen" do
	  expect(board[0][3]).to be_a Queen
	end

	it "is black" do
	  expect(board[0][3].color).to eql(false)
	end

	it "is saving the right position" do
	  expect(board[0][3].x_position).to eql(3)
	  expect(board[0][3].y_position).to eql(0)
	end

	it "belongs to the correct game" do
	  expect(board[0][3].game_id).to eql(game.id)
	end
      end

      context "the black king" do
	it "is a king" do
	  expect(board[0][4]).to be_a King
	end

	it "is black" do
	  expect(board[0][4].color).to eql(false)
	end

	it "is saving the right position" do
	  expect(board[0][4].x_position).to eql(4)
	  expect(board[0][4].y_position).to eql(0)
	end

	it "belongs to the correct game" do
	  expect(board[0][4].game_id).to eql(game.id)
	end
      end

      context "the black pawn" do
	it "is a pawn" do
	  board[1].each { |pawn| expect(pawn).to be_a Pawn }
	end

	it "is black" do
	  board[1].each { |pawn| expect(pawn.color).to eql(false) }
	end

	it "is saving the right position" do
	  board[1].each_with_index { |pawn, index| expect(pawn.x_position).to eql(index) }
	  board[1].each { |pawn| expect(pawn.y_position).to eql(1) }
	end

	it "belongs to the correct game" do
	  board[1].each { |pawn| expect(pawn.game_id).to eql(game.id) }
	end
      end
    end

    describe "creating the white pieces" do
      context "the white rook" do
	it "is a rook" do
	  expect(board[7][0]).to be_a Rook
	  expect(board[7][7]).to be_a Rook
	end

	it "is white" do
	  expect(board[7][0].color).to eql(true)
	  expect(board[7][7].color).to eql(true)
	end

	it "is saving the right location" do
	  expect(board[7][0].x_position).to eql(0)
	  expect(board[7][0].y_position).to eql(7)
	  expect(board[7][7].x_position).to eql(7)
	  expect(board[7][7].y_position).to eql(7)
	end

	it "belongs to the correct game" do
	  expect(board[7][0].game_id).to eql(game.id)
	  expect(board[7][7].game_id).to eql(game.id)
	end
      end

      context "the white knight" do
	it "is a knight" do
	  expect(board[7][1]).to be_a Knight
	  expect(board[7][6]).to be_a Knight
	end

	it "is white" do
	  expect(board[7][1].color).to eql(true)
	  expect(board[7][6].color).to eql(true)
	end

	it "is saving the right location" do
	  expect(board[7][1].x_position).to eql(1)
	  expect(board[7][1].y_position).to eql(7)
	  expect(board[7][6].x_position).to eql(6)
	  expect(board[7][6].y_position).to eql(7)
	end

	it "belongs to the correct game" do
	  expect(board[7][1].game_id).to eql(game.id)
	  expect(board[7][6].game_id).to eql(game.id)
	end
      end

      context "the white bishops" do
	it "is a bishop" do
	  expect(board[7][2]).to be_a Bishop
	  expect(board[7][5]).to be_a Bishop
	end

	it "is white" do
	  expect(board[7][2].color).to eql(true)
	  expect(board[7][5].color).to eql(true)
	end

	it "is saving the right location" do
	  expect(board[7][2].x_position).to eql(2)
	  expect(board[7][2].y_position).to eql(7)
	  expect(board[7][5].x_position).to eql(5)
	  expect(board[7][5].y_position).to eql(7)
	end

	it "belongs to the correct game" do
	  expect(board[7][2].game_id).to eql(game.id)
	  expect(board[7][5].game_id).to eql(game.id)
	end
      end

      context "the white queen" do
	it "is a queen" do
	  expect(board[7][3]).to be_a Queen
	end

	it "is white" do
	  expect(board[7][3].color).to eql(true)
	end

	it "is saving the right location" do
	  expect(board[7][3].x_position).to eql(3)
	  expect(board[7][3].y_position).to eql(7)
	end
	
	it "belongs to the correct game" do
	  expect(board[7][3].game_id).to eql(game.id)
	end
      end

      context "the white king" do
	it "is a king" do
	  expect(board[7][4]).to be_a King
	end

	it "is white" do
	  expect(board[7][4].color).to eql(true)
	end

	it "is saving the right location" do
	  expect(board[7][4].x_position).to eql(4)
	  expect(board[7][4].y_position).to eql(7)
	end

	it "belongs to the correct game" do
	  expect(board[7][4].game_id).to eql(game.id)
	end
      end

      context "creates white pawns" do
	it "is a pawn" do
	  board[6].each { |pawn| expect(pawn).to be_a Pawn }
	end

	it "is white" do
	  board[6].each { |pawn| expect(pawn.color).to eql(true) }
	end

	it "is saving the right location" do
	  board[6].each_with_index { |pawn, index| expect(pawn.x_position).to eql(index) }
	  board[6].each { |pawn| expect(pawn.y_position).to eql(6) }
	end

	it "belongs to the correct game" do
	  board[6].each { |pawn| expect(pawn.game_id).to eql(game.id) }
	end
      end
    end
  end
  describe "#refresh the board" do
    game = Game.new
    @player_one = Player.new
    @player_two = Player.new
    board = Board.new.populate(game.id, @player_one.id, @player_two.id)
    
    context "white player has moved the pawn at 3,6" do
      pawn = board[6][3]
      it "one space forward" do
	pawn.update_attributes(y_position: 5)
	board = Board.new.refresh(game.id)
	expect(board[5][3]).to eql(pawn)
      end

      it "two spaces forward" do
	pawn.update_attributes(y_position: 4)
	board = Board.new.refresh(game.id)
	expect(board[4][3]).to eql(pawn)
      end
    end

    context "black player has moved knight at 1,0" do
      knight = board[0][1]
      it "two spaces forward and one to the left" do
	knight.update_attributes(y_position: 2, x_position: 0)
	board = Board.new.refresh(game.id)
	expect(board[2][0]).to eql(knight)
      end
    end
  end
end
