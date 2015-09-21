
F=
->s,m{s.chars.chunk{|x|x}.reduce(0){|x,(c,g)|l=g.size
t,f=l%3,l%5
x+(c!=m ?0:l<2||t+f<1?1:t*f<1?-1:0)}}

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
