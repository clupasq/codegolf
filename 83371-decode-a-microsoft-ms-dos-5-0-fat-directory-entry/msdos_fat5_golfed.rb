require 'minitest/autorun'
require_relative '../test_utils'

def parse_fat

m=gets
o=[]

s=->b,l{b.slice!(0,l).to_i 2}

t=->b{'%02d:%02d:%02d %d/%d/%d'%[s[b,5],s[b,6],2*s[b,5],s[b,7]+1980,s[b,4],s[b,5],]}

i=(0..32).map{|i|m[i*8,8].to_i(2)}

c=i.map(&:chr).join

n=c[0,8].strip
e=c[8,3].strip

e>?!&&n<<?.+e
o<<n

f=''
6.times{|j|i[11][j]>0&&f<<%w(RO H S VL SD A)[j]}
o<<f

o<<t[m[8*0x0e,99]]
o<<t[m[8*0x16,99]]

o<<(f[/VL|SD/]?0:m[-32..-1].to_i(2)).to_s

$><<o*' '

end

describe 'msdos_fat_parser' do
  it 'can parse files' do
    file_descriptor = '0111000001110010011011110110011101110010011000010110110101101101011010010110111001100111000001100000000000000000101000100100010001001000110101000000000000000000000000000000000010100010010001000100100011010100000000000000000000000000000000001101000000000000'
    expected = 'programm.ing HS 20:18:08 2016/6/20 20:18:08 2016/6/20 53248'
    assert_equal expected, call_parse_fat(file_descriptor)
  end

  it 'can parse non-files' do
    file_descriptor = '0010000000100000001000000010000001110000011100000110001101100111001000000010000000100000000101000000000000000000010111010110110000111101100111110000000000000000000000000000000010100010010001000100100011010100000000000000000011110000000100111111001011100001'

    expected = 'ppcg SSD 11:43:24 2010/12/31 20:18:08 2016/6/20 0'
    assert_equal expected, call_parse_fat(file_descriptor)
  end

  def call_parse_fat(bit_string)
    output = capture_stdout(bit_string){ parse_fat }
    output.string
  end
end


print_size_stats :parse_fat
puts

