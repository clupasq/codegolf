require 'pp'
require 'minitest/autorun'


class World
  def initialize(width, height)
    @width = width
    @height = height
  end

  attr_accessor :width, :height

  def possible_animal_placements(animal)
    animal_width = animal[0].length
    animal_height = animal.length

    [].tap do |results|

      linear_animal = animal.join(?o * (@width - animal_width))

      # [0..@height*@width - linear_animal.length].map do |offset|
      #   field = ?o * (@height * @width)
      #   field[offset...offset+linear_animal.size] = linear_animal

      #   results << field.scan(Regexp(".{#{@width}}"))
      # end

      (0..@height - animal_height).each do |y_offs|
        (0..@width - animal_width).each do |x_offs|
          field = height.times.map { 'o' * @width }
          animal_height.times do |y|
            field[y + y_offs][x_offs...x_offs+animal_width] = animal[y]
          end
          results << field
        end
      end
    end
  end

  def heatmap_for_animal(animal)
    @height.times.map { [0] * @width }.tap do |heatmap|
      placements = possible_animal_placements(animal)

      @height.times do |y|
        @width.times do |x|
          placements.each do |pl|
            heatmap[y][x] += 1 if pl[y][x] < ?o
          end
        end
      end
    end
  end

  def heatmap(placements)
    @height.times.map { [0] * @width }.tap do |heatmap|

      @height.times do |y|
        @width.times do |x|
          placements.each do |pl|
            heatmap[y][x] += 1 if pl[y][x] < ?o
          end
        end
      end
    end
  end
end



class WorldTests < Minitest::Test
  def test_can_create_worlds_of_different_sizes
    w = World.new(5, 4)
    assert_equal 5, w.width
    assert_equal 4, w.height
  end
  
  class SimpleAnimalInSmallWorld < Minitest::Test
    @@world = World.new(2, 2)
    @@animal = ['X']

    def test_placements
      expected = [['Xo', 'oo'], ['oX', 'oo'], ['oo', 'Xo'], ['oo', 'oX']]
      assert_equal expected, @@world.possible_animal_placements(@@animal)
    end

    def test_heatmap
      expected = [
        [1, 1],
        [1, 1]
      ]
      assert_equal expected, @@world.heatmap_for_animal(@@animal)
    end
  end

  class BiggerAnimalInBiggerWorld < Minitest::Test
    @@world = World.new(4, 3)
    @@animal = ['Xoo',
                'oXX']


    def test_placements
      expected = [
        ['Xooo',
         'oXXo',
         'oooo'],
        ['oXoo',
         'ooXX',
         'oooo'],
        ['oooo',
         'Xooo',
         'oXXo'],
        ['oooo',
         'oXoo',
         'ooXX'],
      ]
      assert_equal expected, @@world.possible_animal_placements(@@animal)
    end
  end
end

UNICORN = [
  'Xoo',
  'oXX']

SHEEP = [
  'XXXX']

KANGAROO = [
  'Xooo',
  'oXoo',
  'ooXo',
  'oooX']

HIPPO = [
  'XoX',
  'ooo',
  'XoX']

def heatmaps
  w = World.new(5, 5)
  pp w.heatmap_for_animal(HIPPO)
end

def combinations
  p [*0..25].combination(10).count
end

# combinations
heatmaps


