import Test.Hspec
import Test.QuickCheck
import Test.QuickCheck.Modifiers(NonEmptyList (..))

-- import Data.Ord
import Data.Char
import Data.List
--
import Debug.Trace

binary :: Int -> String
binary 0=""
binary n|(d,r)<-divMod n 2=binary d++["01"!!r]

substrings :: String -> [String]
substrings xs = nub$inits xs>>=tails

properSubstrings :: String -> [String]
properSubstrings xs = substrings xs\\[xs]

sb=substrings.binary
psb=properSubstrings.binary

g = scanl step (1,[]) [1..]
  where step (_,l) x | psb x\\l/=[]=(x,l++sb x)
                     | otherwise=(0,l)

f=filter(>1)$fst<$>g


main = hspec $ do

  it "does something interesting" $ do

    print $ properSubstrings "test"

    print $ binary 17
    print $ binary 20

    print $ take 50 $ f

    pending



