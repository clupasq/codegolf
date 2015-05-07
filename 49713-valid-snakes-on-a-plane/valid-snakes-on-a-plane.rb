# coding: utf-8
require 'minitest/autorun'

F = -> input {
  # Coordinates are expressed using one number,
  # that is computed using the formula `y + x*max_x`.
  # Assume max horizontal field width (max_x) to be 10000,
  # since that's the max length of the input.
  position = max_x = 1e4

  # These are possible directions to move to
  # The current direction is always the first
  directions = [1,max_x,-1,-max_x]
  
  visited = [position]

  visited += input.chars.map{|c|
    # adjust current direction...
    directions.rotate! case c
    when ?L
      -1
    when ?R
      1
    when ?S
      0
    end

    # ...and move there
    position += directions[0]
  }

  # Return `true` if `visited` only contains distinct elements, `false` otherwise
  visited == visited & visited
}


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




