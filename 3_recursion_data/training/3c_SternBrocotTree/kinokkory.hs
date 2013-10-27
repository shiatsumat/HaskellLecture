import Data.Ratio

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

sternbrocotTree :: BinaryTree Rational
sternbrocotTree = go (0,1) (1,1) (1,0)
    where go (a,b) (c,d) (e,f) =
              Bin (go (a,b) (a+c,b+d) (c,d)) (c%d) (go (c,d) (c+e,d+f) (e,f))

simplest :: (Double,Double) -> Rational
simplest (a,b) = go sternbrocotTree (a,b)
    where go (Bin l x r) (a,b)
            | a'<=x&&x<=b' = x
            | b'<x = go l (a,b)
            | x<a' = go r (a,b)
            where a' = toRational a
                  b' = toRational b

rationals :: Integer -> [Rational]
rationals k = go sternbrocotTree k
    where go (Bin l x r) k
            | denominator x + numerator x > k = []
            | otherwise = go l k ++ [x] ++ go r k

main = print $ takeBinaryTree 5 sternbrocotTree
-- main = print $ simplest (3.14,3.15)
-- main = print $ rationals 20

