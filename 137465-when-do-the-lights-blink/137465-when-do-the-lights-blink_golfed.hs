import Test.Hspec

-- START COUNTING
import Data.List
t!l=sort$(zip[0..]l)>>=takeWhile(\(a,_,_)->a<=t).(\(i,(d,w))->iterate(\(t,i,s)->(t+w,i,not s))(d,i,2>1))
-- END COUNTING


main = hspec $ do

  it "test case 1" $ do

    2000 ! [(  0, 1000),
            (500, 1000)] `shouldBe` [(   0, 0, True),
                                     ( 500, 1, True),
                                     (1000, 0, False),
                                     (1500, 1, False),
                                     (2000, 0, True)]

  it "test case 2" $ do

    500 ! [(100,50),
           (200,100),
           (300,150)] `shouldBe` [(100,0,True),
                                  (150,0,False),
                                  (200,0,True),
                                  (200,1,True),
                                  (250,0,False),
                                  (300,0,True),
                                  (300,1,False),
                                  (300,2,True),
                                  (350,0,False),
                                  (400,0,True),
                                  (400,1,True),
                                  (450,0,False),
                                  (450,2,False),
                                  (500,0,True),
                                  (500,1,False)]

  it "test case 3" $ do
    1000 ! [(23,345),
           (65,98),
           (912,12),
           (43,365)] `shouldBe` [(23,0,True),
                                (43,3,True),
                                (65,1,True),
                                (163,1,False),
                                (261,1,True),
                                (359,1,False),
                                (368,0,False),
                                (408,3,False),
                                (457,1,True),
                                (555,1,False),
                                (653,1,True),
                                (713,0,True),
                                (751,1,False),
                                (773,3,True),
                                (849,1,True),
                                (912,2,True),
                                (924,2,False),
                                (936,2,True),
                                (947,1,False),
                                (948,2,False),
                                (960,2,True),
                                (972,2,False),
                                (984,2,True),
                                (996,2,False)]
