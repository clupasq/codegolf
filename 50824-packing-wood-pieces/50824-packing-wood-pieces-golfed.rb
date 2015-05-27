require 'minitest/autorun'

F=
->m,n{[[m,n],[m,n.reverse],[n,m],[n,m.reverse]].map{|u,d|[(0..l=u.size).find{|i|(d.to_i(2)<<i)&u.to_i(2)<1}+d.size,l].max}.min}

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

  def test_new_1
    assert_equal 5, F['0010', '10111']
  end

  def test_new_2
    assert_equal 5, F['0100', '10111']
  end

  def test_new_3
    assert_equal 5, F['0010', '11101']
  end

  def test_new_4
    assert_equal 5, F['0100', '11101']
  end

  def test_new_5
    assert_equal 5, F['10111', '0010']
  end

  def test_new_6
    assert_equal 5, F['10111', '0100']
  end

  def test_new_7
    assert_equal 5, F['11101', '0010']
  end

  def test_new_8
    assert_equal 5, F['11101', '0100']
  end
end
