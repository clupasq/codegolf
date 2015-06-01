require 'minitest/autorun'

N, W, S, E = 1, 2, 4, 8

def opposite (dir)
  dir < 3 ? dir * 4 : dir / 4
end

def goto(from, dir)
  y, x = from
  
  dx = case dir
  when W then -1
  when E then 1
  else 0
  end

  dy = case dir
  when N then -1
  when S then 1
  else 0
  end

  [y+dy, x+dx]
end


BuildTrack =->{ 


_ = {
  ?│ => [N, S],
  ?─ => [W, E],
  ?┌ => [S, E],
  ?┐ => [S, W],
  ?└ => [N, E],
  ?┘ => [N, W],
  ?┼ => [N, S, W, E], 
}

c=gets.split(?,).map &:to_i

pieces = 6.downto(0).map{|i|_.keys[i]*c[i]}.join.chars

solve=->(available_pieces,loose_ends=[[[0,0],nil]],board={}){

  return board if loose_ends==[] and available_pieces==[]

  # optimization to avoid pursuing expensive paths
  # which cannot yield a result.
  # This prunes about 90% of the search space
  c = loose_ends.map{ |c, _| c }
  not_enough_pieces = c.product(c).any? { |q, r| 
    ((q[0]-r[0])**2+(q[1]-r[1])**2) > available_pieces.size**2
  }
  return if not_enough_pieces

  position, connect_from = loose_ends.pop

  return unless position

  available_pieces.size.times do |i|
    piece = available_pieces[i]

    remaining_pieces = available_pieces[0...i] + available_pieces[i+1..-1]

    piece_not_connected_ok = connect_from && _[piece] & [connect_from] == []
    next if piece_not_connected_ok

    new_loose_ends = loose_ends.select  { |pos, dir| 
      # remove loose ends that may have been 
      # fixed, now that we placed this piece
      position != pos || _[piece] & [dir] == []
    }

    invalid_placement = false

    (_[piece]-[connect_from]).map do |dir|
      new_pos = goto(position, dir)
      new_dir = opposite(dir)

      if board[new_pos]
        if _[board[new_pos]] & [new_dir] != []
          # do nothing; already connected
        else
          # going towards an existing piece
          # which has no suitable connection
          invalid_placement = true
        end
      else
        new_loose_ends << [new_pos, new_dir]
      end
    end

    next if invalid_placement

    new_board = board.merge({position => piece})

    result = solve[remaining_pieces, new_loose_ends, new_board]
    return result if result
  end
  nil
}

def print_board board
  min_x = min_y = max_x = max_y = 0

  board.each do |position, _|
    y, x = position
    min_x = [min_x, x].min
    min_y = [min_y, y].min
    max_x = [max_x, x].max
    max_y = [max_y, y].max
  end

  str = (min_y..max_y).map{|_|
    ' ' * (max_x - min_x + 1)
  }

  board.each do |position, piece|
    y, x = position
    str[y-min_y][x-min_x] = piece
  end
  puts str
end

print_board(solve[pieces])


}

describe BuildTrack do
  # takes ~0.1s
  def test_very_simple_square
    assert_equal <<-EOS, execute("2,2,1,1,1,1,0\n")
┌─┐
│ │
└─┘
EOS
  end

  # takes ~0.6s
  def test_added_more_vertical_pieces
    assert_equal <<-EOS, execute("6,2,1,1,1,1,0\n")
┌─┐
│ │
│ │
│ │
└─┘
EOS
  end

  # takes ~0.0s
  def test_throwing_cross_pieces_into_the_mix
    assert_equal <<-EOS, execute("0,0,2,1,1,2,1\n")
 ┌┐
┌┼┘
└┘ 
EOS
  end

  # takes ~0.4s
  def test_longer_track_containing_a_cross_piece
    assert_equal <<-EOS, execute("4,4,2,1,1,2,1\n")
   ┌┐
┌──┼┘
│  │ 
│  │ 
└──┘ 
EOS
  end

  # remove the leading "x_"s to run these long lasting tests

  # takes ~34s
  def x_test_OP_testcase_1
    assert_equal <<-EOS, execute("3,5,2,2,2,2,1\n")
┌──┐┌┐
│  └┼┘
│   │ 
└───┘ 
EOS
  end

  # takes ~2s
  def x_test_OP_testcase_2
    assert_equal <<-EOS, execute("0,0,1,4,4,1,3\n")
┌┐   
└┼┐  
 └┼┐ 
  └┼┐
   └┘
EOS
  end


  def execute(input)
    capture_stdout(input){ BuildTrack[] }
  end
end


# capture STDIN/STDOUT for testing purposes
require 'stringio'
module Kernel
  def capture_stdout(console_input = '')
    $stdin = StringIO.new(console_input)
    out = StringIO.new
    out.set_encoding 'utf-8'
    $stdout = out
    yield
    return out.string
  ensure
    $stdout = STDOUT
    $stdin = STDIN
  end
end




def profile 
  require 'ruby-prof'

  # Profile the code
  RubyProf.start
  
  yield

  result = RubyProf.stop

  # Print a flat profile to text
  printer = RubyProf::FlatPrinter.new(result)
  printer.print(STDOUT)
end


def run_with_profiling
  solution = nil
  profile do 
    solution = build_track
  end
  puts print_board solution
end

def run_normally
  build_track  
end

# run_normally

