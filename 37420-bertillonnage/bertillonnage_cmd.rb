x=(1..81).select{|j|$*[0].split(?,).all?{|y|i=j-1
z='SML'
[z[i%9/3]+?H,z[i%3]+?E,z[i/27]+?B,z[i/9%3]+?F].member?(y[-2,2])^y[?!]}}
p x==[]?[0]:x