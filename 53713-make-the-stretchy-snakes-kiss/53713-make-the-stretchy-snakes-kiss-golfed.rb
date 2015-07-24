# coding: utf-8
require 'pp'
require 'minitest/autorun'

K=
->t{
c=->s{(0...2**s.scan(y=/\|+/).size).map{|i|x=-1;s.gsub(y){|r|i[x+=1]<1?r:'\/'*r.size}}}
s=r=t.size
i=m=t[/ +/].size
c[t].map{|x|d=i+s-x.size
d>-1&&d<m&&(r=x.gsub(/ +/,' '*m=d))}
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




