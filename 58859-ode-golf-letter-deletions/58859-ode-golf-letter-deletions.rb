
F=
-> dict {
  output = []
  smaller_words = {}
  dict = dict.sort_by{|word|[word.size, word]}.map do |word|
    word = word.upcase.gsub /[^A-Z]/, ''
    smaller_words[word]=l=1
    word.size.times do |i|
      prefix = word[0...i]
      suffix = word[i+1..-1]

      if smaller_words[prefix + suffix] && word[i] != l
        output << "#{prefix}(#{word[i]})#{suffix}"
      end
      l = word[i]
    end
  end
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

  def test_case_3
    assert_equal [
        'SCRA(P)PED'], 
      F[[
        'scrapped', 
        'scraped']]
  end
end
