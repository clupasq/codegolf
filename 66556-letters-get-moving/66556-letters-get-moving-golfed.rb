# rubocop: disable all
require 'minitest/autorun'

def move(s)
a=s.chars.map{|c|[c,c=~/[a-z]/i&&c.upcase.ord-64]}

while i=a.index{|c|c[1]}
c=a.delete_at i
n=(i+c[1])%(a.size+1)
c[1]=p
a.insert(n,c)
end

a.join
end

describe :MovingLetters do
  def test_case_1
    assert_equal 'tca', move('cat')
  end

  def test_case_2
    assert_equal '.F.NU', move('F.U.N')
  end

  def test_case_3
    assert_equal 'goD', move('Dog')
  end

  def test_case_4
    assert_equal '*hibey', move('hi*bye')
  end
end
