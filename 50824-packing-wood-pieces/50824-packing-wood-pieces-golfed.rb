require 'minitest/autorun'

F=
->m,n{[M[m,n],M[m,n.reverse],M[n,m],M[n,m.reverse]].min}
M=->u,d{[(0..l=u.size).find{|i|(d.to_i(2)<<i)&u.to_i(2)<1}+d.size,l].max}

describe F do
  def test_1
    assert_equal 1, F['0', '0']
  end

  def test_2
    assert_equal 1, F['1', '0']
  end

  def test_3
    assert_equal 2, F['1', '1']
  end

  def test_4
    assert_equal 5, F['11', '111']
  end

  def test_5
    assert_equal 5, F['010', '0110']
  end

  def test_6
    assert_equal 5, F['0010', '111']
  end

  def test_7
    assert_equal 5, F['0010', '10111']
  end

  def test_8
    assert_equal 6, F['00010', '11011']
  end

  def test_9
    assert_equal 5, F['01010', '10101']
  end

  def test_a
    assert_equal 6, F['1001', '100001']
  end

  def test_b
    assert_equal 14, F['1110001100001', '1100100101']
  end

  def test_c
    assert_equal 16, F['001101010000101', '100010110000']
  end

  def test_d
    assert_equal 21, F['0010110111100', '001011010101001000000']
  end

  def test_e
    assert_equal 28, F['0010110111100', '001011010101001001100']
  end

  def test_f
    assert_equal 27, F['100010100100111101', '11100101100010100100000001']
  end
end
