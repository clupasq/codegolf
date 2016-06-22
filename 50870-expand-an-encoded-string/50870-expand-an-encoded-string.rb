# coding: utf-8
require 'minitest/autorun'

PROGRAM =-> {
###
gets.split(/(\d)(?!\d)/).each_slice(2){|s,i|s.chars.map{|c|$><<c*i.to_i}}
###
}

describe PROGRAM do
  def test_case_1
    assert_equal 'aaabbbccccc', execute('ab3c5')
  end

  def test_case_2
    assert_equal 'bbb', execute('a0b3')
  end

  def test_case_3
    assert_equal '111b', execute('13b1')
  end

  def test_case_4
    assert_equal 'aaa111b', execute('a13b1')
  end

  def test_case_5
    assert_equal 'aaa111222b', execute('a123b1')
  end

  def test_case_6
    assert_equal 'aaaaab', execute('aa2a1b1')
  end


  def execute(input)
    capture_stdout(input){ PROGRAM[] }
  end
end

# capture STDIN/STDOUT for testing purposes
require 'stringio'
module Kernel
  def capture_stdout(console_input = '')
    $stdin = StringIO.new(console_input)
    out = StringIO.new
    $stdout = out
    yield
    return out.string.chomp
  ensure
    $stdout = STDOUT
    $stdin = STDIN
  end
end
