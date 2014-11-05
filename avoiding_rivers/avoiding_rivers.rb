require 'rspec/autorun'

RSpec.describe 'program' do
  let(:large_text){ 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eismod tempor incididunt ut labore et dolore maga aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eismod tempor incididunt ut labore et dolore maga aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.' }

  describe '#split_into_words' do
    it { expect(split_into_words('Lorem ipsum dolor sit amet, consectetur ')).to eql ['Lorem','ipsum','dolor','sit','amet,','consectetur'] } 
  end

  describe '#print_text_with_max_width' do
    it { expect(print_text_with_max_width('Lorem ipsum dolor sit amet, consectetur ', 15))
      .to eql ['Lorem ipsum', 'dolor sit amet,', 'consectetur']} 
    it { expect(print_text_with_max_width('Lorem ipsum dolor sit amet, consectetur. ', 20))
      .to eql ['Lorem ipsum dolor', 'sit amet,', 'consectetur.']} 

    context 'large text' do
      it 'wraps to 82' do
        expect(print_text_with_max_width(large_text, 82)).to eql [
'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eismod tempor', 
'incididunt ut labore et dolore maga aliqua. Ut enim ad minim veniam, quis nostrud', 
'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute', 
'irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla', 
'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui', 
'officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet,', 
'consectetur adipisicing elit, sed do eismod tempor incididunt ut labore et dolore', 
'maga aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris', 
'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in', 
'voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint', 
'occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id', 
'est laborum.']
      end

      it 'wraps to 78' do
        expect(print_text_with_max_width(large_text, 78)).to eql [
'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eismod tempor', 
'incididunt ut labore et dolore maga aliqua. Ut enim ad minim veniam, quis', 
'nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 
'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore', 
'eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt', 
'in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor', 
'sit amet, consectetur adipisicing elit, sed do eismod tempor incididunt ut', 
'labore et dolore maga aliqua. Ut enim ad minim veniam, quis nostrud', 
'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis', 
'aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu', 
'fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in', 
'culpa qui officia deserunt mollit anim id est laborum.', 
]
      end
    end
  end

  describe '#max_river' do
    let(:text_lines) { print_text_with_max_width large_text, width }

    context 'wrapped to 78' do
      let(:width) { 78 }
      it { expect(max_river(text_lines, width)).to eql 2 }
    end
    context 'wrapped to 82' do
      let(:width) { 82 }
      it { expect(max_river(text_lines, width)).to eql 6 }
    end
  end

  describe '#optimum_wrap' do
    subject { optimum_wrap text }

    context 'simple example' do
      let(:text) { '' }
    end

  end
end

end


def split_into_words text
  text.split' '
end

def print_text_with_max_width text, max_width
  first_word,*words = split_into_words text

  rows = [first_word]

  words.each{|w|
    last_row = rows.last

    if last_row.length + w.length + 1 > max_width
      rows << w
    else
      rows[-1] = (rows[-1]).to_s+' '+w
    end
  }
  rows
end

def print_text_with_max_width text, max_width
  (text+' ').scan(%r{(.{1,#{max_width-1}}\S) }).flatten
end


def max_river text_lines, wrap_width
  (0..82).map{|i| text_lines.map{|l|l[i]}.join.scan(/ +/) }.flatten.max_by(&:size).size
end

def optimum_wrap text, min, max
  
end