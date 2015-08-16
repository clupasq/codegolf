gets = "cat[s[up[][]][]ch[e[r[]s[]]]a[maran[]comb[]pult[[]ing[]]]]\n"
# gets = "[donut[][]cruller[]]\n"
# gets = "[]\n"
# gets = "[[[[[]]]]]\n"

stack = ['']
weights = [0]

gets.chars.map do |c|
  case c
  when ?[
    weights[-1]+=1
    stack << ''
    weights << 0
  when ?]
    last_weight = weights.pop

    if stack.pop == ''
      puts stack.join if last_weight < 1
      stack[-1]=''
    end
  else
    stack[-1] << c
  end
end

