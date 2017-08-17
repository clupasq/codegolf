import Test.Hspec
import Test.QuickCheck
import Test.QuickCheck.Modifiers(NonEmptyList (..))

-- import Data.Ord
import Data.Char
import Data.List
--
import Debug.Trace

-- START COUNTING
b 0=""
b n=b(n`div`2)++(show$n`mod`2)
s=nub.(tails=<<).inits
p x=s x\\[x]
n(_,l)x|(p.b)x\\l/=[]=(x,l++(s.b)x)|1<2=(0,l)
g=scanl n(1,[])[1..]
f=filter(>1)$fst<$>g
--END COUNTING


main = hspec $ do

  it "does something interesting" $ do

    take 40 f `shouldBe` [2, 4, 5, 6, 8, 9, 10, 11, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 26, 30, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 50, 54, 56, 58]

