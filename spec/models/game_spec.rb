require 'rails_helper'

RSpec.describe Game, :type => :model do
  describe "#populate_board" do
    board = Game.new.populate_board

    it "creates black rooks" do
      expect(board[0][0]).to be_a Rook
      expect(board[0][0].color).to eql(false)

      expect(board[0][7]).to be_a Rook
      expect(board[0][7].color).to eql(false)
    end

    it "creates black knights" do
      expect(board[0][1]).to be_a Knight
      expect(board[0][1].color).to eql(false)

      expect(board[0][6]).to be_a Knight
      expect(board[0][6].color).to eql(false)
    end

    it "creates black bishops" do
      expect(board[0][2]).to be_a Bishop
      expect(board[0][2].color).to eql(false)

      expect(board[0][5]).to be_a Bishop
      expect(board[0][5].color).to eql(false)
    end

    it "creates black queen" do
      expect(board[0][3]).to be_a Queen
      expect(board[0][3].color).to eql(false)
    end

    it "creates black king" do
      expect(board[0][4]).to be_a King
      expect(board[0][4].color).to eql(false)
    end

    it "creates black pawns" do
      board[1].each { |pawn| expect(pawn).to be_a Pawn }
      board[1].each { |pawn| expect(pawn.color).to eql(false) }
    end
    
    it "creates white rooks" do
      expect(board[7][0]).to be_a Rook
      expect(board[7][0].color).to eql(true)

      expect(board[7][7]).to be_a Rook
      expect(board[7][7].color).to eql(true)
    end

    it "creates white knights" do
      expect(board[7][1]).to be_a Knight
      expect(board[7][1].color).to eql(true)

      expect(board[7][6]).to be_a Knight
      expect(board[7][6].color).to eql(true)
    end

    it "creates white bishops" do
      expect(board[7][2]).to be_a Bishop
      expect(board[7][2].color).to eql(true)

      expect(board[7][5]).to be_a Bishop
      expect(board[7][5].color).to eql(true)
    end

    it "creates white queen" do
      expect(board[7][3]).to be_a Queen
      expect(board[7][3].color).to eql(true)
    end

    it "creates white king" do
      expect(board[7][4]).to be_a King
      expect(board[7][4].color).to eql(true)
    end

    it "creates white pawns" do
      board[6].each { |pawn| expect(pawn).to be_a Pawn }
      board[6].each { |pawn| expect(pawn.color).to eql(true) }
    end
  end
end
