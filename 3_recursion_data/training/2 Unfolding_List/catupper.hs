import Prelude hiding (map, replicate)
import Data.List (unfoldr)

map :: (a -> b) -> [a] -> [b]
map f = unfoldr (\x -> if (length x /= 0) then (let (a:as) = x in Just (f a, as)) else Nothing)

replicate :: Int -> a -> [a]
replicate n a = unfoldr (\x -> if x /= 0  then Just(a, x - 1) else Nothing) n

fib :: [Int]
fib = unfoldr (\(a, b) -> Just (a + b, (b, a + b))) (1, 0)

-- main = print $ map (+1) [1..5]
-- main = print $ replicate 5 1
main = print $ take 10 fib