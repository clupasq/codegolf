require 'pp'
require 'minitest/autorun'

F=
->g,w,h{c={}
g.each_index{|y|g[y].size.times{|x|q=g[y][x];q>?!&&c[[y,x]]=q}}
m=->y,x,d,v=[]{r=Hash.new 0
(y...y+h).map{|y|(x...x+w).map{|x|q=c[[y,x]];q&&r[q]+=1}}
j=r[?>]-r[?<]
k=r[?v]-r[?^]
o,q=j**2,k**2
d=[d,p,0][o<=>q]
v<<[y,x]
d ?y+=k<=>0:x+=j<=>0
v[-1]==[y,x]?p: v&[[y, x]]!=[]?1:m[y,x,d,v]}
m[0,0,p]}

describe :X do
  describe 'g 1 (2x2)' do
    before do
      @g = [
        '>v',
        '^<' ]
    end

    # it 'detects loop for 1x1' do assert F[@g, 1, 1] end
    # it 'detects loop for 1x2' do assert F[@g, 1, 2] end
    # it 'detects loop for 2x1' do assert F[@g, 2, 1] end
    # it 'detects rest for 2x2' do refute F[@g, 2, 2] end
  end

  describe 'g 2 (3x3)' do
    before do
      @g = [
        '> v',
        '   ',
        '^ <' ]
    end

    it 'detects rest for 1x1' do refute F[@g, 1, 1] end
    it 'detects rest for 1x2' do refute F[@g, 1, 2] end
    it 'detects rest for 1x3' do refute F[@g, 1, 3] end
    it 'detects rest for 2x1' do refute F[@g, 2, 1] end
    it 'detects loop for 2x2' do assert F[@g, 2, 2] end
    it 'detects loop for 2x3' do assert F[@g, 2, 3] end
    it 'detects rest for 3x1' do refute F[@g, 3, 1] end
    it 'detects loop for 3x2' do assert F[@g, 3, 2] end
    it 'detects rest for 3x3' do refute F[@g, 3, 3] end
  end

  describe 'g 3 (6x5)' do
    before do
      @g = [
        '>v>v>v',
        '^v^v^v',
        '^v^v^v',
        '^>^>^v',
        '^<<<<<']
    end

    it 'detects loop for 1x1' do assert F[@g, 1, 1] end
    it 'detects rest for 1x2' do refute F[@g, 1, 2] end
    it 'detects loop for 2x1' do assert F[@g, 2, 1] end
    it 'detects loop for 2x2' do assert F[@g, 2, 2] end
    it 'detects loop for 2x4' do assert F[@g, 2, 4] end
    it 'detects rest for 2x5' do refute F[@g, 2, 5] end
    it 'detects rest for 3x1' do refute F[@g, 3, 1] end
    it 'detects loop for 3x2' do assert F[@g, 3, 2] end
    it 'detects loop for 3x3' do assert F[@g, 3, 3] end
    it 'detects loop for 3x5' do assert F[@g, 3, 5] end
    it 'detects rest for 6x2' do refute F[@g, 6, 2] end
    it 'detects loop for 6x3' do assert F[@g, 6, 3] end
    it 'detects rest for 6x5' do refute F[@g, 6, 5] end
  end

  describe 'g 4 (10x6)' do
    before do
      @g = [
        '> <vv    <',
        ' v ^ >v v ',
        '  >v^^>vv^',
        '    ^>^ v ',
        '>  v<v  >>',
        '  >v v<^  ']
    end

    it 'detects rest for 1x1' do refute F[@g, 1, 1] end
    it 'detects rest for 2x3' do refute F[@g, 2, 3] end
    it 'detects rest for 2x6' do refute F[@g, 2, 6] end
    it 'detects loop for 3x2' do assert F[@g, 3, 2] end
    it 'detects rest for 5x4' do refute F[@g, 5, 4] end
    it 'detects loop for 6x1' do assert F[@g, 6, 1] end
    it 'detects rest for 10x6' do refute F[@g, 10, 6] end
  end
end
