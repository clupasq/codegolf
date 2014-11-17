require 'stringio'

module Kernel
  def capture_stdout(console_input = '')
    $stdin = StringIO.new(console_input)
    out = StringIO.new
    $stdout = out
    yield
    return out
  ensure
    $stdout = STDOUT
    $stdin = STDIN
  end
end