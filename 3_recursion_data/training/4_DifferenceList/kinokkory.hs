data BinaryTree a = Bin (BinaryTree a) a (BinaryTree a) | Tip

flatten :: BinaryTree a -> [a]
flatten t = flatten' t []
flatten' :: BinaryTree a -> [a] -> [a]
flatten' Tip = id
flatten' (Bin l x r) = flatten' l . ([x]++) . flatten' r

bigtree :: BinaryTree Int
bigtree = bigtree' 100000
bigtree' 0 = Tip
bigtree' n = Bin (bigtree' (n-1)) 0 Tip

main = print $ flatten bigtree
