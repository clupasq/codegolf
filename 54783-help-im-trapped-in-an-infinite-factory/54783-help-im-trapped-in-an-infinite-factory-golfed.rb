require 'pp'
require 'minitest/autorun'

# ideas: 
#  - replace r(Hash) with simply vars j, k
#  - more efficient loops on line #2


F=
->g,w,h{m=->y,x,d,v=[]{r=->s{g[[0,y].max...y+h].map{|l|l[[0,x].max...x+w]}.join.count s}
j=r[?>]-r[?<]
k=r[?v]-r[?^]
q=y,x
q[d=[d,1,0][j*j<=>k*k]]+=[k,j][d]<=>0
v&[q<<d]!=[]?q!=v[-1]:m[*q,v<<q]}
m[0,0,1]}

describe :X do
  describe 'g 1 (2x2)' do
    before do
      @g = [
        '>v',
        '^<' ]
    end

    it 'detects loop for 1x1' do assert F[@g, 1, 1] end
    it 'detects loop for 1x2' do assert F[@g, 1, 2] end
    it 'detects loop for 2x1' do assert F[@g, 2, 1] end
    it 'detects rest for 2x2' do refute F[@g, 2, 2] end
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
