data BinaryTree a = Bin (BinaryTree a) a (BinaryTree a) | Tip

instance Show a => Show (BinaryTree a) where
  show = showBinaryTree

takeBinaryTree :: Int -> BinaryTree a -> BinaryTree a
takeBinaryTree 0 _ = Tip
takeBinaryTree n Tip = Tip
takeBinaryTree n (Bin l x r) = Bin (takeBinaryTree (n-1) l) x (takeBinaryTree (n-1) r)

showBinaryTree :: Show a => BinaryTree a -> String
showBinaryTree t = unlines $ fst $ showBinaryTree' 0 t
showBinaryTree' :: Show a => Int -> BinaryTree a -> ([String],Int)
showBinaryTree' _ Tip = ([], 0)
showBinaryTree' i (Bin l x r)
    | i== 0  = (sr++[sx]++sl, n)
    | i== 1  = (map ("|  "++) sr ++ ["+--"++sx] ++ map ("   "++) sl, n)
    | i== -1 = (map ("   "++) sr ++ ["+--"++sx] ++ map ("|  "++) sl, n)
    where (sl,nl) = showBinaryTree' 1 l
          (sr,nr) = showBinaryTree' (-1) r
          n = nl + 1 + nr
          sx = show x

main = print $ takeBinaryTree 100 $ Bin (Bin (Bin Tip 3 Tip) 2 (Bin (Bin (Bin Tip 6 Tip) 5 (Bin Tip 7 Tip)) 4 (Bin (Bin (Bin Tip 10 Tip) 9 (Bin Tip 11 Tip)) 8 Tip))) 1 (Bin (Bin Tip 13 (Bin Tip 14 Tip)) 12 (Bin Tip 15 Tip))

