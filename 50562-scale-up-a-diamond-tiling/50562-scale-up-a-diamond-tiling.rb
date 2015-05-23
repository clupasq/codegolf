require 'minitest/autorun'

F=
-> input, zoom {
  input.split(?\n).map do |l|
    zoom.times.map do |y|
      l.size.times.map do |i|
        zoom.times.map do |x|
          out_char = crt_char = l[i]

          out_char = ' '

          if zoom == y+1 && l[i-1..i]=='_\\'
            out_char = ?_
          end
          if zoom == y+1 && l[i..i+1]=='/_'
            out_char = ?_
          end

          out_char = crt_char if crt_char == ' '
          out_char = crt_char if x==y && crt_char == ?\\  
          out_char = crt_char if zoom==y+1 && crt_char == ?_
          out_char = crt_char if x+y+1==zoom && crt_char == ?/

          out_char
        end.join
      end.join.rstrip
    end - ['']
  end.join ?\n
}

describe '#F' do
  describe 'small diamond' do
    SmallDiamond = ' __
/_/\
\_\/
'

    def test_3
      assert_equal F[SmallDiamond, 3], '   ______
  /     /\
 /     /  \
/_____/    \
\     \    /
 \     \  /
  \_____\/'

    end
  end

  describe 'medium diamond' do
    MediumDiamond = ' __
/_/\
\_\/
'

    def a_test_3
      assert_equal F[MediumDiamond, 3], '   ______
  /     /\
 /     /  \
/_____/    \
\     \    /
 \     \  /
  \_____\/'

    end
  end


end