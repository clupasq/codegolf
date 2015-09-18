
F=
->input{

rows = input.split'
'
node = Struct.new :incoming_connection_count, :next_node

nodes = Hash.new{|h,k|h[k] = node.new 0}

rows.size.times{|y|
  x=0
  rows[y].chars{|c|
    case c
    when ?>
      from = [y,x-4]
      to = [y,x+2]
    when ?<
      from = [y,x+4]
      to = [y,x-2]     
    when ?^
      from = [y+3,x]
      to = [y-1,x]
    when ?v
      from = [y-3,x]
      to = [y+1,x]
    end

    if from
      nodes[from].next_node = nodes[to]
      nodes[to].incoming_connection_count += 1
    end

    x+=1
  }
}

current = nodes.values.find{|n|n.incoming_connection_count < 1}
loop_start = nodes.values.find{|n|n.incoming_connection_count > 1}

unless loop_start
  # no loop; adjust the total node count
  [nodes.size-1, 0]
else
  # there's a loop; measure length of the tail
  tail = 0
  (tail+=1;current = current.next_node) while current!=loop_start
  [tail, nodes.size-tail]
end

}

require 'minitest/autorun'

describe F do

  def test_simple_case
    assert_equal [2, 6], F[<<-DOC]
# --> # --> # --> #
^     ^           |
|     |           |
|     |           v
#     # <-- # <-- #
DOC
  end

  def test_harder_case
    assert_equal [3, 10], F[<<-DOC]
            # --> # --> #
            ^           |
            |           |
            |           v
      # --> # <-- #     # --> #
      ^           ^           |
      |           |           |
      |           |           v
# --> #           # <-- # <-- #
DOC
  end

  def test_no_loop
    assert_equal [6, 0], F[<<-DOC]
# --> # --> # --> #
                  |
                  |
                  v
        <-- # <-- #
DOC
  end

end