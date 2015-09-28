
F=
->d{o=[]
c={}
d=d.sort_by{|w|[w.size,w]}.map{|w|w=w.upcase.gsub /[^A-Z]/,''
c[w]=l=1
w.size.times{|i|p,x,s=w[0...i],w[i],w[i+1..-1]
c[p+s]&&l!=x&&o<<p+"(#{w[i]})"+s
l=x}}
o}


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
