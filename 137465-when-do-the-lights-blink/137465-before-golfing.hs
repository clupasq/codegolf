import Test.Hspec
-- import Data.Ord

-- light::(Int,(Int,Int))->[(Int,Int,Bool)]
-- simulate :: Int -> [(Int, Int)] -> [(Int,Int,Bool)]
-- START COUNTING
import Data.List

light (id,(delay,interval)) = iterate step (delay, id, True)
  where step (time, id, state) = (time+interval, id, not state)

simulate timeLimit lights = sort $ concatMap lightSim (zip [0..] lights)
  where lightSim l = takeWhile(\(a,b,c)->a<=timeLimit)$light l
-- END COUNTING


main = hspec $ do

  it "can test" $ do
    1 `shouldBe` 1

  it "can generate a lighting sequence" $ do

    take 10 (light (1, (0, 1000))) `shouldBe` [(   0, 1, True),
                                               (1000, 1, False),
                                               (2000, 1, True),
                                               (3000, 1, False),
                                               (4000, 1, True),
                                               (5000, 1, False),
                                               (6000, 1, True),
                                               (7000, 1, False),
                                               (8000, 1, True),
                                               (9000, 1, False)]

    take 5 (light (3, (500, 1000))) `shouldBe` [( 500, 3, True),
                                                (1500, 3, False),
                                                (2500, 3, True),
                                                (3500, 3, False),
                                                (4500, 3, True)]


  it "can simulate multiple lights" $ do

    simulate 2000 [(  0, 1000),
                   (500, 1000)] `shouldBe` [(   0, 0, True),
                                            ( 500, 1, True),
                                            (1000, 0, False),
                                            (1500, 1, False),
                                            (2000, 0, True)]

