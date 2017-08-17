import Test.Hspec
import Test.QuickCheck
import Test.QuickCheck.Modifiers(NonEmptyList (..))

-- import Data.Ord
import Data.Char
import Data.List
--
import Debug.Trace

-- START COUNTING
binary 0=""
binary n|(d,r)<-divMod n 2=binary d++["01"!!r]

substrings xs = nub$inits xs>>=tails

properSubstrings xs = substrings xs\\[xs]

sb=substrings.binary
psb=properSubstrings.binary

g = scanl step (1,[]) [1..]
  where step (_,l) x | psb x\\l/=[]=(x,l++sb x)
                     | otherwise=(0,l)

f=filter(>1)$fst<$>g
--END COUNTING


main = hspec $ do

  it "does something interesting" $ do

    take 40 f `shouldBe` [2, 4, 5, 6, 8, 9, 10, 11, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 26, 30, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 50, 54, 56, 58]

