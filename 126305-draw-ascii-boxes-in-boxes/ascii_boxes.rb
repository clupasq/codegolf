require 'minitest/autorun'
require_relative '../test_utils'

f = ->(a,b,c){
  g = a.times.map{?#*a}

  x=(a-b)/2
  r=[*x...a-x]
  r.product (r) do |i|
    m,n=i
    g[m][n]=?*
  end

  x=(a-c)/2
  r=[*x...a-x]
  r.product (r) do |i|
    m,n=i
    g[m][n]=?@
  end

  g
}


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

# print_size_stats :fmt

