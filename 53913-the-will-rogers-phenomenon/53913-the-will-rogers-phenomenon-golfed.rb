require 'minitest/autorun'

A=->x{x.reduce(0.0,:+)/x.size}
F=->q{b,a=q.sort_by{|x|A[x]};a.any?{|x|x<A[a]&&x>A[b]}}
 
describe F do
  def test_truthy_cases
    [
    [[1], [2, 3]],
    [[1, 2, 3], [4, 5, 6]],
    [[3, 4, 5, 6], [2, 3, 4, 5]],
    [[6, 5, 9, 5, 6, 0], [6, 2, 0, 9, 5, 2]],
    [[0, 4], [9, 1, 0, 2, 8, 0, 5, 5, 4, 9]]
    ].each do |arrays|
      assert F[arrays]
    end
  end
 
  def test_falsy_cases
    [
    [[1], [2]],
    [[2, 4], [5]],
    [[1, 5], [2, 3, 4, 5]],
    [[2, 1, 2, 3, 1, 3], [5, 1, 6]],
    [[4, 4, 5, 2, 4, 0], [9, 2, 10, 1, 9, 0]]
    ].each do |arrays|
      refute F[arrays]
    end
  end
end
