# http://codegolf.stackexchange.com/questions/47229/water-held-in-a-hexagonal-rod-scuplture
require 'minitest/autorun'
require 'pp'

Rod = Struct.new :x,:y,:height,:water_height,:neighbors do
  def to_s
    "(#{x},#{y})->#{height}"
  end

  def total_height
    height + water_height
  end
end

f=->input{

  #parse input
  list = []
  l = input.lines
  (0...l.size).map do |y|
    x=-1      
    list += l[y].scan(/../).map{|v| Rod.new x=x+1, y, v.to_i, v.to_i<1?0:99}
  end 

  empty_rod = Rod.new(0,0,0,0)
  find_rod_by_coords=->x,y{list.find{ |r| r.x==x && r.y==y } || empty_rod}

  # populate the neighbors of each rod
  list.each do |rod|
    neighbor_coord_offsets = [[-1,-1],[1,-1],[-2,0],[2,0],[1,-1],[1,1]]
    rod.neighbors = neighbor_coord_offsets.map{|w,z| find_rod_by_coords[rod.x+w,rod.y+z]}
  end

  # let the water leak...
  changed = 1

  adjust_water=->rod{
    m = rod.neighbors.map(&:total_height).min
    if rod.total_height > m && rod.water_height > 0
      rod.water_height = [0,m-rod.height].max
      changed = 1
    end
  }

  (changed=!0
    list.map{|rod| adjust_water[rod]}
  )while changed

  # ...and return the result
  list.map(&:water_height).reduce :+
}


describe '#f' do

  it 'passes test case #1' do
    input = <<-EOS
  04  04
04  01  03
  04  04
EOS
    
    assert_equal 2, f[input]
  end

  it 'passes test case #2' do
    input = <<-EOS
55  34  45  66
  33  21  27
23  12  01  77
  36  31  74
EOS

    assert_equal 35, f[input]
  end


  it 'passes test case #3' do
    input = <<-EOS
        35  36  77  22                      23  32  54  24
      33  07  02  04  21                  54  07  07  07  76
    20  04  07  07  01  20              54  11  81  81  07  76
  20  67  67  22  07  01  78          54  07  81  07  81  09  76
20  67  07  67  22  22  07  44  55  54  07  81  07  07  61  07  20
  67  57  50  50  07  07  14  03  02  15  81  99  91  07  81  04
67  07  50      50  87  39  45  41  34  81  07  07  89  07  81  79
  67  07  50  50  07  07  07  27  07  27  81  07  07  79  81  78
20  67  67  07  07  07  07  99  33  46  02  81  07  07  81  01  20
  33  07  07  01  05  01  92          20  02  81  07  81  15  32
    22  07  20  20  07  20              63  02  80  81  15  32
      45  20  01  20  39                  20  15  07  15  32
        23  20  20  29  43  21  18  41  20  66  66  43  21
      90                  99  47  07  20
    50                      20  02  48
  70                          56  20
                                90
EOS

    assert_equal 1432, f[input]
  end
end
