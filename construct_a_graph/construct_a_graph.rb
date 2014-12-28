# coding: utf-8
require 'pp'

class Node
  def initialize
    @neighbours = []
  end

  attr_accessor :neighbours

  def link(other)
    @neighbours << other
    other.neighbours << self
  end

  def unlink(others)
    @neighbours -= others
  end
end

class Graph
  def initialize(commands)
    @nodes = []
    commands.each do |cmd|
      case cmd
      when 0 then add_disconnected_node
      when 1 then add_connected_node
      else remove_degree(cmd)
      end
    end
  end

  def add_disconnected_node
    @nodes << Node.new
  end

  def add_connected_node
    new_node = Node.new
    @nodes.each{ |n| n.link new_node }
    @nodes << new_node
  end

  def remove_degree(l)
    to_delete = @nodes.select { |n| n.neighbours.count % l < 1 }
    @nodes -= to_delete
    @nodes.each{ |n| n.unlink to_delete }
  end

  def count
    @nodes.count
  end
end

#--------------------------------------------------

require "minitest/autorun"

class TestGraph < MiniTest::Unit::TestCase
  def test_empty
    assert_equal 0, Graph.new([]).count
    assert_equal 4, Graph.new([0,1,0,1,0,1,3]).count
    assert_equal 0, Graph.new([5]).count
    assert_equal 0, Graph.new([0, 0, 0, 11]).count
    assert_equal 6, Graph.new([0,0,0,1,1,1]).count
    assert_equal 6, Graph.new([0,0,1,1,0,0,1,1,2,5,7,0,1]).count
    assert_equal 6, Graph.new([0,0,1,1,1,1,5,1,4,3,1,0,0,0,1,2]).count
    assert_equal 8, Graph.new([0,0,1,1,0,0,1,1,5,2,3,0,0,1,1,0,0,1,1,3,4,0,0,1,1,2,1,1]).count
    assert_equal 14, Graph.new([0,0,1,1,0,0,1,1,2,5,7,0,1,1,1,1,1,0,1,1,1,1,1,1,1,1,8]).count
  end
end