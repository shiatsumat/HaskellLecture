import Prelude hiding (length, map, reverse, filter)

length :: [a] -> Int
length = foldr (\_ n -> n+1) 0

map :: (a -> b) -> [a] -> [b]
map f = foldl (\bs a -> bs ++ [f a]) []

reverse :: [a] -> [a]
reverse = foldl (\as a -> a : as) []

filter :: (a -> Bool) -> [a] -> [a]
filter f = foldr (\a as -> if f a then a:as else as) []

subsequences :: [a] -> [[a]]
subsequences = foldr (\a ass -> concatMap (\as -> [as,a:as]) ass) [[]]

main = print $ length [1..5]
-- main = print $ map (+1) [1..5]
-- main = print $ reverse [1..5]
-- main = print $ filter odd [1..5]
-- main = print $ subsequences [1..3]
