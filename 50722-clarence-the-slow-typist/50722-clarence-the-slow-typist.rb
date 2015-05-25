
INPUT='219.45.143.143'

KEY_POSITIONS = [*?1..?9]+[?.,?0]

def dist key1, key2
  return 0 unless key2
  i=KEY_POSITIONS.index(key1)
  j=KEY_POSITIONS.index(key2)
  dx = (i%3-j%3)**2
  dy = (i/3-j/3)**2
  (dx+dy)**0.5
end

# p INPUT.chars.each_cons(2).map{|x,y|dist x,y}.reduce(:+).round(2).to_s+'cm'

sum = 0
INPUT.size.times{|i|sum+=dist(INPUT[i], INPUT[i+1])}
print sum.round(2),'cm'


