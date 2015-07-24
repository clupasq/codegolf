# coding: utf-8
require 'pp'
require 'minitest/autorun'

K=
->t{s=r=t.size
i=m=t[o=/ +/].size
(0...2**t.scan(y=/\|+/).size).map{|n|q=-1
x=t.gsub(y){|r|n[q+=1]<1?r:'\/'*r.size}
d=i+s-x.size
d<0||d<m&&r=x.gsub(o,' '*m=d)}
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




