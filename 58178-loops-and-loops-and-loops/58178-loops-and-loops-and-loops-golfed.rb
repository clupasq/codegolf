
F=
->i{n={}
g=->x{n[x]||=[0,p]}
t=y=0
i.lines{|l|x=0
l.chars{|c|x+=1
'><'[c]&&(r=c.ord-61;s,d=[y,x-4*r],[y,x+2*r])
'^v'[c]&&(r=c<?_?1:-1;s,d=[y+r*3,x],[y-r,x])
s&&(g[s][1]=g[d])[0]+=1}
y+=1}
c,*_,s=n.values.sort_by{|v|v[0]}
l=n.size
s[0]>1?((t+=1;c=c[1])while c!=s):t=l-=1
[t,l-t]}


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