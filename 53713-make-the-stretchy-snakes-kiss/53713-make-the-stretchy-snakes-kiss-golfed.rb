# coding: utf-8
require 'pp'
require 'minitest/autorun'

K=
->t{
s=r=t.size
i=m=t[/ +/].size
(0...2**t.scan(y=/\|+/).size).map{|i|x=-1;t.gsub(y){|r|i[x+=1]<1?r:'\/'*r.size}}.map{|x|d=i+s-x.size
d<0||d<m&&(r=x.gsub(/ +/,' '*m=d))}
r}

describe K do 
  def test_case_0
    assert_equal '<\/=||:)~~(:\/\/\/\/>', K['<|=||:)~     ~(:||||>']
  end

  def test_case_1
    assert_equal '<|=\/\/:)~~(:\/\/\/=|>', K['<|=||:)~     ~(:|||=|>']
  end

  def test_case_2
    assert_equal '<\/\/=||||:)~ ~(:||>', K['<||=||||:)~   ~(:||>']
  end
end




