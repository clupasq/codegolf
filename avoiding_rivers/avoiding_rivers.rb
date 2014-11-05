require 'rspec/autorun'

SAMPLE_TEXT = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eismod tempor incididunt ut labore et dolore maga aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eismod tempor incididunt ut labore et dolore maga aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'

RSpec.describe 'program' do
  let(:large_text){ SAMPLE_TEXT }

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
    subject { optimum_wrap text, min, max }

    context 'simple example' do
      let(:text) { 'abc def ghi jkl mno pqr' }
      let(:min) { 7 }
      let(:max) { 16 }

      it { expect(subject).to eql <<-EOS.chomp
abc def ghi
jkl mno pqr
EOS
      }

    end

    context 'real example' do
      let(:text) { large_text }
      let(:min) { 70 }
      let(:max) { 90 }

            it { expect(subject).to eql <<-EOS.chomp
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eismod tempor
incididunt ut labore et dolore maga aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore
eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt
in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor
sit amet, consectetur adipisicing elit, sed do eismod tempor incididunt ut
labore et dolore maga aliqua. Ut enim ad minim veniam, quis nostrud
exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis
aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.
EOS
      }
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
  (0..99).map{|i| text_lines.map{|l|l[i]}.join.scan(/ +/) }.flatten.max_by(&:size).size
end

def optimum_wrap text, min, max

  smallest_max = max
  result = ''

  min.upto(max){|w|}
  (min..max).each{|w|
    wrap = print_text_with_max_width(text, w)
    if max_river(wrap,w)<smallest_max
      smallest_max = max_river(wrap,w)
      result = wrap.join ?\n
    end
  }
  result
end




RSpec.describe '#golfed' do
  subject { golfed text }

  context 'real example' do
    let(:text) { SAMPLE_TEXT }
    it { expect(subject).to eql <<-EOS.chomp
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eismod tempor
incididunt ut labore et dolore maga aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore
eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt
in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor
sit amet, consectetur adipisicing elit, sed do eismod tempor incididunt ut
labore et dolore maga aliqua. Ut enim ad minim veniam, quis nostrud
exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis
aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.
EOS
    }
  end
end

def golfed getS
  
  result = ''

  (70..smallest_max=90).each{|w|

    wrap = (getS+' ').scan(%r{(.{1,#{w-1}}\S) }).flatten
    max_crt_river = (0..99).map{|i| wrap.map{|l|l[i]} }.flatten.join.scan(/ +/).max_by(&:size).size

    if max_crt_river<smallest_max
      smallest_max = max_crt_river
      result = wrap.join ?\n
    end
  }
  result

end