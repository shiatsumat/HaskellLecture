import Data.Ratio
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

calkinwilfTree :: BinaryTree Rational
calkinwilfTree = calkinwilfTree' (1 % 1)
  where
    calkinwilfTree' :: Rational -> BinaryTree Rational
    calkinwilfTree' r = Bin (calkinwilfTree' (numerator r % (numerator r + denominator r))) r (calkinwilfTree' ((numerator r + denominator r) % denominator r))

calkinwilfSeq :: [Rational]
calkinwilfSeq = concat $ calkinwilfSeq' calkinwilfTree
  where
    calkinwilfSeq' :: BinaryTree Rational -> [[Rational]]
    calkinwilfSeq' (Bin b1 a b2) = [a] : zipWith (++) (calkinwilfSeq' b1) (calkinwilfSeq' b2)

calkinwilfGet :: Int -> Rational
calkinwilfGet = calkinwilfGet' calkinwilfTree . tail . reverse . toBinArray
  where
    calkinwilfGet' :: BinaryTree Rational -> [Bool] -> Rational
    calkinwilfGet' (Bin b1 a b2) [] = a
    calkinwilfGet' (Bin b1 a b2) bs
      | not $ head bs = calkinwilfGet' b1 $ tail bs
      | otherwise     = calkinwilfGet' b2 $ tail bs
    toBinArray :: Int -> [Bool]
    toBinArray 0 = []
    toBinArray n = (n `mod` 2 /= 0) : toBinArray (n `div` 2)

main = do print $ takeBinaryTree 5 calkinwilfTree
          print $ take 100 $ calkinwilfSeq
          print $ calkinwilfGet 100
