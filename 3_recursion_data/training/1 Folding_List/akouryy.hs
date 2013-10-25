import Prelude hiding (length, map, reverse, filter)

length :: [a] -> Int
length = foldl (\a b -> a + 1) 0

map :: (a -> b) -> [a] -> [b]
map f = foldr (\a bs -> f a : bs) []

reverse :: [a] -> [a]
reverse = foldl (\as a -> a : as) []

filter :: (a -> Bool) -> [a] -> [a]
filter f = foldr (\a as -> if f a then a : as else as) []

subsequences :: [a] -> [[a]]
subsequences = foldr (\a ass -> concatMap (\as -> [as, a : as]) ass) [[]]

main = do print $ length [1..5]
          print $ map (+1) [1..5]
          print $ reverse [1..5]
          print $ filter odd [1..5]
          print $ subsequences [1..5]
