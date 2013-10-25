data BinaryTree a = Bin (BinaryTree a) a (BinaryTree a) | Tip
data Direction = DLeft | DRight | DNone

instance Show a => Show (BinaryTree a) where
  show = showBinaryTree

takeBinaryTree :: Int -> BinaryTree a -> BinaryTree a
takeBinaryTree 0 _             = Tip
takeBinaryTree n (Bin b1 a b2) = Bin (takeBinaryTree (n - 1) b1) a (takeBinaryTree (n - 1) b2)
takeBinaryTree n Tip           = Tip

showBinaryTree :: Show a => BinaryTree a -> String
showBinaryTree b = unlines $ showBinaryTree' DNone b
  where
    showBinaryTree' :: Show a => Direction -> BinaryTree a -> [String]
    showBinaryTree' _ Tip                = []
    showBinaryTree' DNone  (Bin b1 a b2) =                 showBinaryTree' DRight b2  ++          [show a] ++                 showBinaryTree' DLeft b1
    showBinaryTree' DLeft  (Bin b1 a b2) = map ("|  " ++) (showBinaryTree' DRight b2) ++ ["+--" ++ show a] ++ map ("   " ++) (showBinaryTree' DLeft b1)
    showBinaryTree' DRight (Bin b1 a b2) = map ("   " ++) (showBinaryTree' DRight b2) ++ ["+--" ++ show a] ++ map ("|  " ++) (showBinaryTree' DLeft b1)

main = print $ takeBinaryTree 5 $ Bin (Bin (Bin Tip 3 Tip) 2 (Bin (Bin (Bin Tip 6 Tip) 5 (Bin Tip 7 Tip)) 4 (Bin (Bin (Bin Tip 10 Tip) 9 (Bin Tip 11 Tip)) 8 Tip))) 1 (Bin (Bin Tip 13 (Bin Tip 14 Tip)) 12 (Bin Tip 15 Tip))
