# rubocop: disable all
require 'minitest/autorun'

#144

F=
->s{a=s.chars.map{|c|[c,c=~/[a-z]/i&&c.upcase.ord-64]}
z=a.size
while i=a.index{|c|c[1]}
c,s=a.delete_at i
n=(i+s)%z
a.insert(n,[c,p])
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
