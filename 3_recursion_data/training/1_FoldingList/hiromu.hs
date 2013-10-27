import Prelude hiding (length, map, reverse, filter)

length :: [a] -> Int
length = foldl (\x _ -> x + 1) 0

map :: (a -> b) -> [a] -> [b]
map f = foldr (\x y -> f x : y) []

reverse :: [a] -> [a]
reverse = foldl (\x y -> y : x) []

filter :: (a -> Bool) -> [a] -> [a]
filter f = foldr (\x y -> if f x then x : y else y) []

subsequences :: [a] -> [[a]]
subsequences = foldl (\x y -> x ++ (map (\z -> z ++ [y]) x)) [[]]

-- main = print $ length [1..5]
-- main = print $ map (+1) [1..5]
-- main = print $ reverse [1..5]
-- main = print $ filter odd [1..5]
main = print $ subsequences [1..3]
