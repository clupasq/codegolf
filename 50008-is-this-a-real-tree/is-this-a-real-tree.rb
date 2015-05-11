# coding: utf-8
require 'pp'
require 'minitest/autorun'

F =-> input {
  row_size = input.index(?\n)+1

  root_coord = input.index /[^ _] *\n\z/

  # coordinates to process
  todo = [root_coord]

  add_todo = -> coord, char{
    if input[coord] == char || input[coord] == ?_
      todo << coord
    end
  }

  while todo.any?
    x = todo.pop

    next unless x # exit quickly if no root present

    case input[x]
    when ?|
      add_todo[x - row_size, ?|]
    when ?_
      add_todo[x - 1, ?\\]
      add_todo[x + 1, ?/]
    when ?/
      add_todo[x - row_size + 1, ?/]
      add_todo[x - row_size, ?\\]
    when ?\\
      add_todo[x - row_size - 1, ?\\]
      add_todo[x - row_size, ?/]
    end
    input[x]=' '
  end
  input.strip < ?*
}


describe '#F' do
  # Valid trees
  #############

  def test_young_tree
    assert F['|
']
  end

  def test_valid_tree
    assert F['  _  
\/  /
 \_/ 
  |  
  |  
']
  end

  def test_valid_italic_tree
    assert F['         
/ /    \/
\ \____/ 
 \/      
 /       
/        
']
  end

  def test_valid_cat_tree
    assert F['      
 \___/
 /   \
 \___/
   |  
   |  
']
  end

  def test_valid_stair_tree
    assert F['      
   __/
 _/   
/     
']
  end

  def test_valid_old_tree
    assert F['           
____       
  \  ___   
 \ \/      
  \/\_____/
 \/  \/    
  \__/     
    |      
    |      
']
  end

  # Invalid trees
  ###############

  def test_invalid_reachable_only_with_downward_route
    refute F['          
\/        
 \_______/
  \__   / 
   | \_/  
   |      
']
  end

  def test_invalid_multiple_roots
    refute F['_']
  end
  
  def test_invalid_multiple_root_characters
    refute F['\/
']
  end
  
  def test_invalid_multiple_roots
    refute F['/\
']
  end
 
  def test_invalid_unreachable_part
    refute F[' 
|
 
|
']
  end

  def test_invalid_unreachable_parts
    refute F['    
 __/
/   
|   
']
  end
  
  def test_invalid_multiple_roots_2
    refute F['      
\____/
 |  | 
']
  end

  def test_invalid_unreachable_parts_2
    refute F['     
_\__/
|    
']
  end
end
