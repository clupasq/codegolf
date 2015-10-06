
DRUNKEN_BISHOP=
->key{
  current_location = 4 * 17 + 8

  =g->x{
    middle = 4 * 17 + 8

    return 'S' if x == middle

    current_location = middle

    x_step_count = 0

    key.split(?:).flat_map{|b|(0..7).map{|i|b.to_i(16)[i]}}.each_slice(2) do |horz, vert|
      if vert == 0 && current_location > 17
        current_location -= 17
      end
      if vert == 1 && current_location < 17 * 9 - 17
        current_location += 17
      end

      if horz == 0 && current_location % 17 > 0
        current_location -= 1
      end
      if horz == 1 && current_location % 17 < 16
        current_location += 1
      end
      
      x_step_count += 1 if current_location == x
    end

    if current_location == x
      return 'E'
    else
      return ' .o+=*BOX@%&#/^'[x_step_count]
    end
  }

  r=[z=?++?-*17+?+]

  (0...17*9).each_slice(17).map do |row|
    r << ?|+row.map(&g).join+?|
  end
  (r+[z]).join ?\n
}


require 'minitest/autorun'

describe DRUNKEN_BISHOP do
  def test_case_1
    assert_equal <<-EOS.chomp, DRUNKEN_BISHOP['37:e4:6a:2d:48:38:1a:0a:f3:72:6d:d9:17:6b:bd:5e']
+-----------------+
|                 |
|                 |
|          .      |
|     .   o       |
|o . o . S +      |
|.+ + = . B .     |
|o + + o B o E    |
| o .   + . o     |
|         .o      |
+-----------------+
EOS
  end

  def test_case_2
    assert_equal <<-EOS.chomp, DRUNKEN_BISHOP['16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48']
+-----------------+
|        .        |
|       + .       |
|      . B .      |
|     o * +       |
|    X * S        |
|   + O o . .     |
|    .   E . o    |
|       . . o     |
|        . .      |
+-----------------+
EOS
  end

  def test_case_3
    assert_equal <<-EOS.chomp, DRUNKEN_BISHOP['b6:dd:b7:1f:bc:25:31:d3:12:f4:92:1c:0b:93:5f:4b']
+-----------------+
|            o.o  |
|            .= E.|
|             .B.o|
|              .= |
|        S     = .|
|       . o .  .= |
|        . . . oo.|
|             . o+|
|              .o.|
+-----------------+
EOS
  end

  def test_case_4
    assert_equal <<-EOS.chomp, DRUNKEN_BISHOP['05:1e:1e:c1:ac:b9:d1:1c:6a:60:ce:0f:77:6c:78:47']
+-----------------+
|       o=.       |
|    o  o++E      |
|   + . Ooo.      |
|    + O B..      |
|     = *S.       |
|      o          |
|                 |
|                 |
|                 |
+-----------------+
EOS
  end
end




