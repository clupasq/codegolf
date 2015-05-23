require 'minitest/autorun'

F=
->i,z{
i.split(?\n).map{|l|z.times.map{|y|l.size.times.map{|i|z.times.map{|x|c=l[i]
z<y+2&&(l[i-1..i]=='_\\'||l[i..i+1]=='/_')&&o=?_
(c<?!||(x==y&&c==?\\)||(z==y+1&&c>?^)||(x+y+1==z&&c==?/))&&o=c
o||' '}.join}.join.rstrip}-['']}.join ?\n}

describe '#F' do
  describe 'small diamond' do

    def diamond
      ' __
/_/\
\_\/
'
    end

    def test_1
      assert_equal F[diamond, 1], ' __
/_/\
\_\/'
    end

    def test_2
      assert_equal F[diamond, 2], '  ____
 /   /\
/___/  \
\   \  /
 \___\/'
    end

    def test_3
      assert_equal F[diamond, 3], '   ______
  /     /\
 /     /  \
/_____/    \
\     \    /
 \     \  /
  \_____\/'

    end

    def test_4
      assert_equal F[diamond, 4], '    ________
   /       /\
  /       /  \
 /       /    \
/_______/      \
\       \      /
 \       \    /
  \       \  /
   \_______\/'
    end

    def test_5
      assert_equal F[diamond, 5], '     __________
    /         /\
   /         /  \
  /         /    \
 /         /      \
/_________/        \
\         \        /
 \         \      /
  \         \    /
   \         \  /
    \_________\/'
    end

    def test_6
      assert_equal F[diamond, 6], '      ____________
     /           /\
    /           /  \
   /           /    \
  /           /      \
 /           /        \
/___________/          \
\           \          /
 \           \        /
  \           \      /
   \           \    /
    \           \  /
     \___________\/'
    end
  end

  describe 'medium diamond' do
    def diamond 
      '  ____
 /_/\_\
/\_\/_/\
\/_/\_\/
 \_\/_/'
    end

    def test_1
      assert_equal F[diamond, 1], '  ____
 /_/\_\
/\_\/_/\
\/_/\_\/
 \_\/_/'
    end

    def test_2
      assert_equal F[diamond, 2], '    ________
   /   /\   \
  /___/  \___\
 /\   \  /   /\
/  \___\/___/  \
\  /   /\   \  /
 \/___/  \___\/
  \   \  /   /
   \___\/___/'
    end

    def test_3
      assert_equal F[diamond, 3], '      ____________
     /     /\     \
    /     /  \     \
   /_____/    \_____\
  /\     \    /     /\
 /  \     \  /     /  \
/    \_____\/_____/    \
\    /     /\     \    /
 \  /     /  \     \  /
  \/_____/    \_____\/
   \     \    /     /
    \     \  /     /
     \_____\/_____/'
    end

    def test_4
      assert_equal F[diamond, 4], '        ________________
       /       /\       \
      /       /  \       \
     /       /    \       \
    /_______/      \_______\
   /\       \      /       /\
  /  \       \    /       /  \
 /    \       \  /       /    \
/      \_______\/_______/      \
\      /       /\       \      /
 \    /       /  \       \    /
  \  /       /    \       \  /
   \/_______/      \_______\/
    \       \      /       /
     \       \    /       /
      \       \  /       /
       \_______\/_______/'
    end

    def test_5
      assert_equal F[diamond, 5], '          ____________________
         /         /\         \
        /         /  \         \
       /         /    \         \
      /         /      \         \
     /_________/        \_________\
    /\         \        /         /\
   /  \         \      /         /  \
  /    \         \    /         /    \
 /      \         \  /         /      \
/        \_________\/_________/        \
\        /         /\         \        /
 \      /         /  \         \      /
  \    /         /    \         \    /
   \  /         /      \         \  /
    \/_________/        \_________\/
     \         \        /         /
      \         \      /         /
       \         \    /         /
        \         \  /         /
         \_________\/_________/'
    end

    def test_6
      assert_equal F[diamond, 6], '            ________________________
           /           /\           \
          /           /  \           \
         /           /    \           \
        /           /      \           \
       /           /        \           \
      /___________/          \___________\
     /\           \          /           /\
    /  \           \        /           /  \
   /    \           \      /           /    \
  /      \           \    /           /      \
 /        \           \  /           /        \
/          \___________\/___________/          \
\          /           /\           \          /
 \        /           /  \           \        /
  \      /           /    \           \      /
   \    /           /      \           \    /
    \  /           /        \           \  /
     \/___________/          \___________\/
      \           \          /           /
       \           \        /           /
        \           \      /           /
         \           \    /           /
          \           \  /           /
           \___________\/___________/'
    end
  end


  describe 'big diamond' do
    def diamond 
      '   ______
  /_/_/\_\
 /_/\_\/\_\
