# coding: utf-8

N=Struct.new:l
def g(c)
  @n = []
  c.map{|m|m==0?(@n<<N.new([])):m==1?(n=N.new([]);@n.map{|x|x.l<<n;n.l<<x};@n<<n):(@n-=r=@n.select{|x|x.l.size%m<1};@n.map{|x|x.l-=r})}
  @n.size
end

#--------------------------------------------------

require "minitest/autorun"

class TestGraph < MiniTest::Unit::TestCase

  def setup
    
  end

  def test_empty
    assert_equal 0, result([])
  end
  def test_1
    assert_equal 4, result([0,1,0,1,0,1,3])
  end
  def test_2
    assert_equal 0, result([5])
  end
  def test_3
    assert_equal 0, result([0, 0, 0, 11])
  end
  def test_4
    assert_equal 6, result([0,0,0,1,1,1])
  end
  def test_5
    assert_equal 6, result([0,0,1,1,0,0,1,1,2,5,7,0,1])
  end
  def test_6
    assert_equal 6, result([0,0,1,1,1,1,5,1,4,3,1,0,0,0,1,2])
  end
  def test_7
    assert_equal 8, result([0,0,1,1,0,0,1,1,5,2,3,0,0,1,1,0,0,1,1,3,4,0,0,1,1,2,1,1])
  end
  def test_8
    assert_equal 14, result([0,0,1,1,0,0,1,1,2,5,7,0,1,1,1,1,1,0,1,1,1,1,1,1,1,1,8])
  end

  def result(commands)
    g(commands)
  end
end