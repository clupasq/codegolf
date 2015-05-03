require 'minitest/autorun'

F=->digits,length{
  positions={}
  (ds=digits.size).times{|i|positions[digits[i]]=ds-i-1}
  result = []
  digits.dup.cycle.map{|n|
    break if digits==[]
    next unless positions[n]

    steps_left = n
    pos = positions[n]

    taking_over = false

    while steps_left > 0
      other_pos = (positions.values - [positions[n]]).map{|x|x%length}

      steps_left-=1

      pos += 1

      if other_pos.include? (pos%length)
        steps_left -= 1 unless taking_over
        taking_over = true
      else
        taking_over = false
        positions[n] = pos
      end
    end

    if positions[n] >= n*length
      result << digits.delete(n)
      positions.delete(n)
    end
  }
  result
}


F=->digits,length{
  digit_positions = digits.map.with_index{|d,i|[d,digits.size-i-1] }
  
  result = []

  digits.cycle.map{|n|
    break if digit_positions==[]
    crt = digit_positions.find{|x,_|x==n}
    next unless crt

    steps_left = n
    pos = crt[1]
    taking_over = false

    while steps_left > 0
      other_pos = (digit_positions-[crt]).map{|_,p|p%length}

      steps_left-=1
      pos += 1

      if other_pos.include? (pos%length)
        steps_left -= 1 unless taking_over
        taking_over = true
      else
        taking_over = false
        crt[1] = pos
      end
    end

    if crt[1] >= n*length
      digit_positions.delete(crt)
      result<<n
    end
  }
  result
}



p F[[5, 1, 6, 8, 3, 2], 17 ]
[1, 6, 8, 2, 3, 5]

describe '#F' do
  # break 
  def test_case_1
    assert_equal [3], F[[3], 2]
  end

  def test_case_2
    assert_equal [9, 5], F[[9, 5], 3]
  end

  def test_case_3
    assert_equal [2, 9, 5], F[[5, 9, 2], 6]
  end

  def test_case_4
    assert_equal [5, 9, 2], F[[5, 9, 2], 10]
  end

  def test_case_5
    assert_equal  [1, 5, 7, 8, 2], F[[5, 7, 8, 1, 2], 10 ]
  end

  def test_case_6
    assert_equal  [1, 6, 8, 2, 3, 5], F[[5, 1, 6, 8, 3, 2], 17 ]
  end

  def test_case_7
    assert_equal  [1, 7, 8, 9, 2, 3], F[[1, 2, 3, 7, 8, 9], 15 ]
  end

  def test_case_8
    assert_equal  [8, 7, 9, 1, 2, 3], F[[9, 8, 7, 3, 2, 1], 15 ]
  end

  def test_case_9
    assert_equal  [1, 2, 3, 4, 5, 6, 7, 8, 9], F[[1, 2, 3, 4, 5, 6, 7, 8, 9], 20 ]
  end

  def test_case_10
    assert_equal  [8, 7, 5, 9, 6, 1, 2, 4, 3], F[[9, 8, 7, 6, 5, 4, 3, 2, 1], 20 ]
  end
end