/\_\/_/\/_/\
\/_/\_\/_/\/
 \_\/_/\_\/
  \_\_\/_/'
    end

    def test_1
      assert_equal F[diamond, 1], '   ______
  /_/_/\_\
 /_/\_\/\_\
/\_\/_/\/_/\
\/_/\_\/_/\/
 \_\/_/\_\/
  \_\_\/_/'
    end
    
    def test_2
      assert_equal F[diamond, 2], '      ____________
     /   /   /\   \
    /___/___/  \___\
   /   /\   \  /\   \
  /___/  \___\/  \___\
 /\   \  /   /\  /   /\
/  \___\/___/  \/___/  \
\  /   /\   \  /   /\  /
 \/___/  \___\/___/  \/
  \   \  /   /\   \  /
   \___\/___/  \___\/
    \   \   \  /   /
     \___\___\/___/'
    end
    
    def test_3
      assert_equal F[diamond, 3], '         __________________
        /     /     /\     \
       /     /     /  \     \
      /_____/_____/    \_____\
     /     /\     \    /\     \
    /     /  \     \  /  \     \
   /_____/    \_____\/    \_____\
  /\     \    /     /\    /     /\
 /  \     \  /     /  \  /     /  \
/    \_____\/_____/    \/_____/    \
\    /     /\     \    /     /\    /
 \  /     /  \     \  /     /  \  /
  \/_____/    \_____\/_____/    \/
   \     \    /     /\     \    /
    \     \  /     /  \     \  /
     \_____\/_____/    \_____\/
      \     \     \    /     /
       \     \     \  /     /
        \_____\_____\/_____/'
    end
    
    def test_4
      assert_equal F[diamond, 4], '            ________________________
           /       /       /\       \
          /       /       /  \       \
         /       /       /    \       \
        /_______/_______/      \_______\
       /       /\       \      /\       \
      /       /  \       \    /  \       \
     /       /    \       \  /    \       \
    /_______/      \_______\/      \_______\
   /\       \      /       /\      /       /\
  /  \       \    /       /  \    /       /  \
 /    \       \  /       /    \  /       /    \
/      \_______\/_______/      \/_______/      \
\      /       /\       \      /       /\      /
 \    /       /  \       \    /       /  \    /
  \  /       /    \       \  /       /    \  /
   \/_______/      \_______\/_______/      \/
    \       \      /       /\       \      /
     \       \    /       /  \       \    /
      \       \  /       /    \       \  /
       \_______\/_______/      \_______\/
        \       \       \      /       /
         \       \       \    /       /
          \       \       \  /       /
           \_______\_______\/_______/'
    end
    
    def test_5
      assert_equal F[diamond, 5], '               ______________________________
              /         /         /\         \
             /         /         /  \         \
            /         /         /    \         \
           /         /         /      \         \
          /_________/_________/        \_________\
         /         /\         \        /\         \
        /         /  \         \      /  \         \
       /         /    \         \    /    \         \
      /         /      \         \  /      \         \
     /_________/        \_________\/        \_________\
    /\         \        /         /\        /         /\
   /  \         \      /         /  \      /         /  \
  /    \         \    /         /    \    /         /    \
 /      \         \  /         /      \  /         /      \
/        \_________\/_________/        \/_________/        \
\        /         /\         \        /         /\        /
 \      /         /  \         \      /         /  \      /
  \    /         /    \         \    /         /    \    /
   \  /         /      \         \  /         /      \  /
    \/_________/        \_________\/_________/        \/
     \         \        /         /\         \        /
      \         \      /         /  \         \      /
       \         \    /         /    \         \    /
        \         \  /         /      \         \  /
         \_________\/_________/        \_________\/
          \         \         \        /         /
           \         \         \      /         /
            \         \         \    /         /
             \         \         \  /         /
              \_________\_________\/_________/'
    end
    
    def test_6
      assert_equal F[diamond, 6], '                  ____________________________________
                 /           /           /\           \
                /           /           /  \           \
               /           /           /    \           \
              /           /           /      \           \
             /           /           /        \           \
            /___________/___________/          \___________\
           /           /\           \          /\           \
          /           /  \           \        /  \           \
         /           /    \           \      /    \           \
        /           /      \           \    /      \           \
       /           /        \           \  /        \           \
      /___________/          \___________\/          \___________\
     /\           \          /           /\          /           /\
    /  \           \        /           /  \        /           /  \
   /    \           \      /           /    \      /           /    \
  /      \           \    /           /      \    /           /      \
 /        \           \  /           /        \  /           /        \
