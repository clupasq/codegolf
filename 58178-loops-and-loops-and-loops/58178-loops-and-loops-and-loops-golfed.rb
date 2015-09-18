
F=
->i{r=i.split'
'
node=Struct.new :incoming_connection_count, :next_node
n=Hash.new{|h,k|h[k]=node.new 0}
r.size.times{|y|x=0
  r[y].chars{|c|
    case c
    when ?>
      f=[y,x-4]
      t=[y,x+2]
    when ?<
      f=[y,x+4]
      t=[y,x-2]     
    when ?^
      f=[y+3,x]
      t=[y-1,x]
    when ?v
      f=[y-3,x]
      t=[y+1,x]
    end
    if f
      n[f].next_node=n[t]
      n[t].incoming_connection_count += 1
    end
    x+=1
  }
}

q=n.values
c=q.find{|n|n.incoming_connection_count<1}
s=q.find{|n|n.incoming_connection_count>1}

unless s
  [n.size-1, 0]
else
  t=0
  (t+=1;c=c.next_node) while c!=s
  [t,n.size-t]
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