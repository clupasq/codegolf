gets = "cat[s[up[][]][]ch[e[r[]s[]]]a[maran[]comb[]pult[[]ing[]]]]\n"
# gets = "[donut[][]cruller[]]\n"
# gets = "[]\n"
# gets = "[[[[[]]]]]\n"

t=['']
l=[0]
gets.chars{|c|c<?]?t<<''&&(l<<0)[-2]+=1:c<?^?(x=l.pop;t.pop==''&&(puts t*''if x<1;t[-1]='')):t[-1]<<c}

