import Prelude hiding (map, replicate)
import Data.List (unfoldr)

map' :: (a -> b) -> [a] -> Maybe (b, [a])
map' f [] = Nothing
map' f (x:xs) = Just (f x, xs)

map :: (a -> b) -> [a] -> [b]
map f = unfoldr (map' f)

replicate :: Int -> a -> [a]
replicate n a = unfoldr (\x -> if x == 0 then Nothing else Just (a, x - 1)) n

fib :: [Int]
fib = unfoldr (\(x, y) -> Just (x, (y, x + y))) (1, 1)

-- main = print $ map (+1) [1..5]
-- main = print $ replicate 5 1
main = print $ take 10 fib
