require 'stringio'
require 'method_source'

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

def get_method(meth)
  meth.kind_of?(Symbol) ? meth = method(meth) : meth
end

def get_method_length(meth)
  meth = get_method(meth)
  countable_source = meth.source.split("\n")[1..-2].join "\n"
  countable_source.bytesize
end

def number_diff(a, b)
  case
  when a == b
    'THE SAME'
  when a < b
    (a-b).to_s
  else
    '+' + (a-b).to_s
  end
end

def print_size_stats(meth)
  meth = get_method(meth)

  file, line = caller
  size_log_file = "#{caller_locations.first.absolute_path}.size_log"

  current_size = get_method_length(meth)

  size_log = File.read(size_log_file).lines.map(&:to_i) rescue []

  if (size_log.last || -1) != current_size
    open(size_log_file, 'a') { |f| f.puts current_size }
  end

  puts "The current code size is #{current_size}."

  return if size_log.empty?

  puts 'Compared to the last version, the current is ' +
    "#{number_diff(current_size, size_log.last)}."

  puts

  return if size_log.size == 1

  puts 'Latest history:'
  latest_history = size_log.last 10

  latest_history.each do |old_size|
    puts '%7d  => %s' %
      [old_size, number_diff(current_size, old_size)]
  end
end

