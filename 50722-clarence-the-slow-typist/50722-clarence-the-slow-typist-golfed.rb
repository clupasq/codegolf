
gets = "219.45.143.143\n"

# print gets.chars.each_cons(2).map{|a|i,j=a.map{|e|'123456789.0'.index e}
# i&&j ?((i%3-j%3)**2+(i/3-j/3)**2)**0.5:0}.reduce(:+).round(2),'cm'

s=0
gets.chars.each_cons(2).map{|a|i,j=a.map{|e|'123456789.0'.index e}
i&&j&&s+=((i%3-j%3)**2+(i/3-j/3)**2)**0.5}
print s.round(2),'cm'