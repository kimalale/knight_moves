require './lib/binary-search-tree'
require 'set'

class Chess

  ENV_SIZE = 8

  # Ensure illegal move are not allowed
  def is_in_bounds(coordinate)
    return 0 <= coordinate[0] && coordinate[0] < ENV_SIZE && 0 <= coordinate[1] && coordinate[1] < ENV_SIZE
  end

  # Generate possible moves
  def get_moves(coordinate)

    valid_moves = []
    #Generate all possible moves
    x = [2, 1, -1, -2, -2, -1, 1, 2]
    y = [1, 2, 2, 1, -1, -2, -2, -1]

    #Store valid moves
    ENV_SIZE.times do |n|
      move = [coordinate[0] + x[n], coordinate[1] + y[n]]
      valid_moves << move if is_valid_move(move)
    end

    valid_moves
  end


end
