
F=
-> dict {
  output = []
  smaller_words = {}
  dict = dict.sort_by{|word|[word.size, word]}.map{|w|
    w = w.upcase.gsub /[^A-Z]/, ''
    smaller_words[w]=1
    w.size.times{|i|
      prefix = w[0...i]
      suffix = w[i+1..-1]

      if smaller_words[prefix + suffix]
        output << "#{prefix}(#{w[i]})#{suffix}"
      end
    }
  }
  output
}


require 'minitest/autorun'

describe F do
  def test_case_1
    assert_equal [
        'CA(R)T', 
        '(C)ODE', 
        'I(N)PLAY', 
        'VER(S)IFY'], 
      F[[
        'cat',
        'cart',
        'code',
        'golf',
        'ode',
        'verify',
        'versify',
        'in-play',
        'IpLay']]
  end

  def test_case_2
    assert_equal [
        'MA(R)', 
        'MA(T)', 
        'MA(R)T', 
        'MAR(T)'], 
      F[[
        'mart', 
        'mar', 
        'mat', 
        'ma']]
  end
end
