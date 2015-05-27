require 'minitest/autorun'

def pack_length piece1, piece2
  min_possible_packed_length = [
    min_packed_length(piece1, piece2),
    min_packed_length(piece1, piece2.reverse),
    min_packed_length(piece2, piece1),
    min_packed_length(piece2, piece1.reverse)
  ].min

  min_possible_packed_length
end

def min_packed_length up_piece, down_piece
  x = up_piece.to_i 2
  y = down_piece.to_i 2

  min_packed_shift = (0..up_piece.size).find{|i| (y<<i)&x<1 }

  # min pack length cannot be smaller than any of the 
  # two pieces
  [min_packed_shift + down_piece.size, up_piece.size].max
end


describe '#pack_length' do
  def test_1
    assert_equal 1, pack_length('0', '0')
  end

  def test_2
    assert_equal 1, pack_length('1', '0')
  end

  def test_3
    assert_equal 2, pack_length('1', '1')
  end

  def test_4
    assert_equal 5, pack_length('11', '111')
  end

  def test_5
    assert_equal 5, pack_length('010', '0110')
  end

  def test_6
    assert_equal 5, pack_length('0010', '111')
  end

  def test_7
    assert_equal 5, pack_length('0010', '10111')
  end

  def test_8
    assert_equal 6, pack_length('00010', '11011')
  end

  def test_9
    assert_equal 5, pack_length('01010', '10101')
  end

  def test_a
    assert_equal 6, pack_length('1001', '100001')
  end

  def test_b
    assert_equal 14, pack_length('1110001100001', '1100100101')
  end

  def test_c
    assert_equal 16, pack_length('001101010000101', '100010110000')
  end

  def test_d
    assert_equal 21, pack_length('0010110111100', '001011010101001000000')
  end

  def test_e
    assert_equal 28, pack_length('0010110111100', '001011010101001001100')
  end

  def test_f
    assert_equal 27, pack_length('100010100100111101', '11100101100010100100000001')
  end

  def test_new_1
    assert_equal 5, pack_length('0010', '10111')
  end

  def test_new_2
    assert_equal 5, pack_length('0100', '10111')
  end

  def test_new_3
    assert_equal 5, pack_length('0010', '11101')
  end

  def test_new_4
    assert_equal 5, pack_length('0100', '11101')
  end

  def test_new_5
    assert_equal 5, pack_length('10111', '0010')
  end

  def test_new_6
    assert_equal 5, pack_length('10111', '0100')
  end

  def test_new_7
    assert_equal 5, pack_length('11101', '0010')
  end

  def test_new_8
    assert_equal 5, pack_length('11101', '0100')
  end
end
