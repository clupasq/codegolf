# o=->s{
# n=/(not )?(able to fly|\w+) (?:is also|are) (not )?(able to fly|\w+)/.match s
# [[n[2],!n[1]],[n[4],!n[3]]]
# }
# c=!z=[]
# w=->r{z.member?(r)||(z<<(a,b=r)
# c|=a[0]==b[0]&&a[1]!=b[1]
# w[[[b[0],!b[1]],[a[0],!a[1]]]]
# z.map{|q|q[1]==r[0]&&w[[q[0],r[1]]]})}
# f=->t{t.split(?.).map{|s|w[o[s]]}
# (c||z.member?([[p='Pigs',true],['able to fly', true]]))?"Yes":(z.member?([[p,true],['able to fly', false]])?"No":"Maybe")}



# h='able to fly'
# i="(not )?(#{h}|\\w+)"
# o=->s{n=Regexp.new(i+" (?:is also|are) "+i).match s
# [[n[2],!n[1]],[n[4],!n[3]]]}
# c=!z=[]
# w=->r{z.member?(r)||(z<<(a,b=r)
# c|=a[0]==b[0]&&a[1]!=b[1]
# w[[[b[0],!b[1]],[a[0],!a[1]]]]
# z.map{|q|q[1]==r[0]&&w[[q[0],r[1]]]})}
# f=->t{t.split(?.).map{|s|w[o[s]]}
# c||z.member?([[p='Pigs',!!0],[h,!!0]])?"Yes":z.member?([[p,!!0],[h,!0]])?"No":"Maybe"}



# h='able to fly'
# i="(not )?(#{h}|\\w+)"
# o=->s{n=Regexp.new(i+" (?:is also|are) "+i).match s
# [[n[2],!n[1]],[n[4],!n[3]]]}
# c=!z=[]
# w=->r{z.member?(r)||(z<<(a,b=r)
# c|=a[0]==b[0]&&a[1]!=b[1]
# w[[[b[0],!b[1]],[a[0],!a[1]]]]
# z.map{|q|q[1]==r[0]&&w[[q[0],r[1]]]})}
# y=->x{z.member?([[p='Pigs',!!0],[h,x]])}
# f=->x{x.split(?.).map{|s|w[o[s]]}
# c|y[!!0]?'Yes':y[!0]?'No':'Maybe'}


h='able to fly'
i="(not )?(#{h}|\\w+)"
o=->s{n=Regexp.new(i+" (is also|are) "+i).match s
[[n[2],!n[1]],[n[5],!n[4]]]}
c=e=!z=[]
w=->r{z.member?(r)||(z<<(a,b=r)
c|=a[0]==b[0]&&a[1]!=b[1]
w[[[b[0],!b[1]],[a[0],!a[1]]]]
z.map{|q|q[1]==r[0]&&w[[q[0],r[1]]]})}
y=->x{z.member?([[p='Pigs',!e],[h,x]])}
f=->x{x.split(?.).map{|s|w[o[s]]}
c|y[!e]?'Yes':y[e]?'No':'Maybe'}

def assert_equal(x, y)
  fail "Not equal: <#{x.inspect}> != <#{y.inspect}>" if x != y
  puts "OK."
end
test=->(text, exp){
  c=!z=[] # (re) initialization needed for multiple test runs
  assert_equal(f[text], exp)
}

test['Pigs are green. Everything that is green is also intelligent. Everything that is able to fly is also not intelligent.', 'No']
test['Pigs are old. Everything that is not able to fly is also not old.', 'Yes']
test['Everything that is sweet is also not old. Everything that is intelligent is also blue.', 'Maybe']
test['Pigs are not able to fly. Everything that is red is also sweet. Everything that is sweet is also not red.', 'Yes']
test['Pigs are very smart. Pigs are able to fly.', 'Yes'] # <-- any answer accepted here


