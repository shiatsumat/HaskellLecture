import Data.List
import Control.Monad

dice' :: [Int] -> Int -> Int -> [Int]
dice' _ _ 0 = [0]
dice' a g n = do
	i <- a
	j <- dice' a g (n - 1)
	return $ if i + j > g then g else if i + j < 0 then 0 else i + j

dice :: [Int] -> Int -> Int -> [Int]
dice a g n = sort $ nub $ dice' a g n

main = do g <- readLn
          n <- readLn
          k <- readLn
          as <- replicateM k readLn
          print $ dice as g n
