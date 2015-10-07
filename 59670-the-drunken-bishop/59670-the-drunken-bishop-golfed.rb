
DRUNKEN_BISHOP=
->k{w=17
r=[z=?++?-*w+?+]
(0...w*9).each_slice(w).map{|o|r<<?|+o.map{|x|c=76
q=0
k.split(?:).flat_map{|b|(0..7).map{|i|b.to_i(16)[i]}}.each_slice(2){|h,v|v<1?(c>w&&c-=w):c<w*8&&c+=w
h<1?(c%w>0&&c-=1):c%w<16&&c+=1
c==x&&q+=1}
x==76?'S':c==x ?'E':' .o+=*BOX@%&#/^'[q]}.join+?|}
(r+[z]).join'
'}


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




