require 'rspec/autorun'

def initial_state
  %W{H B E F}.product(%W{S M L}).map{|f,s|"!"+s+f}
end

def add(array, feature)
  array<<feature
  array.delete "!"+feature
end

RSpec.describe '#initial_state' do
  it 'contains all negated features' do
    expect(initial_state).to eql %W{!SH !MH !LH !SB !MB !LB !SE !ME !LE !SF !MF !LF}
  end
end

RSpec.describe '#add' do
  subject{initial_state}

  before(:each){
    add(subject, 'SH')
    add(subject, 'ME')
  }

  it 'has the given attributes' do
    expect(subject.member? 'SH').to be true
    expect(subject.member? 'ME').to be true
  end
  it 'does not negate the given attributes' do
    expect(subject.member? '!SH').to be false
    expect(subject.member? '!ME').to be false
  end
end


def build_board
  board=[]
  81.times{|i|
    cell = initial_state
    board << cell

    sizes='SML'

    add(cell, sizes[i%9/3]+"H")
    add(cell, sizes[i%3]+"E")
    add(cell, sizes[i/27]+"B")
    add(cell, sizes[i/9%3]+"F")
  }

  board
end

RSpec.describe '#build_board' do
  subject {build_board}

  it 'has 81 elements' do
    expect(subject.size).to eql 81
  end

  it 'print board' do
    # puts
    # 81.times{|i|
    #   puts "#{i.to_s.rjust(2, '0')} -> #{subject[i]}"
    # }
  end
end

def query(filter)
  b = build_board
  rules = filter.split ?,
  z=(1..81).find_all{|i|rules.all?{|r|b[i-1].member? r}}
  z.empty?&&z<<0 
  z.inspect
end

RSpec.describe '#query' do
  it 'passes test cases' do
    expect(query('SH,LB,ME,SF')).to eql '[56]'
    expect(query('!SH,LB,!ME,SF')).to eql '[58, 60, 61, 63]'
    expect(query('SB,!MF,!LF')).to eql '[1, 2, 3, 4, 5, 6, 7, 8, 9]'
    expect(query('MH,!MH')).to eql '[0]'
  end
end
