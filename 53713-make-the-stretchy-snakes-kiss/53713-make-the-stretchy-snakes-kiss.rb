# coding: utf-8
require 'pp'
require 'minitest/autorun'

# enumerates the possible states for a given snake
COMBINATIONS =-> snake {
  expandable_fragments = snake.split /(\|+)/

  (0...2**(expandable_fragments.size/2)).map{ |i|
    x=-1
    snake.gsub(/\|+/){|r| i[x+=1]>0 ? '\/'*r.size : r}
  }
}

# finds the configuration in which snakes are closest to each other
KISS=
-> input {
  a,b = input.split
  result = input
  s = input.size
  initial_distance = min_distance = input[/ +/].size

  COMBINATIONS[input].map{|c|
    distance = initial_distance + s - c.size
    if distance > -1 && distance < min_distance
      min_distance = distance
      result = c.gsub(/ +/,' '*distance)
    end
  }
  
  result
}


describe KISS do 
  def test_case_0
    assert_equal '<\/=||:)~~(:\/\/\/\/>', KISS['<|=||:)~     ~(:||||>']
  end

  def test_case_1
    assert_equal '<|=\/\/:)~~(:\/\/\/=|>', KISS['<|=||:)~     ~(:|||=|>']
  end

  def test_case_2
    assert_equal '<\/\/=||||:)~ ~(:||>', KISS['<||=||||:)~   ~(:||>']
  end
end



