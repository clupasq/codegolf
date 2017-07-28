import Test.Hspec

isPrime :: Int -> Bool
isPrime n = and[mod n i>0|i<-[2..n-1]]

fermat :: Int -> Int
fermat=(filter isPrime [2^(2^i)+1|i<-[0..]]!!)

main = hspec $ do
  describe "Fermat" $ do
    it "detects primes" $ do
      isPrime 2 `shouldBe` True
      isPrime 3 `shouldBe` True
      isPrime 5 `shouldBe` True
      isPrime 7 `shouldBe` True
      isPrime 19 `shouldBe` True
      isPrime 4 `shouldBe` False
      isPrime 32 `shouldBe` False
      isPrime 49 `shouldBe` False
      isPrime 33 `shouldBe` False
      isPrime 51 `shouldBe` False

    it "finds Fermat numbers" $ do
      fermat 0 `shouldBe` 3
      fermat 1 `shouldBe` 5
      fermat 2 `shouldBe` 17
      fermat 3 `shouldBe` 257
      fermat 4 `shouldBe` 65537





