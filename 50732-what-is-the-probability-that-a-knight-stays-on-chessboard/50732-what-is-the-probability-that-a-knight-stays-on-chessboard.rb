# coding: utf-8
require 'minitest/autorun'

# ungolfed
def probability_to_stay_on_board(board_size, move_count, x, y)
  range = 0...board_size
  return 0 unless range===x && range===y
  return 1 if move_count < 1

  possible_new_locations = (0..7).map do |i|
    dx, dy = [1,2].rotate i[2]
    dx *= i[0]*2-1
    dy *= i[1]*2-1

    [x+dx, y+dy]
  end

  possible_new_locations.map do |new_x, new_y| 
    probability_to_stay_on_board(board_size, move_count-1, new_x, new_y) / 8.0 
  end.inject :+
end

# golfed
P=
->l,m,x,y{!((r=0...l)===x&&r===y)?0:m<1?1:(0..7).map{|i|a,b=[1,2].rotate i[2]
P[l,m-1,x+a*(i[0]*2-1),y+b*(i[1]*2-1)]/8.0}.inject(:+)}

describe P do
  def test_0_moves
    assert_equal 1, P[5, 0, 2, 2]
  end

  def test_1_move
    assert_equal 1, P[5, 1, 2, 2]
  end

  def test_2_moves
    assert_equal 0.375, P[5, 2, 2, 2]
  end

  def test_3_moves
    assert_equal 0.25, P[5, 3, 2, 2]
  end

  def test_4_moves
    assert_equal 0.1171875, P[5, 4, 2, 2]
  end

  def test_5_moves
    assert_equal 0.06640625, P[5, 5, 2, 2]
  end
end
