require 'minitest/autorun'
require_relative '../test_utils'


f=->(a,b,c){
  q=(a-b)/2
  q=(q...a-q)
  v=(a-c)/2
  v=(v...a-v)
  (0...a*a).map{|i|
    y=i/a
    x=i%a
    v===y && v===x ? ?@  : (  q===y && q===x  ? ?* : ?# ) + (x==a-1??\n:'')
  }.join
}

# --- {START COUNTING}

f=->(a,b,c){o=a.times.map{?#*a}
g=->(y,c){x=(a-y)/2
r=[*x...a-x];r.product(r){|i|m,n=i
o[m][n]=c}}
g[b,?*]
g[c,?@]
o}

# --- {END COUNTING}

describe :AsciiBoxes do

  it 'passes Test Case #1' do
    expected = <<-EOS.split
######
#****#
#*@@*#
#*@@*#
#****#
######
EOS
    assert_equal f[6,4,2], expected
  end

  it 'passes Test Case #2' do
    expected = <<-EOS.split
########
#******#
#******#
#**@@**#
#**@@**#
#******#
#******#
########
EOS
    assert_equal f[8,6,2], expected
  end


end

print_size_stats

