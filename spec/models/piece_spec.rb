require 'rails_helper'

RSpec.describe Piece, :type => :model do
  describe "#is_move_obstructed?" do
    before :each do
      @board = Board.new
      @board.board[3][3] = Queen.new(x_position: 3, y_position: 3, color: false)
      @board.board[2][2] = Pawn.new(x_position: 2, y_position: 2, color: false)
      @board.board[2][3] = Pawn.new(x_position: 3, y_position: 2, color: false)
      @board.board[2][4] = Pawn.new(x_position: 4, y_position: 2, color: false)
      @board.board[3][2] = Pawn.new(x_position: 2, y_position: 3, color: false)
      @board.board[3][4] = Pawn.new(x_position: 4, y_position: 3, color: false)
      @board.board[4][2] = Pawn.new(x_position: 2, y_position: 4, color: false)
      @board.board[4][3] = Pawn.new(x_position: 3, y_position: 4, color: false)
      @board.board[4][4] = Pawn.new(x_position: 4, y_position: 4, color: false)

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
	  @board.board[3][3] = Knight.new(x_position: 3, y_position: 3, color: false)
	  knight = @board.board[3][3]
	  expect(knight.is_move_obstructed?(knight.x_position + 1, knight.y_position + 2, @board)).to be false
	end
      end

      context "target space has another piece" do
	it "move is obstructed" do
	  @board.board[3][3] = Knight.new(x_position: 3, y_position: 3, color: false)
	  knight = @board.board[3][3]
	  @board.board[5][4] = Pawn.new(x_position: 4, y_position: 5, color: false)
	  expect(knight.is_move_obstructed?(knight.x_position + 1, knight.y_position + 2, @board)).to be true
	end
      end
    end
  end

  describe "#legal_move?" do
    before :each do
      @board = Board.new
    end

    context "king movement" do
      it "is a legal move" do
	@board.board[4][0] = King.new(x_position: 4, y_position: 0)
	king = @board.board[4][0]
	expect(king.legal_move?(king.x_position + 1, king.y_position)).to be true
	expect(king.legal_move?(king.x_position + 2, king.y_position)).to be false
      end
    end

    context "bishop movement" do
      it "is a legal move" do
	@board.board[2][0] = Bishop.new(x_position: 2, y_position: 0)
	bishop = @board.board[2][0]
	expect(bishop.legal_move?(bishop.x_position + 1, bishop.y_position)).to be false
	expect(bishop.legal_move?(bishop.x_position + 1, bishop.y_position + 1 )).to be true
      end
    end

    context "knight movement" do
      it "is a legal move" do
	@board.board[1][0] = Knight.new(x_position: 1, y_position: 0)
	knight = @board.board[1][0]
	expect(knight.legal_move?(knight.x_position + 3, knight.y_position + 0)).to be false
	expect(knight.legal_move?(knight.x_position + 4, knight.y_position + 0)).to be false
	expect(knight.legal_move?(knight.x_position + 1, knight.y_position + 2)).to be true
	expect(knight.legal_move?(knight.x_position + 2, knight.y_position + 1)).to be true
      end
    end

    context "pawn movement" do
      it "first move is a legal move" do
	@board.board[0][1] = Pawn.new(color: false, x_position: 0, y_position: 1)
	pawn = @board.board[0][1]
	expect(pawn.legal_move?(pawn.x_position + 1, pawn.y_position)).to be false
	expect(pawn.legal_move?(pawn.x_position, pawn.y_position + 2)).to be true
	expect(pawn.legal_move?(pawn.x_position, pawn.y_position + 1)).to be true
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

    context "queen movement" do
      it "is a legal move" do
	@board.board[3][0] = Queen.new(x_position: 3, y_position: 0)
	queen = @board.board[3][0]
	expect(queen.legal_move?(queen.x_position, queen.y_position + 4 )).to be true
	expect(queen.legal_move?(queen.x_position + 1, queen.y_position + 1 )).to be true
      end
    end

    context "rook movement" do
      it "is a legal move" do
	@board.board[0][0] = Rook.new(x_position: 0, y_position: 0)
	rook = @board.board[0][0]
	expect(rook.legal_move?(rook.x_position, rook.y_position + 4 )).to be true
	expect(rook.legal_move?(rook.x_position + 1, rook.y_position + 1 )).to be false
      end
    end
  end

	describe "#attempt_move" do
    before :each do
      @game = Game.create
      @board = Board.new
      @pawn = Pawn.create(x_position: 0, y_position: 1, color: false, game_id: @game.id)
      @king = King.create(x_position: 4, y_position: 0, color: false, game_id: @game.id)
      @board.board[1][0] = @pawn
      @board.board[4][0] = @king
      @board.refresh(@game.id)
    end

    context "piece" do
      it "invalid move distance" do
	expect(@pawn.attempt_move(@pawn.x_position, @pawn.y_position + 3, @board, @pawn.color, @game.id)).to be false
      end

      it "path is blocked" do
	piece = Pawn.new(x_position: 0, y_position: 2)
	@board.board[2][0] = piece
	@board.refresh(@game.id)
	expect(@pawn.attempt_move(@pawn.x_position, @pawn.y_position + 2, @board, @pawn.color, @game.id)).to be false
      end

      it "invalid move direction" do
	expect(@pawn.attempt_move(@pawn.x_position + 1, @pawn.y_position, @board, @pawn.color, @game.id)).to be false
      end

      it "lands on another piece of same color" do
	piece = Pawn.new(x_position: 0, y_position: 2, color: false)
	@board.board[2][0] = piece
	@board.refresh(@game.id)
	expect(@pawn.attempt_move(@pawn.x_position, @pawn.y_position + 1, @board, @pawn.color, @game.id)).to be false
      end
    end

    context "king attempts to move into check" do
    	it "invalid move into check" do
  check_piece = Bishop.create(x_position: 6, y_position: 3, color: true, game_id: @game.id)
  @board.refresh(@game.id)
  expect(@king.attempt_move(@king.x_position, @king.y_position + 1, @board, @king.color, @game.id)).to be false
    	end
   end
    

    context 'king tries to castle with no pieces in the way' do
    	it 'is a legal move' do
   rook = Rook.create(x_position: 0, y_position: 0, color: false, game_id: @game.id)
   @board.refresh(@game.id)
   expect(@king.attempt_move(@king.x_position - 2, @king.y_position, @board, @king.color, @game.id)).to be true
    	end
    end

    context 'king tries to castle with pieces in the way' do
      it 'fails kingside' do
  @rook = Rook.create(x_position: 7, y_position: 0, color: false, game_id: @game.id)
	@board.board[7][5] = Bishop.create(x_position: 5, y_position: 0, color: true, game_id: @game.id)
	@board.refresh(@game.id)
	expect(@king.attempt_move(@king.x_position + 2, @king.y_position, @board, @king.color, @game.id)).to be false
      end

      it 'fails queenside' do
	@rook = Rook.create(x_position: 0, y_position: 0, color: false, game_id: @game.id)
	Bishop.create(x_position: 2, y_position: 0, color: true, game_id: @game.id)
	@board.refresh(@game.id)
	expect(@king.attempt_move(@king.x_position - 2, @king.y_position, @board, @king.color, @game.id)).to be false
    end 
  end
end

  describe '.capture' do
    before :each do
      @game = Game.create
      @board = Board.new
      @board.board[2][2] = Pawn.new(x_position: 2, y_position: 2, game_id: @game.id)
      @pawn = @board.board[2][2]
      @attacker = Rook.new(x_position: 2, y_position: 3, game_id: @game.id)
      @board.board[3][2] = @attacker
      @x = 2
      @y = 2
    end

    context 'when captured' do
      it 'the board space is nil' do
	@attacker.capture(@x, @y, @board)
	expect(@board.board[2][2]).to equal nil
      end
    end
  end
end
