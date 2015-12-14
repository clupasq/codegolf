# rubocop: disable all
require 'minitest/autorun'

#149

F=
->s{a=s.chars.map{|c|[c,c=~/[a-z]/i&&c.upcase.ord-64]}
z=a.size
while i=a.index{|c|c[1]}
c=a.delete_at i
n=(i+c[1])%z
c[1]=p
a.insert(n,c)
end

a.join}

describe :MovingLetters do
  def test_case_1
    assert_equal 'tca', F['cat']
  end

  def test_case_2
    assert_equal '.F.NU', F['F.U.N']
  end

  def test_case_3
    assert_equal 'goD', F['Dog']
  end

  def test_case_4
    assert_equal '*hibey', F['hi*bye']
  end
end
