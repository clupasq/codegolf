# coding: utf-8
require 'minitest/autorun'

F=->s{d=[1,w=z=1e4,-1,-z]
v=[w]+s.chars.map{|c|w+=d.rotate!(c<?R?-1:c>?R?0:1)[0]}
v==v&v}

describe '#F' do
  describe 'valid slithers' do
    def test_first_case
      assert F['SRSLSSLRLRSSRSRSS']
    end

    def test_valid
      assert F['SSLSLSRSRSSRSSSLLSSSRRLRSLRLLSSS']
    end
    def test_a_hilbert_curve
      assert F['SRRLSLLRRLLSLRRSRLLRSRRLLRRSRLLSSLLRSRRLLRRSRLLRSRRLSLLRRLLSLRR']
    end
    def test_another_valid
      assert F['RLLRSRRLSLLRRLLSLRRSRLLRSRRLLRRSRLLSSLLRSRRLLRRSRLLRSRRLSLLRRLLSLRRSRLLRSRRLLRRSRLLSSLLRSRRLLRR']
    end
    def test_Spiral
      assert F['SRRSRSRSSRSSRSSSRSSSRSSSSRSSSSRSSSSSRSSSSSRSSSSSSRSSSSSSRSSSSSS']
    end
    def test_bigger_squigglier_spiral
      assert F['SSSSSSSSSSLSSSSSSSLSSSSSSSSLSSSSSLSSSSSSLSSSLLRRLLRRLLSLSSSRRSSSSRSSSRSSSSSSRSSSSSRSSSSSSSSRSSSSSSSRSSSSSSSSS']
    end
    def test_yet_another_valid
      assert F['LRSLLRLSRSLLSRLSLRSLSSSLRRSSLSRRLRSRLRLSLRLLRLRSSLSLRLRSRSSSSSLSRRLSLSSSRRLRLRLRLRRLLSSLSSSRRLRLRLRLRLSLSSSSSSSSSSSSSRLRLLRLRLRLRLRLRLRLSLSSSLSLSLL']
    end
  end

  describe 'invalid slithers' do
    def test_invalid_1
      refute F['SRRLSLLRRLLSLRRSRLLRSRRLLRRSRLLLLRSRRLLRRSRLLRSRRLSLLRRLLSLRR']
    end
    def test_invalid_2
      refute F['SRRLSLLRRLLSLRRSRLLRSRRLLSRSSSRSSSSSSSRSRSSSSSSSRRLLRRSRLLRSRRLSLLRRLLSLRR']
    end
    def test_invalid_3
      refute F['SRRSRSRSSRSSRSSSRSSSRSSSSSSSSSSRSSSSRSSSSSRSSSSSRSSSSSSRSSSSSSRSSSSSS']
    end
    def test_invalid_4
      refute F['SSSSSSSSSSLSSSSSSSLSSSSSSSSLSSSSSLSSSSSSLSSSLLRRLRLRRLLSLSSSRRSSSSRSSSRSSSSSSRSSSSSRSSSSSSSSRSSSSSSSRSSSSSSSSS']
    end
    def test_invalid_5
      refute F['LRSLLRLSRSLLSRLSLRSLSSSLRRSSLSRRLRSRLRLSLRLLRLRSSLSLRLRSRSSSSSLSRRLSLSSSRRLRLRLRLRRLLSSLSSSRRLRLRLRLRLSLSSSSSSSSSSSSSRLRLLRLRLRLRLRLRLRLSLSSSLSLSLLSLRLSLRSLRSLRSLSLSLRSRLSLRSLRLSRSLLLRLRLRRRRSLSLSSLLSLSLSLSSLLSLSLLRLRSLLRSRLSLSSLLLLSSSSSSSSSSSSSSSSSSSSRLRLLRRLRLRLLRLRLRLRLRLSSSSLSLRLLRLSLSSLSLSLSLSLRLLRLSLLLSRSSSSSSSSSSSSSSSRLRLRLLRLRLSLSRSRSSSLSRLRLRLRSLSLSLSRLLSRLSLSLSLSLSSLSLSLLSLSRLLRLRLRLRLRLRLRLRLRLRLSLSRLRLSLLRRLSLLSLSLSLSLSLLSLSLSLRLRLRLRLRLRLRLRLRLRRLRSLSLSLSLSLSLSLSSLSSSSSLSLSSSLSLSLSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS']
    end
  end
end




