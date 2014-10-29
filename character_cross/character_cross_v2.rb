require 'rspec/autorun'
require 'stringio'

# Trying to write the string string.length times 
# and then space out the non-diagonal chars

def get_diagonal_indices str_length, line_index
  [line_index, str_length-line_index-1]
end

def character_cross word
  length = word.length
  (0...length).map{|line|
    word.chars.map.with_index{|c,i| get_diagonal_indices(length, line).member?(i) ? c : ' ' }.join ' '
  }.join ?\n
end

#Golfed:
f=->a{(0...l=a.size).map{|i|puts a.chars.map.with_index{|c,j|[i,l-i-1].member?(j)?c:' '}.join' '}}

RSpec.describe '#get_unmasked_char_indices' do
  let(:str_length) { 7 }
  def result_for_index i
    get_diagonal_indices str_length, i
  end

  context 'upper half' do
    it { expect(result_for_index 0).to eql [0, 6] }
    it { expect(result_for_index 1).to eql [1, 5] }
    it { expect(result_for_index 2).to eql [2, 4] }
  end

  context 'middle line' do
    it { expect(result_for_index 3).to eql [3, 3] }
  end
  
  context 'middle line' do
    it { expect(result_for_index 4).to eql [4, 2] }
    it { expect(result_for_index 5).to eql [5, 1] }
    it { expect(result_for_index 6).to eql [6, 0] }
  end
end

TARGET = <<-EOS
P           M
  R       A  
    O   R    
      G      
    O   R    
  R       A  
P           M
EOS

RSpec.describe '#character_cross' do
  it { expect(character_cross('PROGRAM')).to eql TARGET.chomp }
end

module Kernel
  def capture_stdout
    out = StringIO.new
    $stdout = out
    yield
    return out
  ensure
    $stdout = STDOUT
  end 
end

RSpec.describe 'golfed implementation' do
  let(:console_out) { StringIO.new }
  before { out = console_out }
  
  it 'prints correct output' do
    out = capture_stdout{ f['PROGRAM'] }
    expect(out.string).to eql TARGET 
  end
end


