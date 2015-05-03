require 'rspec/autorun'

class MinesweeperChecker
  def initialize board_data
    @board_data = board_data
  end

  attr_reader :rows

  def count_surrounding_mines(y, x)
    r=[-1,0,1]
    r.product(r)
      .map{|a,b|[y+a,x+b]}
      .count{ |y, x| x >= 0 && y >= 0 &&(rows[y] || [])[x] == 'X' }
  end

  def rows
    @board_data.scan(/\S+/)
  end

  def valid?

    rows.each_with_index do |row, y|
      row.chars.each_with_index do |cell, x|
        next if cell == ?X
        return false if cell.to_i != count_surrounding_mines(y, x)
      end
    end
    true
  end
end

RSpec.describe MinesweeperChecker do

  subject { MinesweeperChecker.new(board) }

  # describe '#rows' do
  #   let(:board) { '02X2 13X2 X211' }
  #   it 'parses board data correctly' do
  #     expect(subject.rows).to eql [ '02X2', '13X2', 'X211' ]
  #   end
  # end

  describe '#count_surrounding_mines' do
    context 'simple board' do
        let(:board) { '02X2 13X2 X211' }
        it{ expect(subject.count_surrounding_mines(1, 1)).to eql 3 }
        it{ expect(subject.count_surrounding_mines(0, 0)).to eql 0 }
    end
  end

  describe '#valid?' do
    subject{ MinesweeperChecker.new(board).valid? }

    context 'valid_boards' do
      after do
        expect(subject).to be_truthy
      end

      context 'simple board' do
        let(:board) { '02X2 13X2 X211' }
        it {}
      end
      context 'full of X' do
        let(:board) { 'XXXX XXXX XXXX XXXX' }
        it {}
      end
      context 'bigger board' do
        let(:board) { 'XX4X2 5X6X4 XX6XX 4XX54 2X4XX' }
        it {}
      end
    end

    context 'invalid_boards' do
      after do
        expect(subject).to be_falsey
      end

      context 'simple board' do
        let(:board) { '02X2 13X2 X212' }
        it {}
      end
      context 'full of X' do
        let(:board) { 'XXXX XXXX X7XX XXXX' }
        it {}
      end
      context 'bigger board' do
        let(:board) { 'XX4X2 5X6X4 XX6XX 4XX54 2X5XX' }
        it {}
      end
    end
  end
end


