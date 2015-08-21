F=
-> input {
  state = [0]*8

  instructions = input.chars.flat_map do |c|
    value = c.ord
    to_print = (0..7).map{|i| value[i] }

    moves, idx = (0..7).map{|i|
      to_print_shifted = to_print.rotate i
      [(0..7).select{|j| state[j] != to_print_shifted[j]}, i]
    }.min_by{|x|x[0].size}

    moves.map{|m| state[m]=1-state[m] }
    moves.map{|m|"t #{7-m}"} + ["p #{idx}"]
  end

  instructions * "\n"
}

require 'minitest/autorun'

describe F do
  def test_case_1
    assert_equal <<-EOS.chomp, F['?']
t 7
t 6
t 5
t 4
t 3
t 2
p 0
EOS
  end

  def test_case_2
    assert_equal <<-EOS.chomp, F[':=']
t 6
t 4
t 3
t 2
p 0
t 1
p 7
EOS
  end

  def test_case_3
    assert_equal <<-EOS.chomp, F['0123456789']
t 3
t 2
p 0
t 7
p 0
t 7
t 6
p 0
t 7
p 0
t 7
t 6
t 5
p 0
t 7
p 0
t 7
t 6
p 0
t 7
p 0
t 3
t 2
p 3
t 2
p 3
EOS
  end


  def test_case_4
    assert_equal <<-EOS.chomp, F['9876543210']
t 7
t 4
t 3
t 2
p 0
t 7
p 0
t 7
t 0
p 5
t 4
p 5
t 5
t 0
p 0
t 7
p 0
t 7
t 6
t 5
p 0
t 7
p 0
t 7
t 6
p 0
t 7
p 0
EOS
  end

  def test_case_5
    assert_equal <<-EOS.chomp, F['Hello, World!']
t 4
t 1
p 0
t 7
t 3
p 2
t 6
t 1
p 2
p 2
t 1
t 0
p 2
t 3
t 1
t 0
p 2
t 7
t 6
p 2
t 7
t 6
t 2
t 0
p 1
t 5
t 1
t 0
p 0
t 7
t 2
p 3
t 6
t 2
p 0
t 4
p 0
t 1
p 3
EOS
  end

  def test_case_6
    assert_equal <<-EOS.chomp, F['The quick brown fox jumps over the lazy dog.']
t 5
t 3
t 1
p 0
t 2
t 1
p 1
t 7
t 3
t 1
p 0
t 7
t 5
t 1
p 0
t 7
t 3
t 1
p 0
t 5
p 0
t 5
t 4
t 3
p 0
t 6
t 4
p 0
t 4
p 0
t 7
t 6
t 4
t 1
p 0
t 6
t 1
p 0
t 3
p 0
t 5
t 0
p 4
t 7
t 0
p 0
t 1
p 1
t 7
t 6
t 5
t 3
p 0
t 6
t 5
t 1
p 0
t 7
t 4
p 0
t 2
t 1
p 3
t 7
t 6
t 5
p 2
t 6
t 2
t 1
p 0
t 0
p 7
t 7
t 0
p 5
t 7
t 6
t 4
t 3
p 0
t 7
t 6
p 0
t 7
t 6
t 3
t 1
p 0
t 7
t 6
t 5
t 4
t 1
p 0
t 4
p 4
t 6
p 0
t 6
t 1
p 4
t 7
t 6
t 5
p 0
t 5
t 3
t 1
p 0
t 1
p 1
t 7
t 3
t 1
p 0
t 7
t 5
t 1
p 0
t 5
t 4
t 1
p 0
t 1
p 3
t 7
t 3
p 1
t 5
t 1
p 0
t 7
t 4
t 3
t 1
p 0
t 5
t 1
p 0
t 7
t 6
t 4
p 0
t 4
p 0
t 7
t 4
t 1
p 0
EOS
  end
end
