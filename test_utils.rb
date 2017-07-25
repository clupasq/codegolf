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
  source_lines = meth.source.split("\n")
  countable_source = source_lines[1..-2]
  get_length countable_source
end

def get_length(source_lines)
  non_empty_lines = source_lines
    .reject { |l| l =~ /^\s*$/ }
    .reject { |l| l =~ /^\s*#/ }
    .join "\n"
  non_empty_lines.bytesize
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

def print_size_stats(source_file=nil)
  source_file = source_file || caller_locations.first.absolute_path
  source_lines = File.readlines(source_file)
    .drop_while { |l| not /START COUNTING/ =~ l }
    .drop(1)
    .take_while { |l| not /END COUNTING/ =~ l }
  current_size = get_length source_lines
  size_log_file = "#{source_file}.size_log"
  print_stats current_size, size_log_file
end

def print_size_stats_for_method(meth)
  meth = get_method(meth)
  current_size = get_method_length(meth)
  size_log_file = "#{caller_locations.first.absolute_path}.size_log"
  print_stats current_size, size_log_file
end

def print_stats current_size, size_log_file
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

  puts 'Latest size history:'
  latest_history = size_log.last 10

  latest_history.each do |old_size|
    puts '%7d  =>  %8s' %
      [old_size, number_diff(current_size, old_size)]
  end
end

