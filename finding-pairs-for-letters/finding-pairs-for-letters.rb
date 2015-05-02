# coding: utf-8
# http://codegolf.stackexchange.com/questions/49517/finding-pairs-for-letters
require 'minitest/autorun'

F=->s{
  l=s.split ?\n
  m=l.size
  n=l[0].size
  b=[]
  t={}
  [*0...m].product([*0...n]).map{|y,x| 
    c=l[y][x]
    c!=' '&&(c>?Z?b<<[c,y,x]:t[c.downcase]=[y,x])
  }
  
  l=->q{
    c,y,x=q
    u,i=t[c]
    d=c.ord-97
    (m*n).times{|w|
      e=([u-y,i-x].map &:abs).max
      e<=d&&q<<w+e
      y=(y+1)%m
      x=(x+1)%n
    }
  }

  b.map &l
  b.map{|x|[x[3],x[0]]}.select{|a,b|a}.sort.map{|a,b|b}
}


class Tests < Minitest::Test
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


