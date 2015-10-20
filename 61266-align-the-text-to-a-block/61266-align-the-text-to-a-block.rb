
def program

  target_row_size, *text = $<.to_a

  target_row_size = target_row_size.to_i
  words = text.join.scan /\S+/

  current_row = []

  while words.any?
    next_word = words.shift

    if current_row.any? && (current_row + [next_word]).join(?.).size > target_row_size
      # print current_row using the right amounts of spaces

      row = ''
      while word = current_row.shift
        row << word
        break_size = current_row.size > 0 ? ((target_row_size - row.size - current_row.join.size) / current_row.size.to_f).ceil : 0
        row << ' ' * break_size
      end
      puts row
    end

    current_row << next_word
  end

  puts current_row.join ' '
end


require 'minitest/autorun'

describe :program do
  def test_case_1
    @input = <<-EOS
40
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
EOS

    get_output.must_equal <<-EOS
Lorem  ipsum dolor sit amet, consectetur
adipiscing  elit,  sed do eiusmod tempor
incididunt  ut  labore  et  dolore magna
aliqua.  Ut  enim  ad minim veniam, quis
nostrud   exercitation  ullamco  laboris
nisi ut aliquip ex ea commodo consequat.
Duis  aute  irure dolor in reprehenderit
in voluptate velit esse cillum dolore eu
fugiat  nulla  pariatur.  Excepteur sint
occaecat cupidatat non proident, sunt in
culpa  qui  officia deserunt mollit anim
id est laborum.
EOS
  end

  def test_case_2
    @input = <<-EOS
10
Lorem ipsum dolor sit amet,
consectetur adipiscing elit, sed do eiusmod tempor
EOS

    get_output.must_equal <<-EOS
Lorem
ipsum
dolor  sit
amet,
consectetur
adipiscing
elit,  sed
do eiusmod
tempor
EOS
  end

  def test_case_3
    @input = <<-EOS
20
Lorem     ipsum

dolor  sit amet,
EOS

    get_output.must_equal <<-EOS
Lorem   ipsum  dolor
sit amet,
EOS
  end

  def test_case_4
    @input = <<-EOS
1
Lorem ipsum dolor sit amet
EOS

    get_output.must_equal <<-EOS
Lorem
ipsum
dolor
sit
amet
EOS
  end


  def get_output
    Kernel.capture_stdout(@input) { program }
  end
end


# This part is needed to stub stdin and stdout for tests
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
