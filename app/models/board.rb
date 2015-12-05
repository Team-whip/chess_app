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
	table_data += "<img src = '/assets/black_rook.png' class = 'img-responsive' />"
      when ["Knight", false]
	table_data += "<img src = '/assets/black_knight.png' class = 'img-responsive' />"
      when ["Bishop", false]
	table_data += "<img src = '/assets/black_bishop.png' class = 'img-responsive' />"
      when ["Queen", false]
	table_data += "<img src = '/assets/black_queen.png' class = 'img-responsive' />"
      when ["King", false]
	table_data += "<img src = '/assets/black_king.png' class = 'img-responsive' />"
      when ["Pawn", false]
	table_data += "<img src = '/assets/black_pawn.png' class = 'img-responsive' />"
      when ["Rook", true]
	table_data += "<img src = '/assets/white_rook.png' class = 'img-responsive' />"
      when ["Knight", true]
	table_data += "<img src = '/assets/white_knight.png' class = 'img-responsive' />"
      when ["Bishop", true]
	table_data += "<img src = '/assets/white_bishop.png' class = 'img-responsive' />"
      when ["Queen", true]
	table_data += "<img src = '/assets/white_queen.png' class = 'img-responsive' />"
      when ["King", true]
	table_data += "<img src = '/assets/white_king.png' class = 'img-responsive' />"
      when ["Pawn", true]
	table_data += "<img src = '/assets/white_pawn.png' class = 'img-responsive' />"
      end
      table_data += "</td>"
      table_data.html_safe
    else 
      "<td data-x = #{x}, data-y = #{y}, data-piece-id = #{nil}, class = 'text-center chess-square'>".html_safe
    end

  end

  def dead_table(game, bool)
    table_data = "<td>"
    color = nil
    bool == 'f' ? color = 'black' : color = 'white' 
    game.dead_pieces.each do |piece|
      if piece[1] == bool
	case [piece[0], bool]
	when ["Rook", bool]
	  table_data += "<i class = \"glyphicon glyphicon-tower #{color}\"></i>"
	when ["Knight", bool]
	  table_data += "<i class = \"glyphicon glyphicon-knight #{color}\"></i>"
	when ["Bishop", bool]
	  table_data += "<i class = \"glyphicon glyphicon-bishop #{color}\"></i>"
	when ["Queen", bool]
	  table_data += "<i class = \"glyphicon glyphicon-queen #{color}\"></i>"
	when ["King", bool]
	  table_data += "<i class = \"glyphicon glyphicon-king #{color}\"></i>"
	when ["Pawn", bool]
	  table_data += "<i class = \"glyphicon glyphicon-pawn #{color}\"></i>"
	end
      end
    end
    table_data += "</td>"
    table_data.html_safe
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