/          \___________\/___________/          \/___________/          \
\          /           /\           \          /           /\          /
 \        /           /  \           \        /           /  \        /
  \      /           /    \           \      /           /    \      /
   \    /           /      \           \    /           /      \    /
    \  /           /        \           \  /           /        \  /
     \/___________/          \___________\/___________/          \/
      \           \          /           /\           \          /
       \           \        /           /  \           \        /
        \           \      /           /    \           \      /
         \           \    /           /      \           \    /
          \           \  /           /        \           \  /
           \___________\/___________/          \___________\/
            \           \           \          /           /
             \           \           \        /           /
              \           \           \      /           /
               \           \           \    /           /
                \           \           \  /           /
                 \___________\___________\/___________/'
    end
  end  

  describe 'even bigger diamond' do
    def diamond 
      '    ________
   /_/\_\_\_\
  /\_\/\_\_\_\
 /\/_/\/_/_/\_\
/\/\_\/_/_/\/\_\ 
\/\/_/\_\_\/\/_/
 \/\_\/_/\_\/_/
  \/\_\_\/_/_/
   \/_/_/_/_/'
    end

    def test_1
      assert_equal F[diamond, 1], '    ________
   /_/\_\_\_\
  /\_\/\_\_\_\
 /\/_/\/_/_/\_\
/\/\_\/_/_/\/\_\
\/\/_/\_\_\/\/_/
 \/\_\/_/\_\/_/
  \/\_\_\/_/_/
   \/_/_/_/_/'
    end
    
    def test_2
      assert_equal F[diamond, 2], '        ________________
       /   /\   \   \   \
      /___/  \___\___\___\
     /\   \  /\   \   \   \
    /  \___\/  \___\___\___\
   /\  /   /\  /   /   /\   \
  /  \/___/  \/___/___/  \___\
 /\  /\   \  /   /   /\  /\   \
/  \/  \___\/___/___/  \/  \___\
\  /\  /   /\   \   \  /\  /   /
 \/  \/___/  \___\___\/  \/___/
  \  /\   \  /   /\   \  /   /
   \/  \___\/___/  \___\/___/
    \  /\   \   \  /   /   /
     \/  \___\___\/___/___/
      \  /   /   /   /   /
       \/___/___/___/___/'
    end
    
    def test_3
      assert_equal F[diamond, 3], '            ________________________
           /     /\     \     \     \
          /     /  \     \     \     \
         /_____/    \_____\_____\_____\
        /\     \    /\     \     \     \
       /  \     \  /  \     \     \     \
      /    \_____\/    \_____\_____\_____\
     /\    /     /\    /     /     /\     \
    /  \  /     /  \  /     /     /  \     \
   /    \/_____/    \/_____/_____/    \_____\
  /\    /\     \    /     /     /\    /\     \
 /  \  /  \     \  /     /     /  \  /  \     \
/    \/    \_____\/_____/_____/    \/    \_____\
\    /\    /     /\     \     \    /\    /     /
 \  /  \  /     /  \     \     \  /  \  /     /
  \/    \/_____/    \_____\_____\/    \/_____/
   \    /\     \    /     /\     \    /     /
    \  /  \     \  /     /  \     \  /     /
     \/    \_____\/_____/    \_____\/_____/
      \    /\     \     \    /     /     /
       \  /  \     \     \  /     /     /
        \/    \_____\_____\/_____/_____/
         \    /     /     /     /     /
          \  /     /     /     /     /
           \/_____/_____/_____/_____/'
    end
    
    def test_4
      assert_equal F[diamond, 4], '                ________________________________
               /       /\       \       \       \
              /       /  \       \       \       \
             /       /    \       \       \       \
            /_______/      \_______\_______\_______\
           /\       \      /\       \       \       \
          /  \       \    /  \       \       \       \
         /    \       \  /    \       \       \       \
        /      \_______\/      \_______\_______\_______\
       /\      /       /\      /       /       /\       \
      /  \    /       /  \    /       /       /  \       \
     /    \  /       /    \  /       /       /    \       \
    /      \/_______/      \/_______/_______/      \_______\
   /\      /\       \      /       /       /\      /\       \
  /  \    /  \       \    /       /       /  \    /  \       \
 /    \  /    \       \  /       /       /    \  /    \       \
