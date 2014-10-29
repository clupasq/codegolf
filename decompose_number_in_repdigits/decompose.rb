require 'rspec/autorun'
require_relative '../test_utils'

class Decomposer
  def self.closest_repdigit n
    ((a=n.to_s)[0]*a.size).to_i
  end

  def self.decompose n
    terms = []
    crt_value = n

    while crt_value != 0
      term = closest_repdigit(crt_value.abs)*(crt_value<=>0)
      terms << term
      crt_value -= term
    end
    terms
  end

  def self.print_decomposition n
    length = n.to_s.size

    puts" #{n}"

    decompose(n).each{|t|
      sgn = t==decompose(n).first ? '=' : '++-'[t<=>0]
      puts "#{sgn}#{t.abs}".rjust(length+1)
      # puts ""      t.to_s.rjust(length+1)
    }

  end
end

RSpec.describe Decomposer do
  describe '#closest_repdigit' do
    it { expect(Decomposer.closest_repdigit(24192)).to eql 22222 }
    it { expect(Decomposer.closest_repdigit(199)).to eql 111 }
    it { expect(Decomposer.closest_repdigit(7)).to eql 7 }
  end

  describe '#decompose' do
    it { expect(Decomposer.decompose(7)).to eql [7] }
    it { expect(Decomposer.decompose(24192)).to eql [22222, 1111, 888, -22, -7] }
    it { expect(Decomposer.decompose(113)).to eql [111, 2] }
  end

  describe '#print_decomposition' do

    it { 
      out = capture_stdout do
        Decomposer.print_decomposition 24192
      end

      expect(out.string).to eql <<-EOS
 24192
=22222
 +1111
  +888
   -22
    -7
EOS
    }
    # it { expect(Decomposer.decompose(113)).to eql [-111, -2] }
  end
end