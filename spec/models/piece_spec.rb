require 'rails_helper'

RSpec.describe Piece, :type => :model do
  describe "#is_move_obstructed?" do
    before :each do
      @board = Board.new
      @board.board[3][3] = Queen.new(x_position: 3, y_position: 3)
      @board.board[2][2] = double('pawn')
      @board.board[2][3] = double('pawn')
      @board.board[2][4] = double('pawn')
      @board.board[3][2] = double('pawn')
      @board.board[3][4] = double('pawn')
      @board.board[4][2] = double('pawn')
      @board.board[4][3] = double('pawn')
      @board.board[4][4] = double('pawn')
      @queen = @board.board[3][3]
    end

    describe "location" do
      context "move onto another piece" do
	it "is obstructed" do
	  expect(@queen.is_move_obstructed?(@queen.x_position + 1, @queen.y_position, @board)).to be true
	end
      end
    end

    describe "path" do
      context "diagonally down and right" do
	it "is obstructed" do
	  expect(@queen.is_move_obstructed?(@queen.x_position + 2, @queen.y_position + 2, @board)).to be true
	end

	it "is not obstructed" do
	  @board.board[@queen.y_position + 1][@queen.x_position + 1] = nil
	  expect(@queen.is_move_obstructed?(@queen.x_position + 2, @queen.y_position + 2, @board)).to be false
	end
      end

      context "move diagonally down and left" do
	it "is obstructed" do
	  expect(@queen.is_move_obstructed?(@queen.x_position - 2, @queen.y_position + 2, @board)).to be true
	end

	it "is not obstructed" do
	  @board.board[@queen.y_position + 1][@queen.x_position - 1] = nil
	  expect(@queen.is_move_obstructed?(@queen.x_position - 2, @queen.y_position + 2, @board)).to be false
	end
      end

      context "move diagonally up and right" do
	it "is obstructed" do
	  expect(@queen.is_move_obstructed?(@queen.x_position + 2, @queen.y_position - 2, @board)).to be true
	end

	it "is not obstructed" do
	  @board.board[@queen.y_position - 1][@queen.x_position + 1] = nil
	  expect(@queen.is_move_obstructed?(@queen.x_position + 2, @queen.y_position - 2, @board)).to be false
	end
      end

      context "move diagonally up and left" do
	it "is obstructed" do
	  expect(@queen.is_move_obstructed?(@queen.x_position - 2, @queen.y_position - 2, @board)).to be true
	end

	it "is not obstructed" do
	  @board.board[@queen.y_position - 1][@queen.x_position - 1] = nil
	  expect(@queen.is_move_obstructed?(@queen.x_position - 2, @queen.y_position - 2, @board)).to be false
	end
      end

      context "move horizontally" do
	it "is obstructed left" do
	  expect(@queen.is_move_obstructed?(@queen.x_position - 2, @queen.y_position, @board)).to be true
	end

	it "is not obstructed left" do
	  @board.board[@queen.y_position][@queen.x_position - 1] = nil
	  expect(@queen.is_move_obstructed?(@queen.x_position - 2, @queen.y_position, @board)).to be false
	end

	it "is obstructed right" do
	  expect(@queen.is_move_obstructed?(@queen.x_position + 2, @queen.y_position, @board)).to be true
	end

	it "is not obstructed right" do
	  @board.board[@queen.y_position][@queen.x_position + 1] = nil
	  expect(@queen.is_move_obstructed?(@queen.x_position + 2, @queen.y_position, @board)).to be false
	end
      end

      context "move vertically" do
	it "is obstructed up" do
	  expect(@queen.is_move_obstructed?(@queen.x_position, @queen.y_position - 2, @board)).to be true
	end

	it "is not obstructed up" do
	  @board.board[@queen.y_position - 1][@queen.x_position] = nil
	  expect(@queen.is_move_obstructed?(@queen.x_position, @queen.y_position - 2, @board)).to be false
	end


	it "is obstructed down" do
	  expect(@queen.is_move_obstructed?(@queen.x_position, @queen.y_position + 2, @board)).to be true
	end

	it "is not obstructed down" do
	  @board.board[@queen.y_position + 1][@queen.x_position] = nil
	  expect(@queen.is_move_obstructed?(@queen.x_position, @queen.y_position + 2, @board)).to be false
	end
      end
    end
    describe "knight movement" do
      context "has a pawn in the way" do
	it "is not obstructed" do
	  @board.board[3][3] = Knight.new(x_position: 3, y_position: 3)
	  knight = @board.board[3][3]
	  expect(knight.is_move_obstructed?(knight.x_position + 1, knight.y_position + 2, @board)).to be false
	end
      end

      context "target space has another piece" do
	it "move is obstructed" do
	  @board.board[3][3] = Knight.new(x_position: 3, y_position: 3)
	  knight = @board.board[3][3]
	  @board.board[5][4] = double('pawn')
	  expect(knight.is_move_obstructed?(knight.x_position + 1, knight.y_position + 2, @board)).to be true
	end
      end
    end
  end
end
