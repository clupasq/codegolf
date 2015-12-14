# rubocop: disable all
require 'minitest/autorun'

class MovableChar
  def initialize value
    @value = value
    is_letter = @value =~ /[[:alpha:]]/

    @move_steps = is_letter ? @value.upcase.ord - 64 : 0
  end

  attr_accessor :move_steps, :value

  def mark_moved
    @move_steps = 0
  end
end

def move(input)
  chars = input.chars.map { |c| MovableChar.new(c) }

  while index_to_move = chars.find_index { |c| c.move_steps > 0 }
    char_to_move = chars.delete_at index_to_move
    new_index = (index_to_move + char_to_move.move_steps) % (chars.size + 1)
    char_to_move.mark_moved
    chars.insert(new_index, char_to_move)
  end

  chars.map(&:value).join
end

describe MovableChar do
  it 'computes moving steps for letters case insensitive' do
    assert_equal 1, MovableChar.new('a').move_steps
    assert_equal 1, MovableChar.new('A').move_steps
    assert_equal 4, MovableChar.new('d').move_steps
    assert_equal 4, MovableChar.new('D').move_steps
  end

  it 'moving steps is zero for non-letters' do
    assert_equal 0, MovableChar.new('*').move_steps
    assert_equal 0, MovableChar.new('.').move_steps
    assert_equal 0, MovableChar.new('-').move_steps
    assert_equal 0, MovableChar.new('~').move_steps
  end

  it 'is not allowed to move more than once' do
    c = MovableChar.new('a')
    c.mark_moved
    assert_equal 0, c.move_steps
  end
end

describe :MovingLetters do
  def test_case_1
    assert_equal 'tca', move('cat')
  end

  def test_case_2
    assert_equal '.F.NU', move('F.U.N')
  end

  def test_case_3
    assert_equal 'goD', move('Dog')
  end

  def test_case_4
    assert_equal '*hibey', move('hi*bye')
  end
end
