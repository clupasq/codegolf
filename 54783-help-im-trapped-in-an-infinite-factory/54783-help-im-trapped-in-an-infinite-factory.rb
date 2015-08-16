require 'pp'
require 'minitest/autorun'

F=
-> grid, box_width, box_height {
  total_width = grid[0].size
  total_height = grid.size

  conveyors = {}

  (0...total_height).map{|y|
    (0...total_width).map{|x|
      w = grid[y][x]
      conveyors[[y,x]] = w if w > ?!
    }
  }  

  move =-> y, x, dir, visited=[]{
    directions = Hash.new 0

    [*y...y + box_height].map{|y|
      [*x...x + box_width].map{|x|
        w = conveyors[[y,x]]
        directions[w] += 1 if w
      }
    }

    horizontal_force = directions[?>] - directions[?<]
    vertical_force = directions[?v] - directions[?^]

    if horizontal_force.abs > vertical_force.abs
      dir = :horizontal
    end
    if horizontal_force.abs < vertical_force.abs
      dir = :vertical
    end

    visited << [y, x]

    case dir
    when :horizontal
      x += horizontal_force <=> 0
    when :vertical
      y += vertical_force <=> 0
    end

    return nil if visited[-1] == [y, x]
    return 1 if visited.include? [y, x]

    move[y, x, dir, visited]
  }

  move[0, 0, :horizontal]
}

describe :X do
  describe 'Grid 1 (2x2)' do
    before do
      @grid = [
        '>v',
        '^<' ]
    end

    it 'detects loop for 1x1' do assert F[@grid, 1, 1] end
    it 'detects loop for 1x2' do assert F[@grid, 1, 2] end
    it 'detects loop for 2x1' do assert F[@grid, 2, 1] end
    it 'detects rest for 2x2' do refute F[@grid, 2, 2] end
  end

  describe 'Grid 2 (3x3)' do
    before do
      @grid = [
        '> v',
        '   ',
        '^ <' ]
    end

    it 'detects rest for 1x1' do refute F[@grid, 1, 1] end
    it 'detects rest for 1x2' do refute F[@grid, 1, 2] end
    it 'detects rest for 1x3' do refute F[@grid, 1, 3] end
    it 'detects rest for 2x1' do refute F[@grid, 2, 1] end
    it 'detects loop for 2x2' do assert F[@grid, 2, 2] end
    it 'detects loop for 2x3' do assert F[@grid, 2, 3] end
    it 'detects rest for 3x1' do refute F[@grid, 3, 1] end
    it 'detects loop for 3x2' do assert F[@grid, 3, 2] end
    it 'detects rest for 3x3' do refute F[@grid, 3, 3] end
  end

  describe 'Grid 3 (6x5)' do
    before do
      @grid = [
        '>v>v>v',
        '^v^v^v',
        '^v^v^v',
        '^>^>^v',
        '^<<<<<']
    end

    it 'detects loop for 1x1' do assert F[@grid, 1, 1] end
    it 'detects rest for 1x2' do refute F[@grid, 1, 2] end
    it 'detects loop for 2x1' do assert F[@grid, 2, 1] end
    it 'detects loop for 2x2' do assert F[@grid, 2, 2] end
    it 'detects loop for 2x4' do assert F[@grid, 2, 4] end
    it 'detects rest for 2x5' do refute F[@grid, 2, 5] end
    it 'detects rest for 3x1' do refute F[@grid, 3, 1] end
    it 'detects loop for 3x2' do assert F[@grid, 3, 2] end
    it 'detects loop for 3x3' do assert F[@grid, 3, 3] end
    it 'detects loop for 3x5' do assert F[@grid, 3, 5] end
    it 'detects rest for 6x2' do refute F[@grid, 6, 2] end
    it 'detects loop for 6x3' do assert F[@grid, 6, 3] end
    it 'detects rest for 6x5' do refute F[@grid, 6, 5] end
  end

  describe 'Grid 4 (10x6)' do
    before do
      @grid = [
        '> <vv    <',
        ' v ^ >v v ',
        '  >v^^>vv^',
        '    ^>^ v ',
        '>  v<v  >>',
        '  >v v<^  ']
    end

    it 'detects rest for 1x1' do refute F[@grid, 1, 1] end
    it 'detects rest for 2x3' do refute F[@grid, 2, 3] end
    it 'detects rest for 2x6' do refute F[@grid, 2, 6] end
    it 'detects loop for 3x2' do assert F[@grid, 3, 2] end
    it 'detects rest for 5x4' do refute F[@grid, 5, 4] end
    it 'detects loop for 6x1' do assert F[@grid, 6, 1] end
    it 'detects rest for 10x6' do refute F[@grid, 10, 6] end
  end
end
