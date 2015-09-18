
F=
->i{node=Struct.new :incoming_connection_count, :next_node
n=Hash.new{|h,k|h[k]=node.new 0}
y=0
i.lines{|l|x=0
  l.chars{|c|
idxs=[[[y,x-4],[y,x+2]],[[y,x+4],[y,x-2]],[[y-3,x],[y+1,x]],[[y+3,x],[y-1,x]]]
x+=1

    i='><v^'.index c

    if i
      f,t=idxs[i]

      n[f].next_node=n[t]
      n[t].incoming_connection_count += 1
    end
  }
  y+=1
}

q=n.values
c=q.find{|n|n.incoming_connection_count<1}
s=q.find{|n|n.incoming_connection_count>1}

t=0
l=n.size
s ?((t+=1;c=c.next_node)while c!=s):t=l-=1
[t,l-t]
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