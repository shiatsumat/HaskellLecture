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
sternbrocotTree = sternbrocotTree' (0%1,1%1,-1%1)
    where sternbrocotTree' (x,y,z) = Bin (sternbrocotTree' (x, add x y, y)) y (sternbrocotTree' (y, add y z, z))
          add x y = (numerator x + numerator' y) % (denominator x + denominator' y)
          numerator' x
            | x == -1%1 = 1
            | otherwise = numerator x
          denominator' x
            | x == -1%1 = 0
            | otherwise = denominator x

simplest :: (Double,Double) -> Rational
simplest (a,b) = simplest' sternbrocotTree (a,b)
    where simplest' (Bin l x r) (a,b)
            | a'<=x&&x<=b' = x
            | b'<x = simplest' l (a,b)
            | x<a' = simplest' r (a,b)
            where a' = toRational a
                  b' = toRational b

rationals :: Integer -> [Rational]
rationals k = rationals' sternbrocotTree k
    where rationals' (Bin l x r) k
            | denominator x + numerator x > k = []
            | otherwise = rationals' l k ++ [x] ++ rationals' r k

main = print $ takeBinaryTree 5 sternbrocotTree
-- main = print $ simplest (3.14,3.15)
-- main = print $ rationals 20

