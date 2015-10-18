# http://codegolf.stackexchange.com/questions/61005/the-black-pawns-revenge
require 'pp'

POINTS = {
  'P' => 1, 
  'B' => 3,
  'N' => 3,
  'R' => 5,
  'Q' => 9
}

Result = Struct.new :points, :lines

def solve(lines, crt_pos=p)
  crt_row, *next_rows = lines.map &:dup
  pos = crt_pos||crt_row.index(?L)

  next_row = next_rows[0]

  points = POINTS[crt_row[pos]]||0
  crt_row[pos] = ?X if crt_pos

  unless next_row
    return Result.new points, crt_row
  end

  next_moves = []
  next_moves << solve(next_rows, pos) if next_row[pos] == ?-
  next_moves << solve(next_rows, pos-1) if pos > 0 && next_row[pos-1] > ?-
  next_moves << solve(next_rows, pos+1) if pos < 8 && next_row[pos+1] > ?-

  # pp next_moves

  best_move = next_moves.compact.max_by{ |m| m.points }

  if best_move
    return Result.new(best_move.points + points, crt_row + best_move.lines)
  end
end

F=
->board{
  solve(board.lines).lines
}

require 'minitest/autorun'

describe F do
  def test_case_1
    input = <<-EOS
----L---
-----P--
------P-
--R--P-Q
----P-P-
---P-P-P
--P-N---
-P------
EOS

    F[input].must_equal <<-EOS
----L---
-----X--
------X-
--R--P-X
----P-X-
---P-X-P
--P-X---
-P--X---
EOS
  end

  def test_case_2
    input = <<-EOS
--L-----
-P------
P-------
-P------
P--Q----
-P------
P-------
-P------
EOS

    F[input].must_equal <<-EOS
--L-----
-PX-----
P-X-----
-PX-----
P--X----
-P-X----
P--X----
-P-X----
EOS
  end

end

