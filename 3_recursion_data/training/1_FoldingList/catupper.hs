import Prelude hiding (length, map, reverse, filter)

length :: [a] -> Int
length = foldl (\x -> \y -> x + 1) 0

map :: (a -> b) -> [a] -> [b]
map f = foldl (\x -> \y -> x ++ [f y]) []

reverse :: [a] -> [a]
reverse = foldl (\x -> \y -> y:x) []

filter :: (a -> Bool) -> [a] -> [a]
filter f = foldl (\x -> \y -> x ++ (if (f y) then [y] else [])) []

subsequences :: [a] -> [[a]]
subsequences = foldl (\x -> \y -> x ++ (map (\z -> z ++ [y]) x)) [[]] 

-- main = print $ length [1..5]
-- main = print $ map (+1) [1..5]
-- main = print $ reverse [1..5]
-- main = print $ filter odd [1..5]
main = print $ subsequences [1..3]