/      \/      \_______\/_______/_______/      \/      \_______\
\      /\      /       /\       \       \      /\      /       /
 \    /  \    /       /  \       \       \    /  \    /       /
  \  /    \  /       /    \       \       \  /    \  /       /
   \/      \/_______/      \_______\_______\/      \/_______/
    \      /\       \      /       /\       \      /       /
     \    /  \       \    /       /  \       \    /       /
      \  /    \       \  /       /    \       \  /       /
       \/      \_______\/_______/      \_______\/_______/
        \      /\       \       \      /       /       /
         \    /  \       \       \    /       /       /
          \  /    \       \       \  /       /       /
           \/      \_______\_______\/_______/_______/
            \      /       /       /       /       /
             \    /       /       /       /       /
              \  /       /       /       /       /
               \/_______/_______/_______/_______/'
    end
    
    def test_5
      assert_equal F[diamond, 5], '                    ________________________________________
                   /         /\         \         \         \
                  /         /  \         \         \         \
                 /         /    \         \         \         \
                /         /      \         \         \         \
               /_________/        \_________\_________\_________\
              /\         \        /\         \         \         \
             /  \         \      /  \         \         \         \
            /    \         \    /    \         \         \         \
           /      \         \  /      \         \         \         \
          /        \_________\/        \_________\_________\_________\
         /\        /         /\        /         /         /\         \
        /  \      /         /  \      /         /         /  \         \
       /    \    /         /    \    /         /         /    \         \
      /      \  /         /      \  /         /         /      \         \
     /        \/_________/        \/_________/_________/        \_________\
    /\        /\         \        /         /         /\        /\         \
   /  \      /  \         \      /         /         /  \      /  \         \
  /    \    /    \         \    /         /         /    \    /    \         \
 /      \  /      \         \  /         /         /      \  /      \         \
/        \/        \_________\/_________/_________/        \/        \_________\
\        /\        /         /\         \         \        /\        /         /
 \      /  \      /         /  \         \         \      /  \      /         /
  \    /    \    /         /    \         \         \    /    \    /         /
   \  /      \  /         /      \         \         \  /      \  /         /
    \/        \/_________/        \_________\_________\/        \/_________/
     \        /\         \        /         /\         \        /         /
      \      /  \         \      /         /  \         \      /         /
       \    /    \         \    /         /    \         \    /         /
        \  /      \         \  /         /      \         \  /         /
         \/        \_________\/_________/        \_________\/_________/
          \        /\         \         \        /         /         /
           \      /  \         \         \      /         /         /
            \    /    \         \         \    /         /         /
             \  /      \         \         \  /         /         /
              \/        \_________\_________\/_________/_________/
               \        /         /         /         /         /
                \      /         /         /         /         /
                 \    /         /         /         /         /
                  \  /         /         /         /         /
                   \/_________/_________/_________/_________/'
    end
    
    def test_6
      assert_equal F[diamond, 6], '                        ________________________________________________
                       /           /\           \           \           \
                      /           /  \           \           \           \
                     /           /    \           \           \           \
                    /           /      \           \           \           \
                   /           /        \           \           \           \
                  /___________/          \___________\___________\___________\
                 /\           \          /\           \           \           \
                /  \           \        /  \           \           \           \
               /    \           \      /    \           \           \           \
              /      \           \    /      \           \           \           \
             /        \           \  /        \           \           \           \
            /          \___________\/          \___________\___________\___________\
           /\          /           /\          /           /           /\           \
          /  \        /           /  \        /           /           /  \           \
         /    \      /           /    \      /           /           /    \           \
        /      \    /           /      \    /           /           /      \           \
       /        \  /           /        \  /           /           /        \           \
      /          \/___________/          \/___________/___________/          \___________\
     /\          /\           \          /           /           /\          /\           \
    /  \        /  \           \        /           /           /  \        /  \           \
   /    \      /    \           \      /           /           /    \      /    \           \
  /      \    /      \           \    /           /           /      \    /      \           \
 /        \  /        \           \  /           /           /        \  /        \           \
/          \/          \___________\/___________/___________/          \/          \___________\
\          /\          /           /\           \           \          /\          /           /
 \        /  \        /           /  \           \           \        /  \        /           /
  \      /    \      /           /    \           \           \      /    \      /           /
   \    /      \    /           /      \           \           \    /      \    /           /
    \  /        \  /           /        \           \           \  /        \  /           /
     \/          \/___________/          \___________\___________\/          \/___________/
      \          /\           \          /           /\           \          /           /
       \        /  \           \        /           /  \           \        /           /
        \      /    \           \      /           /    \           \      /           /
         \    /      \           \    /           /      \           \    /           /
          \  /        \           \  /           /        \           \  /           /
           \/          \___________\/___________/          \___________\/___________/
            \          /\           \           \          /           /           /
             \        /  \           \           \        /           /           /
              \      /    \           \           \      /           /           /
               \    /      \           \           \    /           /           /
                \  /        \           \           \  /           /           /
                 \/          \___________\___________\/___________/___________/
                  \          /           /           /           /           /
                   \        /           /           /           /           /
                    \      /           /           /           /           /
                     \    /           /           /           /           /
                      \  /           /           /           /           /
                       \/___________/___________/___________/___________/'
    end
  end  


end