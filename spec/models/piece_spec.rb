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

#Legal Moves

	describe "king movement" do
    it "is a legal move" do
      @board.board[4][0] = King.new(x_position: 4, y_position: 0)
      king = @board.board[4][0]
      expect(king.legal_move?(king.x_position + 1, king.y_position)).to be true
      expect(king.legal_move?(king.x_position + 2, king.y_position)).to be false
	end
	  end

	describe "bishop movement" do
    it "is a legal move" do
      @board.board[2][0] = Bishop.new(x_position: 2, y_position: 0)
      bishop = @board.board[2][0]
      expect(bishop.legal_move?(bishop.x_position + 1, bishop.y_position)).to be false
      expect(bishop.legal_move?(bishop.x_position + 1, bishop.y_position + 1 )).to be true
	end
	  end

	describe "knight movement" do
    it "is a legal move" do
      @board.board[1][0] = Knight.new(x_position: 1, y_position: 0)
      knight = @board.board[1][0]
      expect(knight.legal_move?(knight.x_position + 3, knight.y_position + 0)).to be false
      expect(knight.legal_move?(knight.x_position + 4, knight.y_position + 0)).to be false
      expect(knight.legal_move?(knight.x_position + 1, knight.y_position + 2)).to be true
      expect(knight.legal_move?(knight.x_position + 2, knight.y_position + 1)).to be true
	end
	  end

	describe "pawn movement" do
	  context "first move" do
    it "is a legal move" do
      @board.board[0][1] = Pawn.new(color: false, x_position: 0, y_position: 1)
      pawn = @board.board[0][1]
      expect(pawn.legal_move?(pawn.x_position + 1, pawn.y_position)).to be false
      expect(pawn.legal_move?(pawn.x_position, pawn.y_position + 2)).to be true
      expect(pawn.legal_move?(pawn.x_position, pawn.y_position + 1)).to be true
	end
	  end
	end

	  context "not the first move" do
    it "is a legal move" do
      @board.board[2][4] = Pawn.new(color: true, x_position: 2, y_position: 4)
      pawn = @board.board[2][4]
      expect(pawn.legal_move?(pawn.x_position, pawn.y_position + 1)).to be false
      expect(pawn.legal_move?(pawn.x_position, pawn.y_position - 2)).to be false
      expect(pawn.legal_move?(pawn.x_position, pawn.y_position - 1)).to be true
	end
	  end

	describe "queen movement" do
    it "is a legal move" do
      @board.board[3][0] = Queen.new(x_position: 3, y_position: 0)
      queen = @board.board[3][0]
      expect(queen.legal_move?(queen.x_position, queen.y_position + 4 )).to be true
      expect(queen.legal_move?(queen.x_position + 1, queen.y_position + 1 )).to be true
	end
	  end

	describe "rook movement" do
    it "is a legal move" do
      @board.board[0][0] = Rook.new(x_position: 0, y_position: 0)
      rook = @board.board[0][0]
      expect(rook.legal_move?(rook.x_position, rook.y_position + 4 )).to be true
      expect(rook.legal_move?(rook.x_position + 1, rook.y_position + 1 )).to be false
	end
	  end

  end

	describe "#in_check?" do
  	before :each do
  		@board = Board.new
  		@board.board[4][0] = King.new(color: false, x_position: 4, y_position: 0)
  		@board.board[4][4] = Rook.new(color: true, x_position: 4, y_position: 4)
  		@board.board[5][7] = King.new(color: true, x_position: 5, y_position: 7)
  		@king = @board.board[4][0]
  		@rook = @board.board[4][4]
  		@king2 = @board.board[5][7]
  	end

  	it "is in check" do
  		expect(@king.in_check?(@king.x_position, @king.y_position, @king.color, @game)).to be true
  	end

  	it "is not in check" do
  		expect(@king2.in_check?(@king.x_position, @king.y_position, @king2.color, @game)).to be false
  	end
	end
end
