require 'minitest/autorun'

BuildTrack =->{ 

_={│:[1, 4],─:[2, 8],┌:[4, 8],┐:[4, 2],└:[1, 8],┘:[1, 2],┼:[1,4,2,8]}
c=gets.split(?,).map &:to_i

pieces = 6.downto(0).map{|i|[_.keys[i]]*c[i]}.flatten

s=->a,l,b{
  l==[]&&a==[]?b:(
  
  l.product(l).any?{|q,r|q,r=q[0],r[0];(q[0]-r[0])**2+(q[1]-r[1])**2>a.size**2}?!0:(
  w,f=l.pop
  w&&!a.size.times{|i|
    y=_[x=a[i]]

    f&&y&[f]==[]&&next
    k=l.select{|p,d|w!=p||y&[d]==[]}
    v=p
    (y-[f]).map{|d|
      z=[w[0]+({1=>-1,4=>1}[d]||0),w[1]+({2=>-1,8=>1}[d]||0)]
      g=d<3?d*4:d/4
      b[z]?_[b[z]]&[g]!=[]||v=0:k<<[z,g]    
    }

    v||r=s[a[0...i]+a[i+1..-1],k,b.merge({w=>x})]
    return r if r
  }))
  
}

def print_board b
  min_x = min_y = max_x = max_y = 0

  b.each do |w, _|
    y, x = w
    min_x = [min_x, x].min
    min_y = [min_y, y].min
    max_x = [max_x, x].max
    max_y = [max_y, y].max
  end

  str = (min_y..max_y).map{|_|
    ' ' * (max_x - min_x + 1)
  }

  b.each do |w, piece|
    y, x = w
    str[y-min_y][x-min_x] = piece.to_s
  end
  puts str
end

print_board(s[pieces,[[[0,0],nil]],{}])


}

describe BuildTrack do
  # takes ~0.1s
  def test_very_simple_square
    assert_equal <<-EOS, execute("2,2,1,1,1,1,0\n")
┌─┐
│ │
└─┘
EOS
  end

  # takes ~0.6s
  def test_added_more_vertical_pieces
    assert_equal <<-EOS, execute("6,2,1,1,1,1,0\n")
┌─┐
│ │
│ │
│ │
└─┘
EOS
  end

  # takes ~0.0s
  def test_throwing_cross_pieces_into_the_mix
    assert_equal <<-EOS, execute("0,0,2,1,1,2,1\n")
 ┌┐
┌┼┘
└┘ 
EOS
  end

  # takes ~0.4s
  def test_longer_track_containing_a_cross_piece
    assert_equal <<-EOS, execute("4,4,2,1,1,2,1\n")
   ┌┐
┌──┼┘
│  │ 
│  │ 
└──┘ 
EOS
  end

  # remove the leading "x_"s to run these long lasting tests

  # takes ~34s
  def x_test_OP_testcase_1
    assert_equal <<-EOS, execute("3,5,2,2,2,2,1\n")
┌──┐┌┐
│  └┼┘
│   │ 
└───┘ 
EOS
  end

  # takes ~2s
  def x_test_OP_testcase_2
    assert_equal <<-EOS, execute("0,0,1,4,4,1,3\n")
┌┐   
└┼┐  
 └┼┐ 
  └┼┐
   └┘
EOS
  end


  def execute(input)
    capture_stdout(input){ BuildTrack[] }
  end
end


# capture STDIN/STDOUT for testing purposes
require 'stringio'
module Kernel
  def capture_stdout(console_input = '')
    $stdin = StringIO.new(console_input)
    out = StringIO.new
    out.set_encoding 'utf-8'
    $stdout = out
    yield
    return out.string
  ensure
    $stdout = STDOUT
    $stdin = STDIN
  end
end
