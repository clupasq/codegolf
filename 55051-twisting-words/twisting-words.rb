F=
-> str, row_size { 
  # pad `str` with spaces to the right, until
  # its length is a multiple of `row_size`
  str +=' '*(row_size - str.size%row_size)

  (0...str.size/row_size).map do |i|
    x = str[i*row_size..i*row_size+row_size-1]
    puts i.odd? ? x.reverse: x
  end
}

require 'minitest/autorun'

describe F do
  def test_case_1
    expected = <<-EOS
Prog
mmar
ing 
zzuP
les 
oC &
de G
 flo
EOS

    actual = capture_stdout(){ F['Programming Puzzles & Code Golf', 4] }

    assert_equal expected, actual
  end

  def test_case_2
    expected = <<-EOS
Hello
roW ,
ld!  
EOS

    actual = capture_stdout(){ F['Hello, World!', 5] }

    assert_equal expected, actual
  end
end



require 'stringio'

module Kernel
  def capture_stdout(console_input = '')
    $stdin = StringIO.new(console_input)
    out = StringIO.new
    $stdout = out
    yield
    return out.string
  ensure
    $stdout = STDOUT
    $stdin = STDIN
  end
end
