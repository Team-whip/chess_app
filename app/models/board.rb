class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def populate(game_id)
    self.create_black_rooks(game_id)
    self.create_black_knights(game_id)
    self.create_black_bishops(game_id)
    self.create_black_queen(game_id)
    self.create_black_king(game_id)
    self.create_black_pawns(game_id)
    self.create_white_rooks(game_id)
    self.create_white_knights(game_id)
    self.create_white_bishops(game_id)
    self.create_white_queen(game_id)
    self.create_white_king(game_id)
    self.create_white_pawns(game_id)
    
    @board
  end


  def create_black_rooks(game_id)
    @board[0][7] = Rook.create(color: false, x_position: 8, y_position: 1, game_id: game_id)
    @board[0][0] = Rook.create(color: false, x_position: 1, y_position: 1, game_id: game_id)
  end

  def create_black_knights(game_id)
    @board[0][1] = Knight.create(color: false, x_position: 2, y_position: 1, game_id: game_id)
    @board[0][6] = Knight.create(color: false, x_position: 7, y_position: 1, game_id: game_id)
  end

  def create_black_bishops(game_id)
    @board[0][2] = Bishop.create(color: false, x_position: 3, y_position: 1, game_id: game_id)
    @board[0][5] = Bishop.create(color: false, x_position: 6, y_position: 1, game_id: game_id)
  end

  def create_black_queen(game_id)
    @board[0][3] = Queen.create(color: false, x_position: 4, y_position: 1, game_id: game_id)
  end

  def create_black_king(game_id)
    @board[0][4] = King.create(color: false, x_position: 5, y_position: 1, game_id: game_id)
  end

  def create_black_pawns(game_id)
    @board[1][0] = Pawn.create(color: false, x_position: 1, y_position: 2, game_id: game_id)
    @board[1][1] = Pawn.create(color: false, x_position: 2, y_position: 2, game_id: game_id)
    @board[1][2] = Pawn.create(color: false, x_position: 3, y_position: 2, game_id: game_id)
    @board[1][3] = Pawn.create(color: false, x_position: 4, y_position: 2, game_id: game_id)
    @board[1][4] = Pawn.create(color: false, x_position: 5, y_position: 2, game_id: game_id)
    @board[1][5] = Pawn.create(color: false, x_position: 6, y_position: 2, game_id: game_id)
    @board[1][6] = Pawn.create(color: false, x_position: 7, y_position: 2, game_id: game_id)
    @board[1][7] = Pawn.create(color: false, x_position: 8, y_position: 2, game_id: game_id)
  end

  def create_white_rooks(game_id)
    @board[7][7] = Rook.create(color: true, x_position: 8, y_position: 8, game_id: game_id)
    @board[7][0] = Rook.create(color: true, x_position: 1, y_position: 8, game_id: game_id)
  end

  def create_white_knights(game_id)
    @board[7][1] = Knight.create(color: true, x_position: 2, y_position: 8, game_id: game_id)
    @board[7][6] = Knight.create(color: true, x_position: 7, y_position: 8, game_id: game_id)
  end

  def create_white_bishops(game_id)
    @board[7][2] = Bishop.create(color: true, x_position: 3, y_position: 8, game_id: game_id)
    @board[7][5] = Bishop.create(color: true, x_position: 6, y_position: 8, game_id: game_id)
  end

  def create_white_queen(game_id)
    @board[7][3] = Queen.create(color: true, x_position: 4, y_position: 8, game_id: game_id)
  end

  def create_white_king(game_id)
    @board[7][4] = King.create(color: true, x_position: 5, y_position: 8, game_id: game_id)
  end

  def create_white_pawns(game_id)
    @board[6][0] = Pawn.create(color: true, x_position: 1, y_position: 7, game_id: game_id)
    @board[6][1] = Pawn.create(color: true, x_position: 2, y_position: 7, game_id: game_id)
    @board[6][2] = Pawn.create(color: true, x_position: 3, y_position: 7, game_id: game_id)
    @board[6][3] = Pawn.create(color: true, x_position: 4, y_position: 7, game_id: game_id)
    @board[6][4] = Pawn.create(color: true, x_position: 5, y_position: 7, game_id: game_id)
    @board[6][5] = Pawn.create(color: true, x_position: 6, y_position: 7, game_id: game_id)
    @board[6][6] = Pawn.create(color: true, x_position: 7, y_position: 7, game_id: game_id)
    @board[6][7] = Pawn.create(color: true, x_position: 8, y_position: 7, game_id: game_id)
  end
end
