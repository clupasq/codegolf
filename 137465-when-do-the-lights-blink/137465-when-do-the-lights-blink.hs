import Test.Hspec
import Data.List
-- import Data.Ord

type LightId = Int
type Time = Int
type State = Bool
type LightEvent = (Time, LightId, State)

light :: Time -> Time -> [(Time, State)]
light delay interval = iterate step (delay, True)
  where step (time, state) = (time+interval, not state)

addId :: LightId -> (Time, State) -> LightEvent
addId id (t, s) = (t, id, s)

simulate :: Time -> [(Time, Time)] -> [LightEvent]
simulate timeLimit lights = sort $ concatMap lightSim (zip [0..] lights)
  where lightSim (id, (delay, interval)) = map (addId id) $ takeWhile ((<=timeLimit) . fst) (light delay interval)


main = hspec $ do

  it "can test" $ do
    1 `shouldBe` 1

  it "can generate a lighting sequence" $ do

    take 10 (light 0 1000) `shouldBe` [(0, True),
                                       (1000, False),
                                       (2000, True),
                                       (3000, False),
                                       (4000, True),
                                       (5000, False),
                                       (6000, True),
                                       (7000, False),
                                       (8000, True),
                                       (9000, False)]

    take 5 (light 500 1000) `shouldBe` [(500, True),
                                       (1500, False),
                                       (2500, True),
                                       (3500, False),
                                       (4500, True)]


  it "can simulate multiple lights" $ do

    simulate 2000 [(  0, 1000),
                   (500, 1000)] `shouldBe` [(   0, 0, True),
                                            ( 500, 1, True),
                                            (1000, 0, False),
                                            (1500, 1, False),
                                            (2000, 0, True)]

