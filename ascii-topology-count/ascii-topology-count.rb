require 'minitest/autorun'

def ascii_topology_count(input)

  max_length = input.lines.map(&:size).max
  lines = input.lines.map { |l| "%-#{max_length}s"%l }

  corners_in_groups = {}

  lines.size.times { |y|
    max_length.times{ |x|
      if lines[y][x] == ?+
        corners_in_groups[[y, x]] = [[y, x]]
      end
    }
  }

  k = corners_in_groups.keys

  combine_groups =-> c1, c2 {
    g1 = corners_in_groups[c1]
    g2 = corners_in_groups[c2]

    g2 += g1
    corners_in_groups[c1] = g2
    g2.map{|x| corners_in_groups[x] = g2}
  }

  corners_in_groups.keys.product(corners_in_groups.keys).map{|c1, c2|
    y1,x1=c1
    y2,x2=c2
    if y1 == y2 && x1 < x2
      # test horizontal edge
      t = lines[y1][x1...x2]
      if t =~ /^\+-[|-]*$/
        # p "#{c1}, #{c2}, [H] #{t}"
        combine_groups[c1, c2]

      end
    end

    if x1 == x2 && y1 < y2
      # test vertical edge
      t=lines[y1...y2].map{|l|l[x1]||' '}.join

      if t =~ /^\+\|[|-]*$/
        # p "#{c1}, #{c2}, [V] #{t}"
        combine_groups[c1, c2]
      end
    end
  }

  corners_in_groups.values.uniq.count
end


class TestAsciiTopologyCount < Minitest::Test
  def test_empty
    assert_equal 0, ascii_topology_count('')
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
    assert_equal 1, ascii_topology_count(input)
  end
 
  def test_2
    input = <<-EOS
            +--+
            |  |
+---+  +----+  |
|   |  |       |
+---+  +-------+
EOS
    assert_equal 2, ascii_topology_count(input)
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
    assert_equal 3, ascii_topology_count(input)
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
    assert_equal 4, ascii_topology_count(input)
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
    assert_equal 5, ascii_topology_count(input)
  end

  def test_3_neaky
    input = <<-EOS
   +----+
+-+|+-+ |
| ||| | |
+-+|+-+ |
   +----+
EOS
    assert_equal 3, ascii_topology_count(input)
  end
end
