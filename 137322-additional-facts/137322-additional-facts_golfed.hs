import Test.Hspec
-- import Data.List
-- import Data.Ord

-- (#) :: Int -> Int -> Fractional a
-- x#2=sum[1..x]
x#1=foldr(*)1[1..x]
x#2=foldr(+)0[1..x]
x#3=foldr(-)0[1..x]
0#4=0
x#4=foldr(/)1[1..x]

-- START COUNTING
0!3=0
x!y=foldr([(*),(+),(-),(/)]!!y)([1,0,0,1]!!y)[1..x]
f s|[(n,b)]<-lex s=read n!(length b-1)
-- END COUNTING



-- f x=let(n,b)=span(>'!')x in (read n)!(length b)


main = hspec $ do

  it "implements factorials" $ do
    f "5!" `shouldBe` 120

  it "computes fact 1" $ do
    0#1  `shouldBe` 1
    1#1  `shouldBe` 1
    2#1  `shouldBe` 2
    3#1  `shouldBe` 6
    4#1  `shouldBe` 24
    5#1  `shouldBe` 120
    6#1  `shouldBe` 720
    7#1  `shouldBe` 5040
    8#1  `shouldBe` 40320
    9#1  `shouldBe` 362880
    10#1 `shouldBe` 3628800

  it "computes fact 2" $ do
    0# 2 `shouldBe` 0
    1# 2 `shouldBe` 1
    2# 2 `shouldBe` 3
    3# 2 `shouldBe` 6
    4# 2 `shouldBe` 10
    5# 2 `shouldBe` 15
    6# 2 `shouldBe` 21
    7# 2 `shouldBe` 28
    8# 2 `shouldBe` 36
    9# 2 `shouldBe` 45
    10#2 `shouldBe` 55

  it "computes fact 3" $ do
    0# 3 `shouldBe` 0
    1# 3 `shouldBe` 1
    2# 3 `shouldBe` -1
    3# 3 `shouldBe` 2
    4# 3 `shouldBe` -2
    5# 3 `shouldBe` 3
    6# 3 `shouldBe` -3
    7# 3 `shouldBe` 4
    8# 3 `shouldBe` -4
    9# 3 `shouldBe` 5
    10#3 `shouldBe` -5

  it "computes fact 4" $ do
    take 7 (show (0# 4)) `shouldBe` "0.0"
    take 7 (show (1# 4)) `shouldBe` "1.0"
    take 7 (show (2# 4)) `shouldBe` "0.5"
    take 7 (show (3# 4)) `shouldBe` "1.5"
    take 7 (show (4# 4)) `shouldBe` "0.375"
    take 7 (show (5# 4)) `shouldBe` "1.875"
    take 7 (show (6# 4)) `shouldBe` "0.3125"
    take 7 (show (7# 4)) `shouldBe` "2.18750"
    take 7 (show (8# 4)) `shouldBe` "0.27343"
    take 7 (show (9# 4)) `shouldBe` "2.46093"
    take 7 (show (10#4)) `shouldBe` "0.24609"


