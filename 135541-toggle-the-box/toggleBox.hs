import Test.Hspec

middle :: [a] -> [a]
middle (x:xs) = init xs

applyStartMiddleEnd :: (a -> b) -> (a -> b) -> [a] -> [b]
applyStartMiddleEnd startEndFunction middleFunction (x:xs) = startEndFunction x : map middleFunction(init xs) ++ [startEndFunction$last xs]

topBottomLine :: String -> String
topBottomLine = applyStartMiddleEnd (\_->'+') (\_->'-')

isTopBottomLine :: String -> Bool
isTopBottomLine s = s == topBottomLine s

wrap :: a -> [a] -> [a]
wrap d xs = d:xs++[d]

wrapMiddle :: String -> String
wrapMiddle s = '|':s++"|"

isMiddleLine :: String -> Bool
isMiddleLine s = (wrapMiddle.middle)s==s

hasBox :: [String] -> Bool
hasBox = and . applyStartMiddleEnd isTopBottomLine isMiddleLine

unbox :: [String] -> [String]
unbox = (map middle).middle

box :: [String] -> [String]
box [] = t:[t] where t=topBottomLine "xx"
box xs = wrap (topBottomLine $ wrapMiddle$head xs) $ map wrapMiddle xs

toggle :: [String] -> [String]
toggle xs = if hasBox xs then unbox xs else box xs

main = hspec $ do

  describe "Toggle box" $ do

    describe "Top or bottom line" $ do

      it "can make lines of various sizes" $ do
        topBottomLine "...." `shouldBe` "+--+"
        topBottomLine ".." `shouldBe` "++"

      it "can detect whether a string is a top or bottom line" $ do
        isTopBottomLine "+--+" `shouldBe` True
        isTopBottomLine "+---+" `shouldBe` True
        isTopBottomLine "++" `shouldBe` True
        isTopBottomLine "+---+ " `shouldBe` False
        isTopBottomLine "+.--+" `shouldBe` False
        isTopBottomLine "+ " `shouldBe` False

    describe "Middle lines" $ do

      it "can wrap content" $ do
        wrapMiddle "abc" `shouldBe` "|abc|"
        wrapMiddle "   " `shouldBe` "|   |"
        wrapMiddle "|"   `shouldBe` "|||"

      it "can detect middle lines" $ do
        isMiddleLine "|abc|" `shouldBe` True
        isMiddleLine "||"    `shouldBe` True
        isMiddleLine "|   |" `shouldBe` True
        isMiddleLine "|   | " `shouldBe` False
        isMiddleLine "|   /" `shouldBe` False


    describe "Box detection" $ do

      it "detects simple boxes" $ do
        hasBox ["+----+",
                "|    |",
                "+----+"] `shouldBe` True
        hasBox ["+---+",
                "|   |",
                "|   |",
                "|   |",
                "+---+"] `shouldBe` True

      it "detects simple boxes with text inside" $ do
        hasBox ["+----+",
                "|test|",
                "+----+"] `shouldBe` True
        hasBox ["+---+",
                "|som|",
                "|e t|",
                "|ext|",
                "+---+"] `shouldBe` True

      it "detects broken boxes" $ do
        hasBox ["+----+",
                "|    |",
                "+---- "] `shouldBe` False
        hasBox ["+-.-+",
                "|   |",
                "|   |",
                "|   |",
                "+---+"] `shouldBe` False


    describe "Unboxing" $ do

      it "can remove boxes" $ do
        unbox ["++",
                   "++"] `shouldBe` []
        unbox ["+----+",
                   "|test|",
                   "+----+"] `shouldBe` ["test"]
        unbox ["+---+",
                   "|som|",
                   "|e t|",
                   "|ext|",
                   "+---+"] `shouldBe` ["som",
                                       "e t",
                                       "ext"]


    describe "Boxing" $ do

      it "can add boxes" $ do
        box ["test"] `shouldBe` ["+----+",
                                    "|test|",
                                    "+----+"]
        box [""] `shouldBe` ["++",
                                "||",
                                "++"]
        box [] `shouldBe` ["++",
                              "++"]


    it "Passes test cases" $ do
      toggle ["Hello, World!"] `shouldBe`
        ["+-------------+",
        "|Hello, World!|",
        "+-------------+"]

      toggle ["Hello,    ",
              "    World!"] `shouldBe`
          ["+----------+",
          "|Hello,    |",
          "|    World!|",
          "+----------+"]


      toggle ["+--------+",
              "|        |",
              " --------+"] `shouldBe`
            ["+----------+",
            "|+--------+|",
            "||        ||",
            "| --------+|",
            "+----------+"]

      toggle ["++",
              "++"] `shouldBe` []


      toggle ["+----+",
              "+----+"] `shouldBe` []

      toggle["++",
             "||",
             "||",
             "++"] `shouldBe` ["", ""]

      toggle ["+-------+",
              "| Hello |",
              "+ ------+"] `shouldBe`
            ["+---------+",
             "|+-------+|",
             "|| Hello ||",
             "|+ ------+|",
             "+---------+"]

      toggle [" +-------+",
              "a| Hello |",
              " +-------+"] `shouldBe`
            ["+----------+",
             "| +-------+|",
             "|a| Hello ||",
             "| +-------+|",
             "+----------+"]



