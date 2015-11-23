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

  def pieces(y, x, game)
    piece = @board[y][x]
    unless piece.nil?
    piece_id = game.pieces.where(x_position: x, y_position: y).first.id
    table_data = "<td data-x = #{x}, data-y = #{y}, data-piece-id = #{piece_id}, class = 'text-center chess-square'>"
      case [piece.type, piece.color]
      when ["Rook", false]
	table_data += "<i class = 'glyphicon glyphicon-tower black'></i>"
      when ["Knight", false]
	table_data += "<i class = 'glyphicon glyphicon-knight black'></i>"
      when ["Bishop", false]
	table_data += "<i class = 'glyphicon glyphicon-bishop black'></i>"
      when ["Queen", false]
	table_data += "<i class = 'glyphicon glyphicon-queen black'></i>"
      when ["King", false]
	table_data += "<i class = 'glyphicon glyphicon-king black'></i>"
      when ["Pawn", false]
	table_data += "<i class = 'glyphicon glyphicon-pawn black'></i>"
      when ["Rook", true]
	table_data += "<i class = 'glyphicon glyphicon-tower white'></i>"
      when ["Knight", true]
	table_data += "<i class = 'glyphicon glyphicon-knight white'></i>"
      when ["Bishop", true]
	table_data += "<i class = 'glyphicon glyphicon-bishop white'></i>"
      when ["Queen", true]
	table_data += "<i class = 'glyphicon glyphicon-queen white'></i>"
      when ["King", true]
	table_data += "<i class = 'glyphicon glyphicon-king white'></i>"
      when ["Pawn", true]
	table_data += "<i class = 'glyphicon glyphicon-pawn white'></i>"
      end
    table_data += "</td>"
    table_data.html_safe
    else 
      "<td data-x = #{x}, data-y = #{y}, data-piece-id = #{nil}, class = 'text-center chess-square'>".html_safe
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
