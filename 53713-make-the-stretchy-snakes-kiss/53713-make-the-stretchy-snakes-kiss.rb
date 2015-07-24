# coding: utf-8
require 'pp'
require 'minitest/autorun'

# enumerates the possible states for a given snake
COMBINATIONS =-> snake {
  expandable_fragments = snake.split /(\|+)/

  (0...2**expandable_fragments.size / 2).map{ |i|
    x=-1
    snake.gsub(/\|+/){|r| i[x+=1]>0 ? '\/'*r.size : r}
  }
}

# finds the configuration in which snakes are closest to each other
KISS=
-> input {
  a,b = input.split
  result = input
  s = min_distance = input.size
  COMBINATIONS[a].product(COMBINATIONS[b]){|a,b|
    distance = (a + b).size - s
    if distance > -1 && distance < min_distance
      min_distance = distance
      result = a+' '*distance+b
    end
  }
  result
}


describe KISS do 
  def test_case_1
    assert_equal '<\/=||:)~~(:\/\/\/=\/>', KISS['<|=||:)~     ~(:|||=|>']
  end

  def test_case_2
    assert_equal '<\/\/=||||:)~ ~(:\/\/>', KISS['<||=||||:)~   ~(:||>']
  end
end




