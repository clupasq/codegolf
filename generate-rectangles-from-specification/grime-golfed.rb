require 'minitest/autorun'

def create_canvas(width, height)
  canvas ||= height.times.map{|_| ?.*width }
end

class Rectangle
  def initialize(letter)
    @letter = letter
    @width = 1
    @height = 1
  end

  attr_reader :width, :height

  def try_set_width(new_width)
    if new_width > 0
      @width = new_width
      return true
    end
  end
  def try_set_height(new_height)
    if new_height > 0
      @height = new_height
      return true
    end
  end

  def display(canvas=nil, x=0, y=0)
    canvas ||= create_canvas(width, height)

    @height.times do |h|
      canvas[y + h][x...x + @width] = @letter * @width
    end
    canvas
  end
end

class HorizontalConcatenation
  def initialize(b, a)
    @a = a
    @b = b
  end

  def width
    @a.width + @b.width
  end
  def height
    return @a.height if @a.height == @b.height

    if @a.try_set_height(@b.height) || @b.try_set_height(@a.height)
      return @a.height
    end
  end

  def try_set_width(new_width)
    return @b.try_set_width(new_width - @a.width) || @a.try_set_width(new_width - @b.width)
  end
  def try_set_height(new_height)
    return @a.try_set_height(new_height) && @b.try_set_height(new_height)
  end

  def display(canvas=nil, x=0, y=0)
    canvas ||= create_canvas(width, height)

    @a.display(canvas, x, y)
    @b.display(canvas, x + @a.width, y)
    canvas
  end
end

class VerticalConcatenation
  def initialize(b, a)
    @a = a
    @b = b;
  end

  def width
    return @a.width if @a.width == @b.width

    if @a.try_set_width(@b.width) || @b.try_set_width(@a.width)
      return @a.width
    end
  end
  def height
    @a.height + @b.height
  end

  def try_set_width(new_width)
    return @a.try_set_width(new_width) && @b.try_set_width(new_width)
  end

  def try_set_height(new_height)
    return @b.try_set_height(new_height - @a.height) || @a.try_set_height(new_height - @b.height)
  end

  def display(canvas=nil, x=0, y=0)
    canvas ||= create_canvas(width, height)

    @a.display(canvas, x, y)
    @b.display(canvas, x, y + @a.height)
    canvas
  end
end

def parse(input)
  stack = []

  input.chars.each do |char|
    case char
    when ?-
      stack << VerticalConcatenation.new(stack.pop, stack.pop)
    when ?|
      stack << HorizontalConcatenation.new(stack.pop, stack.pop)
    else
      stack << Rectangle.new(char)
    end
  end

  stack.last
end


class RectangleDisplayTest < Minitest::Test
  def test_simple_rectangle
    assert_equivalent('a', 'a')
  end

  def test_stacked_vertically
    assert_equivalent(%q{
a
b      
    }, 'ab-')
  end

  def test_stacked_horizontally
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


  def assert_equivalent(expected_result, input)
    actual = parse(input).display
    assert_equal expected_result.strip.split, actual
  end
end

