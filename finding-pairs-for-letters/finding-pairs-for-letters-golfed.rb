# coding: utf-8
require 'minitest/autorun'

F=->s{l=s.split ?\n
m=l.size
n=l[0].size
b=[]
t={}
[*0...m].product([*0...n]).map{|y,x|c=l[y][x]
c!=' '&&c>?Z?b<<[c,y,x]:t[c.downcase]=[y,x]}
b.map{|q|c,y,x=q
u,i=t[c]
(m*n).times{|w|e=([u-(y+w)%m,i-(x+w)%n].map &:abs).max
e>c.ord-97||q<<w+e}
q[3]&&[q[3],q[0]]}.compact.sort.map{|a,b|b}}


describe '#F' do
  def test_case_1
    assert_equal %w[d a], F[%q{      
D     
  d Aa
      
      }]
  end

  def test_case_2
    assert_equal %w[w b], F[%q{        
W      B
    A   
  b     
        
      a 
  w     
        }]
  end

  def test_case_3
    assert_equal %w[a], F[%q{        
        
     A  
        
        
      a 
        }]
  end

  def test_case_4
    assert_equal %w[i d f], F[%q{          
          
   i      
  f     d 
          
          
    DI  F }]
  end

  def test_case_5
    assert_equal %w[g w j], F[%q{                                                  
                                                  
                                                  
  g                 a                             
                                                  
                                                  
        G               W                         
                                                  
                                                  
                                                  
                                                  
                    j                             
             w                                    
                                                  
                                                  
                                                  
                                         A      J 
                                                  
                                                  
                                                  }]
  end
end


