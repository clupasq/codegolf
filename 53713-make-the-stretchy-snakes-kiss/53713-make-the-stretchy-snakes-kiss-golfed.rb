# coding: utf-8
require 'pp'
require 'minitest/autorun'

K=
->t{
c=->s{(0...2**s.scan(/(\|+)/).size).map{|i|x=-1;s.gsub(/\|+/){|r|i[x+=1]<1?r:'\/'*r.size}}}
a,b=r=t.split
s=m=t.size
c[a].product(c[b]){|a,b|d=(a+b).size-s
d>-1&&d<m&&r=a+' '*(m=d)+b}
r}

describe K do 
  def test_case_1
    assert_equal '<\/=||:)~~(:\/\/\/=\/>', K['<|=||:)~     ~(:|||=|>']
  end

  def test_case_2
    assert_equal '<\/\/=||||:)~ ~(:\/\/>', K['<||=||||:)~   ~(:||>']
  end
end




