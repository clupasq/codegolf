# rubocop: disable all
require 'minitest/autorun'

#125

F=
->q{a=q.chars.map{|c|[c,c=~/[a-z]/i&&c.ord%32]}
while i=a.index{|c,s|s}
c,s=a.delete_at i
a.insert (i+s)%q.size,[c]
end
a*''}

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
