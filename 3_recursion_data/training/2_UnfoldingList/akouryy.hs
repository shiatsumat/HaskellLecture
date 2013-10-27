import Prelude hiding (map, replicate)
import Data.List (unfoldr)

map :: (a -> b) -> [a] -> [b]
map f = unfoldr (\as -> if null as then Nothing else Just (f $ head as, tail as))

replicate :: Int -> a -> [a]
replicate n a = unfoldr (\n -> if n == 0 then Nothing else Just (a, n - 1)) n

fib :: [Int]
fib = unfoldr (\(a, b) -> Just (b, (a + b, a))) (1, 1)

main = do print $ map (+1) [1..5]
          print $ replicate 5 1
          print $ take 10 fib
