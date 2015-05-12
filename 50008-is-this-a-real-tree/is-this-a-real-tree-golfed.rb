# coding: utf-8
require 'pp'
require 'minitest/autorun'

F=
->i{
w=i.index(?\n)+1
t=[i.index(/[^ _] *\n\z/)]
a=->x,c{(i[x]==c||i[x]==?_)&&t<<x}
((x=t.pop)&&(s=x-w;c=i[x])<?0?(a[s+1,?/];a[s,?\\]):c<?]?(a[s-1,?\\];a[s,?/]):c<?`?(a[x-1,?\\];a[x+1,?/]):a[s,?|]
i[x]=' ')while t!=[]
!i[/\S/]}


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
