import Test.Hspec

t :: [String] -> [String]
b :: [String] -> [String]
h :: [String] -> Bool
z :: String -> Bool
d :: String -> String
(%) :: a -> [a] -> [a]
i :: String -> Bool
l :: String -> String
a :: (a -> b) -> (a -> b) -> [a] -> [b]
m :: [a] -> [a]

-- Not posting this because it is a lot larger than the existing JS solution
-- and assumes that the input is rectangular (all lines are the same length).

-- START COUNTING

m(x:y)=init y
a b m(x:y)=b x:map m(init y)++[b$last y]
l=a(\_->'+')(\_->'-')
i s=s==l s
d%y=d:y++[d]
d s='|':s++"|"
z s=(d.m)s==s
h=and.a i z
b[]=t:[t]where t=l"xx"
b y=(l$d$head y)%map d y
t y|h y=((map m).m)y|1<2=b y

-- END COUNTING

main = hspec $ do

  describe "Toggle box" $ do

    it "Passes test cases" $ do
      t ["Hello, World!"] `shouldBe`
        ["+-------------+",
        "|Hello, World!|",
        "+-------------+"]

      t ["Hello,    ",
         "    World!"] `shouldBe`
          ["+----------+",
          "|Hello,    |",
          "|    World!|",
          "+----------+"]


      t ["+--------+",
         "|        |",
         " --------+"] `shouldBe`
            ["+----------+",
            "|+--------+|",
            "||        ||",
            "| --------+|",
            "+----------+"]

      t ["++",
         "++"] `shouldBe` []


      t ["+----+",
         "+----+"] `shouldBe` []

      t ["++",
         "||",
         "||",
         "++"] `shouldBe` ["", ""]

      t ["+-------+",
         "| Hello |",
         "+ ------+"] `shouldBe`
            ["+---------+",
             "|+-------+|",
             "|| Hello ||",
             "|+ ------+|",
             "+---------+"]

      t [" +-------+",
         "a| Hello |",
              " +-------+"] `shouldBe`
            ["+----------+",
             "| +-------+|",
             "|a| Hello ||",
             "| +-------+|",
             "+----------+"]

