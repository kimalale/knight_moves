require 'set'

class Chess

  ENV_SIZE = 8

  # Ensure illegal move are not allowed
  def is_in_bounds(coordinate)
    return 0 <= coordinate[0] && coordinate[0] < ENV_SIZE && 0 <= coordinate[1] && coordinate[1] < ENV_SIZE
  end

end


class Knight < Chess

   # Generate possible moves
  def get_knight_moves(coordinate)

    valid_moves = []
    #Generate all possible moves
    x = [2, 1, -1, -2, -2, -1, 1, 2]
    y = [1, 2, 2, 1, -1, -2, -2, -1]

    #Store valid moves
    ENV_SIZE.times do |n|
      move = [coordinate[0] + x[n], coordinate[1] + y[n]]
      valid_moves << move if is_in_bounds(move)
    end

    valid_moves
  end

  # Search for the shortest path
  def breadth_first_search(start, finish)
    queue = [[start, [start]]]
    visited = Set.new

    until queue.empty?

      (x, y), moves = queue.shift

      return moves if [x, y] == finish
      visited.add([x, y])


      get_knight_moves([x, y]).each do |nx, ny|
        if !visited.include?([nx, ny])
         queue << [[nx, ny], moves + [[nx, ny]]]
        end
      end
    end
  end

  def knight_moves(start, dest)

    knight_path = breadth_first_search(start, dest)
    knight_path
  end

end
