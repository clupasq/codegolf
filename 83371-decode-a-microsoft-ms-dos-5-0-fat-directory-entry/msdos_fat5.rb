require 'minitest/autorun'
require_relative '../test_utils'

PARSE_FAT =-> {
  m = gets
  output = []

  ints = (0..32).map{|i| m[i*8,8].to_i(2) }

  str = ints.map(&:chr).join

  name = str[0,8].strip
  ext = str[8,3].strip

  name<<?.+ext if ext>?!
  output<< name

  flag_byte = ints[11]
  flag_positions = %w(RO H S VL SD A)

  flags = ''
  6.times{|i|flags<<flag_positions[i] if flag_byte[i] > 0}
  output<< flags

  slice_to_int=->bits,length{
    bits.slice!(0, length).to_i 2
  }

  time=->bits{
    hour = slice_to_int[bits,5]
    minute = slice_to_int[bits, 6]
    second = 2 * slice_to_int[bits, 5]

    year = slice_to_int[bits,7]+1980
    month = slice_to_int[bits,4]
    day = slice_to_int[bits,5]

    '%02d:%02d:%02d %d/%d/%d' % [hour, minute, second, year, month, day]
  }

  output << time[m[8 * 0x0e,99]]
  output << time[m[8 * 0x16,99]]

  not_file = flags[/VL|SD/]
  size = not_file ? 0 : m[-32..-1].to_i(2)
  output<< size.to_s

  $><< output.join(' ')
}

describe 'msdos_fat_parser' do
  it 'can parse files' do
    file_descriptor = '0111000001110010011011110110011101110010011000010110110101101101011010010110111001100111000001100000000000000000101000100100010001001000110101000000000000000000000000000000000010100010010001000100100011010100000000000000000000000000000000001101000000000000'
    expected = 'programm.ing HS 20:18:08 2016/6/20 20:18:08 2016/6/20 53248'
    assert_equal expected, parse_fat(file_descriptor)
  end

  it 'can parse non-files' do
    file_descriptor = '0010000000100000001000000010000001110000011100000110001101100111001000000010000000100000000101000000000000000000010111010110110000111101100111110000000000000000000000000000000010100010010001000100100011010100000000000000000011110000000100111111001011100001'

    expected = 'ppcg SSD 11:43:24 2010/12/31 20:18:08 2016/6/20 0'
    assert_equal expected, parse_fat(file_descriptor)
  end

  def parse_fat(bit_string)
    output = capture_stdout(bit_string){ PARSE_FAT[] }
    output.string
  end
end

