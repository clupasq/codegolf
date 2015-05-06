require 'minitest/autorun'

# alternative #1

A=->d,l{t={}
(ds=d.size).times{|i|t[d[i]]=ds-i-1}
r=[]
d.dup.cycle.map{|n|d==[]&&break
t[n]||next
w=t[s=n]
o=p
(a=(t.values-[t[n]]).map{|x|x%l};s-=1;w+=1
a.include?(w%l)?(o||s-=1;o=0):(o=p;t[n]=w))while s>0
t[n]<n*l||(r<<d.delete(n);t.delete(n))}
r}


# alternative #2

F=->d,l{
i=0
t=d.map{|x|[x,d.size-(i+=1)]}
r=[]
d.cycle.map{|n|
t==[]&&break
(c=t.find{|x,_|x==n})&&(s=n
w=c[1]
o=p
(a=(t-[c]).map{|_,p|p%l}
s-=1;w+=1
a&[w%l]==[]?(o=p;c[1]=w):o||s-=o=1)while s>0
c[1]>=n*l&&(t.delete c;r<<n))}
r}

# F = B

describe '#F' do
  # break 
  def test_case_1
    assert_equal [3], F[[3], 2]
  end

  def test_case_2
    assert_equal [9, 5], F[[9, 5], 3]
  end

  def test_case_3
    assert_equal [2, 9, 5], F[[5, 9, 2], 6]
  end

  def test_case_4
    assert_equal [5, 9, 2], F[[5, 9, 2], 10]
  end

  def test_case_5
    assert_equal  [1, 5, 7, 8, 2], F[[5, 7, 8, 1, 2], 10 ]
  end

  def test_case_6
    assert_equal  [1, 6, 8, 2, 3, 5], F[[5, 1, 6, 8, 3, 2], 17 ]
  end

  def test_case_7
    assert_equal  [1, 7, 8, 9, 2, 3], F[[1, 2, 3, 7, 8, 9], 15 ]
  end

  def test_case_8
    assert_equal  [8, 7, 9, 1, 2, 3], F[[9, 8, 7, 3, 2, 1], 15 ]
  end

  def test_case_9
    assert_equal  [1, 2, 3, 4, 5, 6, 7, 8, 9], F[[1, 2, 3, 4, 5, 6, 7, 8, 9], 20 ]
  end

  def test_case_10
    assert_equal  [8, 7, 5, 9, 6, 1, 2, 4, 3], F[[9, 8, 7, 6, 5, 4, 3, 2, 1], 20 ]
  end
end