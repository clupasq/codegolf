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
      term = closest_repdigit(crt_value.abs)*(0<=>crt_value)
      terms << term
      crt_value += term
    end
    terms
  end

  def self.print_decomposition n

  end
end

RSpec.describe Decomposer do
  describe '#closest_repdigit' do
    it { expect(Decomposer.closest_repdigit(24192)).to eql 22222 }
    it { expect(Decomposer.closest_repdigit(199)).to eql 111 }
    it { expect(Decomposer.closest_repdigit(7)).to eql 7 }
  end

  describe '#decompose' do
    it { expect(Decomposer.decompose(7)).to eql [-7] }
    it { expect(Decomposer.decompose(24192)).to eql [-22222, -1111, -888, +22, +7] }
    it { expect(Decomposer.decompose(113)).to eql [-111, -2] }
  end

  describe '#print_decomposition' do
    it { expect(Decomposer.decompose(24192)).to eql [-22222, -1111, -888, +22, +7] }
    it { expect(Decomposer.decompose(113)).to eql [-111, -2] }
  end
end