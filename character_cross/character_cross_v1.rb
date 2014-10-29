

# a=$*[0]
# b=a.size/2
# s=' '
# t=(0...b).map{|i|([s]*i+[a[i]]+[s]*((b-i)*2-1)+[a[~i]])}
# puts (t+[[s]*b+[a[b]]]+t.reverse).map{|l|l.join s}

# taking input from cmdline args - 132 chars

f=->a{b=a.size/2
s=' '
t=(0...b).map{|i|([s]*i+[a[i]]+[s]*((b-i)*2-1)+[a[~i]])}
puts (t+[[s]*b+[a[b]]]+t.reverse).map{|l|l.join s}}

# as a function - 131 chars

puts f['program']
