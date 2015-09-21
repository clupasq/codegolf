
F=-> str, match_char {
  y = str.chars.chunk{|x|x}.map{|char, arr|
    l = arr.size
    case
    when char != match_char
      0
    when l == 1
      1
    when l % 3 == 0 && l % 5 == 0
      1
    when l % 3 == 0 || l % 5 == 0
      -1
    else
      0
    end
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
