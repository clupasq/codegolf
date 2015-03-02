s={}
l=$<.lines
y=0
l.map{|r|x=0
r.scan(/../).map{|v|s[[x,y]]=[v=v.to_i,v<1?0:99];x+=1}
y+=1}
loop{break if s.map{|c,r|x,y=c
m = [[-1,-1],[1,-1],[-2,0],[2,0],[1,-1],[1,1]].map{|w,z|s[[x+w,y+z]]}.map{|n|n ?n[0]+n[1]:0}.min
r[1]=[0,m-r[0]].max if r[0]+r[1]>m&&r[1]>0}.none?}
puts s.map{|c,r|r[1]}.reduce :+