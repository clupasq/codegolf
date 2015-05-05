# coding: utf-8
require 'minitest/autorun'

F=->s{r=[1.0]
s.lines.map{|l|
n=[i=0.0]*(r.size+1)
l.scan(/\S/).map{|e|a,b=e>?/?e>?]?[0.5]*2:[0,1]:[1,0]
z=r[i]
n[i]+=z*a
n[i+=1]+=z*b}
r=n}
r}

describe '#F' do
  def test_0_levels
    assert_equal [1.0], F['']
  end

  def test_1_level
    assert_equal [0.5, 0.5], F['^']
    assert_equal [1.0, 0.0], F['/']
    assert_equal [0.0, 1.0], F['\\']
  end

  def test_2_levels
    assert_equal [0.5, 0.5, 0.0], F['
 /
^ ^
      '.strip]
  end

  def test_3_levels
    assert_equal [0.125, 0.375, 0.375, 0.125], F['
  ^
 ^ ^
^ ^ ^
      '.strip]

    assert_equal [0.0, 0.0, 0.0, 1.0], F['
  \
 / \
/ / \
      '.strip]
  end

  def test_4_levels
    assert_equal [0.0, 0.1875, 0.5625, 0.125, 0.125], F['
   ^
  \ ^
 ^ ^ \
\ ^ / ^
      '.strip]
  end

  def test_7_levels
    assert_equal [0.0, 0.09375, 0.28125, 0.4375, 0.1875, 0.0, 0.0, 0.0], F['
      ^
     / ^
    ^ ^ /
   / \ / \
  ^ ^ / ^ \
 ^ \ ^ \ / ^
\ ^ ^ ^ \ ^ /
      '.strip]
  end
  
end