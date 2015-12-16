# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
test_player = Player.create(first_name: 'Test', email: 'test@test.com', password: 'password')
test_player_two = Player.create(first_name: 'Test Two', email: 'test2@test.com', password: 'password')
games = Game.create([
		    { name: 'Castling', turn: test_player.id, player_one_id: test_player.id, player_two_id: test_player.id }, 
		    { name: 'Pawn Promotion', turn: test_player.id, player_one_id: test_player.id, player_two_id: test_player.id},
		    { name: 'Turn Testing', turn: test_player.id, player_one_id: test_player.id, player_two_id: test_player_two.id},
		    { name: 'Checkmate', turn: test_player.id, player_one_id: test_player.id, player_two_id: test_player.id}
])

castle = Game.find_by(name: 'Castling')
pawn = Game.find_by(name: 'Pawn Promotion')
turn = Game.find_by(name: 'Turn Testing')
checkmate = Game.find_by(name: 'Checkmate')

# Create pawns for pawn promotion
8.times do |x|
  Pawn.create(x_position: x, y_position: 6, color: false, player_id: test_player.id, game_id: pawn.id)
  Pawn.create(x_position: x, y_position: 1, color: true, player_id: test_player.id, game_id: pawn.id)
end

# Create rooks and kings for castling
Rook.create(x_position: 0, y_position: 0, color: false, player_id: test_player.id, game_id: castle.id)
Rook.create(x_position: 7, y_position: 0, color: false, player_id: test_player.id, game_id: castle.id)
Rook.create(x_position: 0, y_position: 7, color: true, player_id: test_player.id, game_id: castle.id)
Rook.create(x_position: 7, y_position: 7, color: true, player_id: test_player.id, game_id: castle.id)
King.create(x_position: 4, y_position: 0, color: false, player_id: test_player.id, game_id: castle.id)
King.create(x_position: 4, y_position: 7, color: true, player_id: test_player.id, game_id: castle.id)

# Create normal game for Turn Management
board = Board.new
board.populate(turn.id, test_player.id, test_player_two.id)

# Create normal game for Check testing
board = Board.new
board.populate(checkmate.id, test_player.id, test_player.id)
