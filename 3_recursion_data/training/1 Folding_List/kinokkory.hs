import Prelude hiding (length, map, reverse, filter)

length :: [a] -> Int
length = foldr (const (+1)) 0

map :: (a -> b) -> [a] -> [b]
map f = foldr (\a bs -> f a : bs) []

reverse :: [a] -> [a]
reverse = foldl (\as a -> a : as) []

filter :: (a -> Bool) -> [a] -> [a]
filter f = foldr (\a as -> if f a then a:as else as) []

subsequences :: [a] -> [[a]]
subsequences = foldl (\ass a -> ass ++ map (++[a]) ass) [[]]

main = print $ length [1..5]
-- main = print $ map (+1) [1..5]
-- main = print $ reverse [1..5]
-- main = print $ filter odd [1..5]
-- main = print $ subsequences [1..3]
