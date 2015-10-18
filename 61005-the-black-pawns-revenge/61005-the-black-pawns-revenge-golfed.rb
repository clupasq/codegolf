# http://codegolf.stackexchange.com/questions/61005/the-black-pawns-revenge
require 'pp'

POINTS = {
  'P' => 1, 
  'B' => 3,
  'N' => 3,
  'R' => 5,
  'Q' => 9
}

def solve(l,w=p)
  c, *x = l.map &:dup
  y = w||c.index(?L)

  n = x[0]

  s = POINTS[c[y]]||0
  w&&c[y]=?X

  unless n
    return [s, c]
  end

  m = []
  m << solve(x,y) if n[y]==?-
  m << solve(x,y-1) if y>0&&n[y-1]>?-
  m << solve(x,y+1) if y<8&&n[y+1]>?-

  b = m.max_by{ |m| m&&m[0]||0 }

  if b
    return [b[0] + s, c + b[1]]
  end
end

F=
->b{
  solve(b.lines)[1]
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

