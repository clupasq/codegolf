require_relative 'experiments/animals'
require 'minitest/autorun'

F=
->a{l=a.join(?o*(5-w=a[0].size))
s=?o*25
q=(0..25-l.size).select{|i|i/5==(i+w-1)/5}.map{|i|(?o*i+l+s)}
(h=q[0].size.times.map{|i|q.count{|p|p[i]<?o}}
s[c=h.index(h.max)]=?X
q.reject!{|p|p[c]<?o})while q!=[]
s.scan /.{5}/}

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
    F[animal].join.count(?X)
  end

end
