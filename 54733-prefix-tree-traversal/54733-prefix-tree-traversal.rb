gets = "cat[s[up[][]][]ch[e[r[]s[]]]a[maran[]comb[]pult[[]ing[]]]]\n"
# gets = "[donut[][]cruller[]]\n"
# gets = "[]\n"
# gets = "[[[[[]]]]]\n"

t=['']
l=[0]

gets.chars.map do |c|
  case c
  when ?[
    l[-1]+=1
    t << ''
    l << 0
  when ?]
    x = l.pop
    if t.pop == ''
      puts t.join if x < 1

      t[-1]=''
    end
  else
    t[-1] << c
  end
end

