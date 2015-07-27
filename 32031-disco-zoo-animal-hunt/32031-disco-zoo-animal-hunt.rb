require_relative 'experiments/animals'
require 'minitest/autorun'

SIZE = 5

def get_placements(animal)
  linear_animal = animal.join(?o*(SIZE - animal[0].size))
  d = SIZE*SIZE
  (0..d-linear_animal.size)
    .select{|i| i/5 == (i+animal[0].size-1)/5} # to avoid wrap-around positions
    .map { |i|
      (?o*i + linear_animal + ?o*d)[0...d]
    }
end

def heatmap(placements)
  placements[0].size.times.map do |i|
    placements.count {|p|p[i] < ?o}
  end
end

def solve(animal)
  placements = get_placements animal
  solution = []

  while placements.any?
    h = heatmap(placements)

    solution << chosen = h.index(h.max)

    placements = placements.reject {|pl| pl[chosen] < ?o }
  end

  (0...25).map{|i| solution.include?(i) ? ?X : ?o }.join.scan /.{5}/
end

describe 'solver returns optimum number of moves' do
  def test_optimal
    assert_equal 4, solution_block_count(MONKEY)
    assert_equal 9, solution_block_count(AATXE)
    assert_equal 3, solution_block_count(LUNAR_TICK)
    assert_equal 4, solution_block_count(RACCOON)
    assert_equal 10, solution_block_count(MARSHMALLOW)
    assert_equal 3, solution_block_count(WOOLY_RHINO)
    assert_equal 4, solution_block_count(GORILLA)
    assert_equal 4, solution_block_count(HIPPO)
    assert_equal 5, solution_block_count(PLATYPUS)
    assert_equal 4, solution_block_count(BEAR)
    assert_equal 3, solution_block_count(ZEBRA)
    assert_equal 3, solution_block_count(KANGAROO)
    assert_equal 10, solution_block_count(SASQUATCH)

  end

  def solution_block_count(animal)
    solve(animal).join.count(?X)
  end

end

