require 'minitest/autorun'

F=->i{l = i.lines
m = l.map(&:size).max
g = {}
l.size.times{|y|m.times{|x|l[y][x]==?+&&g[[y, x]]=[[y, x]]}}
c=->a,b{w=g[b]+g[a];w.map{|x|g[x]=w}}
k=g.keys
k.product(k).map{|n, o|
r,p=n
s,q=o
((r==s&&p<q&&l[r][p...q]=~/^\+-[|-]*$/)||(p==q&&r<s&&l[r...s].map{|l|l[p]||' '}.join=~/^\+\|[|-]*$/))&&c[n, o]}
g.values.uniq.count}


class TestAsciiTopologyCount < Minitest::Test
  def test_empty
    assert_equal 0, F['']
  end

  def test_1
    input = <<-EOS
   +---+
   |   |
+--+   |
|      |
+--+   |
   |   |
   |   |
   |   |
+--+   +--+
|         |
+---------+
EOS
    assert_equal 1, F[input]
  end
 
  def test_2
    input = <<-EOS
            +--+
            |  |
+---+  +----+  |
|   |  |       |
+---+  +-------+
EOS
    assert_equal 2, F[input]
  end

  def test_3
    input = <<-EOS
+---------+
| +-----+ |
| | +-+ | |
| | | | | |
| | +-+ | |
| +-----+ |
+---------+
EOS
    assert_equal 3, F[input]
  end

  def test_4
    input = <<-EOS
  +--------------+
  |  +--+  +--+  |
  |  |  |  |  |  |
+-|-----|-----|----+
| |  |  |  |  |  | |
| +--+  +--+  +--+ |
+------------------+

              +------------+
              |            |
        +-----+  +-----+   |
        |        |     |   |
  +-----|-----------+  |   |
  |     |  +--+  |  |  |   |
  +-+   +--|--|--+  +---------+
    |      |  +-+      |   |  |
    +------+    |      |   |  |
                +-------+  |  |
                       ||  |  |
                       |+-----+
                       |   |
                       +---+
EOS
    assert_equal 4, F[input]
  end

  def test_5
    input = <<-EOS
+--------+  +--------+  +--------+
|        |  |        |  |        |
|     +--|-----+  +--|-----+     |
|     |  |  |  |  |  |  |  |     |
+-----|--+  +-----|--+  +--------+
      |        |  |        |
      +--------+  +--------+
EOS
    assert_equal 5, F[input]
  end

  def test_3_neaky
    input = <<-EOS
   +----+
+-+|+-+ |
| ||| | |
+-+|+-+ |
   +----+
EOS
    assert_equal 3, F[input]
  end
end
