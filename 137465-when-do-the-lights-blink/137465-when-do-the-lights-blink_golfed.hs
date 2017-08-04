import Test.Hspec
-- import Data.Ord

-- light::(Int,(Int,Int))->[(Int,Int,Bool)]
-- simulate :: Int -> [(Int, Int)] -> [(Int,Int,Bool)]
-- START COUNTING
import Data.List

light (i,(d,w)) = iterate step (d, i, True)
  where step (t, i, state) = (t+w, i, not state)

timeLimit!lights = sort $ concatMap lightSim (zip [0..] lights)
  where lightSim l = takeWhile(\(a,b,c)->a<=timeLimit)$light l
-- END COUNTING


main = hspec $ do

  it "can simulate multiple lights" $ do

    2000 ! [(  0, 1000),
            (500, 1000)] `shouldBe` [(   0, 0, True),
                                     ( 500, 1, True),
                                     (1000, 0, False),
                                     (1500, 1, False),
                                     (2000, 0, True)]

