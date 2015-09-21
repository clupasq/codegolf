
F=->s,m{
  y=s.chars.chunk{|x|x}.map{|c,a|
    l=a.size
    d=[3,5].count{|z|l%z<1}

    c!=m ?0:l<2||d>1?1:d>0?-1:0
  }

  y.reduce(0, :+)
}

require 'minitest/autorun'

describe F do
  def test_cases
    assert_equal 1, F['a', 'a']
    assert_equal -1, F['aaa', 'a']
    assert_equal -1, F['aaaaa', 'a']
    assert_equal 1, F['aaaaaaaaaaaaaaa', 'a']
    assert_equal 0, F['aa', 'a']

    assert_equal 2, F['aba', 'a']
    assert_equal 1, F['aaba', 'a']
    assert_equal 0, F['aaaba', 'a']
    assert_equal -1, F['aaaaaa', 'a']
  end
end
