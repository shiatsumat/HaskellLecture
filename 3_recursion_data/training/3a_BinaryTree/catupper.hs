data BinaryTree a = Bin (BinaryTree a) a (BinaryTree a) | Tip

instance Show a => Show (BinaryTree a) where
  show = showBinaryTree

takeBinaryTree :: Int -> BinaryTree a -> BinaryTree a
{- edit here -}
takeBinaryTree 1 (Bin _ a _) = Bin Tip a Tip
takeBinaryTree _ Tip = Tip
takeBinaryTree n (Bin left a right) = Bin (takeBinaryTree (n - 1) left) a (takeBinaryTree (n - 1) right)
{- pyaaaaaaa -}

showBinaryTree :: Show a => BinaryTree a -> String
{- edit here -}
showBinaryTree Tip = ""
showBinaryTree (Bin left a right) = let (ll, lc, lr) = splitSBT  ([],[],(lines $ showBinaryTree left))
                                        (rl, rc, rr) = splitSBT  ([],[],(lines $ showBinaryTree right))
                                      in unlines $ (map (\x->"   "++x) rl) ++ (map (\x->"+--"++x) rc) ++ (map (\x->"|  "++x) rr) ++ [show a] ++ (map (\x->"|  "++x) ll) ++ (map (\x->"+--"++x) lc) ++ (map (\x->"   "++x) lr)

splitSBT::([String], [String], [String])->([String], [String], [String])
splitSBT a@(_, _, []) = a
splitSBT res@(lefts, n, (a:as)) | f /= "+" && f /= "|" && f /= " " && n /= []= res
                                | otherwise = splitSBT (lefts ++ n, [a], as)
                               where f = if n == [] || n == [""] then "" else take 1 $ n!!0
{- pyaaaaaaa -}

main = print $ takeBinaryTree 4 $ Bin (Bin (Bin Tip 3 Tip) 2 (Bin (Bin (Bin Tip 6 Tip) 5 (Bin Tip 7 Tip)) 4 (Bin (Bin (Bin Tip 10 Tip) 9 (Bin Tip 11 Tip)) 8 Tip))) 1 (Bin (Bin Tip 13 (Bin Tip 14 Tip)) 12 (Bin Tip 15 Tip))
