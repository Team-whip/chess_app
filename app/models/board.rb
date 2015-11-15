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

    self.refresh(game_id)
  end

  def refresh(game_id)
    pieces = Piece.where(game_id: game_id)
    pieces.each do |piece|
      @board[piece.y_position][piece.x_position] = piece
    end
    @board
  end

  def piece_glyphs(y, x)
    piece = @board[y][x]
    unless piece.nil?
      case [piece.type, piece.color]
      when ["Rook", false]
	      "<i class = 'glyphicon glyphicon-tower black'></i>".html_safe
      when ["Knight", false]
        "<i class = 'glyphicon glyphicon-knight black'></i>".html_safe
      when ["Bishop", false]
        "<i class = 'glyphicon glyphicon-bishop black'></i>".html_safe
      when ["Queen", false]
        "<i class = 'glyphicon glyphicon-queen black'></i>".html_safe
      when ["King", false]
        "<i class = 'glyphicon glyphicon-king black'></i>".html_safe
      when ["Pawn", false]
        "<i class = 'glyphicon glyphicon-pawn black'></i>".html_safe
      when ["Rook", true]
	      "<i class = 'glyphicon glyphicon-tower white'></i>".html_safe
      when ["Knight", true]
        "<i class = 'glyphicon glyphicon-knight white'></i>".html_safe
      when ["Bishop", true]
        "<i class = 'glyphicon glyphicon-bishop white'></i>".html_safe
      when ["Queen", true]
        "<i class = 'glyphicon glyphicon-queen white'></i>".html_safe
      when ["King", true]
        "<i class = 'glyphicon glyphicon-king white'></i>".html_safe
      when ["Pawn", true]
        "<i class = 'glyphicon glyphicon-pawn white'></i>".html_safe
      end
    end
  end

  def create_black_rooks(game_id)
    Rook.create(color: false, x_position: 7, y_position: 0, game_id: game_id)
    Rook.create(color: false, x_position: 0, y_position: 0, game_id: game_id)
  end

  def create_black_knights(game_id)
    Knight.create(color: false, x_position: 1, y_position: 0, game_id: game_id)
    Knight.create(color: false, x_position: 6, y_position: 0, game_id: game_id)
  end

  def create_black_bishops(game_id)
    Bishop.create(color: false, x_position: 2, y_position: 0, game_id: game_id)
    Bishop.create(color: false, x_position: 5, y_position: 0, game_id: game_id)
  end

  def create_black_queen(game_id)
    Queen.create(color: false, x_position: 3, y_position: 0, game_id: game_id)
  end

  def create_black_king(game_id)
    King.create(color: false, x_position: 4, y_position: 0, game_id: game_id)
  end

  def create_black_pawns(game_id)
    Pawn.create(color: false, x_position: 0, y_position: 1, game_id: game_id)
    Pawn.create(color: false, x_position: 1, y_position: 1, game_id: game_id)
    Pawn.create(color: false, x_position: 2, y_position: 1, game_id: game_id)
    Pawn.create(color: false, x_position: 3, y_position: 1, game_id: game_id)
    Pawn.create(color: false, x_position: 4, y_position: 1, game_id: game_id)
    Pawn.create(color: false, x_position: 5, y_position: 1, game_id: game_id)
    Pawn.create(color: false, x_position: 6, y_position: 1, game_id: game_id)
    Pawn.create(color: false, x_position: 7, y_position: 1, game_id: game_id)
  end

  def create_white_rooks(game_id)
    Rook.create(color: true, x_position: 7, y_position: 7, game_id: game_id)
    Rook.create(color: true, x_position: 0, y_position: 7, game_id: game_id)
  end

  def create_white_knights(game_id)
    Knight.create(color: true, x_position: 1, y_position: 7, game_id: game_id)
    Knight.create(color: true, x_position: 6, y_position: 7, game_id: game_id)
  end

  def create_white_bishops(game_id)
    Bishop.create(color: true, x_position: 2, y_position: 7, game_id: game_id)
    Bishop.create(color: true, x_position: 5, y_position: 7, game_id: game_id)
  end

  def create_white_queen(game_id)
    Queen.create(color: true, x_position: 3, y_position: 7, game_id: game_id)
  end

  def create_white_king(game_id)
    King.create(color: true, x_position: 4, y_position: 7, game_id: game_id)
  end

  def create_white_pawns(game_id)
    Pawn.create(color: true, x_position: 0, y_position: 6, game_id: game_id)
    Pawn.create(color: true, x_position: 1, y_position: 6, game_id: game_id)
    Pawn.create(color: true, x_position: 2, y_position: 6, game_id: game_id)
    Pawn.create(color: true, x_position: 3, y_position: 6, game_id: game_id)
    Pawn.create(color: true, x_position: 4, y_position: 6, game_id: game_id)
    Pawn.create(color: true, x_position: 5, y_position: 6, game_id: game_id)
    Pawn.create(color: true, x_position: 6, y_position: 6, game_id: game_id)
    Pawn.create(color: true, x_position: 7, y_position: 6, game_id: game_id)
  end
end
