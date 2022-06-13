require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :children, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @prev_move_pos = prev_move_pos
    @next_mover_mark = next_mover_mark
    @children = []

  end

  def losing_node?(evaluator)
    next_mark = (next_mover_mark == :x) ? :o : :x
    loser = (evaluator == :x) ? :o : :x
    return true if loser == @board.winner
    return true if @children.all? {|child| child.losing_node?(next_mark)}
    
    #false
  end

  def winning_node?(evaluator)
    return true if @board.winner == evaluator
    @children.each do |el|
      return true if @children.winning_node?
    end
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    next_mark = (@next_mover_mark == :x) ? :o : :x
    (0..2).each do |i|
      (0..2).each do |j|
        @board_dup = @board.dup
        pos = [i,j]
        if @board_dup.empty?(pos)
          
          @board_dup[pos] = @next_mover_mark
          
          @children << TicTacToeNode.new(@board_dup, next_mark, pos)
        end
      end
    end
    return @children
  end
end

b = Board.new
t = TicTacToeNode.new(b, :x)
# p t.children