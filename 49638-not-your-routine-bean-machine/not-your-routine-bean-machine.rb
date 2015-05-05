# coding: utf-8
require 'minitest/autorun'

F=->input {
  probabilities = [1.0]

  input.lines.map{|line|
    elements = line.scan /\S/
    new_probabilities = [0.0]*(probabilities.size+1)
    
    elements.map.with_index{|el, i|
      case el
      when ?^
        new_probabilities[i] += probabilities[i]/2
        new_probabilities[i+1] += probabilities[i]/2
      when ?/
        new_probabilities[i] += probabilities[i]
      when ?\\
        new_probabilities[i+1] += probabilities[i]
      end
    }
    probabilities = new_probabilities
  }
  probabilities
}

describe '#F' do
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