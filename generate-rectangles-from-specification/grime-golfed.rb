require 'minitest/autorun'

class R
  def initialize(letter)
    @letter = letter
    @w=@h=1
  end

  attr_accessor :w, :h

  def tw(nw)
    nw>0&&@w=nw
  end

  def th(nh)
    nh>0&&@h=nh
  end

  def d(c,x,y)
    @h.times{|h|c[y+h][x...x+@w]=@letter*@w}
  end
end

class H
  def initialize(b, a)
    @a = a
    @b = b
  end

  def w
    @a.w+@b.w
  end
  def h
    @a.th(@b.h)||@b.th(@a.h);@a.h
  end

  def tw(nw)
    @b.tw(nw - @a.w)||@a.tw(nw - @b.w)
  end
  def th(nh)
    @a.th(nh)&&@b.th(nh)
  end

  def d(c,x,y)
    @a.d(c,x,y)
    @b.d(c,x+@a.w,y)
  end
end

class V
  def initialize(b, a)
    @a = a
    @b = b;
  end

  def w
    @a.tw(@b.w)||@b.tw(@a.w);@a.w
  end
  def h
    @a.h+@b.h
  end

  def tw(nw)
    @a.tw(nw)&&@b.tw(nw)
  end

  def th(nh)
    @b.th(nh-@a.h)||@a.th(nh-@b.h)
  end

  def d(c,x,y)
    @a.d(c,x,y)
    @b.d(c,x,y+@a.h)
  end
end

F=->i{s=[]
  i.each_char{|c|s<<(c=~/\w/?R.new(c):(c>?.?H: V).new(s.pop,s.pop))}
  e=s[-1]
  e.d(c=e.h.times.map{|_|?.*e.w},0,0)
  c
}


class RDisplayTest < Minitest::Test
  def test_simple_R
    assert_equivalent('a', 'a')
  end

  def test_sed_vertically
    assert_equivalent(%q{
a
b      
    }, 'ab-')
  end

  def test_sed_horizontally
    assert_equivalent(%q{
ab      
    }, 'ab|')
  end

  def test_first_example
    assert_equivalent(%q{
pas
prs
eee
    }, 'par-s||e-')
  end

  def test_second_example
    assert_equivalent(%q{
comp
iler
    }, 'co|m|p|il|e|r|-')
  end

  def test_extra_example_1
    assert_equivalent(%q{
coooy
mplly
exify
    }, 'co|mp|l|-ex|i|f|-y|')
  end

  def test_extra_example_2
    assert_equivalent(%q{
jronze
aroidd
ggoidd
    }, 'ja-r|g-o|ni-|ze|d-|')
  end

  def test_extra_example_3
    assert_equivalent(%q{
unnnnnnn
coyriggl
ppyrihhe
ppyritte
ppyriabe
    }, 'un|co|p-yr|i|gh-t-ab|-|le-||-')
  end


  def assert_equivalent(expected_result, i)
    actual = F[i]
    assert_equal expected_result.strip.split, actual
  end
end

