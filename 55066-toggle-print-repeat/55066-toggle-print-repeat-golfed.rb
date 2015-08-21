# pending solution for http://meta.codegolf.stackexchange.com/a/5732/3527

F=
#173
->w{s=[0]*8
q=[]
w.chars{|c|z=0..7
*m,i=z.map{|j|z.select{|k|s[k]!=z.map{|i|c.ord[i]}.rotate(j)[k]}+[j]}.min_by &:size
q+=m.map{|m|s[m]=1-s[m];"t #{7-m}"}+["p #{i}"]}
q*?\n}

puts F['?'] 

# require 'minitest/autorun'

# describe F do
#   def test_case_1
#     @actual = capture_stdout() { F['?'] } 

#     @expected = <<-EOS
# t 7
# t 6
# t 5
# t 4
# t 3
# t 2
# p 0
# EOS
#   end

#   def test_case_2
#     @actual = capture_stdout() { F[':='] } 

#     @expected = <<-EOS
# t 6
# t 4
# t 3
# t 2
# p 0
# t 1
# p 7
# EOS
#   end

#   def test_case_3
#     @actual = capture_stdout() { F['0123456789'] } 

#     @expected = <<-EOS
# t 3
# t 2
# p 0
# t 7
# p 0
# t 7
# t 6
# p 0
# t 7
# p 0
# t 7
# t 6
# t 5
# p 0
# t 7
# p 0
# t 7
# t 6
# p 0
# t 7
# p 0
# t 3
# t 2
# p 3
# t 2
# p 3
# EOS
#   end


#   def test_case_4
#     @actual = capture_stdout() { F['9876543210'] } 

#     @expected = <<-EOS
# t 7
# t 4
# t 3
# t 2
# p 0
# t 7
# p 0
# t 7
# t 0
# p 5
# t 4
# p 5
# t 5
# t 0
# p 0
# t 7
# p 0
# t 7
# t 6
# t 5
# p 0
# t 7
# p 0
# t 7
# t 6
# p 0
# t 7
# p 0
# EOS
#   end

#   def test_case_5
#     @actual = capture_stdout() { F['Hello, World!'] } 

#     @expected = <<-EOS
# t 4
# t 1
# p 0
# t 7
# t 3
# p 2
# t 6
# t 1
# p 2
# p 2
# t 1
# t 0
# p 2
# t 3
# t 1
# t 0
# p 2
# t 7
# t 6
# p 2
# t 7
# t 6
# t 2
# t 0
# p 1
# t 5
# t 1
# t 0
# p 0
# t 7
# t 2
# p 3
# t 6
# t 2
# p 0
# t 4
# p 0
# t 1
# p 3
# EOS
#   end

#   def test_case_6
#     @actual = capture_stdout() { F['The quick brown fox jumps over the lazy dog.'] } 

#     @expected = <<-EOS
# t 5
# t 3
# t 1
# p 0
# t 2
# t 1
# p 1
# t 7
# t 3
# t 1
# p 0
# t 7
# t 5
# t 1
# p 0
# t 7
# t 3
# t 1
# p 0
# t 5
# p 0
# t 5
# t 4
# t 3
# p 0
# t 6
# t 4
# p 0
# t 4
# p 0
# t 7
# t 6
# t 4
# t 1
# p 0
# t 6
# t 1
# p 0
# t 3
# p 0
# t 5
# t 0
# p 4
# t 7
# t 0
# p 0
# t 1
# p 1
# t 7
# t 6
# t 5
# t 3
# p 0
# t 6
# t 5
# t 1
# p 0
# t 7
# t 4
# p 0
# t 2
# t 1
# p 3
# t 7
# t 6
# t 5
# p 2
# t 6
# t 2
# t 1
# p 0
# t 0
# p 7
# t 7
# t 0
# p 5
# t 7
# t 6
# t 4
# t 3
# p 0
# t 7
# t 6
# p 0
# t 7
# t 6
# t 3
# t 1
# p 0
# t 7
# t 6
# t 5
# t 4
# t 1
# p 0
# t 4
# p 4
# t 6
# p 0
# t 6
# t 1
# p 4
# t 7
# t 6
# t 5
# p 0
# t 5
# t 3
# t 1
# p 0
# t 1
# p 1
# t 7
# t 3
# t 1
# p 0
# t 7
# t 5
# t 1
# p 0
# t 5
# t 4
# t 1
# p 0
# t 1
# p 3
# t 7
# t 3
# p 1
# t 5
# t 1
# p 0
# t 7
# t 4
# t 3
# t 1
# p 0
# t 5
# t 1
# p 0
# t 7
# t 6
# t 4
# p 0
# t 4
# p 0
# t 7
# t 4
# t 1
# p 0
# EOS
#   end



#   after do
#     assert_equal @expected, @actual
#   end

# end


# require 'stringio'

# module Kernel
#   def capture_stdout(console_input = '')
#     $stdin = StringIO.new(console_input)
#     out = StringIO.new
#     $stdout = out
#     yield
#     return out.string
#   ensure
#     $stdout = STDOUT
#     $stdin = STDIN
#   end
# end
