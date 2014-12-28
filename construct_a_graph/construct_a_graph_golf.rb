# coding: utf-8

Node = Struct.new(:l) do
  def link(other)
    l << other
    other.l << self
  end

  def unlink(others)
    self.l -= others
  end
end


def compute_graph_count(commands)
  @nodes = []

  def add_disconnected_node
    @nodes << Node.new([])
  end

  def add_connected_node
    new_node = Node.new([])
    @nodes.each{ |n| n.link new_node }
    @nodes << new_node
  end

  def remove_degree(d)
    to_delete = @nodes.select { |n| n.l.size%d<1 }
    @nodes -= to_delete
    @nodes.each{ |n| n.unlink to_delete }
  end

  commands.each do |cmd|
    case cmd
    when 0 then add_disconnected_node
    when 1 then add_connected_node
    else remove_degree(cmd)
    end
  end

  @nodes.count
end

#--------------------------------------------------

require "minitest/autorun"

class TestGraph < MiniTest::Unit::TestCase

  def setup
    
  end

  def test_empty
    assert_equal 0, result([])
  end
  def test_1
    assert_equal 4, result([0,1,0,1,0,1,3])
  end
  def test_2
    assert_equal 0, result([5])
  end
  def test_3
    assert_equal 0, result([0, 0, 0, 11])
  end
  def test_4
    assert_equal 6, result([0,0,0,1,1,1])
  end
  def test_5
    assert_equal 6, result([0,0,1,1,0,0,1,1,2,5,7,0,1])
  end
  def test_6
    assert_equal 6, result([0,0,1,1,1,1,5,1,4,3,1,0,0,0,1,2])
  end
  def test_7
    assert_equal 8, result([0,0,1,1,0,0,1,1,5,2,3,0,0,1,1,0,0,1,1,3,4,0,0,1,1,2,1,1])
  end
  def test_8
    assert_equal 14, result([0,0,1,1,0,0,1,1,2,5,7,0,1,1,1,1,1,0,1,1,1,1,1,1,1,1,8])
  end

  def result(commands)
    compute_graph_count(commands)
  end
end