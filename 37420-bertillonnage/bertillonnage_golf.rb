require 'rspec/autorun'

def q1(filte)
b=(q=1..81).map{|j|i=j-1
c=%W{H B E F}.product(z=%W{S M L}).map{|f,s|"!"+s+f}
d=->a,f{a<<f;a.delete"!"+f}
d[c,z[i%9/3]+"H"]
d[c,z[i%3]+"E"]
d[c,z[i/27]+"B"]
d[c,z[i/9%3]+"F"]
c}
x=q.find_all{|i|filte.split(?,).all?{|y|b[i-1].member?y}}
x.empty?&&x<<0 
x.inspect
end

def q2(filte)
b=(q=1..81).map{|j|i=j-1
c=[];z='SML'
c<<z[i%9/3]+?H
c<<z[i%3]+?E
c<<z[i/27]+?B
c<<z[i/9%3]+?F
c}
x=q.find_all{|i|filte.split(?,).all?{|y|b[i-1].member?(y[-2..-1])^y[?!]}}
x.empty?&&x<<0 
x.inspect
end

def q3(filte)

x=(1..81).find_all{|j|filte.split(?,).all?{|y|i=j-1
c=[];z='SML'
c<<z[i%9/3]+?H
c<<z[i%3]+?E
c<<z[i/27]+?B
c<<z[i/9%3]+?F
c.member?(y[-2..-1])^y[?!]}}
x.empty?&&x<<0 
x.inspect

end

def q4(filte)

x=(1..81).find_all{|j|filte.split(?,).all?{|y|i=j-1
z='SML'
[z[i%9/3]+?H,z[i%3]+?E,z[i/27]+?B,z[i/9%3]+?F].member?(y[-2..-1])^y[?!]}}
x.empty?&&x<<0 
x.inspect

end

def q(filte)

x=(1..81).select{|j|filte.split(?,).all?{|y|i=j-1
z='SML'
[z[i%9/3]+?H,z[i%3]+?E,z[i/27]+?B,z[i/9%3]+?F].member?(y[-2,2])^y[?!]}}
x==[]&&x<<0 
x.inspect

end

RSpec.describe '#q' do
  it 'passes test cases' do
    expect(q('SH,LB,ME,SF')).to eql '[56]'
    expect(q('!SH,LB,!ME,SF')).to eql '[58, 60, 61, 63]'
    expect(q('SB,!MF,!LF')).to eql '[1, 2, 3, 4, 5, 6, 7, 8, 9]'
    expect(q('MH,!MH')).to eql '[0]'
    expect(q('!MH,!LH,!MB,!LB')).to eql '[1, 2, 3, 10, 11, 12, 19, 20, 21]'
  end
end